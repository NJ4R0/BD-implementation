USE `tu_wpisz_tytul`;

DELIMITER $$
CREATE PROCEDURE `sp_validateLogin`(
IN mail VARCHAR(128)
)
BEGIN
    select NickName, Password, Salt from valdata JOIN users ON valdata.EMail = users.EMail where mail = valdata.EMail COLLATE utf8mb4_general_ci ;
END$$
DELIMITER ;


DELIMITER $$
DROP PROCEDURE IF EXISTS add_routine;
CREATE PROCEDURE add_routine(ftime DATE, ltime DATE, dayy INT(11), usernick VARCHAR(32), transactionname VARCHAR(64), price FLOAT, cCurrency CHAR(3))
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
    INSERT INTO routines(RoutineName, NickName, FirstDate, LastDate, Day, Cost, Currency) VALUE (transactionname, usernick, ftime, ltime, dayy, price, cCurrency);
  END
$$


DELIMITER $$
DROP PROCEDURE IF EXISTS add_favourite;
CREATE PROCEDURE add_favourite(usernick VARCHAR(32), transactionname VARCHAR(64), price FLOAT, cCurrency CHAR(3), shop VARCHAR(64))
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
    INSERT INTO favourites(NickName, FavouriteName, ShopID, Cost, Currency) VALUE (usernick, transactionname, (SELECT ShopID FROM shops WHERE shop = ShopName LIMIT 1), price, cCurrency);
  END
$$

DELIMITER $$
CREATE PROCEDURE `show_tran`(
IN nickuser VARCHAR(32)
)
BEGIN
    select * from transactions RIGHT JOIN shops s ON transactions.ShopID = s.ShopID where nickuser = transactions.NickName;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `show_rout`(
IN nickuser VARCHAR(32)
)
BEGIN
    select * from routines where nickuser = routines.NickName;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `show_fav`(
IN nickuser VARCHAR(32)
)
BEGIN
    select * from favourites RIGHT JOIN shops s ON favourites.ShopID = s.ShopID where nickuser = favourites.NickName;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `show_shops`(
)
BEGIN
    select * from shopdetails;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE `get_budget`(
IN nickuser VARCHAR(32)
)
BEGIN
  SELECT BudgetPerMonth, SUM(MoneySpent) FROM accountsettings JOIN transactions ON accountsettings.NickName = transactions.NickName WHERE accountsettings.NickName = nickuser GROUP BY accountsettings.NickName;
END$$
DELIMITER ;


CALL show_rout('Flask');
CALL get_budget('Flask');

