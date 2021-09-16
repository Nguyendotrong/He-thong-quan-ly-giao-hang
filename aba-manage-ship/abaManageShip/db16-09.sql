-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: abashipdb
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `abaship_auction`
--

DROP TABLE IF EXISTS `abaship_auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_auction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `cost` decimal(14,2) NOT NULL,
  `is_win` tinyint(1) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `post_id` bigint NOT NULL,
  `shipper_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abaShip_auction_post_id_shipper_id_93170b5d_uniq` (`post_id`,`shipper_id`),
  KEY `abaShip_auction_shipper_id_3d568bf1_fk_abaShip_user_id` (`shipper_id`),
  CONSTRAINT `abaShip_auction_post_id_6b882420_fk_abaShip_post_id` FOREIGN KEY (`post_id`) REFERENCES `abaship_post` (`id`),
  CONSTRAINT `abaShip_auction_shipper_id_3d568bf1_fk_abaShip_user_id` FOREIGN KEY (`shipper_id`) REFERENCES `abaship_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_auction`
--

LOCK TABLES `abaship_auction` WRITE;
/*!40000 ALTER TABLE `abaship_auction` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_auction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_categoryproductship`
--

DROP TABLE IF EXISTS `abaship_categoryproductship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_categoryproductship` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_categoryproductship`
--

LOCK TABLES `abaship_categoryproductship` WRITE;
/*!40000 ALTER TABLE `abaship_categoryproductship` DISABLE KEYS */;
INSERT INTO `abaship_categoryproductship` VALUES (1,'Hàng điện tử.','Hàng điện tử.'),(2,'Hàng gia dụng','Hàng gia dụng'),(3,'Hàng mỹ phẩm','Hàng mỹ phẩm'),(4,'Chuyển nhà','Chuyển nhà'),(5,'Chuyển văn phòng','Chuyển văn phòng');
/*!40000 ALTER TABLE `abaship_categoryproductship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_commentshipper`
--

DROP TABLE IF EXISTS `abaship_commentshipper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_commentshipper` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` int NOT NULL,
  `customer_id` bigint NOT NULL,
  `shipper_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abaShip_commentshipper_customer_id_shipper_id_6a01ed25_uniq` (`customer_id`,`shipper_id`),
  KEY `abaShip_commentshipper_shipper_id_ef95241e_fk_abaShip_user_id` (`shipper_id`),
  CONSTRAINT `abaShip_commentshipper_customer_id_d6570e70_fk_abaShip_user_id` FOREIGN KEY (`customer_id`) REFERENCES `abaship_user` (`id`),
  CONSTRAINT `abaShip_commentshipper_shipper_id_ef95241e_fk_abaShip_user_id` FOREIGN KEY (`shipper_id`) REFERENCES `abaship_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_commentshipper`
--

LOCK TABLES `abaship_commentshipper` WRITE;
/*!40000 ALTER TABLE `abaship_commentshipper` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_commentshipper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_debtapp`
--

DROP TABLE IF EXISTS `abaship_debtapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_debtapp` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `has_payed` tinyint(1) NOT NULL,
  `deduct_id` bigint NOT NULL,
  `shipper_id` bigint NOT NULL,
  `order_ship_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_ship_id` (`order_ship_id`),
  KEY `abaShip_debtapp_deduct_id_153d1920_fk_abaShip_deduct_id` (`deduct_id`),
  KEY `abaShip_debtapp_shipper_id_760206b8_fk_abaShip_user_id` (`shipper_id`),
  CONSTRAINT `abaShip_debtapp_deduct_id_153d1920_fk_abaShip_deduct_id` FOREIGN KEY (`deduct_id`) REFERENCES `abaship_deduct` (`id`),
  CONSTRAINT `abaShip_debtapp_order_ship_id_cc3b4148_fk_abaShip_o` FOREIGN KEY (`order_ship_id`) REFERENCES `abaship_ordership` (`auction_win_id`),
  CONSTRAINT `abaShip_debtapp_shipper_id_760206b8_fk_abaShip_user_id` FOREIGN KEY (`shipper_id`) REFERENCES `abaship_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_debtapp`
--

LOCK TABLES `abaship_debtapp` WRITE;
/*!40000 ALTER TABLE `abaship_debtapp` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_debtapp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_debtshipper`
--

DROP TABLE IF EXISTS `abaship_debtshipper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_debtshipper` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `has_payed` tinyint(1) NOT NULL,
  `deduct_id` bigint NOT NULL,
  `shipper_id` bigint NOT NULL,
  `order_ship_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_ship_id` (`order_ship_id`),
  KEY `abaShip_debtshipper_deduct_id_65a356ec_fk_abaShip_deduct_id` (`deduct_id`),
  KEY `abaShip_debtshipper_shipper_id_fb9a6074_fk_abaShip_user_id` (`shipper_id`),
  CONSTRAINT `abaShip_debtshipper_deduct_id_65a356ec_fk_abaShip_deduct_id` FOREIGN KEY (`deduct_id`) REFERENCES `abaship_deduct` (`id`),
  CONSTRAINT `abaShip_debtshipper_order_ship_id_d12aa24a_fk_abaShip_o` FOREIGN KEY (`order_ship_id`) REFERENCES `abaship_ordership` (`auction_win_id`),
  CONSTRAINT `abaShip_debtshipper_shipper_id_fb9a6074_fk_abaShip_user_id` FOREIGN KEY (`shipper_id`) REFERENCES `abaship_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_debtshipper`
--

LOCK TABLES `abaship_debtshipper` WRITE;
/*!40000 ALTER TABLE `abaship_debtshipper` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_debtshipper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_deduct`
--

DROP TABLE IF EXISTS `abaship_deduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_deduct` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `percent` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_deduct`
--

LOCK TABLES `abaship_deduct` WRITE;
/*!40000 ALTER TABLE `abaship_deduct` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_deduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_idcard`
--

DROP TABLE IF EXISTS `abaship_idcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_idcard` (
  `user_id` bigint NOT NULL,
  `id_card` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_card_front` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_card_back` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mfg_date` datetime(6) NOT NULL,
  `exp_date` datetime(6) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `id_card` (`id_card`),
  CONSTRAINT `abaShip_idcard_user_id_7caa3372_fk_abaShip_user_id` FOREIGN KEY (`user_id`) REFERENCES `abaship_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_idcard`
--

LOCK TABLES `abaship_idcard` WRITE;
/*!40000 ALTER TABLE `abaship_idcard` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_idcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_imageitem`
--

DROP TABLE IF EXISTS `abaship_imageitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_imageitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `abaShip_imageitem_post_id_f9201e8f_fk_abaShip_post_id` (`post_id`),
  CONSTRAINT `abaShip_imageitem_post_id_f9201e8f_fk_abaShip_post_id` FOREIGN KEY (`post_id`) REFERENCES `abaship_post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_imageitem`
--

LOCK TABLES `abaship_imageitem` WRITE;
/*!40000 ALTER TABLE `abaship_imageitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_imageitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_notification`
--

DROP TABLE IF EXISTS `abaship_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seen` tinyint(1) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_notification`
--

LOCK TABLES `abaship_notification` WRITE;
/*!40000 ALTER TABLE `abaship_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_ordership`
--

DROP TABLE IF EXISTS `abaship_ordership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_ordership` (
  `created_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `auction_win_id` bigint NOT NULL,
  `active` tinyint(1) NOT NULL,
  `shipped_date` datetime(6) DEFAULT NULL,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`auction_win_id`),
  CONSTRAINT `abaShip_ordership_auction_win_id_0c77a3a7_fk_abaShip_auction_id` FOREIGN KEY (`auction_win_id`) REFERENCES `abaship_auction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_ordership`
--

LOCK TABLES `abaship_ordership` WRITE;
/*!40000 ALTER TABLE `abaship_ordership` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_ordership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_ordershipdetail`
--

DROP TABLE IF EXISTS `abaship_ordershipdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_ordershipdetail` (
  `orderShip_id` bigint NOT NULL,
  `pay_method` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `voucher_id` bigint NOT NULL,
  PRIMARY KEY (`orderShip_id`),
  KEY `abaShip_ordershipdet_voucher_id_80d88286_fk_abaShip_v` (`voucher_id`),
  CONSTRAINT `abaShip_ordershipdet_orderShip_id_76ac21dd_fk_abaShip_o` FOREIGN KEY (`orderShip_id`) REFERENCES `abaship_ordership` (`auction_win_id`),
  CONSTRAINT `abaShip_ordershipdet_voucher_id_80d88286_fk_abaShip_v` FOREIGN KEY (`voucher_id`) REFERENCES `abaship_voucher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_ordershipdetail`
--

LOCK TABLES `abaship_ordershipdetail` WRITE;
/*!40000 ALTER TABLE `abaship_ordershipdetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_ordershipdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_post`
--

DROP TABLE IF EXISTS `abaship_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_post` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `weight` double DEFAULT NULL,
  `customer_id` bigint NOT NULL,
  `receive_stock_id` bigint NOT NULL,
  `send_stock_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `abaShip_post_customer_id_d4f46beb_fk_abaShip_user_id` (`customer_id`),
  KEY `abaShip_post_receive_stock_id_66af681c_fk_abaShip_stock_id` (`receive_stock_id`),
  KEY `abaShip_post_send_stock_id_cb628ae2_fk_abaShip_stock_id` (`send_stock_id`),
  CONSTRAINT `abaShip_post_customer_id_d4f46beb_fk_abaShip_user_id` FOREIGN KEY (`customer_id`) REFERENCES `abaship_user` (`id`),
  CONSTRAINT `abaShip_post_receive_stock_id_66af681c_fk_abaShip_stock_id` FOREIGN KEY (`receive_stock_id`) REFERENCES `abaship_stock` (`id`),
  CONSTRAINT `abaShip_post_send_stock_id_cb628ae2_fk_abaShip_stock_id` FOREIGN KEY (`send_stock_id`) REFERENCES `abaship_stock` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_post`
--

LOCK TABLES `abaship_post` WRITE;
/*!40000 ALTER TABLE `abaship_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_post_category_product_ship`
--

DROP TABLE IF EXISTS `abaship_post_category_product_ship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_post_category_product_ship` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` bigint NOT NULL,
  `categoryproductship_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abaShip_post_category_pr_post_id_categoryproducts_19f478c8_uniq` (`post_id`,`categoryproductship_id`),
  KEY `abaShip_post_categor_categoryproductship__35176703_fk_abaShip_c` (`categoryproductship_id`),
  CONSTRAINT `abaShip_post_categor_categoryproductship__35176703_fk_abaShip_c` FOREIGN KEY (`categoryproductship_id`) REFERENCES `abaship_categoryproductship` (`id`),
  CONSTRAINT `abaShip_post_categor_post_id_342420d6_fk_abaShip_p` FOREIGN KEY (`post_id`) REFERENCES `abaship_post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_post_category_product_ship`
--

LOCK TABLES `abaship_post_category_product_ship` WRITE;
/*!40000 ALTER TABLE `abaship_post_category_product_ship` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_post_category_product_ship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_stock`
--

DROP TABLE IF EXISTS `abaship_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_stock` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_represent_man` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `abaShip_stock_customer_id_bb13cc4b_fk_abaShip_user_id` (`customer_id`),
  CONSTRAINT `abaShip_stock_customer_id_bb13cc4b_fk_abaShip_user_id` FOREIGN KEY (`customer_id`) REFERENCES `abaship_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_stock`
--

LOCK TABLES `abaship_stock` WRITE;
/*!40000 ALTER TABLE `abaship_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_user`
--

DROP TABLE IF EXISTS `abaship_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_user`
--

LOCK TABLES `abaship_user` WRITE;
/*!40000 ALTER TABLE `abaship_user` DISABLE KEYS */;
INSERT INTO `abaship_user` VALUES (1,'pbkdf2_sha256$260000$rvueupsCPjos0NZlQxJlmw$jrTvWpsbg/bXoN5a9S9ozXQ1m7ZhYdc3Ukd+jv1jiVM=','2021-09-16 09:29:17.196636',1,'admin','','','admin@gmail.com',1,1,'2021-09-16 09:20:18.977260',NULL,'','0000-00-00','0',''),(2,'pbkdf2_sha256$260000$km4rln4Wc77d6bZCWpwHbY$jUWNNA4GUY1jG40hSkHoMRgJA7kSKDy2XIvW8vz0tA8=',NULL,0,'shippper','shipper','Nguyễn','shipper@gmail.com',0,1,'2021-09-16 09:40:44.338114','image/upload/v1631785246/naw4wnxeqfse8wc1iukj.jpg','Cao Bằng','2000-11-11','0','0123456777'),(3,'pbkdf2_sha256$260000$Wmwj88o7NoOqqPOUaaP86u$khRSYnC9Fp9cvtBOyNZ57+BEaXpLgw41CiCc6OAkrc8=',NULL,0,'shippper1','shipper1','Nguyễn','shipper@gmail.com',0,1,'2021-09-16 09:41:53.407011','image/upload/v1631785314/ou4jjmixu229zflijiq4.jpg','Cao Bằng','2000-11-11','0','0123456778'),(4,'pbkdf2_sha256$260000$9vY1dTYEnIbAGnUi59Ey3B$5iedJwshVdnviACBfHLX03nyT3QItJVUr0thfMSRouw=',NULL,0,'phanhuy','Huy','Nguyễn','huy@gmail.com',0,1,'2021-09-16 09:42:56.662288','image/upload/v1631785378/k9h7sitjcxl4sax1ttxk.jpg','61 Bình Dương','2000-11-11','0','0123456788'),(5,'pbkdf2_sha256$260000$uS1akBlOXEqVx9m0i2qUtI$LCy1SQ6PMLYPfjbLIgLMzjBgGLQKsUDZf7PVhP7PyNY=',NULL,0,'dotrong','Trọng','Đỗ','trong@gmail.com',0,1,'2021-09-16 09:44:14.681933','image/upload/v1631786690/auabqxaalnemxpnvimrv.jpg','61 Bình Dương','2000-11-11','0','0123456788');
/*!40000 ALTER TABLE `abaship_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_user_groups`
--

DROP TABLE IF EXISTS `abaship_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abaShip_user_groups_user_id_group_id_f92a3023_uniq` (`user_id`,`group_id`),
  KEY `abaShip_user_groups_group_id_7e283486_fk_auth_group_id` (`group_id`),
  CONSTRAINT `abaShip_user_groups_group_id_7e283486_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `abaShip_user_groups_user_id_9d37a2f4_fk_abaShip_user_id` FOREIGN KEY (`user_id`) REFERENCES `abaship_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_user_groups`
--

LOCK TABLES `abaship_user_groups` WRITE;
/*!40000 ALTER TABLE `abaship_user_groups` DISABLE KEYS */;
INSERT INTO `abaship_user_groups` VALUES (1,2,2),(2,3,2),(3,4,2),(4,5,1);
/*!40000 ALTER TABLE `abaship_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_user_notifications`
--

DROP TABLE IF EXISTS `abaship_user_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_user_notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `notification_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abaShip_user_notifications_user_id_notification_id_b53942db_uniq` (`user_id`,`notification_id`),
  KEY `abaShip_user_notific_notification_id_b7b22e76_fk_abaShip_n` (`notification_id`),
  CONSTRAINT `abaShip_user_notific_notification_id_b7b22e76_fk_abaShip_n` FOREIGN KEY (`notification_id`) REFERENCES `abaship_notification` (`id`),
  CONSTRAINT `abaShip_user_notifications_user_id_0f0a9e43_fk_abaShip_user_id` FOREIGN KEY (`user_id`) REFERENCES `abaship_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_user_notifications`
--

LOCK TABLES `abaship_user_notifications` WRITE;
/*!40000 ALTER TABLE `abaship_user_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_user_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_user_user_permissions`
--

DROP TABLE IF EXISTS `abaship_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abaShip_user_user_permis_user_id_permission_id_e5d34c36_uniq` (`user_id`,`permission_id`),
  KEY `abaShip_user_user_pe_permission_id_dea1df3a_fk_auth_perm` (`permission_id`),
  CONSTRAINT `abaShip_user_user_pe_permission_id_dea1df3a_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `abaShip_user_user_pe_user_id_6f4e0305_fk_abaShip_u` FOREIGN KEY (`user_id`) REFERENCES `abaship_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_user_user_permissions`
--

LOCK TABLES `abaship_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `abaship_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_voucher`
--

DROP TABLE IF EXISTS `abaship_voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_voucher` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount` double NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_voucher`
--

LOCK TABLES `abaship_voucher` WRITE;
/*!40000 ALTER TABLE `abaship_voucher` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_voucher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'customer'),(2,'shipper');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (60,1,22),(6,1,24),(10,1,28),(2,1,40),(11,1,44),(12,1,45),(13,1,46),(14,1,47),(15,1,48),(16,1,49),(17,1,50),(18,1,51),(19,1,52),(20,1,53),(21,1,54),(22,1,55),(23,1,56),(24,1,57),(25,1,58),(26,1,59),(27,1,60),(3,1,61),(4,1,62),(5,1,63),(1,1,64),(28,1,73),(29,1,74),(30,1,75),(31,1,76),(32,1,77),(33,1,78),(34,1,79),(35,1,80),(61,2,22),(36,2,24),(37,2,25),(38,2,26),(39,2,27),(40,2,28),(41,2,32),(42,2,36),(43,2,40),(44,2,44),(45,2,45),(46,2,46),(47,2,47),(48,2,48),(49,2,52),(50,2,56),(51,2,60),(52,2,61),(53,2,62),(54,2,63),(55,2,64),(56,2,68),(57,2,72),(58,2,76),(59,2,80);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add auction',7,'add_auction'),(26,'Can change auction',7,'change_auction'),(27,'Can delete auction',7,'delete_auction'),(28,'Can view auction',7,'view_auction'),(29,'Can add category product ship',8,'add_categoryproductship'),(30,'Can change category product ship',8,'change_categoryproductship'),(31,'Can delete category product ship',8,'delete_categoryproductship'),(32,'Can view category product ship',8,'view_categoryproductship'),(33,'Can add deduct',9,'add_deduct'),(34,'Can change deduct',9,'change_deduct'),(35,'Can delete deduct',9,'delete_deduct'),(36,'Can view deduct',9,'view_deduct'),(37,'Can add notification',10,'add_notification'),(38,'Can change notification',10,'change_notification'),(39,'Can delete notification',10,'delete_notification'),(40,'Can view notification',10,'view_notification'),(41,'Can add voucher',11,'add_voucher'),(42,'Can change voucher',11,'change_voucher'),(43,'Can delete voucher',11,'delete_voucher'),(44,'Can view voucher',11,'view_voucher'),(45,'Can add id card',12,'add_idcard'),(46,'Can change id card',12,'change_idcard'),(47,'Can delete id card',12,'delete_idcard'),(48,'Can view id card',12,'view_idcard'),(49,'Can add order ship',13,'add_ordership'),(50,'Can change order ship',13,'change_ordership'),(51,'Can delete order ship',13,'delete_ordership'),(52,'Can view order ship',13,'view_ordership'),(53,'Can add stock',14,'add_stock'),(54,'Can change stock',14,'change_stock'),(55,'Can delete stock',14,'delete_stock'),(56,'Can view stock',14,'view_stock'),(57,'Can add post',15,'add_post'),(58,'Can change post',15,'change_post'),(59,'Can delete post',15,'delete_post'),(60,'Can view post',15,'view_post'),(61,'Can add image item',16,'add_imageitem'),(62,'Can change image item',16,'change_imageitem'),(63,'Can delete image item',16,'delete_imageitem'),(64,'Can view image item',16,'view_imageitem'),(65,'Can add debt shipper',17,'add_debtshipper'),(66,'Can change debt shipper',17,'change_debtshipper'),(67,'Can delete debt shipper',17,'delete_debtshipper'),(68,'Can view debt shipper',17,'view_debtshipper'),(69,'Can add debt app',18,'add_debtapp'),(70,'Can change debt app',18,'change_debtapp'),(71,'Can delete debt app',18,'delete_debtapp'),(72,'Can view debt app',18,'view_debtapp'),(73,'Can add comment shipper',19,'add_commentshipper'),(74,'Can change comment shipper',19,'change_commentshipper'),(75,'Can delete comment shipper',19,'delete_commentshipper'),(76,'Can view comment shipper',19,'view_commentshipper'),(77,'Can add order ship detail',20,'add_ordershipdetail'),(78,'Can change order ship detail',20,'change_ordershipdetail'),(79,'Can delete order ship detail',20,'delete_ordershipdetail'),(80,'Can view order ship detail',20,'view_ordershipdetail'),(81,'Can add application',21,'add_application'),(82,'Can change application',21,'change_application'),(83,'Can delete application',21,'delete_application'),(84,'Can view application',21,'view_application'),(85,'Can add access token',22,'add_accesstoken'),(86,'Can change access token',22,'change_accesstoken'),(87,'Can delete access token',22,'delete_accesstoken'),(88,'Can view access token',22,'view_accesstoken'),(89,'Can add grant',23,'add_grant'),(90,'Can change grant',23,'change_grant'),(91,'Can delete grant',23,'delete_grant'),(92,'Can view grant',23,'view_grant'),(93,'Can add refresh token',24,'add_refreshtoken'),(94,'Can change refresh token',24,'change_refreshtoken'),(95,'Can delete refresh token',24,'delete_refreshtoken'),(96,'Can view refresh token',24,'view_refreshtoken'),(97,'Can add id token',25,'add_idtoken'),(98,'Can change id token',25,'change_idtoken'),(99,'Can delete id token',25,'delete_idtoken'),(100,'Can view id token',25,'view_idtoken');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_abaShip_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_abaShip_user_id` FOREIGN KEY (`user_id`) REFERENCES `abaship_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2021-09-16 09:30:40.060619','1','customer',1,'[{\"added\": {}}]',3,1),(2,'2021-09-16 09:33:52.487239','1','customer',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(3,'2021-09-16 09:35:38.673638','2','shipper',1,'[{\"added\": {}}]',3,1),(4,'2021-09-16 09:35:51.659621','1','customer',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(5,'2021-09-16 09:36:29.663539','1','Category: Hàng điện tử.,\nDescription: Hàng điện tử.',1,'[{\"added\": {}}]',8,1),(6,'2021-09-16 09:36:41.181016','2','Category: Hàng gia dụng,\nDescription: Hàng gia dụng',1,'[{\"added\": {}}]',8,1),(7,'2021-09-16 09:36:49.603591','3','Category: Hàng mỹ phẩm,\nDescription: Hàng mỹ phẩm',1,'[{\"added\": {}}]',8,1),(8,'2021-09-16 09:37:00.879908','4','Category: Chuyển nhà,\nDescription: Chuyển nhà',1,'[{\"added\": {}}]',8,1),(9,'2021-09-16 09:37:17.543663','5','Category: Chuyển văn phòng,\nDescription: Chuyển văn phòng',1,'[{\"added\": {}}]',8,1),(10,'2021-09-16 09:48:16.603804','1','customer',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(11,'2021-09-16 09:48:39.732099','2','shipper',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (7,'abaShip','auction'),(8,'abaShip','categoryproductship'),(19,'abaShip','commentshipper'),(18,'abaShip','debtapp'),(17,'abaShip','debtshipper'),(9,'abaShip','deduct'),(12,'abaShip','idcard'),(16,'abaShip','imageitem'),(10,'abaShip','notification'),(13,'abaShip','ordership'),(20,'abaShip','ordershipdetail'),(15,'abaShip','post'),(14,'abaShip','stock'),(6,'abaShip','user'),(11,'abaShip','voucher'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(22,'oauth2_provider','accesstoken'),(21,'oauth2_provider','application'),(23,'oauth2_provider','grant'),(25,'oauth2_provider','idtoken'),(24,'oauth2_provider','refreshtoken'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2021-09-16 09:17:50.388999'),(2,'contenttypes','0002_remove_content_type_name','2021-09-16 09:17:50.566095'),(3,'auth','0001_initial','2021-09-16 09:17:51.169118'),(4,'auth','0002_alter_permission_name_max_length','2021-09-16 09:17:51.287228'),(5,'auth','0003_alter_user_email_max_length','2021-09-16 09:17:51.334201'),(6,'auth','0004_alter_user_username_opts','2021-09-16 09:17:51.351191'),(7,'auth','0005_alter_user_last_login_null','2021-09-16 09:17:51.364184'),(8,'auth','0006_require_contenttypes_0002','2021-09-16 09:17:51.373178'),(9,'auth','0007_alter_validators_add_error_messages','2021-09-16 09:17:51.387170'),(10,'auth','0008_alter_user_username_max_length','2021-09-16 09:17:51.409160'),(11,'auth','0009_alter_user_last_name_max_length','2021-09-16 09:17:51.424717'),(12,'auth','0010_alter_group_name_max_length','2021-09-16 09:17:51.458943'),(13,'auth','0011_update_proxy_permissions','2021-09-16 09:17:51.472933'),(14,'auth','0012_alter_user_first_name_max_length','2021-09-16 09:17:51.488270'),(15,'abaShip','0001_initial','2021-09-16 09:18:01.390522'),(16,'admin','0001_initial','2021-09-16 09:18:02.089707'),(17,'admin','0002_logentry_remove_auto_add','2021-09-16 09:18:02.151672'),(18,'admin','0003_logentry_add_action_flag_choices','2021-09-16 09:18:02.207641'),(19,'oauth2_provider','0001_initial','2021-09-16 09:18:04.736547'),(20,'oauth2_provider','0002_auto_20190406_1805','2021-09-16 09:18:04.975285'),(21,'oauth2_provider','0003_auto_20201211_1314','2021-09-16 09:18:05.134166'),(22,'oauth2_provider','0004_auto_20200902_2022','2021-09-16 09:18:06.233957'),(23,'sessions','0001_initial','2021-09-16 09:18:06.340896'),(24,'abaShip','0002_auto_20210916_1620','2021-09-16 09:21:30.531318');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('02ei0vnelc61kz7kzzzq3nunabrz3bif','.eJxVjEEOwiAQRe_C2hAGmA64dO8ZCJRBqoYmpV0Z765NutDtf-_9lwhxW2vYOi9hyuIsQJx-txTHB7cd5Htst1mOc1uXKcldkQft8jpnfl4O9--gxl6_tUIkSskilORL0bkwOGUGTdqBNsSk0BlrLBosihVz9pacHYgiOA_i_QG7rjZo:1mQnhl:x0uEl920FVVSVvWZjlvJUddJe5nyQB4vGjDVq3QJA5E','2021-09-30 09:29:17.201939');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_accesstoken`
--

DROP TABLE IF EXISTS `oauth2_provider_accesstoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_accesstoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `source_refresh_token_id` bigint DEFAULT NULL,
  `id_token_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `source_refresh_token_id` (`source_refresh_token_id`),
  UNIQUE KEY `id_token_id` (`id_token_id`),
  KEY `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_accesstoken_user_id_6e4c9a65_fk_abaShip_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_acce_id_token_id_85db651b_fk_oauth2_pr` FOREIGN KEY (`id_token_id`) REFERENCES `oauth2_provider_idtoken` (`id`),
  CONSTRAINT `oauth2_provider_acce_source_refresh_token_e66fbc72_fk_oauth2_pr` FOREIGN KEY (`source_refresh_token_id`) REFERENCES `oauth2_provider_refreshtoken` (`id`),
  CONSTRAINT `oauth2_provider_accesstoken_user_id_6e4c9a65_fk_abaShip_user_id` FOREIGN KEY (`user_id`) REFERENCES `abaship_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_accesstoken`
--

LOCK TABLES `oauth2_provider_accesstoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_accesstoken` VALUES (1,'O4dkqk6O2MwRC3z8G4qvUtWiM1rYrT','2021-09-16 19:57:37.277811','read write',1,5,'2021-09-16 09:57:37.278811','2021-09-16 09:57:37.278811',NULL,NULL);
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_application`
--

DROP TABLE IF EXISTS `oauth2_provider_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_application` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `client_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect_uris` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `authorization_grant_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_secret` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `skip_authorization` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `algorithm` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `oauth2_provider_application_user_id_79829054_fk_abaShip_user_id` (`user_id`),
  KEY `oauth2_provider_application_client_secret_53133678` (`client_secret`),
  CONSTRAINT `oauth2_provider_application_user_id_79829054_fk_abaShip_user_id` FOREIGN KEY (`user_id`) REFERENCES `abaship_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_application`
--

LOCK TABLES `oauth2_provider_application` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_application` DISABLE KEYS */;
INSERT INTO `oauth2_provider_application` VALUES (1,'GAoIoyXnX6pX6SwLNxeFWmcSyFY7lRfnDzKEDJDI','','confidential','password','jszRNc5BqGwiJ4bt8a2JixeCEWUb2OiAm2cxYbWatnClTfNRWn8IgBy8nOP57wluThd3qiKdn4xUtko8nySFWxjS2TfiH9HlyUzee4s99srowoQ1UQ9t4ccdb2HnDSMe','abshipApp',1,0,'2021-09-16 09:56:43.197870','2021-09-16 09:56:43.197870','');
/*!40000 ALTER TABLE `oauth2_provider_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_grant`
--

DROP TABLE IF EXISTS `oauth2_provider_grant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_grant` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `redirect_uri` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `scope` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `code_challenge` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code_challenge_method` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nonce` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `claims` longtext COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT (_utf8mb3''),
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_grant_user_id_e8f62af8_fk_abaShip_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_grant_user_id_e8f62af8_fk_abaShip_user_id` FOREIGN KEY (`user_id`) REFERENCES `abaship_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_grant`
--

LOCK TABLES `oauth2_provider_grant` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_grant` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_grant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_idtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_idtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_idtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `jti` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jti` (`jti`),
  KEY `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_idtoken_user_id_dd512b59_fk_abaShip_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_idtoken_user_id_dd512b59_fk_abaShip_user_id` FOREIGN KEY (`user_id`) REFERENCES `abaship_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_idtoken`
--

LOCK TABLES `oauth2_provider_idtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_idtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_idtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_refreshtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_refreshtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_refreshtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` bigint DEFAULT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `revoked` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_token_id` (`access_token_id`),
  UNIQUE KEY `oauth2_provider_refreshtoken_token_revoked_af8a5134_uniq` (`token`,`revoked`),
  KEY `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_refreshtoken_user_id_da837fce_fk_abaShip_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_refr_access_token_id_775e84e8_fk_oauth2_pr` FOREIGN KEY (`access_token_id`) REFERENCES `oauth2_provider_accesstoken` (`id`),
  CONSTRAINT `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_refreshtoken_user_id_da837fce_fk_abaShip_user_id` FOREIGN KEY (`user_id`) REFERENCES `abaship_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_refreshtoken`
--

LOCK TABLES `oauth2_provider_refreshtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_refreshtoken` VALUES (1,'UQTp6rkvnL0OI7ZB50e3PlJrvQEFsL',1,1,5,'2021-09-16 09:57:37.285807','2021-09-16 09:57:37.285807',NULL);
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-16 17:08:02
