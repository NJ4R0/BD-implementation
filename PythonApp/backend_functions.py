#!/usr/bin/python3
# -*- utf8 -*-

import pymysql as mariadb
import re as regexp
import rsa


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
    isinstance(connection, mariadb.Connection.__class__)
    cursor = connection.cursor()
    try:
        cursor.execute(statement)
        connection.commit()
        return cursor.fetchall()
    except Exception as e:
        connection.rollback()
        print("something went wrong")


def signup_user(username, email, password):
    """
    creates user account
    :param username:
    :param email:
    :param password:
    :return: returns False if there was some error and True if user created succesfully
    """
    if not regexp.match('[A-Za-z0-9]{1,32}', username):
        print("username must contain only letters and digits, must contain at least 1 character and max 32")
        return False
        # TODO: if needed in GUI, throw as Exception
    if not regexp.match('^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$', email):
        print("email invalid")
        return False
    try:
        (pub, priv) = rsa.newkeys(1024)
        signature=rsa.sign(password.encode('utf-8'), priv, 'SHA-512').hex()
        key = rsa.PublicKey.save_pkcs1(pub, 'DER')
        execute_sql_command(
            database_connect('localhost', 'user', 'userpassword'),
            "CALL add_user( " + username + ", " + email + ", " + signature + ", " + key + " )"
        )
        return True
    except Exception as e:
        return False


# def validate_user(email, password):

