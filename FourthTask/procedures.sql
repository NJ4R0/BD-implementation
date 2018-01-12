# ©Jarosław Nigiel
USE `tu_wpisz_tytul`;

DELIMITER $$
DROP PROCEDURE IF EXISTS add_user;
CREATE PROCEDURE add_user(nick VARCHAR(32), mail VARCHAR(128), passhash VARCHAR(256), pkey VARCHAR(280), answer CHAR(1)) #comment: password is not necessary to know in any stage of server, and that will provide more safety
  BEGIN
    IF (!(nick REGEXP '^[a-zA-Z0-9]+$'))
    THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'NickName can contain only letters and digits';
    END IF;
    IF (!(passhash REGEXP '^[0-9a-f]+$'))
    THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'wrong password format';
    END IF;
    IF (!(mail REGEXP
          '^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$')) #source: official regexp from W3C, on site "http://emailregex.com/"
    THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Email incorrect';
    END IF;
    INSERT INTO valdata VALUE (mail, passhash, pkey);
    INSERT INTO accountsettings (NickName,BudgetPerMonth,MonthStart) VALUE (nick,1000,1);
    INSERT INTO users VALUE (mail, nick,answer);
  END
$$


DELIMITER $$
DROP PROCEDURE IF EXISTS set_account_settings;
CREATE PROCEDURE set_account_settings(nick VARCHAR(32), budget FLOAT, startofmonth INT(11))
  BEGIN
    UPDATE accountsettings
    SET BudgetPerMonth = budget
    WHERE budget IS NOT NULL AND nick = NickName;
    UPDATE accountsettings
    SET MonthStart = startofmonth
    WHERE startofmonth IS NOT NULL AND nick = NickName;
  END
$$

DELIMITER $$
DROP PROCEDURE IF EXISTS add_currency;
CREATE PROCEDURE add_currency(name CHAR(3), fToPLN FLOAT)
  BEGIN
    IF !(name REGEXP '^[A-Z]{3}$')
    THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Currency name must be 3-letter tag';
    END IF;
    IF ((SELECT count(*)
         FROM currencies
         WHERE Currency = name) = 0)
    THEN
      INSERT INTO currencies VALUE (name, fToPLN);
    ELSE
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Currency already exists';
    END IF;
  END
$$

DELIMITER $$
DROP PROCEDURE IF EXISTS add_shop;
CREATE PROCEDURE add_shop(name VARCHAR(64))
  BEGIN
    INSERT INTO shops(ShopName) VALUE (name);
  END
$$

DELIMITER $$
DROP PROCEDURE IF EXISTS describe_shop;
CREATE PROCEDURE describe_shop(name VARCHAR(64), caddress VARCHAR(80), ccountry VARCHAR(64), ccity VARCHAR(64))
  BEGIN
    INSERT INTO shopdetails VALUE(name, caddress, ccountry, ccity); #TODO: REGEXP values
  END
$$

DELIMITER $$
DROP PROCEDURE IF EXISTS add_transaction;
CREATE PROCEDURE add_transaction(time DATE, usernick VARCHAR(32), transactionname VARCHAR(64), categoryname VARCHAR(32), price FLOAT, cCurrency CHAR(3), shop VARCHAR(64))
  BEGIN
    IF (price<0)
      THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'price cannot be negative';
    END IF;
    IF (cCurrency NOT IN (SELECT Currency FROM currencies))
      THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'given currency does not exist in database';
    END IF;
    IF (shop NOT IN (SELECT ShopName FROM shops))
    THEN
      CALL add_shop(shop);
    END IF;
    IF(transactionname NOT IN (SELECT SaleName FROM categories))
    THEN
        IF(categoryname NOT IN (SELECT Category FROM categories))
        THEN
          SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'chosen category does not exist';
        ELSE
          INSERT INTO categories VALUE (transactionname, categoryname);
        END IF; # TODO: Warning if chosen category is not equal to existing pair in database
    END IF;
    INSERT INTO transactions(Date, NickName, SaleName, MoneySpent, Currency, ShopID) VALUE (time, usernick, transactionname, price, cCurrency, (SELECT ShopID FROM shops WHERE shop = ShopName LIMIT 1));
  END
$$