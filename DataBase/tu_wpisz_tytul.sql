-- MySQL dump 10.16  Distrib 10.1.26-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: tu_wpisz_tytul
-- ------------------------------------------------------
-- Server version	10.1.26-MariaDB-1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accountsettings`
--

DROP TABLE IF EXISTS `accountsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountsettings` (
  `NickName` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `BudgetPerMonth` decimal(10,0) NOT NULL DEFAULT '0',
  `MonthStart` int(11) DEFAULT '1',
  `PremiumSavedMoney` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`NickName`),
  UNIQUE KEY `AccountSettings_NickName_uindex` (`NickName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountsettings`
--

LOCK TABLES `accountsettings` WRITE;
/*!40000 ALTER TABLE `accountsettings` DISABLE KEYS */;
INSERT INTO `accountsettings` (`NickName`, `BudgetPerMonth`, `MonthStart`, `PremiumSavedMoney`) VALUES ('Flask',1000,1,NULL),('Hiirokasu',1000,1,NULL),('janusz',1000,1,NULL),('Konrad',1000,1,NULL),('Python',1000,1,NULL),('Radek',1000,1,NULL);
/*!40000 ALTER TABLE `accountsettings` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER account_insert BEFORE INSERT ON accountsettings
  FOR EACH ROW
  BEGIN
    IF (NEW.BudgetPerMonth < 0 OR NEW.MonthStart <= 0 OR NEW.MonthStart >= 32) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong data input on budget or month day';
    END IF ;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8 COLLATE utf8_general_ci ;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER account_update BEFORE UPDATE ON accountsettings
  FOR EACH ROW
  BEGIN
    IF (NEW.BudgetPerMonth < 0 OR NEW.MonthStart <= 0 OR NEW.MonthStart >= 32) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong data input on budget or month day';
    END IF ;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8 COLLATE utf8_general_ci ;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `SaleName` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Category` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`SaleName`),
  UNIQUE KEY `Categories_SaleName_uindex` (`SaleName`),
  KEY `Categories_CategoryTags_CategoryName_fk` (`Category`),
  CONSTRAINT `Categories_CategoryTags_CategoryName_fk` FOREIGN KEY (`Category`) REFERENCES `categorytags` (`CategoryName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`SaleName`, `Category`) VALUES ('Ksiazka','Books'),('Python','Books'),('Skd','Books'),('Coffee','Drink'),('Hotdog','Food'),('Headphones','RTV');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorytags`
--

DROP TABLE IF EXISTS `categorytags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorytags` (
  `CategoryName` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`CategoryName`),
  UNIQUE KEY `CategoryTags_CategoryName_uindex` (`CategoryName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorytags`
--

LOCK TABLES `categorytags` WRITE;
/*!40000 ALTER TABLE `categorytags` DISABLE KEYS */;
INSERT INTO `categorytags` (`CategoryName`) VALUES ('Books'),('Drink'),('Food'),('RTV');
/*!40000 ALTER TABLE `categorytags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currencies` (
  `Currency` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ToPLN` decimal(10,0) NOT NULL,
  PRIMARY KEY (`Currency`),
  UNIQUE KEY `Currencies_Currency_uindex` (`Currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` (`Currency`, `ToPLN`) VALUES ('EUR',4),('PLN',1),('USD',3);
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER currencies_insert BEFORE INSERT ON currencies
  FOR EACH ROW
  BEGIN
    IF (NEW.ToPLN <= 0) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong currency value input';
      END IF;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8 COLLATE utf8_general_ci ;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER currencies_update BEFORE UPDATE ON currencies
  FOR EACH ROW
  BEGIN
    IF (NEW.ToPLN <= 0) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong currency value input';
      END IF;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8 COLLATE utf8_general_ci ;

--
-- Table structure for table `favourites`
--

DROP TABLE IF EXISTS `favourites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favourites` (
  `NickName` varchar(32) NOT NULL,
  `FavouriteName` varchar(64) NOT NULL,
  `ShopID` int(11) NOT NULL,
  `Cost` decimal(10,0) DEFAULT NULL,
  `Currency` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`NickName`,`FavouriteName`),
  UNIQUE KEY `Favourites_NickName_FavouriteName_uindex` (`NickName`,`FavouriteName`),
  KEY `Favourites_Currencies_Currency_fk` (`Currency`),
  KEY `Favourites_Shops_ShopID_fk` (`ShopID`),
  CONSTRAINT `Favourites_Currencies_Currency_fk` FOREIGN KEY (`Currency`) REFERENCES `currencies` (`Currency`) ON UPDATE CASCADE,
  CONSTRAINT `Favourites_Shops_ShopID_fk` FOREIGN KEY (`ShopID`) REFERENCES `shops` (`ShopID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favourites`
--

LOCK TABLES `favourites` WRITE;
/*!40000 ALTER TABLE `favourites` DISABLE KEYS */;
INSERT INTO `favourites` (`NickName`, `FavouriteName`, `ShopID`, `Cost`, `Currency`) VALUES ('Flask','Zakupy',1,20,'PLN'),('Konrad','asd',1,0,'USD');
/*!40000 ALTER TABLE `favourites` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER fav_insert BEFORE INSERT ON favourites
  FOR EACH ROW
  BEGIN
    IF (NEW.Cost <= 0) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong cost value input';
    END IF ;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8 COLLATE utf8_general_ci ;

--
-- Table structure for table `routines`
--

DROP TABLE IF EXISTS `routines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routines` (
  `RoutineName` varchar(64) NOT NULL,
  `NickName` varchar(32) NOT NULL,
  `FirstDate` date DEFAULT NULL,
  `LastDate` date DEFAULT NULL,
  `Day` int(11) DEFAULT NULL,
  `Cost` decimal(10,0) DEFAULT NULL,
  `Currency` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`RoutineName`,`NickName`),
  UNIQUE KEY `Routines_RoutineName_NickName_uindex` (`RoutineName`,`NickName`),
  KEY `Routines_Currencies_Currency_fk` (`Currency`),
  CONSTRAINT `Routines_Currencies_Currency_fk` FOREIGN KEY (`Currency`) REFERENCES `currencies` (`Currency`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routines`
--

LOCK TABLES `routines` WRITE;
/*!40000 ALTER TABLE `routines` DISABLE KEYS */;
INSERT INTO `routines` (`RoutineName`, `NickName`, `FirstDate`, `LastDate`, `Day`, `Cost`, `Currency`) VALUES ('Net','Flask','0000-00-00','0000-00-00',14,23,'PLN');
/*!40000 ALTER TABLE `routines` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER rout_insert BEFORE INSERT ON routines
  FOR EACH ROW
  BEGIN
    IF (NEW.Cost <= 0 OR NEW.Day <= 0 OR NEW.Day >= 32) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong data input on cost or execution day';
    END IF ;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8 COLLATE utf8_general_ci ;

--
-- Table structure for table `shopdetails`
--

DROP TABLE IF EXISTS `shopdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shopdetails` (
  `ShopName` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Address` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Country` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `City` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ShopName`,`Address`,`Country`,`City`),
  UNIQUE KEY `ShopDetails_Country_City_Address_uindex` (`ShopName`,`Country`,`City`,`Address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopdetails`
--

LOCK TABLES `shopdetails` WRITE;
/*!40000 ALTER TABLE `shopdetails` DISABLE KEYS */;
INSERT INTO `shopdetails` (`ShopName`, `Address`, `Country`, `City`) VALUES ('Asd','qweqe','Poland','Wroclaw'),('mojeTesco','dluga','Poland','Wroclaw'),('myTesco','Dluga Street','Poland','Wroclaw'),('Sks','Pwr','Poland','Wroclaw');
/*!40000 ALTER TABLE `shopdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shops`
--

DROP TABLE IF EXISTS `shops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shops` (
  `ShopID` int(11) NOT NULL AUTO_INCREMENT,
  `ShopName` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ShopID`),
  UNIQUE KEY `Shops_ShopID_uindex` (`ShopID`),
  UNIQUE KEY `Shops_ShopName_uindex` (`ShopName`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shops`
--

LOCK TABLES `shops` WRITE;
/*!40000 ALTER TABLE `shops` DISABLE KEYS */;
INSERT INTO `shops` (`ShopID`, `ShopName`) VALUES (3,'Asd'),(4,'mojeTesco'),(1,'myTesco'),(2,'Sks');
/*!40000 ALTER TABLE `shops` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER shop_insert BEFORE INSERT ON shops
  FOR EACH ROW
  BEGIN
    IF ((SELECT count(*) FROM shops WHERE NEW.ShopName=ShopName)<>0)
    THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'shop already exists';
    END IF;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8 COLLATE utf8_general_ci ;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER shop_update BEFORE UPDATE ON shops
  FOR EACH ROW
  BEGIN
    IF ((SELECT count(*) FROM shops WHERE NEW.ShopName=ShopName)<>0)
    THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'cannot change name to another. New name exists in database';
    END IF;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8 COLLATE utf8_general_ci ;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `Transaction ID` int(11) NOT NULL AUTO_INCREMENT,
  `Date` date DEFAULT NULL,
  `NickName` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `SaleName` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MoneySpent` decimal(10,0) NOT NULL DEFAULT '0',
  `Currency` char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PLN',
  `ShopID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Transaction ID`),
  UNIQUE KEY `Transactions_Transaction ID_uindex` (`Transaction ID`),
  KEY `Transactions_AccountSettings_NickName_fk` (`NickName`),
  KEY `Transactions_Shops_ShopID_fk` (`ShopID`),
  KEY `Transactions_Categories_SaleName_fk` (`SaleName`),
  KEY `Transactions_Currencies_Currency_fk` (`Currency`),
  CONSTRAINT `Transactions_AccountSettings_NickName_fk` FOREIGN KEY (`NickName`) REFERENCES `accountsettings` (`NickName`),
  CONSTRAINT `Transactions_Categories_SaleName_fk` FOREIGN KEY (`SaleName`) REFERENCES `categories` (`SaleName`) ON UPDATE CASCADE,
  CONSTRAINT `Transactions_Currencies_Currency_fk` FOREIGN KEY (`Currency`) REFERENCES `currencies` (`Currency`) ON UPDATE CASCADE,
  CONSTRAINT `Transactions_Shops_ShopID_fk` FOREIGN KEY (`ShopID`) REFERENCES `shops` (`ShopID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` (`Transaction ID`, `Date`, `NickName`, `SaleName`, `MoneySpent`, `Currency`, `ShopID`) VALUES (1,'0000-00-00','Konrad','Skd',12,'PLN',1),(2,'0000-00-00','Flask','Ksiazka',13,'PLN',4);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tran_insert BEFORE INSERT ON transactions
  FOR EACH ROW
  BEGIN
    IF (NEW.MoneySpent <= 0) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Wrong cost value input';
    END IF ;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8 COLLATE utf8_general_ci ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `EMail` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NickName` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Type` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  UNIQUE KEY `Users_EMail_uindex` (`EMail`),
  UNIQUE KEY `Users_NickName_uindex` (`NickName`),
  CONSTRAINT `Users_AccountSettings_NickName_fk` FOREIGN KEY (`NickName`) REFERENCES `accountsettings` (`NickName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Users_ValData_EMail_fk` FOREIGN KEY (`EMail`) REFERENCES `valdata` (`EMail`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`EMail`, `NickName`, `Type`) VALUES ('asdf@mail.com','Flask','Y'),('localhost@flaskmail.com','Hiirokasu','Z'),('cos@gmail.com','Python','N'),('abc@def.ij','Konrad','Y'),('zxcv@egzample.com','janusz','N'),('qwerty@wp.pl','Radek','Y');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER user_insert BEFORE INSERT ON users
  FOR EACH ROW
  BEGIN
    IF(!(NEW.EMail REGEXP '^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$')) #source: official regexp from W3C, on site "http://emailregex.com/"
    THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Incorrect mail...';
    END IF ;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8 COLLATE utf8_general_ci ;

--
-- Table structure for table `valdata`
--

DROP TABLE IF EXISTS `valdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valdata` (
  `EMail` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'janusz@example.com',
  `Password` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Salt` varchar(280) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`EMail`),
  UNIQUE KEY `ValData_EMail_uindex` (`EMail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valdata`
--

LOCK TABLES `valdata` WRITE;
/*!40000 ALTER TABLE `valdata` DISABLE KEYS */;
INSERT INTO `valdata` (`EMail`, `Password`, `Salt`) VALUES ('abc@def.ij','69dad19b58a6deff36a24d0df9412a0cadc9b0c76dec90b90ba9658e2d118c13f7edd5c7c03c68419c2f89006ba76bd6d7904158d1cecf8874b1c3cb720a8c59f0d06b29e3dcb0958aef9e86e417a2cda8478bbcedb3fb05e95b8a68044aa9408fa48b7d548710b15446c7df8a00fa3c261bc050ec210f8723804b7d5c6d8696','3081890281810097d8635c781fe3cab724d81e9152751debd67ff05efb07cd1934df1564340f963781c054943b1113dae6e037058538c7e05119de6f3c67dfa6f5908424016c5aaa4c09df0f8bffb06242283d157e7532d5610d641b1c35f6ed3e845a4ebc73c3dbe757652f04693d67b709dcdb0f51e1af63699f3265e05d9791a4984b7631bb0203010001'),('asdf@mail.com','26a82ab07ea22c8c6e6a1c9994b15fb21f4699813a5a59499580df4bda601ce08648a27c077d46e6f3b8e45e083a9350456f9171494279bf1233d8d29902083fbd6f09fba604a0122291f293c188d850dcbf4772b55cc0f6f201bbb6a615af7e80fd0ef2fbf1604bfb585b086fc35bb7efb9dd77ac67dc9f999f5291f687ce60','30818902818100a56349b56c4dab730b1bf64ed238c7b2755ab9613ee2467a8a88dbf044f29b200afd044c9831c4e0ac10334076bdaae14ee8134c87e3f491ee81e88b7e8316644b7286d5cd48a133f52410684a01bf68c7b98c24fdfcd6a3407c39a19ce65903df7310c5e0e5007077b94f5166adf148e86ef63790444d3409f649517499f8a70203010001'),('cos@gmail.com','1c3209072114c9efed1a8102ce6e38b6a878fe83392531f6eb6d0b922afaae735010da6575d0cd5ba7459a59c24c405ead7add2e561654060dcfcf35258cd0ced43b53166f0573fd3f3f3b71e289e599404132f4aef4879b48681f64dfd812a42afaa5152abf5c6a201ad2f8875bd15c4b3eb3f44f9c53d4afc61afdd73ee659','30818902818100a7dc8fd1fd81a554f6d6223fbcc903b2be229efb04d26ecf6f5480f0c293732140d6577ee909a14f69951da20155dd79b8ed39873e2ef3dd7b8615e0175b8cc1404bc76b3eff280be6306419863dab7fd7edb5316b618bf4bd5e3eae9e2f6cb140ae2ebfbf3374ae3aa4288e76db18c02373ff5a41856816e26b66990fbb4a370203010001'),('localhost@flaskmail.com','740ec1fb99b5410a8c0e9f9638e4632d63ef214ada8e13b42b4f9bef35593ce52267f18ca6cf53e7399399fd25c1ca9c95b007e5735d6381a1130e9a72d03881ca16c5889f2d213cf70d2fc458e386c40ce4463fbc0f0378c75d276bc96aaea157b84ec7a5fe91be0f500c9343a47a98f3352014e1881c9bd57f4c1f257d4d96','308189028181009f2ad2f08bc3577625b66547f3d96afa0eef42bef2ec83b66d58ae4e7b373eb67dd39bef0c8bfa7c78b5d61913b4401552549daeeb1518719b6a9ae5cf38de9bd4c9d381cbe849129461d03ff26bdea3b213f1b15cb6c903e4cace98b55854a4191e2b52417b7233f76341ec7d142db1def47eb1ca60a5491ad110faa0b282a90203010001'),('qwerty@wp.pl','07c79db4bd00a97b6515453c0998624c63e3400b4dcd502dc0100948f60ea1a050474d7c139ef866ee9d3e02a7f53914b99a4a11b3a0747e4d4b5764885d53bdc0d70a5d81bca1b3d6dc24cbdd83accd8477ce6a3f8dbc738cda30339836c677e5ee8ce0ec103618a3365ac3f5955af546d186d08dfb58312c767badc21c3a61','3081890281810088b00651592f7dd881df9f18e30399a1883c4eb4724a66d5d8e2e73fccedb72f5cbe7ba4d9215cf820f953f50dbbd2518cf09fac8804fdc2836eb053c0b7ad16884f4c193ad6c2e3482491e9bd95a230cad863e11875e0af5efa0d167e22a45ae49d8790d83cceab9fdefbb84c58b969756c8dea5a3bcb85c0da61c76fd5f87b0203010001'),('zxcv@egzample.com','7acd8bd0f25a54f09147656e0660e481645b32e2e88f22b94dda9f45e28043c214febed26d13edb578b00e4154ca4179ff2fa5da544c2eb009f468b0c0edb81bfb960eb4ca54a3365811ddd42aff92cd29611dd21b4270b3708f237460eb8e88fe927c7c086b565fe2779b65fc2baf69375f4d0cac3df0340a39bda41e136949','30818902818100a652f89264cb3ce4538dd4398da6bd1f76551fb3f2b83ffa6dd96326c9abfa756cdb0ede13859168607ae33d1efe5df8350764038b28380a595eede967ca23c5b0c66ae93df9f7552ffee801e9800d8bcdd0a71a886b9b77ee5dcfd17508b2a5415342b07b89aa233147695d45b4fe2cb4b088bbc2c64a81cbb35a8dae7cd4b50203010001');
/*!40000 ALTER TABLE `valdata` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER val_insert BEFORE INSERT ON valdata
  FOR EACH ROW
  BEGIN
    IF(!(NEW.EMail REGEXP '^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$')) #source: official regexp from W3C, on site "http://emailregex.com/"
    THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Incorrect mail...';
    END IF ;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `tu_wpisz_tytul` CHARACTER SET utf8 COLLATE utf8_general_ci ;

--
-- Dumping routines for database 'tu_wpisz_tytul'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_currency` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_currency`(name CHAR(3), fToPLN DECIMAL)
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
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_favourite` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_favourite`(usernick VARCHAR(32), transactionname VARCHAR(64), price DECIMAL, cCurrency CHAR(3), shop VARCHAR(64))
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
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_routine` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_routine`(ftime DATE, ltime DATE, dayy INT(11), usernick VARCHAR(32), transactionname VARCHAR(64), price DECIMAL, cCurrency CHAR(3))
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
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_shop` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_shop`(name VARCHAR(64))
BEGIN
    INSERT INTO shops(ShopName) VALUE (name);
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_transaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_transaction`(time DATE, usernick VARCHAR(32), transactionname VARCHAR(64), categoryname VARCHAR(32), price DECIMAL, cCurrency CHAR(3), shop VARCHAR(64))
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
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_user`(nick VARCHAR(32), mail VARCHAR(128), passhash VARCHAR(256), pkey VARCHAR(280), answer CHAR(1))
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
    INSERT INTO accountsettings (NickName) VALUE (nick);
    INSERT INTO users VALUE (mail, nick,answer);
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `describe_shop` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `describe_shop`(name VARCHAR(64), caddress VARCHAR(80), ccountry VARCHAR(64), ccity VARCHAR(64))
BEGIN
    INSERT INTO shopdetails VALUE(name, caddress, ccountry, ccity); #TODO: REGEXP values
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `set_account_settings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `set_account_settings`(nick VARCHAR(32), budget DECIMAL, startofmonth INT(11))
BEGIN
    UPDATE accountsettings
    SET BudgetPerMonth = budget
    WHERE budget IS NOT NULL AND nick = NickName;
    UPDATE accountsettings
    SET MonthStart = startofmonth
    WHERE startofmonth IS NOT NULL AND nick = NickName;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-12 22:15:14
