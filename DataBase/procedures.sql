# ©Jarosław Nigiel
USE `tu_wpisz_tytul`;

DELIMITER $$
DROP PROCEDURE IF EXISTS add_user;
CREATE PROCEDURE add_user(nick VARCHAR(32), mail VARCHAR(128), passhash VARCHAR(128)) #comment: password is not necessary to know in any stage of server, and that will provide more safety
  BEGIN
    IF(!(nick REGEXP '^[a-zA-Z0-9]+$' ))
      THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'NickName can contain only letters and digits';
    END IF;
    IF(!(passhash REGEXP '^[0-9a-f]+$' ))
      THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'wrong password format';
    END IF;
    IF(!(mail REGEXP '^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$')) #source: official regexp from W3C, on site "http://emailregex.com/"
    THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Email incorrect';
    END IF;
    INSERT INTO users(EMail, NickName) VALUE (mail, nick);
    INSERT INTO valdata(EMail, Password, Salt) VALUE (mail, passhash, ''); # TODO: change passhash into RSA protocol
    INSERT INTO accountsettings(NickName) VALUE (nick);
  END
$$

DELIMITER $$
DROP PROCEDURE IF EXISTS add_currency;
CREATE PROCEDURE add_currency(name char(3), fToPLN FLOAT)
  BEGIN
    IF !(name REGEXP '^[A-Z]{3}$')
      THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Currency name must be 3-letter tag';
    END IF;
    IF ((SELECT count(*) FROM currencies WHERE Currency = name)=0)
      THEN
        INSERT INTO currencies VALUE (name, fToPLN);
      ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Currency already exists';
    END IF;
  END
$$

DELIMITER $$
DROP PROCEDURE IF EXISTS set_account_settings;
CREATE PROCEDURE set_account_settings(nick VARCHAR(32), budget float, startofmonth int(11))
  BEGIN
    UPDATE accountsettings
      SET BudgetPerMonth = budget WHERE budget IS NOT NULL AND nick = NickName;
    UPDATE accountsettings
      SET MonthStart = startofmonth WHERE startofmonth IS NOT NULL AND nick = NickName;
  END
$$
