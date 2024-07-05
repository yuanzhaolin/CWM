#!/usr/bin/python
# -*- coding:utf8 -*-
from fashion import get_data
from fashion import generate_response
import json
import argparse

parser = argparse.ArgumentParser()

parser.add_argument('--model', type=str, default='gpt-3.5-turbo')

args = parser.parse_args()

user = [
    "What are the orders for PolyU?",
    "What is the order status of John?",
    "What is the production progress of the Dress ordered by Emily?",
    "What products are included in James's order?",
    "When was Sophia's order created?",
    "What products are included in PolyU's January orders?",
    "How many orders are there in total under PolyU?",
    "What materials were used in Olivia's order?",
    "What is the progress of sewing tasks for William?",
    "When is Michael's order expected to be completed?",
    "Create a cutting task for the order from the Hong Kong Polytechnic University on May 10th, with a task period from June 30th to July 12th, and the cutting team responsible is Expert Cutters. Other fields are temporarily left blank. Return the cropping task number."
]

production_manager = [
    "What are the current cutting tasks in progress?",
    "What are the current sewing tasks in progress?",
    "What is the material with the highest remaining inventory?",
    "What is the material with the lowest remaining inventory?",
    "What are the current cutting tasks not yet started?",
    "What are the current sewing tasks not yet started?",
    "Which cutting tasks use Cotton Fabric?",
    "Which sewing tasks use Silk?",
    "Which products have zero remaining inventory?",
    "List the work tasks of the Skilled Sewers sewing team in the past 5 days.",
    "Start production for James_Skirt's order.",
    "Which tasks are nearing completion?",
    "For the cutting task with the number sw34, allocate cutting materials from Cotton Fabric in Main Warehouse, 30 meters.",
    "Materials are stored in the Main Warehouse and 1000 Leathers are stored.",
    "The product is stored in the Auxiliary warehouse, with 100 pieces of product p15 being stored."
]

sewer = [
    "What are the current sewing tasks assigned to Elite Sewers?",
    "Which sewing tasks have been completed by Master Sewers?",
    "Which materials were used by Skilled Sewers?",
    "What are the unfinished tasks for Advanced Sewers?",
    "What are the sewing tasks for PolyU's orders at Hong Kong Polytechnic University?",
    "What are the sewing tasks for Premier Sewers?",
    "Which sewing tasks are for products categorized as Dress?"
]

cutter = [
    "What are the current cutting tasks assigned to Precision Cutters?",
    "Which cutting tasks have been completed by Master Cutters?",
    "Which materials were used in the cutting tasks by Expert Cutters?",
    "What are the unfinished tasks in the cutting tasks by Professional Cutters?",
    "Which orders are from PolyU in the cutting tasks?",
    "Which planned cutting task has the highest quantity?",
    "How is the progress of cutting tasks by Advanced Cutters?",
    "Which cutting tasks use Leather?",
    "Which cutting tasks are for products categorized as T-shirt?"
]

if __name__ == '__main__':
    id = 1
    with open(f'../../questions/q0702/{id}.json', 'r', encoding='utf-8') as file:
        question = json.load(file)
    query = question["q_en"]

    data, err = get_data(query, model=args.model, return_sql=True)

    sql = json.loads(data)['sql']
    rows = json.loads(data)['rows']
    execution_time = json.loads(data)['time']
    thought = json.loads(data)['thought']

    if err:
        print(f'Error: {err}')

    else:
        print('#' * 50 + ' Result of executing SQL ' + '#' * 50)
        print(rows)
        response = generate_response(
            user_query=f'''
            Please use the content within the <Context></Context> tags as your knowledge to answer user questions.
            <Context>
            SQL query used to retrieve data from the database:
            {sql},
            Data retrieved from the database based on user questions:
            {rows}
            </Context>
            User question: {query}
            ''',
            system_query='',
            model="gpt-3.5-turbo"
        )

        print('#' * 50 + ' Response ' + '#' * 50)
        print(response)

        if 'gt' in question:
            del question['gt']
        question["thought"] = thought
        question["sqls"] = [{
            "command": sql,
            "execution time": execution_time,
            "Result of executing SQL": rows,
        }]
        question["answer"] = response
        with open(f'../../outputs/gpt35/{id}.json', 'w', encoding='utf-8') as file:
            json.dump(question, file, ensure_ascii=False, indent=4)
