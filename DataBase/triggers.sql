# ©Adam Friedensberg
USE `tu_wpisz_tytul`;

-- Triggers for database
-- Validate data input and update values in tables

DELIMITER $$
DROP TRIGGER IF EXISTS currencies_insert;
CREATE TRIGGER currencies_insert BEFORE INSERT ON currencies
  FOR EACH ROW
  BEGIN
    IF (NEW.ToPLN <= 0) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong currency value input';
      END IF;
  END;
$$

DELIMITER $$
DROP TRIGGER IF EXISTS currencies_update;
CREATE TRIGGER currencies_update BEFORE UPDATE ON currencies
  FOR EACH ROW
  BEGIN
    IF (NEW.ToPLN <= 0) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong currency value input';
      END IF;
  END;
$$

DELIMITER $$
DROP TRIGGER IF EXISTS account_insert;
CREATE TRIGGER account_insert BEFORE INSERT ON accountsettings
  FOR EACH ROW
  BEGIN
    IF (NEW.BudgetPerMonth < 0 OR NEW.MonthStart <= 0 OR NEW.MonthStart >= 32) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong data input on budget or month day';
    END IF ;
  END
$$

DELIMITER $$
DROP TRIGGER IF EXISTS account_update;
CREATE TRIGGER account_update BEFORE UPDATE ON accountsettings
  FOR EACH ROW
  BEGIN
    IF (NEW.BudgetPerMonth < 0 OR NEW.MonthStart <= 0 OR NEW.MonthStart >= 32) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong data input on budget or month day';
    END IF ;
  END
$$

DELIMITER $$
DROP TRIGGER IF EXISTS rout_insert;
CREATE TRIGGER rout_insert BEFORE INSERT ON routines
  FOR EACH ROW
  BEGIN
    IF (NEW.Cost <= 0 OR NEW.Day <= 0 OR NEW.Day >= 32) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong data input on cost or execution day';
    END IF ;
  END
$$

DELIMITER $$
DROP TRIGGER IF EXISTS fav_insert;
CREATE TRIGGER fav_insert BEFORE INSERT ON favourites
  FOR EACH ROW
  BEGIN
    IF (NEW.Cost <= 0) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong cost value input';
    END IF ;
  END
$$

DELIMITER $$
DROP TRIGGER IF EXISTS tran_insert;
CREATE TRIGGER tran_insert BEFORE INSERT ON transactions
  FOR EACH ROW
  BEGIN
    IF (NEW.MoneySpent <= 0) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong cost value input';
    END IF ;
  END
$$

DELIMITER $$
DROP TRIGGER IF EXISTS user_insert;
CREATE TRIGGER user_insert BEFORE INSERT ON users
  FOR EACH ROW
  BEGIN
    IF(!(NEW.EMail REGEXP '^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$')) #source: official regexp from W3C, on site "http://emailregex.com/"
    THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Incorrect mail...';
    END IF ;
  END
$$

DELIMITER $$
DROP TRIGGER IF EXISTS val_insert;
CREATE TRIGGER val_insert BEFORE INSERT ON valdata
  FOR EACH ROW
  BEGIN
    IF(!(NEW.EMail REGEXP '^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$')) #source: official regexp from W3C, on site "http://emailregex.com/"
    THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Incorrect mail...';
    END IF ;
  END
$$



