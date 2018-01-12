from PythonApp.dbconnection import *
import re as regexp
from flask import json


def add_transaction(
        date: str,
        username: str,
        transactionname: str,
        categoryname: str,
        price,
        currency: str,
        shopname: str
) -> bool:
    if not regexp.match('^\d\d\d\d-\d\d-\d\d$', date):
        print("wrong date format")
        return False
    if not (
            regexp.match('[A-Za-z0-9]+', username) and
            regexp.match('[A-Za-z0-9]+', transactionname) and
            regexp.match('[A-Z]{3}', currency) and
            regexp.match('[A-Za-z0-9]', shopname) and
            regexp.match('[A-Za-z]', categoryname) and
            regexp.match('\d+([.,]\d{2})?', price)
    ):
        return False
    try:
        execute_sql_command(
            database_connect(),
            "CALL add_transaction( {0}, \'{1}\', \'{2}\', \'{3}\', {4}, \'{5}\', \'{6}\');".format(date, username,
                                                                                                   transactionname,
                                                                                                   categoryname,
                                                                                                   str(price), currency,
                                                                                                   shopname)
        )
        return True
    except Exception as e:
        print(e)
        return False


def monthly_balance(
        month: int,
        year: int,
        username: str
) -> dict:
    if not regexp.match('[A-Za-z0-9]+', username):
        return {'stacktrace': 'don\'t be a hacker!'}
    try:
        transactions = execute_sql_command(
            database_connect(),
            """SELECT  accountsettings.BudgetPerMonth, SUM(transactions.MoneySpent) 
                FROM transactions JOIN accountsettings ON transactions.NickName = accountsettings.NickName
                WHERE YEAR(transactions.Date) = {0} 
                AND (
                  (MONTH(transactions.Date) = {1} AND DAY(transactions.Date)>=accountsettings.MonthStart) 
                  OR 
                  ({1}<>12 AND MONTH(transactions.Date) = {1}+1 AND DAY(transactions.Date)<accountsettings.MonthStart)
                  OR 
                  ({1}=12 AND MONTH(transactions.Date) = 1 AND DAY(transactions.Date)<accountsettings.MonthStart))
                AND transactions.NickName = \'{2}\'
                GROUP BY NickName;
            """.format(str(year), str(month), username)
        )
        return json.dumps([{'Total': transactions[0][0],
                            'Spent': transactions[0][1],
                            'Left':  str(float(transactions[0][0])-float(transactions[0][1]))}])
    except Exception as e:
        return {'stacktrace': e}
