#!/usr/bin/python3
# -*- utf8 -*-

import re as regexp
import rsa
from binascii import unhexlify
from PythonApp.dbconnection import *

"""
this file contains functions to create and validate user
"""


def signup_user(username: str, email: str, password: str) -> bool:
    """
    creates user account
    :param username: nick of user created
    :param email: email of user created
    :param password: password for user created
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
        signature = rsa.sign(password.encode('utf-8'), priv, 'SHA-512').hex()
        key = rsa.PublicKey.save_pkcs1(pub, 'DER').hex()
        execute_sql_command(
            database_connect(CONST_DBHOST, CONST_DBUSER, CONST_DBPASSWD),
            "CALL add_user( \'" + username + "\', \'" + email + "\', \'" + signature + "\', \'" + key + "\', 'N' )"
        )  # TODO: localhost
        return True
    except Exception as e:
        print(e)
        return False


def validate_user(email: str, password: str) -> bool:
    """
    checks if email and password are correct
    :param email: email of user
    :param password: password of user
    :return:
    """
    if not regexp.match('^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$', email):
        print("email incorrect")
        return False

    try:
        (signature, key) = execute_sql_command(
            database_connect(CONST_DBHOST, CONST_DBUSER, CONST_DBPASSWD),
            "SELECT valdata.Password, valdata.key FROM valdata WHERE EMail = '{0}'".format(email)
        )[0]  # TODO: localhost
        pubkey = rsa.PublicKey.load_pkcs1(unhexlify(key), 'DER')
        return rsa.verify(password.encode('utf-8'), unhexlify(signature), pubkey)

    except Exception as e:
        print("some error occured. if your password and email is correct please contact our programmer")
        return False


def set_monthly_budget(username: str, amount: float) -> bool:
    if not regexp.match('[A-Za-z0-9]+', username):
        print("username invalid")
        return False
    try:
        execute_sql_command(
            database_connect(),
            "UPDATE accountsettings SET BudgetPerMonth = {0} WHERE NickName = \'{1}\';".format(str(amount), username)
        )
        return True
    except Exception as e:
        print(e)
        return False


def set_month_start(username: str, monthday: int) -> bool:
    if not regexp.match('[A-Za-z0-9]+', username):
        print("username invalid")
        return False
    if monthday>28 or monthday < 1:
        print("day of the month is too big or too small")
        return False
    try:
        execute_sql_command(
            database_connect(),
            "UPDATE accountsettings SET MonthStart = {0} WHERE NickName = {1}".format(str(monthday), username)
        )
        return True
    except Exception as e:
        print(e)
        return False

