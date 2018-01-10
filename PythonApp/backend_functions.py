#!/usr/bin/python3
# -*- utf8 -*-

import pymysql as mariadb


def database_connect(dbhost, dbuser, dbpasswd):
    conn = mariadb.connect(
        host=dbhost,
        user=dbuser,
        passwd=dbpasswd,
        db='tu_wpisz_tytul',
        charset='utf8'
    )
    return conn


