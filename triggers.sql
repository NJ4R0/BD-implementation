USE `ProjectTask`;

-- Triggers for database
-- Validate data input and update values in tables

DELIMITER $$
CREATE TRIGGER crncies_insert BEFORE INSERT ON currencies
  FOR EACH ROW
  BEGIN
    IF (NEW.ToPLN <= 0) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong currency value input';
      END IF;
  END;
$$

DELIMITER $$
CREATE TRIGGER crncies_update BEFORE UPDATE ON currencies
  FOR EACH ROW
  BEGIN
    IF (NEW.ToPLN <= 0) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong currency value input';
      END IF;
  END;
$$

DELIMITER $$
CREATE TRIGGER account_insert BEFORE INSERT ON accountsettings
  FOR EACH ROW
  BEGIN
    IF (NEW.BudgetPerMonth <= 0 OR NEW.MonthStart <= 0 OR NEW.MonthStart >= 32) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong data input on budget or month day';
    END IF ;
  END
$$

DELIMITER $$
CREATE TRIGGER account_update BEFORE UPDATE ON accountsettings
  FOR EACH ROW
  BEGIN
    IF (NEW.BudgetPerMonth <= 0 OR NEW.MonthStart <= 0 OR NEW.MonthStart >= 32) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong data input on budget or month day';
    END IF ;
  END
$$

DELIMITER $$
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
CREATE TRIGGER user_insert BEFORE INSERT ON users
  FOR EACH ROW
  BEGIN
    IF ((NEW.EMail REGEXP '^[a-zA-Z0-9._]+@[a-zA-Z0-9._]+[.][a-zA-Z]{2,4}$') = 0) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Incorrect mail...';
    END IF ;
  END
$$

DELIMITER $$
CREATE TRIGGER val_insert BEFORE INSERT ON valdata
  FOR EACH ROW
  BEGIN
    IF ((NEW.EMail REGEXP '^[a-zA-Z0-9._]+@[a-zA-Z0-9._]+[.][a-zA-Z]{2,4}$') = 0) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Incorrect mail...';
    END IF ;
  END
$$



