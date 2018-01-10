#!/usr/bin/python3
# -*- utf8 -*-

import pymysql as mariadb


def database_connect(dbhost, dbuser, dbpasswd):
    """
    connects to database. you can store the return to some variable to not repeat that
    :param dbhost: name or IP of mariadb host
    :param dbuser: mariadb username
    :param dbpasswd: password of username
    :return: returns Connection class
    """
    conn = mariadb.connect(
        host=dbhost,
        user=dbuser,
        passwd=dbpasswd,
        db='tu_wpisz_tytul',
        charset='utf8'
    )
    return conn


def execute_sql_command(connection, statement): #Warning! that is insecure and musn't be used as GUI function!
    """
    executes any sql command
    :param connection: Connection class on wich query will operate
    :param statement: String to execute sql query
    :return: void
    """
    isinstance(connection, mariadb.Connection)
    cursor = connection.cursor()
    try:
        cursor.execute(statement)
        connection.commit()
    except Exception as e:
        connection.rollback()
        print("something went wrong")



