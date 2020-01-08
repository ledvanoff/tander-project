# -*- coding: utf-8 -*-

import sqlite3
from collections import Counter

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

def fetch_all(**kwargs):
    records = kwargs['executed'].fetchall()
    return records

def do_commit(**kwargs):
    return kwargs['con'].commit()

def execute_db_query(query, executor, db_name=DB_NAME, factory=True):
    con = sqlite3.connect(db_name)
    if factory:
        con.row_factory = do_dict_factory
    cursor = con.cursor()
    executed = cursor.execute(query)
    result = executor(con=con,executed=executed)
    con.close()
    return result

def get_all_comments():
    query = """SELECT Comments.id, last_name, first_name, third_name, phone, email, comment, city_name, region_name FROM Comments INNER JOIN Cities ON Cities.id = Comments.city_id INNER JOIN Regions ON Regions.id = Comments.region_id;""" 
    all_comments = execute_db_query(query, fetch_all)
    return all_comments

def delete_by_id(id):
    query = f'DELETE FROM "Comments" WHERE id = {id}'
    try:
        execute_db_query(query,do_commit)
        return {'status' : 'ok'}
    except Exception as e:
        return {
            'status' : 'err',
            'err_text' : str(e)
        }

def get_regions():
    query = 'SELECT * FROM Regions'
    regions = execute_db_query(query, fetch_all)
    return regions

def get_cities_by_id(id):
    query = f'SELECT id,city_name FROM "Cities" WHERE region_id = {id}'
    cities = execute_db_query(query, fetch_all)
    return cities

def add_comment(comment):
    query = f'''INSERT INTO "Comments" ("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id") VALUES ("{comment['lastName']}", "{comment['name']}", "{comment['patron']}", "{comment['phone']}", "{comment['email']}", "{comment['comment']}", "{comment['city']}", "{comment['region']}")'''
    print(query)
    try:
        execute_db_query(query,do_commit)
        return {'status' : 'ok'}
    except Exception as e:
        return {
            'status' : 'err',
            'err_text' : str(e)
        }

def get_all_cities():
    query = 'SELECT city_name, region_name FROM Cities INNER JOIN Regions ON Regions.id = region_id'
    all_cities = execute_db_query(query, fetch_all)
    return all_cities

def get_statistics():
    LIMIT = 5
    cities = get_all_cities()
    cities_match = {}
    for city in cities:
        cities_match[city['city_name']] = city['region_name']
    comments = get_all_comments()
    if not comments:
        return {'warn':'No comments'}
    all_regions = [comment['region_name'] for comment in comments]
    regions_stat = Counter(all_regions)
    all_cities = [comment['city_name'] for comment in comments]
    cities_stat = Counter(all_cities)
    statistics = []
    for k,v in regions_stat.items():
        if v >= LIMIT:
            statistics.append({'region':k,'total':v,'cities':{}})
    if len(statistics) == 0:
        return {'warn':'Not enough comments'}
    for item in statistics:
        for k,v in cities_stat.items():
            if cities_match[k] == item['region']:
                item['cities'][k] = v
    return statistics



if __name__ == "__main__":
    # create_db()
    get_statistics()
