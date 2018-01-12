-- MySQL dump 10.13  Distrib 5.7.20, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: projecttask
-- ------------------------------------------------------
-- Server version	5.7.20-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
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
  `BudgetPerMonth` float NOT NULL DEFAULT '0',
  `MonthStart` int(11) DEFAULT '1',
  `PremiumSavedMoney` float DEFAULT NULL,
  PRIMARY KEY (`NickName`),
  UNIQUE KEY `AccountSettings_NickName_uindex` (`NickName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountsettings`
--

LOCK TABLES `accountsettings` WRITE;
/*!40000 ALTER TABLE `accountsettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `accountsettings` ENABLE KEYS */;
UNLOCK TABLES;

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
  `ToPLN` float NOT NULL,
  PRIMARY KEY (`Currency`),
  UNIQUE KEY `Currencies_Currency_uindex` (`Currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` (`Currency`, `ToPLN`) VALUES ('PLN',1);
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

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
  `Cost` float DEFAULT NULL,
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
/*!40000 ALTER TABLE `favourites` ENABLE KEYS */;
UNLOCK TABLES;

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
  `Cost` float DEFAULT NULL,
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
/*!40000 ALTER TABLE `routines` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shops`
--

LOCK TABLES `shops` WRITE;
/*!40000 ALTER TABLE `shops` DISABLE KEYS */;
/*!40000 ALTER TABLE `shops` ENABLE KEYS */;
UNLOCK TABLES;

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
  `MoneySpent` float NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `EMail` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NickName` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  UNIQUE KEY `Users_EMail_uindex` (`EMail`),
  UNIQUE KEY `Users_NickName_uindex` (`NickName`),
  CONSTRAINT `Users_AccountSettings_NickName_fk` FOREIGN KEY (`NickName`) REFERENCES `accountsettings` (`NickName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Users_ValData_EMail_fk` FOREIGN KEY (`EMail`) REFERENCES `valdata` (`EMail`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valdata`
--

DROP TABLE IF EXISTS `valdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valdata` (
  `EMail` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'janusz@example.com',
  `Password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Salt` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`EMail`),
  UNIQUE KEY `ValData_EMail_uindex` (`EMail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valdata`
--

LOCK TABLES `valdata` WRITE;
/*!40000 ALTER TABLE `valdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `valdata` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-27  0:05:44