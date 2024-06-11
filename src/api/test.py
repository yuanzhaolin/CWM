#!/usr/bin/python
# -*- coding:utf8 -*-
from fashion import get_data

if __name__ == '__main__':
    # query = input('Please input your query: ')
    query = '香港理工大学全部订单'
    data, err = get_data(query)
    if err:
        print(f'Error: {err}')
    else:
        print(data)
    connection = pymysql.connect(host=host, port=port, user=user, password=password, database=database,
                                 cursorclass=pymysql.cursors.DictCursor)
    cursor = connection.cursor()
    cursor.execute(sql)
    rows = cursor.fetchall()
    json.dumps(rows, default=datetime_to_str, ensure_ascii=False)