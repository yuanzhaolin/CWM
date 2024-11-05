#!/usr/bin/python
# -*- coding:utf8 -*-
import os
import json
import sys
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))+'/chatDB')
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

print(sys.path)
from chatdb import generate_chat_responses, init_database
mysql_db = init_database()

project_dir = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# load questions/q0702/*.json
filter_q = None
# filter_q = []

outputs_dir = os.path.join(project_dir, 'questions', '2024-10-31')
os.makedirs(outputs_dir, exist_ok=True)


def question_filter(q_name):
    # extract file name and to int
    q_name = int(q_name.split('.')[0])
    if filter_q is None:
        return True
    else:
        return q_name in filter_q


def handle_request(q):
    print(q)
    historical_message, context_abstract = [], ""
    sql_results, sql_commands, err, response, context_abstract = generate_chat_responses(
        user_inp=q, mysql_db=mysql_db, historical_message=historical_message, context_abstract=context_abstract
    )
    return sql_results, response
    # return None

for f in os.listdir(os.path.join(project_dir, 'questions/q0702')):
    if f.endswith('.json') and question_filter(f):
        print(f)
        with open(os.path.join(project_dir, 'questions/q0702', f), 'r') as file:
            q = json.loads(file.read())
            sql_results, response = handle_request(q['q_en'])
            q['steps'] = sql_results
            q['gt'] = response
            with open(os.path.join(outputs_dir, f), 'w', encoding='utf-8') as out:
                out.write(json.dumps(q, indent=4, ensure_ascii=False))
                # utf-8 encoding
        break





