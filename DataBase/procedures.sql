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
