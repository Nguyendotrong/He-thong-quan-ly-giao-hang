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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_auction`
--

LOCK TABLES `abaship_auction` WRITE;
/*!40000 ALTER TABLE `abaship_auction` DISABLE KEYS */;
INSERT INTO `abaship_auction` VALUES (1,'2021-10-05 02:29:14.866055','2021-10-05 03:28:04.969946',50000.00,1,1,1,27),(2,'2021-10-05 04:10:13.050003','2021-10-05 04:13:03.645035',50000.00,1,1,3,27),(3,'2021-10-05 04:30:19.574633','2021-10-05 04:31:57.269255',60000.00,1,1,4,27),(4,'2021-10-05 04:49:49.267849','2021-10-05 04:50:54.895315',70000.00,1,1,5,27);
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
INSERT INTO `abaship_categoryproductship` VALUES (1,'Hàng điện tử.','view_detail_auction'),(2,'Hàng gia dụng','Hàng gia dụng'),(3,'Hàng mỹ phẩm','Hàng mỹ phẩm'),(4,'Chuyển nhà','Chuyển nhà'),(5,'Chuyển văn phòng','Chuyển văn phòng');
/*!40000 ALTER TABLE `abaship_categoryproductship` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_imageitem`
--

LOCK TABLES `abaship_imageitem` WRITE;
/*!40000 ALTER TABLE `abaship_imageitem` DISABLE KEYS */;
INSERT INTO `abaship_imageitem` VALUES (1,'image/upload/v1633365583/nbulwpzhkst6hyee6rsx.jpg',1),(2,'image/upload/v1633365584/jaeg0rpnzn7jquatd24s.png',1),(3,'image/upload/v1633365983/drnbm6jojderozejsgvd.jpg',2),(4,'image/upload/v1633365983/lzzpvafmqsobldjqcl6b.png',2),(5,'image/upload/v1633406916/qojbh2ggbzqhk83oavih.jpg',3),(6,'image/upload/v1633408151/lare6t23levyuuum0kw0.jpg',4),(7,'image/upload/v1633409346/otuvktqi4wfvf0oputqr.jpg',5);
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
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `shipped_date` datetime(6) DEFAULT NULL,
  `status` smallint unsigned NOT NULL,
  `pay_method` smallint unsigned NOT NULL,
  `voucher_id` bigint DEFAULT NULL,
  PRIMARY KEY (`auction_win_id`),
  KEY `abaShip_ordership_voucher_id_714cf0b1_fk_abaShip_voucher_id` (`voucher_id`),
  CONSTRAINT `abaShip_ordership_auction_win_id_0c77a3a7_fk_abaShip_auction_id` FOREIGN KEY (`auction_win_id`) REFERENCES `abaship_auction` (`id`),
  CONSTRAINT `abaShip_ordership_voucher_id_714cf0b1_fk_abaShip_voucher_id` FOREIGN KEY (`voucher_id`) REFERENCES `abaship_voucher` (`id`),
  CONSTRAINT `abaship_ordership_chk_1` CHECK ((`status` >= 0)),
  CONSTRAINT `abaship_ordership_chk_2` CHECK ((`pay_method` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_ordership`
--

LOCK TABLES `abaship_ordership` WRITE;
/*!40000 ALTER TABLE `abaship_ordership` DISABLE KEYS */;
INSERT INTO `abaship_ordership` VALUES ('2021-10-05 03:28:04.959034','2021-10-05 03:28:04.959034',1,1,NULL,0,2,NULL),('2021-10-05 04:13:03.635043','2021-10-05 04:13:03.635043',2,1,NULL,0,2,NULL),('2021-10-05 04:31:57.260615','2021-10-05 04:31:57.260615',3,1,NULL,0,2,NULL),('2021-10-05 04:50:54.883320','2021-10-05 04:50:54.883320',4,1,NULL,0,2,NULL);
/*!40000 ALTER TABLE `abaship_ordership` ENABLE KEYS */;
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
  `is_finish` tinyint(1) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_post`
--

LOCK TABLES `abaship_post` WRITE;
/*!40000 ALTER TABLE `abaship_post` DISABLE KEYS */;
INSERT INTO `abaship_post` VALUES (1,'2021-10-04 16:32:14.075152','2021-10-05 03:28:04.966030',1,'giao hàng gia dụng',NULL,1,26,2,1),(2,'2021-10-04 16:46:20.419402','2021-10-04 16:51:06.823203',1,'giao hàng gia dụng',9,0,26,2,1),(3,'2021-10-05 04:08:33.359464','2021-10-05 04:13:03.642039',1,'giao hàng gia dụng',9,1,26,2,1),(4,'2021-10-05 04:29:08.983312','2021-10-05 04:31:57.264903',1,'chuyển nhà',9,1,26,2,1),(5,'2021-10-05 04:49:03.784546','2021-10-05 04:50:54.890321',1,'chuyển nhà',9,1,26,1,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_post_category_product_ship`
--

LOCK TABLES `abaship_post_category_product_ship` WRITE;
/*!40000 ALTER TABLE `abaship_post_category_product_ship` DISABLE KEYS */;
INSERT INTO `abaship_post_category_product_ship` VALUES (1,1,2),(2,2,2),(3,3,2),(4,4,3),(5,5,3);
/*!40000 ALTER TABLE `abaship_post_category_product_ship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_rate`
--

DROP TABLE IF EXISTS `abaship_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_rate` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` int unsigned NOT NULL,
  `customer_id` bigint NOT NULL,
  `shipper_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abaShip_rate_customer_id_shipper_id_17089e47_uniq` (`customer_id`,`shipper_id`),
  KEY `abaShip_rate_shipper_id_c0aeb476_fk_abaShip_user_id` (`shipper_id`),
  CONSTRAINT `abaShip_rate_customer_id_c3b178ff_fk_abaShip_user_id` FOREIGN KEY (`customer_id`) REFERENCES `abaship_user` (`id`),
  CONSTRAINT `abaShip_rate_shipper_id_c0aeb476_fk_abaShip_user_id` FOREIGN KEY (`shipper_id`) REFERENCES `abaship_user` (`id`),
  CONSTRAINT `abaship_rate_chk_1` CHECK ((`rate` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_rate`
--

LOCK TABLES `abaship_rate` WRITE;
/*!40000 ALTER TABLE `abaship_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `abaship_rate` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_stock`
--

LOCK TABLES `abaship_stock` WRITE;
/*!40000 ALTER TABLE `abaship_stock` DISABLE KEYS */;
INSERT INTO `abaship_stock` VALUES (1,'số 10 Nguyễn Trãi','Phong','0122112133',26),(2,'số 11 Nguyễn Kiệm','Ba','0122112133',26);
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
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_user`
--

LOCK TABLES `abaship_user` WRITE;
/*!40000 ALTER TABLE `abaship_user` DISABLE KEYS */;
INSERT INTO `abaship_user` VALUES (1,'pbkdf2_sha256$260000$0ptLMUBzMBvBpRGdVb1qhl$RT2ZdAbRmpGTADG9mJRMCECg4TM5BKPIsp+WW5ktR6w=','2021-10-05 02:11:50.459292',1,'admin','nguyendotrong.it@gmail.com',1,1,'2021-10-03 16:05:33.288059',NULL,NULL,NULL,NULL,'0',NULL,NULL),(25,'pbkdf2_sha256$260000$Vjfgqe74dEGakvJxIq4sOM$EAQCmTb9//aWE/FvB0XyuAzWDChWItNZmOM0JPjrw7I=',NULL,0,'DoTrong','nguyendotrong.it@gmail.com',0,1,'2021-10-04 15:35:01.778130',NULL,'0223456778','Trọng','Nguyễn','0','GV HCM','2000-11-12'),(26,'pbkdf2_sha256$260000$FkeyG04x1CrpvHy5IJtipf$3MB7LFch/paBkEdU5CUiHzwg9ivKwbn1cUi4Io1l59A=',NULL,0,'phanhuy','nguyendotrong.it@gmail.com',0,1,'2021-10-04 15:39:15.114193',NULL,'0223456778','phan','Nguyễn','0','GV HCM','2000-11-12'),(27,'pbkdf2_sha256$260000$IcYHhgomHj65OYTNSNxc9E$LPRufjSi2lSSVwH9Ld2GbALqt/tDaB+oZPMvXkSt9u0=',NULL,0,'shipper','nguyendotrong.it@gmail.com',0,1,'2021-10-05 02:13:30.000000','image/upload/v1633400565/q7qqmismp29xwbwyrrba.jpg','0223456778','shipper','Nguyễn','Male','GV HCM','2000-11-12'),(28,'pbkdf2_sha256$260000$Lrlvs1TrJdEgpdVnjf6g9h$W0hpDbsUzzUYcbcH4aBkKVUAVUrwMqGAydXa6xead8U=',NULL,0,'shipper1','nguyendotrong.it@gmail.com',0,1,'2021-10-05 02:14:18.000000','image/upload/v1633400529/uupx6h32o96rpsqofmcn.jpg','0223456778','shipper1','Nguyễn','Male','GV HCM','2000-11-12');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_user_groups`
--

LOCK TABLES `abaship_user_groups` WRITE;
/*!40000 ALTER TABLE `abaship_user_groups` DISABLE KEYS */;
INSERT INTO `abaship_user_groups` VALUES (7,25,1),(8,26,1),(12,27,2),(11,28,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_voucher`
--

LOCK TABLES `abaship_voucher` WRITE;
/*!40000 ALTER TABLE `abaship_voucher` DISABLE KEYS */;
INSERT INTO `abaship_voucher` VALUES (1,'2021-10-05 03:25:45.752666','2021-10-05 03:25:45.752666','ad','as',12,'2021-10-05 03:25:34.000000','2021-10-13 00:00:00.000000');
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
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (51,1,22),(1,1,24),(2,1,28),(3,1,36),(4,1,40),(5,1,41),(6,1,42),(7,1,43),(8,1,44),(9,1,45),(10,1,46),(11,1,47),(12,1,48),(13,1,49),(14,1,50),(15,1,51),(16,1,52),(17,1,53),(18,1,54),(19,1,55),(20,1,56),(21,1,60),(22,1,61),(23,1,62),(24,1,63),(25,1,64),(26,1,65),(27,1,66),(28,1,67),(29,1,68),(53,1,97),(50,2,22),(30,2,24),(31,2,28),(32,2,32),(33,2,36),(34,2,40),(35,2,41),(36,2,42),(37,2,43),(38,2,44),(39,2,48),(40,2,52),(41,2,56),(42,2,57),(43,2,58),(44,2,59),(45,2,60),(46,2,64),(47,2,68),(48,2,72),(49,2,76),(52,2,99);
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
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add category product ship',7,'add_categoryproductship'),(26,'Can change category product ship',7,'change_categoryproductship'),(27,'Can delete category product ship',7,'delete_categoryproductship'),(28,'Can view category product ship',7,'view_categoryproductship'),(29,'Can add deduct',8,'add_deduct'),(30,'Can change deduct',8,'change_deduct'),(31,'Can delete deduct',8,'delete_deduct'),(32,'Can view deduct',8,'view_deduct'),(33,'Can add notification',9,'add_notification'),(34,'Can change notification',9,'change_notification'),(35,'Can delete notification',9,'delete_notification'),(36,'Can view notification',9,'view_notification'),(37,'Can add voucher',10,'add_voucher'),(38,'Can change voucher',10,'change_voucher'),(39,'Can delete voucher',10,'delete_voucher'),(40,'Can view voucher',10,'view_voucher'),(41,'Can add id card',11,'add_idcard'),(42,'Can change id card',11,'change_idcard'),(43,'Can delete id card',11,'delete_idcard'),(44,'Can view id card',11,'view_idcard'),(45,'Can add stock',12,'add_stock'),(46,'Can change stock',12,'change_stock'),(47,'Can delete stock',12,'delete_stock'),(48,'Can view stock',12,'view_stock'),(49,'Can add post',13,'add_post'),(50,'Can change post',13,'change_post'),(51,'Can delete post',13,'delete_post'),(52,'Can view post',13,'view_post'),(53,'Can add image item',14,'add_imageitem'),(54,'Can change image item',14,'change_imageitem'),(55,'Can delete image item',14,'delete_imageitem'),(56,'Can view image item',14,'view_imageitem'),(57,'Can add auction',15,'add_auction'),(58,'Can change auction',15,'change_auction'),(59,'Can delete auction',15,'delete_auction'),(60,'Can view detail auction',15,'view_detail_auction'),(61,'Can add rate',16,'add_rate'),(62,'Can change rate',16,'change_rate'),(63,'Can delete rate',16,'delete_rate'),(64,'Can view rate',16,'view_rate'),(65,'Can add order ship',17,'add_ordership'),(66,'Can change order ship',17,'change_ordership'),(67,'Can delete order ship',17,'delete_ordership'),(68,'Can view order ship',17,'view_ordership'),(69,'Can add debt shipper',18,'add_debtshipper'),(70,'Can change debt shipper',18,'change_debtshipper'),(71,'Can delete debt shipper',18,'delete_debtshipper'),(72,'Can view debt shipper',18,'view_debtshipper'),(73,'Can add debt app',19,'add_debtapp'),(74,'Can change debt app',19,'change_debtapp'),(75,'Can delete debt app',19,'delete_debtapp'),(76,'Can view debt app',19,'view_debtapp'),(77,'Can add application',20,'add_application'),(78,'Can change application',20,'change_application'),(79,'Can delete application',20,'delete_application'),(80,'Can view application',20,'view_application'),(81,'Can add access token',21,'add_accesstoken'),(82,'Can change access token',21,'change_accesstoken'),(83,'Can delete access token',21,'delete_accesstoken'),(84,'Can view access token',21,'view_accesstoken'),(85,'Can add grant',22,'add_grant'),(86,'Can change grant',22,'change_grant'),(87,'Can delete grant',22,'delete_grant'),(88,'Can view grant',22,'view_grant'),(89,'Can add refresh token',23,'add_refreshtoken'),(90,'Can change refresh token',23,'change_refreshtoken'),(91,'Can delete refresh token',23,'delete_refreshtoken'),(92,'Can view refresh token',23,'view_refreshtoken'),(93,'Can add id token',24,'add_idtoken'),(94,'Can change id token',24,'change_idtoken'),(95,'Can delete id token',24,'delete_idtoken'),(96,'Can view id token',24,'view_idtoken'),(97,'can view list auction on post',15,'view_list_auction_on_post'),(98,'can view shipper\'s list auction',15,'view_list_auction_of_shipper'),(99,'Can add auction into post',13,'add_auction_into_post');
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2021-10-03 16:43:38.437261','1','customer',1,'[{\"added\": {}}]',3,1),(2,'2021-10-03 16:43:45.794277','2','shipper',1,'[{\"added\": {}}]',3,1),(3,'2021-10-04 16:06:25.487010','12','username: ',3,'',6,1),(4,'2021-10-04 16:06:25.496007','13','username: add',3,'',6,1),(5,'2021-10-04 16:06:25.499004','14','username: dat',3,'',6,1),(6,'2021-10-04 16:06:25.504004','15','username: q',3,'',6,1),(7,'2021-10-04 16:06:25.507999','16','username: t',3,'',6,1),(8,'2021-10-04 16:06:25.513995','17','username: td',3,'',6,1),(9,'2021-10-04 16:18:52.289032','1','customer',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(10,'2021-10-04 16:20:23.135303','2','shipper',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(11,'2021-10-04 16:20:37.213686','57','abaShip | auction | Can add auction into post',2,'[{\"changed\": {\"fields\": [\"Name\", \"Codename\"]}}]',2,1),(12,'2021-10-04 16:20:44.868276','57','abaShip | auction | Can add auction into post',2,'[]',2,1),(13,'2021-10-04 16:25:01.372772','60','abaShip | auction | Can view detail auction',2,'[{\"changed\": {\"fields\": [\"Name\", \"Codename\"]}}]',2,1),(14,'2021-10-04 16:25:30.686623','97','abaShip | auction | can view list auction on post',1,'[{\"added\": {}}]',2,1),(15,'2021-10-04 16:25:52.419576','98','abaShip | auction | can view shipper\'s list auction',1,'[{\"added\": {}}]',2,1),(16,'2021-10-04 16:26:18.356506','99','abaShip | post | Can add auction into post',1,'[{\"added\": {}}]',2,1),(17,'2021-10-04 16:26:38.855483','57','abaShip | auction | Can add auction',2,'[{\"changed\": {\"fields\": [\"Name\", \"Codename\"]}}]',2,1),(18,'2021-10-04 16:29:23.824741','1','Category: Hàng điện tử.,\nDescription: view_detail_auction',1,'[{\"added\": {}}]',7,1),(19,'2021-10-04 16:29:32.983057','2','Category: Hàng gia dụng,\nDescription: Hàng gia dụng',1,'[{\"added\": {}}]',7,1),(20,'2021-10-04 16:29:43.110950','3','Category: Hàng mỹ phẩm,\nDescription: Hàng mỹ phẩm',1,'[{\"added\": {}}]',7,1),(21,'2021-10-04 16:29:49.753619','4','Category: Chuyển nhà,\nDescription: Chuyển nhà',1,'[{\"added\": {}}]',7,1),(22,'2021-10-04 16:29:57.209164','5','Category: Chuyển văn phòng,\nDescription: Chuyển văn phòng',1,'[{\"added\": {}}]',7,1),(23,'2021-10-05 02:12:25.459770','21','username: phanhuy1',3,'',6,1),(24,'2021-10-05 02:12:25.463767','24','username: phanhuy11',3,'',6,1),(25,'2021-10-05 02:17:28.089946','2','shipper',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(26,'2021-10-05 02:18:31.314905','1','customer',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(27,'2021-10-05 02:22:09.174084','28','username: shipper1',2,'[{\"changed\": {\"fields\": [\"Groups\", \"Avatar\"]}}]',6,1),(28,'2021-10-05 02:22:45.408552','27','username: shipper',2,'[{\"changed\": {\"fields\": [\"Groups\", \"Avatar\", \"First name\", \"Gender\"]}}]',6,1),(29,'2021-10-05 02:29:08.578755','2','shipper',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(30,'2021-10-05 03:16:53.956987','1','customer',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(31,'2021-10-05 03:25:45.755769','1','name: ad,\ndiscount: 12.0',1,'[{\"added\": {}}]',10,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (15,'abaShip','auction'),(7,'abaShip','categoryproductship'),(19,'abaShip','debtapp'),(18,'abaShip','debtshipper'),(8,'abaShip','deduct'),(11,'abaShip','idcard'),(14,'abaShip','imageitem'),(9,'abaShip','notification'),(17,'abaShip','ordership'),(13,'abaShip','post'),(16,'abaShip','rate'),(12,'abaShip','stock'),(6,'abaShip','user'),(10,'abaShip','voucher'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(21,'oauth2_provider','accesstoken'),(20,'oauth2_provider','application'),(22,'oauth2_provider','grant'),(24,'oauth2_provider','idtoken'),(23,'oauth2_provider','refreshtoken'),(5,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2021-10-03 15:58:36.543220'),(2,'contenttypes','0002_remove_content_type_name','2021-10-03 15:58:36.702935'),(3,'auth','0001_initial','2021-10-03 15:58:37.220113'),(4,'auth','0002_alter_permission_name_max_length','2021-10-03 15:58:37.319095'),(5,'auth','0003_alter_user_email_max_length','2021-10-03 15:58:37.331751'),(6,'auth','0004_alter_user_username_opts','2021-10-03 15:58:37.343742'),(7,'auth','0005_alter_user_last_login_null','2021-10-03 15:58:37.355737'),(8,'auth','0006_require_contenttypes_0002','2021-10-03 15:58:37.361733'),(9,'auth','0007_alter_validators_add_error_messages','2021-10-03 15:58:37.374727'),(10,'auth','0008_alter_user_username_max_length','2021-10-03 15:58:37.386723'),(11,'auth','0009_alter_user_last_name_max_length','2021-10-03 15:58:37.401714'),(12,'auth','0010_alter_group_name_max_length','2021-10-03 15:58:37.429339'),(13,'auth','0011_update_proxy_permissions','2021-10-03 15:58:37.444329'),(14,'auth','0012_alter_user_first_name_max_length','2021-10-03 15:58:37.459320'),(15,'abaShip','0001_initial','2021-10-03 15:58:41.588279'),(16,'admin','0001_initial','2021-10-03 15:58:41.858384'),(17,'admin','0002_logentry_remove_auto_add','2021-10-03 15:58:41.893365'),(18,'admin','0003_logentry_add_action_flag_choices','2021-10-03 15:58:41.923347'),(19,'oauth2_provider','0001_initial','2021-10-03 15:58:45.735368'),(20,'oauth2_provider','0002_auto_20190406_1805','2021-10-03 15:58:45.984225'),(21,'oauth2_provider','0003_auto_20201211_1314','2021-10-03 15:58:46.208096'),(22,'oauth2_provider','0004_auto_20200902_2022','2021-10-03 15:58:47.274340'),(23,'sessions','0001_initial','2021-10-03 15:58:47.342408');
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
INSERT INTO `django_session` VALUES ('hxjr45jnkfq9qmoyms2qohuaq64jnd6i','.eJxVjMEOwiAQRP-FsyHAFioevfsNZBe2UjWQlPZk_Hdp0oPeZubNzFsE3NYctsZLmJO4CC1OvxlhfHLZQXpguVcZa1mXmeRekQdt8lYTv65H9-8gY8t9PZ4RQFuNNDBH0JFNF-QgOTRWWz_AaDx0b92kInskcsqRM0lNOibx-QLdVjfu:1mX4a7:xnJrUozic5qOFpXKfuJ72zbBTG0M6fEi6aHwxFD8I04','2021-10-17 16:43:19.795658'),('jvesix5mxqzbveiabiycccxtcxvpxv5p','.eJxVjMEOwiAQRP-FsyHAFioevfsNZBe2UjWQlPZk_Hdp0oPeZubNzFsE3NYctsZLmJO4CC1OvxlhfHLZQXpguVcZa1mXmeRekQdt8lYTv65H9-8gY8t9PZ4RQFuNNDBH0JFNF-QgOTRWWz_AaDx0b92kInskcsqRM0lNOibx-QLdVjfu:1mXZvq:4MwISXBg8is0CbugyqC3QbPMXNlPQMH7UTdxLsnIX10','2021-10-19 02:11:50.468287');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_accesstoken`
--

LOCK TABLES `oauth2_provider_accesstoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_accesstoken` VALUES (1,'l6rkYy2Eed92SsNTfGk8uyyXb9W0Yg','2021-10-05 02:14:58.314267','read write',1,26,'2021-10-04 16:14:58.314267','2021-10-04 16:14:58.314267',NULL,NULL),(2,'E2NbUdo6j20vc2VIq8sL3Vo6vgDT4L','2021-10-05 12:11:25.675748','read write',1,26,'2021-10-05 02:11:25.676753','2021-10-05 02:11:25.676753',NULL,NULL),(3,'K1BefE3UEBKbEjBs0uQPTQpQue6CwV','2021-10-05 12:14:53.339788','read write',1,27,'2021-10-05 02:14:53.340788','2021-10-05 02:14:53.340788',NULL,NULL),(4,'aIiqfey7sKhML98vDzZbGkVI99I0bT','2021-10-05 12:20:38.812530','read write',1,27,'2021-10-05 02:20:38.813534','2021-10-05 02:20:38.813534',NULL,NULL),(5,'O0eGu2QLLtIhM85C9GBbvikiYY6uoM','2021-10-05 12:26:02.839439','read write',1,27,'2021-10-05 02:26:02.840440','2021-10-05 02:26:02.840440',NULL,NULL),(6,'7TAn5P1K8CfGs6YsMUPaUujoRRJuO3','2021-10-05 13:06:15.770924','read write',1,26,'2021-10-05 03:06:15.770924','2021-10-05 03:06:15.770924',NULL,NULL),(7,'VXaAMinNJCYdPLGitvkCZSALb5vRxs','2021-10-05 13:06:52.725215','read write',1,25,'2021-10-05 03:06:52.726215','2021-10-05 03:06:52.726215',NULL,NULL),(8,'tawGaniSlpCSZYPjNLvVu6cA4FSdec','2021-10-05 13:10:19.651164','read write',1,26,'2021-10-05 03:10:19.652164','2021-10-05 03:10:19.652164',NULL,NULL),(9,'AfP3Yy6ieSbwnJUqH71AmVWuq36HvE','2021-10-05 14:09:29.530078','read write',1,27,'2021-10-05 04:09:29.531077','2021-10-05 04:09:29.531077',NULL,NULL),(10,'ZLjk6t4PDwwoompguqXysSDMJ5gLrL','2021-10-05 14:28:04.162124','read write',1,26,'2021-10-05 04:28:04.164123','2021-10-05 04:28:04.164123',NULL,NULL),(11,'Qbiv5dIWQLF7qn7JVlPS07seEcUrny','2021-10-05 14:29:35.500172','read write',1,27,'2021-10-05 04:29:35.501172','2021-10-05 04:29:35.501172',NULL,NULL),(12,'u4KawDkqqchHTARfIQdOb62vK4ALCa','2021-10-05 14:48:04.272816','read write',1,26,'2021-10-05 04:48:04.273815','2021-10-05 04:48:04.273815',NULL,NULL),(13,'RBaazqMmcfYNXEQRnmtxnGRukkYApK','2021-10-05 14:49:21.150571','read write',1,27,'2021-10-05 04:49:21.151570','2021-10-05 04:49:21.151570',NULL,NULL),(14,'sgblPVVlR64m8fLFXHvzBgf1cYEU7x','2021-10-05 14:50:33.123899','read write',1,26,'2021-10-05 04:50:33.124900','2021-10-05 04:50:33.124900',NULL,NULL);
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
INSERT INTO `oauth2_provider_application` VALUES (1,'fGB8Dw4LisdjAjNUdWhL0Howw25DZ39LiRdTUTro','','confidential','password','TVZDBuqShhQXxwkrQW6aextygWGIFHX4RjIJWgdo9MOKIJI1xCGWrNz3bWbaV5oaYFgcp3hiI8krwOBqWEmP3zEW5FkEoxsFBse39ozudGaxL7o08UIcRdSGU99puoSW','abshipapp',1,0,'2021-10-04 16:13:25.148046','2021-10-04 16:13:25.148046','');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_refreshtoken`
--

LOCK TABLES `oauth2_provider_refreshtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_refreshtoken` VALUES (1,'QkZmGCY4quOgUwacp0YNoJfenQzvO9',1,1,26,'2021-10-04 16:14:58.320264','2021-10-04 16:14:58.320264',NULL),(2,'auYnoyGQngl5Qha0MTrZSgJtjBS5q3',2,1,26,'2021-10-05 02:11:25.688750','2021-10-05 02:11:25.688750',NULL),(3,'5x942eNqOjkg7nUppuTLaLKVbYCN5m',3,1,27,'2021-10-05 02:14:53.344787','2021-10-05 02:14:53.344787',NULL),(4,'qd0GpA39OeUbnLlO1u8iQVrI07p8aA',4,1,27,'2021-10-05 02:20:38.817664','2021-10-05 02:20:38.817664',NULL),(5,'Q75BmHd3c0cCyDINBxbvEh1bAW4Itu',5,1,27,'2021-10-05 02:26:02.843809','2021-10-05 02:26:02.843809',NULL),(6,'GgUY2TfVIaTDtc44IgMitVcbZqOKY3',6,1,26,'2021-10-05 03:06:15.774920','2021-10-05 03:06:15.774920',NULL),(7,'IYGX9EXKEDYD7mxxgb8s31oNdKYwFB',7,1,25,'2021-10-05 03:06:52.728215','2021-10-05 03:06:52.728215',NULL),(8,'xZaKKeyzdNMn6TTVaGuIDsHa6kFpPU',8,1,26,'2021-10-05 03:10:19.654726','2021-10-05 03:10:19.654726',NULL),(9,'1gjxPcfjBL527w9xcVKtU6ZI9DyoDt',9,1,27,'2021-10-05 04:09:29.534071','2021-10-05 04:09:29.534071',NULL),(10,'QXqmYNbXMUrELXm5KJtORZtYGUm6Qi',10,1,26,'2021-10-05 04:28:04.170120','2021-10-05 04:28:04.170120',NULL),(11,'nTSVzAHKb7OlXOQfuHoju18abrk6kV',11,1,27,'2021-10-05 04:29:35.503170','2021-10-05 04:29:35.503170',NULL),(12,'xpXhDVa6W3UrNflK6qUzWuFKf46gUb',12,1,26,'2021-10-05 04:48:04.277811','2021-10-05 04:48:04.277811',NULL),(13,'mHUXBgJGwsLxNau7GAZaPBKvcdbpw8',13,1,27,'2021-10-05 04:49:21.153569','2021-10-05 04:49:21.153569',NULL),(14,'ORV08hqIw47QrSEYCIVPl5FGLFVI1a',14,1,26,'2021-10-05 04:50:33.126897','2021-10-05 04:50:33.126897',NULL);
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

-- Dump completed on 2021-10-05 14:13:32
