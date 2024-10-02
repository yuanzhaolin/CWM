#!/usr/bin/python
# -*- coding:utf8 -*-

from langchain_core.tools import BaseTool
from langchain_core.tools import tool
import math
import sys


# from ..chatdb import mysql_db
sys.path.append('..')
sys.path.append('.')

from chatdb import init_database


from typing import Optional


mysql_db = init_database()

def get_wip_materials(product_id: str):
    material_select_sql = f'''
        SELECT material_id, number FROM product_material WHERE product_id = '{str(product_id)}';
    '''
    material_select_sql_results, material_select_sql_res_str = mysql_db.execute_sql(material_select_sql)
    return material_select_sql_results

def get_original_materials(wip_id: str):
    material_select_sql = f'''
        SELECT origin_material_id, number FROM wip_material WHERE wip_id = '{str(wip_id)}';
    '''
    material_select_sql_results, material_select_sql_res_str = mysql_db.execute_sql(material_select_sql)
    return material_select_sql_results

def get_warehouse_materials(material_id: str):
    warehouse_material_select_sql = f'''
        SELECT id, warehouse_id, left_number FROM warehouse_material WHERE material_id = '{str(material_id)}';
    '''
    warehouse_material_select_sql_results, warehouse_material_select_sql_res_str = mysql_db.execute_sql(warehouse_material_select_sql)
    return warehouse_material_select_sql_results

def update_warehouse_materials(warehouse_material_id: int, left_number: int):
    if left_number < 0:
        print(f"Invalid left number {left_number} for warehouse material {warehouse_material_id}.")
        return
    if left_number == 0 :
        warehouse_material_update_sql = f'''
            DELETE FROM warehouse_material WHERE id = '{warehouse_material_id}';
        '''
    else:
        warehouse_material_update_sql = f'''
            UPDATE warehouse_material SET left_number = {left_number} WHERE id = '{warehouse_material_id}';
        '''
    warehouse_material_update_sql_results = mysql_db.execute_sql(warehouse_material_update_sql)
    return warehouse_material_update_sql_results

def allocate_cutting_task(order_product_id: str, produced_wip_id: str, planned_number: int, working_group_id: str):
    cutting_task_insert_sql = f'''
        INSERT INTO cutting_tasks (id, order_product_id, produced_wip_id, planned_number, completed_number, working_group_id, status)
        VALUES (UUID(), '{order_product_id}', '{produced_wip_id}', {planned_number}, 0, '{working_group_id}', 0);
    '''
    result = mysql_db.execute_sql(cutting_task_insert_sql)
    if 'Error' in result[1]:
        raise result[0]

    ori_material_select_sql_results = get_original_materials(wip_id=produced_wip_id)

    for item in ori_material_select_sql_results:
        ori_m, ori_planned_number = item['origin_material_id'], math.ceil(item['number'] * planned_number)

        # 对 ori_planned_number 向上取整
        warehouse_material_select_sql_results = get_warehouse_materials(material_id=ori_m)
        for item in warehouse_material_select_sql_results:
            warehouse_material_id, warehouse_id, left_number = item['id'], item['warehouse_id'], item['left_number']
            used_number = min(left_number, ori_planned_number)
            ori_planned_number -= used_number
            left_number -= used_number
            update_warehouse_materials(warehouse_material_id=warehouse_material_id, left_number=left_number)
            if ori_planned_number == 0:
                break
        if ori_planned_number > 0:
            print(
                'Not enough original material {} in warehouse. Please purchase more. {} additional units are required.'.format(
                    ori_m, ori_planned_number)
            )

    return result

def find_working_group_name(work_group_id: str):
    working_group_select_sql = f'''
        SELECT name FROM working_groups WHERE id = '{work_group_id}';
    '''
    working_group_select_sql_results, working_group_select_sql_res_str = mysql_db.execute_sql(working_group_select_sql)
    return working_group_select_sql_results
def allocate_sewing_task(order_product_id: str, planned_number: int, working_group_id: str):

    # add UUID as id
    sewing_task_insert_sql = f''' INSERT INTO sewing_tasks (id, order_product_id, planned_number, completed_number, working_group_id, status)
    VALUES (UUID(), '{order_product_id}', {planned_number}, 0, '{working_group_id}', 0);
    '''
    result = mysql_db.execute_sql(sewing_task_insert_sql)
    # query the id of the inserted sewing task
    
    if 'successfully' in result[1]:
        return 'Allocate sewing task to {}, .'.format(
            find_working_group_name(work_group_id=working_group_id)[0]['name'],

        )
    return result



# 寻找最空闲的cutting group
def find_cutting_group_working_load():
    cutting_group_select_sql = f'''
        SELECT working_group_id, SUM(planned_number - completed_number) AS unfinished_workload
        FROM cutting_tasks
        WHERE status != 2
        GROUP BY working_group_id;
    '''
    cutting_group_select_sql_results, cutting_group_select_sql_res_str = mysql_db.execute_sql(cutting_group_select_sql)
    return cutting_group_select_sql_results

def find_sewing_group_working_load():
    sewing_group_select_sql = f'''
        SELECT working_group_id, SUM(planned_number - completed_number) AS unfinished_workload
        FROM sewing_tasks
        WHERE status != 2
        GROUP BY working_group_id;
    '''
    sewing_group_select_sql_results, sewing_group_select_sql_res_str = mysql_db.execute_sql(sewing_group_select_sql)
    return sewing_group_select_sql_results



@tool(parse_docstring=True)
def allocate_task_order(order_id: Optional[str] = None, order_name: Optional[str] = None) -> str:
    """ Allocate the cutting task and sewing tasks for all products belonging to the order, and return
    the allocated tasks and corresponding working groups.

    Args:
        order_id: The order ID, a string generally starting with 'o'.
    """

    if order_name is None:
        condition = f"o.id = '{order_id}'"
    else:
        condition = f"o.order_name = '{order_name}'"

    # 使用条件拼接SQL语句
    order_product_select_sql = f"""SELECT op.id, op.product_id, op.number 
        FROM order_product op
        JOIN orders o ON op.order_id = o.id
        WHERE {condition};"""

    order_product_select_sql_results, order_product_select_sql_res_str = mysql_db.execute_sql(order_product_select_sql)



    for item in order_product_select_sql_results:
        order_product_id, product_number, product_id = item['id'], item['number'], item['product_id']

        # find the most idle sewing group and allocate the sewing task
        sewing_group_select_sql_results = find_sewing_group_working_load()
        most_idle_sewing_group = min(sewing_group_select_sql_results, key=lambda x: x['unfinished_workload'])
        allocate_sewing_task(order_product_id=order_product_id, planned_number=product_number, working_group_id=most_idle_sewing_group['working_group_id'])

        # for m, required_number in material_select_sql_results:
        material_select_sql_results = get_wip_materials(product_id=product_id)
        for item in material_select_sql_results:
            m, required_number = item['material_id'], item['number']
            total_required_number = required_number * product_number

            warehouse_material_select_sql_results = get_warehouse_materials(material_id=m)
            for item in warehouse_material_select_sql_results:
                warehouse_material_id, warehouse_id, left_number = item['id'], item['warehouse_id'], item['left_number']
                used_number = min(left_number, total_required_number)
                total_required_number -= used_number
                left_number -= used_number
                update_warehouse_materials(warehouse_material_id=warehouse_material_id, left_number=left_number)
                if total_required_number == 0:
                    break
            if total_required_number > 0:
                cutting_group_select_sql_results = find_cutting_group_working_load()
                most_idle_cutting_group = min(cutting_group_select_sql_results, key=lambda x: x['unfinished_workload'])
                allocate_cutting_task(order_product_id=order_product_id, produced_wip_id=m, planned_number=total_required_number, working_group_id=most_idle_cutting_group['working_group_id'])






















    # product_select_sql = f"""SELECT * FROM products WHERE id = {};"""

if __name__ == '__main__':
    # allocate_task_order(order_name="PolyU_Tshirt")
    allocate_task_order.invoke({'order_name': 'PolyU_Tshirt'})
    allocate_task_order.invoke({'order_id': 'o10'})










