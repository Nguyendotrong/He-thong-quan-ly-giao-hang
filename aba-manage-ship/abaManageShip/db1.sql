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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_auction`
--

LOCK TABLES `abaship_auction` WRITE;
/*!40000 ALTER TABLE `abaship_auction` DISABLE KEYS */;
INSERT INTO `abaship_auction` VALUES (3,'2021-08-26 13:44:12.718557','2021-08-26 14:13:09.390837',100000.00,1,1,6,4),(4,'2021-08-26 13:45:51.258046','2021-08-26 13:45:51.258046',200000.00,0,1,7,5),(5,'2021-08-26 14:13:48.197957','2021-08-26 14:13:48.197957',120000.00,0,1,6,5);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_categoryproductship`
--

LOCK TABLES `abaship_categoryproductship` WRITE;
/*!40000 ALTER TABLE `abaship_categoryproductship` DISABLE KEYS */;
INSERT INTO `abaship_categoryproductship` VALUES (1,'Hàng điện tử.','Thiết bị điện tử'),(2,'Hàng gia dụng','Đồ dùng gia đình'),(3,'Thiết bị y tế','các loại trang thiết bị y tế'),(4,'Hàng mỹ phẩm','Mỹ phẩm'),(5,'Hồ sơ, tài liệu','các loại hồ sơ giấy tờ'),(6,'Kho hàng','kho hàng'),(7,'cửa hàng','Chuyển dời cửa hàng'),(8,'Chuyển nhà','Chuyển nhà trọn gói'),(9,'Chuyển văn phòng','trọn gói');
/*!40000 ALTER TABLE `abaship_categoryproductship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abaship_commentshipper`
--

DROP TABLE IF EXISTS `abaship_commentshipper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abaship_commentshipper` (
  `created_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `order_ship_id` bigint NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` int NOT NULL,
  PRIMARY KEY (`order_ship_id`),
  CONSTRAINT `abaShip_commentshipp_order_ship_id_73eb6e1a_fk_abaShip_o` FOREIGN KEY (`order_ship_id`) REFERENCES `abaship_ordership` (`auction_win_id`)
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
INSERT INTO `abaship_idcard` VALUES (2,'123456789055','idcard/2021/08/When_we_say_your_donations_are_life_changing_we_really_mean_it._1.jpg','idcard/2021/08/Beige_Green_and_Pink_Blob_Organic_Sale_Quick_Create_Facebook_Cover_4_7el4MJB.jpg','2015-04-02 12:00:00.000000','2024-03-01 00:00:00.000000'),(3,'234567890123','idcard/2021/08/Kem_Ảnh_ghép_Hữu_cơ_Thể_hình__Trang_phục_thể_thao_Trang_phục_năng_động_Bi_KcGh3Kw.jpg','idcard/2021/08/xem_ngày_tốt_chuyển_nhà.jpg','2019-09-03 12:00:00.000000','2023-08-31 00:00:00.000000'),(4,'456789012345','idcard/2021/08/213973463_1942006965937850_1965702884954308535_n.jpg','idcard/2021/08/218442956_907179206823561_3240609724349587219_n.jpg','2015-04-02 12:00:00.000000','2024-03-01 00:00:00.000000'),(5,'333333333333','idcard/2021/08/Kem_Ảnh_ghép_Hữu_cơ_Thể_hình__Trang_phục_thể_thao_Trang_phục_năng_động_Bi_BqdL88P.jpg','idcard/2021/08/207495964_4769054996441488_4147815477131087680_n.jpg','2019-09-03 12:00:00.000000','2024-03-01 00:00:00.000000');
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
INSERT INTO `abaship_imageitem` VALUES (3,'item/2021/08/207495964_4769054996441488_4147815477131087680_n.jpg',6),(4,'item/2021/08/213897943_1777108715829368_9181823631468435031_n.jpg',7),(5,'image/upload/v1630081382/xmrwdv8idefv6rxqbwlc.jpg',15),(6,'image/upload/v1630081383/av84akavav3b4piz5fsx.jpg',15),(7,'image/upload/v1630081384/grvj4wwdbutq72ym3rwt.jpg',15);
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
INSERT INTO `abaship_ordership` VALUES ('2021-08-26 14:13:09.395913','2021-08-26 14:13:09.395913',3,1,NULL,'NOTYETSHIPPED');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_post`
--

LOCK TABLES `abaship_post` WRITE;
/*!40000 ALTER TABLE `abaship_post` DISABLE KEYS */;
INSERT INTO `abaship_post` VALUES (6,'2021-08-26 12:13:52.487768','2021-08-26 13:43:06.650258',1,'<p>hai c&aacute;i tủ gỗ, 1 m&aacute;y lạnh th&aacute;o lắp, 1 m&aacute;y giặt, 1 tủ lạnh.</p>',111,2,5,4),(7,'2021-08-26 12:17:32.795903','2021-08-26 13:42:46.055094',1,'<p>Hai c&aacute;i l&ograve; nướng.</p>',10,3,7,6),(8,'2021-08-27 16:08:49.056371','2021-08-27 16:08:49.056371',1,'hoathinh',2,8,3,4),(9,'2021-08-27 16:10:32.192307','2021-08-27 16:10:32.192307',1,'hoathinh',2,8,3,4),(10,'2021-08-27 16:11:32.451886','2021-08-27 16:11:32.451886',1,'hoathinh',2,8,3,4),(11,'2021-08-27 16:12:21.994782','2021-08-27 16:12:21.994782',1,'hoathinh',2,8,3,4),(12,'2021-08-27 16:14:07.471652','2021-08-27 16:14:07.471652',1,'hoathinh',2,8,3,4),(13,'2021-08-27 16:17:26.984195','2021-08-27 16:17:26.984195',1,'hoathinh',2,8,3,4),(14,'2021-08-27 16:22:06.473263','2021-08-27 16:22:06.473263',1,'hoathinh',2,8,3,4),(15,'2021-08-27 16:22:59.868055','2021-08-27 16:22:59.868055',1,'hoathinh',2,8,3,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_post_category_product_ship`
--

LOCK TABLES `abaship_post_category_product_ship` WRITE;
/*!40000 ALTER TABLE `abaship_post_category_product_ship` DISABLE KEYS */;
INSERT INTO `abaship_post_category_product_ship` VALUES (6,6,8),(7,7,2),(8,8,1),(9,9,1),(10,10,1),(11,11,1),(12,12,1),(13,13,1),(14,14,1),(15,15,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_stock`
--

LOCK TABLES `abaship_stock` WRITE;
/*!40000 ALTER TABLE `abaship_stock` DISABLE KEYS */;
INSERT INTO `abaship_stock` VALUES (3,'371 NK','nguyễn Chí Tiến','1234567890',2),(4,'371 NK','nguyễn Chí Tiến','1234567890',2),(5,'372 Nk','Trần Hành','9876543210',2),(6,'97 Võ Văn Tần','Trần Tỏi','0123698777',3),(7,'98 Võ Văn Tần','Phạm Ớt','0838383399',3),(8,'91 Bạch Đằng','Phan Công Bình','0989898989',8);
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
  `phone` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_user`
--

LOCK TABLES `abaship_user` WRITE;
/*!40000 ALTER TABLE `abaship_user` DISABLE KEYS */;
INSERT INTO `abaship_user` VALUES (1,'pbkdf2_sha256$260000$qyzANjmmIkSE8uwDWUZvZB$nAmAmSw6IQjVMU1h4RziiVAiBDZom3CSewlzqwF3MMg=','2021-08-26 15:27:57.978956',1,'admin','nguyentrong.it@gmail.com',1,1,'2021-08-19 08:42:52.326422','','','','','0'),(2,'123456',NULL,0,'customera','1851050159trong@ou.edu.vn',0,1,'2021-08-19 08:57:27.000000','avatar/2021/08/download_1_7Gh9j9E.jpg','0943940261','A','Nguyễn Văn','0'),(3,'123456',NULL,0,'customerb','tronghk9no@gmail.com',0,1,'2021-08-19 08:59:12.000000','avatar/2021/08/download_2_Kwq4ysw.jpg','0328934415','B','Trần','0'),(4,'123456',NULL,0,'shipperc','ndt050800@gmail.com',0,1,'2021-08-19 09:00:23.000000','avatar/2021/08/download_3_Qc16cHB.jpg','0382753581','C','Nguyễn Văn','0'),(5,'123456',NULL,0,'shipperd','Phuc@gmail.com',0,1,'2021-08-19 09:01:47.000000','avatar/2021/08/images_gGFEXEV.jpg','0123456789','D','Trần','0'),(6,'123456',NULL,0,'dotrong','trong@gmail.com',0,1,'2021-08-25 14:00:25.143881','avatar/2021/08/download_nTRnl57.jpg','','Trọng','Đỗ','0'),(7,'pbkdf2_sha256$260000$cTVvWBVO8Z7fAwVoKmrg3R$/hwsDzJWmnuiB6aTm1aXVezoKpMO3EXU/czXB8MoHaE=',NULL,0,'dotrong2','trong2@gmail.com',0,1,'2021-08-25 14:11:02.217929','avatar/2021/08/images_1_lylUDIx.jpg','','Trọng2','Đỗ2','0'),(8,'pbkdf2_sha256$260000$X0purRV7GWdCNRHKPugwbq$SlDNHzsDYjzqUmO93JpZ1HYrQR8eS/ckuV02TldEeQs=',NULL,0,'phanhuy','huy@gmail.com',0,1,'2021-08-25 17:37:42.210688','avatar/2021/08/Example-of-AIML-code.png','0123456789','huy','phan','0');
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
INSERT INTO `abaship_user_groups` VALUES (1,2,1),(2,3,1),(3,4,2),(4,5,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (24,1,21),(25,1,22),(26,1,23),(27,1,24),(28,1,28),(29,1,37),(30,1,38),(31,1,39),(32,1,40),(33,1,44),(34,1,45),(35,1,46),(36,1,47),(37,1,48),(1,1,49),(38,1,50),(39,1,51),(40,1,52),(41,1,53),(42,1,54),(43,1,55),(44,1,56),(45,1,57),(46,1,58),(47,1,59),(48,1,60),(49,1,61),(50,1,62),(51,1,63),(52,1,64),(53,1,73),(54,1,74),(55,1,75),(56,1,76),(3,2,25),(4,2,26),(5,2,27),(6,2,28),(7,2,29),(8,2,30),(9,2,31),(10,2,32),(11,2,40),(12,2,45),(13,2,46),(14,2,47),(15,2,48),(16,2,52),(17,2,56),(18,2,57),(19,2,58),(20,2,59),(21,2,60),(22,2,64),(23,2,76);
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
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add auction',7,'add_auction'),(26,'Can change auction',7,'change_auction'),(27,'Can delete auction',7,'delete_auction'),(28,'Can view auction',7,'view_auction'),(29,'Can add category product ship',8,'add_categoryproductship'),(30,'Can change category product ship',8,'change_categoryproductship'),(31,'Can delete category product ship',8,'delete_categoryproductship'),(32,'Can view category product ship',8,'view_categoryproductship'),(33,'Can add deduct',9,'add_deduct'),(34,'Can change deduct',9,'change_deduct'),(35,'Can delete deduct',9,'delete_deduct'),(36,'Can view deduct',9,'view_deduct'),(37,'Can add stock',10,'add_stock'),(38,'Can change stock',10,'change_stock'),(39,'Can delete stock',10,'delete_stock'),(40,'Can view stock',10,'view_stock'),(41,'Can add voucher',11,'add_voucher'),(42,'Can change voucher',11,'change_voucher'),(43,'Can delete voucher',11,'delete_voucher'),(44,'Can view voucher',11,'view_voucher'),(45,'Can add id card',12,'add_idcard'),(46,'Can change id card',12,'change_idcard'),(47,'Can delete id card',12,'delete_idcard'),(48,'Can view id card',12,'view_idcard'),(49,'Can add order ship',13,'add_ordership'),(50,'Can change order ship',13,'change_ordership'),(51,'Can delete order ship',13,'delete_ordership'),(52,'Can view order ship',13,'view_ordership'),(53,'Can add post',14,'add_post'),(54,'Can change post',14,'change_post'),(55,'Can delete post',14,'delete_post'),(56,'Can view post',14,'view_post'),(57,'Can add image item',15,'add_imageitem'),(58,'Can change image item',15,'change_imageitem'),(59,'Can delete image item',15,'delete_imageitem'),(60,'Can view image item',15,'view_imageitem'),(61,'Can add comment shipper',16,'add_commentshipper'),(62,'Can change comment shipper',16,'change_commentshipper'),(63,'Can delete comment shipper',16,'delete_commentshipper'),(64,'Can view comment shipper',16,'view_commentshipper'),(65,'Can add debt shipper',17,'add_debtshipper'),(66,'Can change debt shipper',17,'change_debtshipper'),(67,'Can delete debt shipper',17,'delete_debtshipper'),(68,'Can view debt shipper',17,'view_debtshipper'),(69,'Can add debt app',18,'add_debtapp'),(70,'Can change debt app',18,'change_debtapp'),(71,'Can delete debt app',18,'delete_debtapp'),(72,'Can view debt app',18,'view_debtapp'),(73,'Can add order ship detail',19,'add_ordershipdetail'),(74,'Can change order ship detail',19,'change_ordershipdetail'),(75,'Can delete order ship detail',19,'delete_ordershipdetail'),(76,'Can view order ship detail',19,'view_ordershipdetail'),(77,'Can add application',20,'add_application'),(78,'Can change application',20,'change_application'),(79,'Can delete application',20,'delete_application'),(80,'Can view application',20,'view_application'),(81,'Can add access token',21,'add_accesstoken'),(82,'Can change access token',21,'change_accesstoken'),(83,'Can delete access token',21,'delete_accesstoken'),(84,'Can view access token',21,'view_accesstoken'),(85,'Can add grant',22,'add_grant'),(86,'Can change grant',22,'change_grant'),(87,'Can delete grant',22,'delete_grant'),(88,'Can view grant',22,'view_grant'),(89,'Can add refresh token',23,'add_refreshtoken'),(90,'Can change refresh token',23,'change_refreshtoken'),(91,'Can delete refresh token',23,'delete_refreshtoken'),(92,'Can view refresh token',23,'view_refreshtoken'),(93,'Can add id token',24,'add_idtoken'),(94,'Can change id token',24,'change_idtoken'),(95,'Can delete id token',24,'delete_idtoken'),(96,'Can view id token',24,'view_idtoken'),(97,'Can add notification',25,'add_notification'),(98,'Can change notification',25,'change_notification'),(99,'Can delete notification',25,'delete_notification'),(100,'Can view notification',25,'view_notification');
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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2021-08-19 08:46:09.474784','1','customer',1,'[{\"added\": {}}]',3,1),(2,'2021-08-19 08:46:19.385910','2','Shipper',1,'[{\"added\": {}}]',3,1),(3,'2021-08-19 08:55:00.601856','2','Shipper',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(4,'2021-08-19 08:55:11.174719','2','Shipper',2,'[]',3,1),(5,'2021-08-19 08:57:20.735065','1','customer',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(6,'2021-08-19 08:59:12.466705','2','name: customera',1,'[{\"added\": {}}, {\"added\": {\"name\": \"id card\", \"object\": \"Id card: 123456789055\"}}]',6,1),(7,'2021-08-19 09:00:22.918841','3','name: customerb',1,'[{\"added\": {}}, {\"added\": {\"name\": \"id card\", \"object\": \"Id card: 234567890123\"}}]',6,1),(8,'2021-08-19 09:01:46.841555','4','name: shipperc',1,'[{\"added\": {}}, {\"added\": {\"name\": \"id card\", \"object\": \"Id card: 456789012345\"}}]',6,1),(9,'2021-08-19 09:03:11.494019','5','name: shipperd',1,'[{\"added\": {}}, {\"added\": {\"name\": \"id card\", \"object\": \"Id card: 333333333333\"}}]',6,1),(10,'2021-08-19 14:15:56.312865','1','Category: Hàng điện tử.,\nDescription: Thiết bị điện tử',1,'[{\"added\": {}}]',8,1),(11,'2021-08-19 14:16:17.052035','2','Category: Hàng gia dụng,\nDescription: Đồ dùng gia đình',1,'[{\"added\": {}}]',8,1),(12,'2021-08-19 14:16:52.836860','3','Category: Thiết bị y tế,\nDescription: các loại trang thiết bị y tế',1,'[{\"added\": {}}]',8,1),(13,'2021-08-19 14:17:08.588948','4','Category: Hàng mỹ phẩm,\nDescription: Mỹ phẩm',1,'[{\"added\": {}}]',8,1),(14,'2021-08-19 14:17:31.696058','5','Category: Hồ sơ, tài liệu,\nDescription: các loại hồ sơ giấy tờ',1,'[{\"added\": {}}]',8,1),(15,'2021-08-19 14:18:00.580802','6','Category: Kho hàng,\nDescription: kho hàng',1,'[{\"added\": {}}]',8,1),(16,'2021-08-19 14:18:23.275882','7','Category: cửa hàng,\nDescription: Chuyển dời cửa hàng',1,'[{\"added\": {}}]',8,1),(17,'2021-08-19 14:18:42.490903','8','Category: Chuyển nhà,\nDescription: Chuyển nhà trọn gói',1,'[{\"added\": {}}]',8,1),(18,'2021-08-19 14:18:59.984126','9','Category: Chuyển văn phòng,\nDescription: trọn gói',1,'[{\"added\": {}}]',8,1),(19,'2021-08-19 14:20:10.338735','1','Address: 371 NK,\n Represent man: nguyễn Chí Tiến,\nPhone: 1111111111',1,'[{\"added\": {}}]',10,1),(20,'2021-08-19 14:20:29.997491','2','Address: 372 Nk,\n Represent man: Trần Hành,\nPhone: 2222222222',1,'[{\"added\": {}}]',10,1),(21,'2021-08-19 14:57:12.492854','2','Customer: A Nguyễn Văn,\nCategory product: abaShip.CategoryProductShip.None,\nCreated date: 2021-08-19 14:57:12.477916+00:00',1,'[{\"added\": {}}, {\"added\": {\"name\": \"image item\", \"object\": \"post: 5.0\"}}]',14,1),(22,'2021-08-19 15:50:01.835975','1','shipper: C,\nprice: 12000',1,'[{\"added\": {}}, {\"added\": {\"name\": \"order ship\", \"object\": \"customer: customera Nguy\\u1ec5n V\\u0103n,\\nshipper: C Nguy\\u1ec5n V\\u0103n,\\nstatus: NOTYETSHIPPED,\\ncreated date: 2021-08-19 15:50:01.830973+00:00\"}}]',7,1),(23,'2021-08-19 15:53:01.732267','1','shipper: C,\nprice: 12000.00',2,'[]',7,1),(24,'2021-08-19 15:53:30.723269','2','shipper: D,\nprice: 120000',1,'[{\"added\": {}}, {\"added\": {\"name\": \"order ship\", \"object\": \"customer: customera Nguy\\u1ec5n V\\u0103n,\\nshipper: D Tr\\u1ea7n,\\nstatus: NOTYETSHIPPED,\\ncreated date: 2021-08-19 15:53:30.719270+00:00\"}}]',7,1),(25,'2021-08-24 12:45:47.324566','2','Customer: A Nguyễn Văn,\nCategory product: abaShip.CategoryProductShip.None,\nCreated date: 2021-08-19 14:57:12.477916+00:00',2,'[{\"changed\": {\"fields\": [\"Active\"]}}]',14,1),(26,'2021-08-26 12:11:25.243803','3','Address: 371 NK,\n Represent man: nguyễn Chí Tiến,\nPhone: 1234567890',1,'[{\"added\": {}}]',10,1),(27,'2021-08-26 12:11:25.249800','4','Address: 371 NK,\n Represent man: nguyễn Chí Tiến,\nPhone: 1234567890',1,'[{\"added\": {}}]',10,1),(28,'2021-08-26 12:12:01.480096','5','Address: 372 Nk,\n Represent man: Trần Hành,\nPhone: 9876543210',1,'[{\"added\": {}}]',10,1),(29,'2021-08-26 12:13:52.563091','6','Customer: A Nguyễn Văn,\nCategory product: abaShip.CategoryProductShip.None,\nCreated date: 2021-08-26 12:13:52.487768+00:00',1,'[{\"added\": {}}, {\"added\": {\"name\": \"image item\", \"object\": \"post: 111.0\"}}]',14,1),(30,'2021-08-26 12:14:01.890360','6','Customer: A Nguyễn Văn,\nCategory product: abaShip.CategoryProductShip.None,\nCreated date: 2021-08-26 12:13:52.487768+00:00',2,'[]',14,1),(31,'2021-08-26 12:15:20.887128','6','Address: 97 Võ Văn Tần,\n Represent man: Trần Tỏi,\nPhone: 0123698777',1,'[{\"added\": {}}]',10,1),(32,'2021-08-26 12:16:36.892070','7','Address: 98 Võ Văn Tần,\n Represent man: Phạm Ớt,\nPhone: 0838383399',1,'[{\"added\": {}}]',10,1),(33,'2021-08-26 12:17:32.810893','7','Customer: B Trần,\nCategory product: abaShip.CategoryProductShip.None,\nCreated date: 2021-08-26 12:17:32.795903+00:00',1,'[{\"added\": {}}, {\"added\": {\"name\": \"image item\", \"object\": \"post: 10.0\"}}]',14,1),(34,'2021-08-26 12:17:37.141849','7','Customer: B Trần,\nCategory product: abaShip.CategoryProductShip.None,\nCreated date: 2021-08-26 12:17:32.795903+00:00',2,'[]',14,1),(35,'2021-08-26 13:42:46.060171','7','Customer: B Trần,\nCategory product: abaShip.CategoryProductShip.None,\nCreated date: 2021-08-26 12:17:32.795903+00:00',2,'[]',14,1),(36,'2021-08-26 13:43:06.655262','6','Customer: A Nguyễn Văn,\nCategory product: abaShip.CategoryProductShip.None,\nCreated date: 2021-08-26 12:13:52.487768+00:00',2,'[]',14,1),(37,'2021-08-26 13:44:12.728172','3','shipper: C,\nprice: 100000',1,'[{\"added\": {}}, {\"added\": {\"name\": \"order ship\", \"object\": \"customer: customera Nguy\\u1ec5n V\\u0103n,\\nshipper: C Nguy\\u1ec5n V\\u0103n,\\nstatus: NOTYETSHIPPED,\\ncreated date: 2021-08-26 13:44:12.724179+00:00\"}}]',7,1),(38,'2021-08-26 13:45:51.268010','4','shipper: D,\nprice: 200000',1,'[{\"added\": {}}, {\"added\": {\"name\": \"order ship\", \"object\": \"customer: customerb Tr\\u1ea7n,\\nshipper: D Tr\\u1ea7n,\\nstatus: NOTYETSHIPPED,\\ncreated date: 2021-08-26 13:45:51.263013+00:00\"}}]',7,1),(39,'2021-08-26 14:11:10.518975','4','customer: customerb Trần,\nshipper: D Trần,\nstatus: NOTYETSHIPPED,\ncreated date: 2021-08-26 13:45:51.263013+00:00',3,'',13,1),(40,'2021-08-26 14:11:10.525520','3','customer: customera Nguyễn Văn,\nshipper: C Nguyễn Văn,\nstatus: NOTYETSHIPPED,\ncreated date: 2021-08-26 13:44:12.724179+00:00',3,'',13,1),(41,'2021-08-26 14:13:09.401830','3','shipper: C,\nprice: 100000.00',2,'[{\"added\": {\"name\": \"order ship\", \"object\": \"customer: customera Nguy\\u1ec5n V\\u0103n,\\nshipper: C Nguy\\u1ec5n V\\u0103n,\\nstatus: NOTYETSHIPPED,\\ncreated date: 2021-08-26 14:13:09.395913+00:00\"}}]',7,1),(42,'2021-08-26 14:13:48.200955','5','shipper: D,\nprice: 120000',1,'[{\"added\": {}}]',7,1),(43,'2021-08-26 16:28:49.213433','2','shipper',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',3,1);
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
INSERT INTO `django_content_type` VALUES (7,'abaShip','auction'),(8,'abaShip','categoryproductship'),(16,'abaShip','commentshipper'),(18,'abaShip','debtapp'),(17,'abaShip','debtshipper'),(9,'abaShip','deduct'),(12,'abaShip','idcard'),(15,'abaShip','imageitem'),(25,'abaShip','notification'),(13,'abaShip','ordership'),(19,'abaShip','ordershipdetail'),(14,'abaShip','post'),(10,'abaShip','stock'),(6,'abaShip','user'),(11,'abaShip','voucher'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(21,'oauth2_provider','accesstoken'),(20,'oauth2_provider','application'),(22,'oauth2_provider','grant'),(24,'oauth2_provider','idtoken'),(23,'oauth2_provider','refreshtoken'),(5,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2021-08-19 08:36:27.122890'),(2,'contenttypes','0002_remove_content_type_name','2021-08-19 08:36:27.315778'),(3,'auth','0001_initial','2021-08-19 08:36:27.811976'),(4,'auth','0002_alter_permission_name_max_length','2021-08-19 08:36:27.956804'),(5,'auth','0003_alter_user_email_max_length','2021-08-19 08:36:27.968617'),(6,'auth','0004_alter_user_username_opts','2021-08-19 08:36:27.979924'),(7,'auth','0005_alter_user_last_login_null','2021-08-19 08:36:27.991015'),(8,'auth','0006_require_contenttypes_0002','2021-08-19 08:36:27.996089'),(9,'auth','0007_alter_validators_add_error_messages','2021-08-19 08:36:28.006786'),(10,'auth','0008_alter_user_username_max_length','2021-08-19 08:36:28.018335'),(11,'auth','0009_alter_user_last_name_max_length','2021-08-19 08:36:28.030619'),(12,'auth','0010_alter_group_name_max_length','2021-08-19 08:36:28.055145'),(13,'auth','0011_update_proxy_permissions','2021-08-19 08:36:28.066969'),(14,'auth','0012_alter_user_first_name_max_length','2021-08-19 08:36:28.079978'),(15,'abaShip','0001_initial','2021-08-19 08:36:31.485844'),(16,'admin','0001_initial','2021-08-19 08:36:31.820576'),(17,'admin','0002_logentry_remove_auto_add','2021-08-19 08:36:31.847786'),(18,'admin','0003_logentry_add_action_flag_choices','2021-08-19 08:36:31.871792'),(19,'sessions','0001_initial','2021-08-19 08:36:31.927687'),(20,'abaShip','0002_auto_20210819_2136','2021-08-19 14:37:05.370184'),(21,'abaShip','0003_alter_ordership_status','2021-08-19 15:31:06.933243'),(22,'abaShip','0004_auto_20210819_2246','2021-08-19 15:47:00.508509'),(23,'oauth2_provider','0001_initial','2021-08-25 08:14:54.336410'),(24,'oauth2_provider','0002_auto_20190406_1805','2021-08-25 08:14:54.530301'),(25,'oauth2_provider','0003_auto_20201211_1314','2021-08-25 08:14:54.658228'),(26,'oauth2_provider','0004_auto_20200902_2022','2021-08-25 08:14:55.603493'),(27,'abaShip','0005_auto_20210826_1009','2021-08-26 03:52:07.576292'),(28,'abaShip','0006_auto_20210827_2026','2021-08-27 13:27:20.682166'),(29,'abaShip','0007_alter_user_avatar','2021-08-27 15:27:34.637438'),(30,'abaShip','0008_auto_20210827_2231','2021-08-27 15:31:11.370022');
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
INSERT INTO `django_session` VALUES ('ssukcapllsptndjr9xjyignphvq6e3ym','.eJxVjEEOwiAURO_C2hA_yCe6dO8ZyPABqRqalHZlvLtt0oVu5703bxWwzDUsPU9hSOqiSB1-twh55raB9EC7j1rGNk9D1Juid9r1bUz5dd3dv4OKXtfaMtiSIxRyxVMSomKEDRXHFnzGCrxIsZ7YsXHwAAuOJ0tsIjn1-QLRejdO:1mJHIL:lRzFFyYn-lMRgrum18GiuVFgqcSQkSS4MdjJIY9Zh_Y','2021-09-09 15:27:57.989950');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_accesstoken`
--

LOCK TABLES `oauth2_provider_accesstoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_accesstoken` VALUES (1,'LelS3AihpXYsGkBXUmvlJmC0j1buOf','2021-08-25 18:54:32.870911','read write',1,1,'2021-08-25 08:54:32.871911','2021-08-25 08:54:32.871911',NULL,NULL),(2,'ObBznu8WlhZaPr7MkerBy5G39xKR6l','2021-08-26 01:39:20.181233','read write',1,1,'2021-08-25 15:39:20.183231','2021-08-25 15:39:20.183231',NULL,NULL),(3,'Ke8HwMjjVFkfFnjfYcVWEczB5xCqd9','2021-08-26 02:10:16.545228','read write',1,1,'2021-08-25 16:10:16.546228','2021-08-25 16:10:16.546228',NULL,NULL),(4,'Nlz1gbGIHXt1DIrcDDZuLLKnxpJqkF','2021-08-26 02:15:43.388595','read write',1,1,'2021-08-25 16:15:43.389595','2021-08-25 16:15:43.389595',NULL,NULL),(5,'ret4DGeUBmUtJXyc6aymQJoDp3Z2sB','2021-08-26 03:00:16.378900','read write',1,7,'2021-08-25 17:00:16.380900','2021-08-25 17:00:16.380900',NULL,NULL),(6,'rJdmiM5CINME40Aq2BaSVslcVIF3fb','2021-08-26 03:08:46.064256','read write',1,1,'2021-08-25 17:08:46.065256','2021-08-25 17:08:46.065256',NULL,NULL),(7,'OHDiWsNGsSNPbV32SMykA3zkJw3YzL','2021-08-26 03:10:44.973966','read write',1,7,'2021-08-25 17:10:44.974966','2021-08-25 17:10:44.974966',NULL,NULL),(8,'UDn5ibgFR6m2dnub1sFsQWEEFFW0K1','2021-08-26 03:43:08.188900','read write',1,8,'2021-08-25 17:43:08.189902','2021-08-25 17:43:08.189902',NULL,NULL),(9,'mmiqz8E0VUfQez0RtdQmEO44NJmQik','2021-08-27 22:15:38.840967','read write',1,8,'2021-08-27 12:15:38.841948','2021-08-27 12:15:38.841948',NULL,NULL),(10,'Cbtdp5IEddW4DLWr206XGsb90MfLqO','2021-08-28 14:33:05.842935','read write',1,8,'2021-08-28 04:33:05.843952','2021-08-28 04:33:05.843952',NULL,NULL),(11,'20DBOJCBEDVLY6n0EIX09n0vrIVz2T','2021-08-28 14:41:26.135420','read write',1,8,'2021-08-28 04:41:26.136421','2021-08-28 04:41:26.136421',NULL,NULL),(12,'lCPaNNn61KuuuLnN3EpQVgUNYzw6lO','2021-08-28 17:34:04.575238','read write',1,8,'2021-08-28 07:34:04.576243','2021-08-28 07:34:04.576243',NULL,NULL);
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
INSERT INTO `oauth2_provider_application` VALUES (1,'tgnUoY0SERab0qLgk7sLLVeg4cLAkX6u03vQKFM6','','confidential','password','vJPDDldC54M4r5lLDHOQIqW7qyj000kZiCI4XbQUefOQUbsJEgcwXXnxaxIrKgb365uLbXaoOc7Ew9qYTkD6svpqByd2GMDjrDqmyjwM02XQmI6If9y0E9JCjfAASDeS','AbaShipApp',1,0,'2021-08-25 08:43:41.515487','2021-08-25 08:43:41.515487','');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_refreshtoken`
--

LOCK TABLES `oauth2_provider_refreshtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_refreshtoken` VALUES (1,'MgxhST87OHqq6Dxf2letRnVvGjbulD',1,1,1,'2021-08-25 08:54:32.877907','2021-08-25 08:54:32.877907',NULL),(2,'4uKmpolq2zbO63OtYxgnrxGnEz6XAP',2,1,1,'2021-08-25 15:39:20.199222','2021-08-25 15:39:20.199222',NULL),(3,'7YV8Q3fF3F4qx0QTdmdJEftQ00aNET',3,1,1,'2021-08-25 16:10:16.549226','2021-08-25 16:10:16.549226',NULL),(4,'lXpkwTtDcbAD3IwnGMg9ptImGi9N5W',4,1,1,'2021-08-25 16:15:43.392593','2021-08-25 16:15:43.392593',NULL),(5,'9H2eLEkMDnQseH3tTIdOu9y1WZVp9s',5,1,7,'2021-08-25 17:00:16.386894','2021-08-25 17:00:16.386894',NULL),(6,'AsNCj3VY4qCmlASo5K2VEpDBfEFMz9',6,1,1,'2021-08-25 17:08:46.068255','2021-08-25 17:08:46.068255',NULL),(7,'uBYPMWzJhkSa8Tp9pSHtdTYa5E5J07',7,1,7,'2021-08-25 17:10:44.978964','2021-08-25 17:10:44.978964',NULL),(8,'z6KFTsS8ecRbXZojuGsWrZgqa27Hxj',8,1,8,'2021-08-25 17:43:08.194897','2021-08-25 17:43:08.194897',NULL),(9,'cNVP2TEbR6C5T4nfpYo6d9xTsu0dPM',9,1,8,'2021-08-27 12:15:38.849538','2021-08-27 12:15:38.849538',NULL),(10,'P85zH24YaGXriRCflhejBSjhFFmYlx',10,1,8,'2021-08-28 04:33:05.867746','2021-08-28 04:33:05.867746',NULL),(11,'79M4DzlVMZ080672qS7lUMBtT9UtRv',11,1,8,'2021-08-28 04:41:26.140439','2021-08-28 04:41:26.140439',NULL),(12,'YKzqhzXreWgTYngT1mNtN11hLOuDgc',12,1,8,'2021-08-28 07:34:04.579891','2021-08-28 07:34:04.579891',NULL);
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

-- Dump completed on 2021-08-30  9:42:02
