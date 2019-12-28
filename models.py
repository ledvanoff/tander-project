# -*- coding: utf-8 -*-

import sqlite3
DB_NAME = 'database.db'

def create_db():
    with open('script.sql','r',encoding='utf8') as sql_script:
        readed_script = sql_script.read()
    con = sqlite3.connect(DB_NAME)
    cursor = con.cursor()
    cursor.executescript(readed_script)
    con.close()

def do_dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

def fetch_all(query, executed):
    records = executed.fetchall()
    return records

def execute_db_query(query, executor, db_name=DB_NAME, factory=True):
    con = sqlite3.connect(db_name)
    if factory:
        con.row_factory = do_dict_factory
    cursor = con.cursor()
    executed = cursor.execute(query)
    result = executor(query,executed)
    con.close()
    return result

def get_all_comments():
    #query = """SELECT * from Comments""" 
    query = """SELECT Comments.id, last_name, first_name, third_name, phone, email, comment, city_name, region_name FROM Comments INNER JOIN Cities ON Cities.id = Comments.city_id INNER JOIN Regions ON Regions.id = Comments.region_id;""" 
    all_comments = execute_db_query(query, fetch_all)
    return all_comments