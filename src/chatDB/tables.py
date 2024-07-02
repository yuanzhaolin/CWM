import re
import pandas as pd
import pymysql
from config import cfg
from mysql import MySQLDB
from fruit_shop_schema import tables
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from urllib.parse import quote


def get_table_info(create_table_sql):
    # Regex to match 'CREATE TABLE' followed by the table name
    pattern = r"CREATE TABLE (\w+)"
    match = re.search(pattern, create_table_sql, re.IGNORECASE)
    table_name = match.group(1)

    # Regex to match the column definitions starting with a lowercase letter
    # This pattern matches a word at the start of the line, followed by a space, followed by another word
    pattern = r"^\s*([a-z]\w*)\s+(\w+)"
    matches = re.findall(pattern, create_table_sql, re.MULTILINE)

    # The matches list now contains tuples with the column name and data type
    column_names = []
    column_types = []
    for column_name, data_type in matches:
        column_names.append(column_name)
        column_types.append(data_type)

    return table_name, column_names, column_types


def get_database_info(tables):
    database_info = dict()
    for tab in tables:
        table_name, column_names, column_types = get_table_info(tab)
        database_info[table_name] = {
            "column_names": column_names,
            "column_types": column_types,
        }
    return database_info


database_info = get_database_info(tables)
# table_details = "\n".join(tables)
table_details = """
-- 客户信息表
CREATE TABLE `customers` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '客户ID',
  `customer_name` VARCHAR(255) NOT NULL COMMENT '客户名称'
);

-- 订单信息表
CREATE TABLE `orders` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '订单ID',
  `user_id` VARCHAR(36) NOT NULL COMMENT '客户ID',
  `order_name` VARCHAR(255) NOT NULL COMMENT '订单名称',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单创建时间'
);

-- 产品类型表
CREATE TABLE `products_types` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '产品类型ID',
  `description` VARCHAR(255) NOT NULL COMMENT '产品类型描述'
);

-- 产品表
CREATE TABLE `products` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '产品ID',
  `products_type_id` VARCHAR(36) NOT NULL COMMENT '产品类型ID',
  `attributes` VARCHAR(255) NOT NULL COMMENT '产品属性'
);

-- 原料表
CREATE TABLE `materials` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '原料ID',
  `name` VARCHAR(255) NOT NULL COMMENT '原料名称',
  `unit` VARCHAR(255) NOT NULL COMMENT '原料单位',
  `type` ENUM('wip', 'origin') NOT NULL COMMENT '原料类型'
);

-- 订单产品关系表
CREATE TABLE `order_product` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '订单产品ID', 
  `order_id` VARCHAR(36) NOT NULL COMMENT '订单ID',
  `product_id` VARCHAR(36) NOT NULL COMMENT '产品ID',
  `number` INTEGER NOT NULL DEFAULT 0 COMMENT '订单产品数量'
);

-- 工作组表
CREATE TABLE `working_group` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '工作组ID',
  `type` ENUM('sew', 'cut') NOT NULL COMMENT '工作组类型，缝纫小组、裁剪小组',
  `name` VARCHAR(255) NOT NULL COMMENT '工作组名称'
);

-- 订单产品裁剪任务表
CREATE TABLE `cutting_tasks` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '裁剪任务ID',
  `start_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '裁剪任务开始时间',
  `end_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '裁剪任务结束时间',
  `working_group_id` VARCHAR(36) NOT NULL COMMENT '工作组ID',
  `order_product_id` VARCHAR(36) NOT NULL COMMENT '订单产品ID',
  `planned_number` INTEGER NOT NULL DEFAULT 0 COMMENT '计划裁剪数量',
  `completed_number` INTEGER NOT NULL DEFAULT 0 COMMENT '已完成裁剪数量',
  `is_started` BOOLEAN NOT NULL DEFAULT FALSE COMMENT '裁剪任务是否已开始'
);

-- 订单产品缝纫任务表
CREATE TABLE `sewing_tasks` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '缝纫任务ID',
  `start_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '缝纫任务开始时间',
  `end_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '缝纫任务结束时间',
  `working_group_id` VARCHAR(36) NOT NULL COMMENT '工作组ID',
  `order_product_id` VARCHAR(36) NOT NULL COMMENT '订单产品ID',
  `planned_number` INTEGER NOT NULL DEFAULT 0 COMMENT '计划缝纫数量',
  `completed_number` INTEGER NOT NULL DEFAULT 0 COMMENT '已完成缝纫数量',
  `is_started` BOOLEAN NOT NULL DEFAULT FALSE COMMENT '缝纫任务是否已开始'
);

-- 订单产品裁剪任务原料分配表
CREATE TABLE `cutting_material_allocation` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '裁剪任务原料分配ID',
  `warehouse_material_id` VARCHAR(36) NOT NULL COMMENT '仓库原料ID',
  `cutting_task_id` VARCHAR(36) NOT NULL COMMENT '裁剪任务ID',
  `allocated_num` INTEGER NOT NULL DEFAULT 0 COMMENT '原料分配数量',
  `is_allocated` BOOLEAN NOT NULL DEFAULT FALSE COMMENT '原料是否已分配'
);

-- 订单产品缝纫任务原料分配表
CREATE TABLE `sewing_material_allocation` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '缝纫任务原料分配ID',
  `warehouse_material_id` VARCHAR(36) NOT NULL COMMENT '仓库原料ID',
  `sewing_task_id` VARCHAR(36) NOT NULL COMMENT '缝纫任务ID',
  `allocated_num` INTEGER NOT NULL DEFAULT 0 COMMENT '原料分配数量',
  `is_allocated` BOOLEAN NOT NULL DEFAULT FALSE COMMENT '原料是否已分配'
);

-- 仓库表
CREATE TABLE `warehouse` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '仓库ID',
  `name` VARCHAR(255) NOT NULL COMMENT '仓库名称'
);

-- 仓库产品关系表
CREATE TABLE `warehouse_product` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '仓库产品ID',
  `warehouse_id` VARCHAR(36) NOT NULL COMMENT '仓库ID',
  `product_id` VARCHAR(36) NOT NULL COMMENT '产品ID',
  `left_number` INTEGER NOT NULL DEFAULT 0 COMMENT '产品剩余库存数量'
);

-- 仓库原料关系表
CREATE TABLE `warehouse_material` (
  `id` VARCHAR(36) PRIMARY KEY COMMENT '仓库原料ID',
  `warehouse_id` VARCHAR(36) NOT NULL COMMENT '仓库ID',
  `material_id` VARCHAR(36) NOT NULL COMMENT '原料ID',
  `left_number` INTEGER NOT NULL DEFAULT 0 COMMENT '原料剩余库存数量'
);
"""
# print("*****************table details*****************")
# print(table_details)

def init_database(database_info=None, db_name=None):
    # global mysqldb
    # print(cfg.mysql_host, cfg.mysql_user, cfg.mysql_password, cfg.mysql_port, db_name)
    if hasattr(cfg, 'mysql_database'):
        mysqldb = MySQLDB(host=cfg.mysql_host, user=cfg.mysql_user, password="Fashion!@#",
                          port=cfg.mysql_port, database=cfg.mysql_database)
    else:
        mysqldb = MySQLDB(host=cfg.mysql_host, user=cfg.mysql_user, password="Fashion!@#",
                          port=cfg.mysql_port, database='fashion')

    return mysqldb
    # print(mysqldb)
    # mysqldb.create_database(db_name)
    # for tab_crate_cmd in tables:
    #     mysqldb.execute_sql(tab_crate_cmd)
    # from sqlalchemy import create_engine
    # from urllib.parse import quote

    # create database engine
    # connect_str = "mysql+pymysql://{user}:{pw}@{host}/{db}".format(user=cfg.mysql_user,
    #                                pw=quote(cfg.mysql_password),
    #                                host=cfg.mysql_host,
    #                                db=db_name)
    # print(connect_str)
    # engine = create_engine(connect_str)
    # print(database_info)
    # read csv data
    # conn = pymysql.connect(
    #         host=cfg.mysql_host,
    #         port=cfg.mysql_port,
    #         user=cfg.mysql_user,
    #         password=cfg.mysql_password,
    #         database=db_name
    #     )
    # for tab_name in database_info.keys():
    #     df = pd.read_csv(f'csvs/{tab_name}.csv')
    #     # write data to MySQL database
    #     df.to_sql(tab_name, con=conn, if_exists='append', index=False)
    # return mysqldb

# def init_database(database_info, db_name):
#     # global mysqldb
#     mysqldb = MySQLDB(host=cfg.mysql_host, user=cfg.mysql_user, password=cfg.mysql_password,
#                       port=cfg.mysql_port, database=None)
#     # print(mysqldb)
#     mysqldb.create_database(db_name)
#     for tab_crate_cmd in tables:
#         mysqldb.execute_sql(tab_crate_cmd)

#     # create database engine
#     engine = create_engine("mysql+pymysql://{user}:{pw}@{host}/{db}"
#                            .format(user=cfg.mysql_user,
#                                    pw=quote(cfg.mysql_password),
#                                    host=cfg.mysql_host,
#                                    db=db_name))

#     # Create a configured "Session" class
#     Session = sessionmaker(bind=engine)

#     # Create a Session
#     session = Session()

#     try:
#         # read csv data and write to MySQL database using the session connection
#         for tab_name in database_info.keys():
#             df = pd.read_csv(f'csvs/{tab_name}.csv')
#             df.to_sql(tab_name, con=session.connection(), if_exists='append', index=False)
        
#         session.commit()
        
#     except Exception as e:
#         session.rollback()
#         raise e
    
#     finally:
#         session.close()

#     return mysqldb


if __name__ == '__main__':
    print(database_info)
    print(table_details)
    # test_db_name = "try1024"
    # init_database(database_info, test_db_name)
