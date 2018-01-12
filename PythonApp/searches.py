from PythonApp.dbconnection import *
import re as regexp
from flask import json


def list_all_shops() -> tuple:
    """
    lists all shops
    example usage:
    xd = list_all_shops()
    xd[i][0] - ID of shop in i position
    xd[i][1] - name of shop in i position
    :return: returns a tuple of shops.
    """
    try:
        connection = database_connect(CONST_DBHOST, CONST_DBUSER, CONST_DBPASSWD)
        shops = execute_sql_command(connection, "SELECT * FROM shops")
        shops_dict = []
        for shop in shops:
            shop_dict = {
            'Name': shop[0],
            'Address': shop[1],
            'Country': shop[2],
            'City': shop[3]}
            shops_dict.append(shop_dict)

        return json.dumps(shops_dict)
    except Exception as e:
        print(e)


def simple_list_my_transactions(username: str):
    """
    lists all user's transactions
    :param username: name of user
    :return: returns list of transactions in json
    """
    if not regexp.match('[A-Za-z0-9]+'):
        return Exception
    try:
        connection = database_connect()
        trans = execute_sql_command(
            connection,
            """
                SELECT `Transaction ID`, `Date`, NickName, SaleName, MoneySpent, Currency, ShopName, Category 
                FROM transactions 
                JOIN categories c ON transactions.SaleName = c.SaleName
                JOIN shops s ON transactions.ShopID = s.ShopID
                WHERE NickName = '{0}'
            """.format(username)
        )
        ret = []
        for t in trans:
            ret.append({
                    'ID': t[0],
                    'Datte': t[1],
                    'Nick': t[2],
                    'Sale': t[3],
                    'Cost': t[4],
                    'Currency': t[5],
                    'Shop': t[6],
                    'Cat': t[7]
            })
        return json.dumps(ret)
    except Exception as e:
        return e


def list_routines(username: str):
    if not regexp.match('[A-Za-z0-9]+', username):
        return NameError
    try:
        routines = execute_sql_command(database_connect(),
                                       "SELECT * FROM routines WHERE NickName = '{0}';".format(username)
                                       )
        rout_ret = []
        for rout in routines:
            rout_ret.append({
                'Name': rout[0],
                'Nick': rout[1],
                'Fdate': rout[2],
                'Ldate': rout[3],
                'Dayy': rout[4],
                'Cost': rout[5],
                'Curr': rout[6]
            })
        return json.dumps(rout_ret)
    except Exception as e:
        return e


def list_favourites(username: str) -> json:
    if not regexp.match('[A-Za-z0-9]+', username):
        return NameError
    try:
        fav = execute_sql_command(
            database_connect(),
            """
                SELECT NickName, FavouriteName, ShopName, Cost, Currency, Category
                FROM favourites 
                  JOIN shops ON favourites.ShopID = shops.ShopID 
                  JOIN categories ON FavouriteName = SaleName
                WHERE NickName = '{0}'""".format(username)
        )
        ret = []
        for f in fav:
            ret.append({
                    'Nick': f[0],
                    'Name': f[1],
                    'Shop': f[2],
                    'Cost': f[3],
                    'Curr': f[4],
                    'Cat': f[5]
            })
        return json.dumps(ret)
    except Exception as e:
        return e
