-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: merarohtak
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

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
-- Table structure for table `class_master`
--

DROP TABLE IF EXISTS `class_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_master` (
  `class_id` varchar(10) NOT NULL,
  `class_name` varchar(50) NOT NULL DEFAULT '',
  `rank` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_master`
--

LOCK TABLES `class_master` WRITE;
/*!40000 ALTER TABLE `class_master` DISABLE KEYS */;
INSERT INTO `class_master` VALUES ('CL1','Bronze',1),('CL2','Silver',2),('CL3','Gold',3),('CL4','Diamond',4),('CL5','Platinum',5),('UNASSIGNED','Not Categorized',0);
/*!40000 ALTER TABLE `class_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colony_master`
--

DROP TABLE IF EXISTS `colony_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `colony_master` (
  `colony_id` varchar(10) NOT NULL,
  `colony_name` varchar(200) NOT NULL DEFAULT '',
  `ward_id` varchar(10) NOT NULL DEFAULT 'W00',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`colony_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colony_master`
--

LOCK TABLES `colony_master` WRITE;
/*!40000 ALTER TABLE `colony_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `colony_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `municipality_master`
--

DROP TABLE IF EXISTS `municipality_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `municipality_master` (
  `municipality_id` varchar(50) NOT NULL,
  `municipality_name` varchar(200) NOT NULL DEFAULT '',
  `municipality_type` varchar(20) NOT NULL DEFAULT '',
  `district` varchar(100) NOT NULL DEFAULT '',
  `state` varchar(100) NOT NULL DEFAULT 'Haryana',
  PRIMARY KEY (`municipality_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `municipality_master`
--

LOCK TABLES `municipality_master` WRITE;
/*!40000 ALTER TABLE `municipality_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `municipality_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `old_property_master`
--

DROP TABLE IF EXISTS `old_property_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `old_property_master` (
  `Property_Id` varchar(32) DEFAULT '11111',
  `Ward_No` int(2) DEFAULT 50,
  `Owner_Name` varchar(179) DEFAULT 'NA',
  `Address` varchar(127) DEFAULT 'AAAAAA'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `old_property_master`
--

LOCK TABLES `old_property_master` WRITE;
/*!40000 ALTER TABLE `old_property_master` DISABLE KEYS */;
INSERT INTO `old_property_master` VALUES ('100C100U681',12,'Kawar Raj Singh','Ghanipura Rohtak');
/*!40000 ALTER TABLE `old_property_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_master`
--

DROP TABLE IF EXISTS `property_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_master` (
  `property_id` varchar(50) NOT NULL,
  `municipality_id` varchar(50) NOT NULL DEFAULT 'UNASSIGNED',
  `colony_id` varchar(10) NOT NULL DEFAULT 'UNASSIGNED',
  `ward_id` varchar(10) NOT NULL DEFAULT 'W00',
  `property_type` varchar(50) NOT NULL DEFAULT '',
  `address_text` varchar(500) NOT NULL DEFAULT '',
  `plot_area_sq_yard` decimal(12,2) NOT NULL DEFAULT 0.00,
  `plot_area_sq_meter` decimal(12,2) NOT NULL DEFAULT 0.00,
  `owner_name_raw` varchar(300) NOT NULL DEFAULT '',
  `is_self_certified` tinyint(1) NOT NULL DEFAULT 0,
  `self_cert_mobile_masked` varchar(50) NOT NULL DEFAULT '',
  `details_url` text DEFAULT NULL,
  `image_url` text DEFAULT NULL,
  PRIMARY KEY (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_master`
--

LOCK TABLES `property_master` WRITE;
/*!40000 ALTER TABLE `property_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `property_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `religion_master`
--

DROP TABLE IF EXISTS `religion_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `religion_master` (
  `religion_id` varchar(10) NOT NULL,
  `religion_name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`religion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `religion_master`
--

LOCK TABLES `religion_master` WRITE;
/*!40000 ALTER TABLE `religion_master` DISABLE KEYS */;
INSERT INTO `religion_master` VALUES ('R01','Hindu'),('R02','Muslim'),('R03','Sikh'),('R04','Christian'),('R99','Other / Prefer not to say');
/*!40000 ALTER TABLE `religion_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_account`
--

DROP TABLE IF EXISTS `user_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_account` (
  `user_id` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL DEFAULT '',
  `email` varchar(200) NOT NULL DEFAULT '',
  `password_hash` varchar(255) NOT NULL DEFAULT '',
  `is_consent_given` tinyint(1) NOT NULL DEFAULT 0,
  `is_account_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `last_login_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_account`
--

LOCK TABLES `user_account` WRITE;
/*!40000 ALTER TABLE `user_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_profile` (
  `user_id` varchar(50) NOT NULL,
  `current_family_id` varchar(50) NOT NULL DEFAULT 'UNASSIGNED',
  `current_property_id` varchar(50) NOT NULL DEFAULT 'UNASSIGNED',
  `current_residency_role` varchar(30) NOT NULL DEFAULT 'UNASSIGNED',
  `class_id` varchar(10) NOT NULL DEFAULT 'UNASSIGNED',
  `name_first` varchar(100) NOT NULL DEFAULT '',
  `name_last` varchar(100) NOT NULL DEFAULT '',
  `gender` varchar(10) NOT NULL DEFAULT '',
  `dob` date NOT NULL DEFAULT '1970-01-01',
  `phone` varchar(20) NOT NULL DEFAULT '',
  `email` varchar(200) NOT NULL DEFAULT '',
  `religion_id` varchar(10) NOT NULL DEFAULT 'UNASSIGNED',
  `aadhaar_number` varchar(20) NOT NULL DEFAULT '',
  `pan_number` varchar(20) NOT NULL DEFAULT '',
  `ration_card_number` varchar(50) NOT NULL DEFAULT '',
  `voter_id_number` varchar(50) NOT NULL DEFAULT '',
  `driving_license_number` varchar(50) NOT NULL DEFAULT '',
  `passport_number` varchar(20) NOT NULL DEFAULT '',
  `manual_address_line1` varchar(200) NOT NULL DEFAULT '',
  `manual_address_city` varchar(100) NOT NULL DEFAULT '',
  `manual_address_state` varchar(100) NOT NULL DEFAULT '',
  `manual_address_pincode` varchar(20) NOT NULL DEFAULT '',
  `manual_address_country` varchar(100) NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile`
--

LOCK TABLES `user_profile` WRITE;
/*!40000 ALTER TABLE `user_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ward_master`
--

DROP TABLE IF EXISTS `ward_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ward_master` (
  `ward_id` varchar(10) NOT NULL,
  `ward_number` int(11) NOT NULL DEFAULT 0,
  `ward_name` varchar(100) NOT NULL DEFAULT '',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ward_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ward_master`
--

LOCK TABLES `ward_master` WRITE;
/*!40000 ALTER TABLE `ward_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `ward_master` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-09 22:41:48
