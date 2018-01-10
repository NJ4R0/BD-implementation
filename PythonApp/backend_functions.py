#!/usr/bin/python3
# -*- utf8 -*-

import pymysql as mariadb


def database_connect(dbhost, dbuser, dbpasswd):
    """
    this function connects to mariadb server.
    dbhost is name or IP Address of the server (usually localhost)
    dbuser is name of user in the database server (not the App user!)
    dbpasswd is password of that user
    """
    conn = mariadb.connect(
        host=dbhost,
        user=dbuser,
        passwd=dbpasswd,
        db='tu_wpisz_tytul',
        charset='utf8'
    )
    return conn


