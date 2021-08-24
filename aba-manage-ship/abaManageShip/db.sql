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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_auction`
--

LOCK TABLES `abaship_auction` WRITE;
/*!40000 ALTER TABLE `abaship_auction` DISABLE KEYS */;
INSERT INTO `abaship_auction` VALUES (1,'2021-08-19 15:50:01.826996','2021-08-19 15:53:01.730554',12000.00,1,1,2,4),(2,'2021-08-19 15:53:30.713645','2021-08-19 15:53:30.713645',120000.00,0,1,2,5);
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
  `image_card_front` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_card_back` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `image` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `abaShip_imageitem_post_id_f9201e8f_fk_abaShip_post_id` (`post_id`),
  CONSTRAINT `abaShip_imageitem_post_id_f9201e8f_fk_abaShip_post_id` FOREIGN KEY (`post_id`) REFERENCES `abaship_post` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_imageitem`
--

LOCK TABLES `abaship_imageitem` WRITE;
/*!40000 ALTER TABLE `abaship_imageitem` DISABLE KEYS */;
INSERT INTO `abaship_imageitem` VALUES (2,'item/2021/08/Luôn_đặt_khách_hàng_làm_trọng_tâm_rVLkOAW.png',2);
/*!40000 ALTER TABLE `abaship_imageitem` ENABLE KEYS */;
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
INSERT INTO `abaship_ordership` VALUES ('2021-08-19 15:50:01.830973','2021-08-19 15:50:01.830973',1,1,NULL,'NOTYETSHIPPED'),('2021-08-19 15:53:30.719270','2021-08-19 15:53:30.719270',2,1,NULL,'NOTYETSHIPPED');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_post`
--

LOCK TABLES `abaship_post` WRITE;
/*!40000 ALTER TABLE `abaship_post` DISABLE KEYS */;
INSERT INTO `abaship_post` VALUES (2,'2021-08-19 14:57:12.477916','2021-08-24 12:46:26.161365',0,'<p>2 c&aacute;i laptop chưa mở hộp</p>',5,2,2,1),(3,'2021-08-23 13:04:02.624827','2021-08-23 13:04:02.624827',1,'2 túi hồ sơ xin việc.',1,2,2,1),(4,'2021-08-23 13:04:52.814896','2021-08-23 13:04:52.814896',1,'2 thỏi son đã đóng gói.',1,2,2,1),(5,'2021-08-23 13:05:17.520505','2021-08-23 13:05:17.520505',1,'chuyển nhà',33,2,2,1);
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
INSERT INTO `abaship_post_category_product_ship` VALUES (2,2,1),(3,3,5),(4,4,4),(5,5,8);
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_stock`
--

LOCK TABLES `abaship_stock` WRITE;
/*!40000 ALTER TABLE `abaship_stock` DISABLE KEYS */;
INSERT INTO `abaship_stock` VALUES (1,'371 NK','nguyễn Chí Tiến','1111111111'),(2,'372 Nk','Trần Hành','2222222222');
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
  `avatar` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abaship_user`
--

LOCK TABLES `abaship_user` WRITE;
/*!40000 ALTER TABLE `abaship_user` DISABLE KEYS */;
INSERT INTO `abaship_user` VALUES (1,'pbkdf2_sha256$260000$qyzANjmmIkSE8uwDWUZvZB$nAmAmSw6IQjVMU1h4RziiVAiBDZom3CSewlzqwF3MMg=','2021-08-24 03:40:22.992195',1,'admin','nguyentrong.it@gmail.com',1,1,'2021-08-19 08:42:52.326422','','','',''),(2,'123456',NULL,0,'customera','1851050159trong@ou.edu.vn',0,1,'2021-08-19 08:57:27.000000','avatar/2021/08/download_1_7Gh9j9E.jpg','0943940261','A','Nguyễn Văn'),(3,'123456',NULL,0,'customerb','tronghk9no@gmail.com',0,1,'2021-08-19 08:59:12.000000','avatar/2021/08/download_2_Kwq4ysw.jpg','0328934415','B','Trần'),(4,'123456',NULL,0,'shipperc','ndt050800@gmail.com',0,1,'2021-08-19 09:00:23.000000','avatar/2021/08/download_3_Qc16cHB.jpg','0382753581','C','Nguyễn Văn'),(5,'123456',NULL,0,'shipperd','Phuc@gmail.com',0,1,'2021-08-19 09:01:47.000000','avatar/2021/08/images_gGFEXEV.jpg','0123456789','D','Trần');
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
INSERT INTO `auth_group` VALUES (1,'customer'),(2,'Shipper');
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
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add auction',7,'add_auction'),(26,'Can change auction',7,'change_auction'),(27,'Can delete auction',7,'delete_auction'),(28,'Can view auction',7,'view_auction'),(29,'Can add category product ship',8,'add_categoryproductship'),(30,'Can change category product ship',8,'change_categoryproductship'),(31,'Can delete category product ship',8,'delete_categoryproductship'),(32,'Can view category product ship',8,'view_categoryproductship'),(33,'Can add deduct',9,'add_deduct'),(34,'Can change deduct',9,'change_deduct'),(35,'Can delete deduct',9,'delete_deduct'),(36,'Can view deduct',9,'view_deduct'),(37,'Can add stock',10,'add_stock'),(38,'Can change stock',10,'change_stock'),(39,'Can delete stock',10,'delete_stock'),(40,'Can view stock',10,'view_stock'),(41,'Can add voucher',11,'add_voucher'),(42,'Can change voucher',11,'change_voucher'),(43,'Can delete voucher',11,'delete_voucher'),(44,'Can view voucher',11,'view_voucher'),(45,'Can add id card',12,'add_idcard'),(46,'Can change id card',12,'change_idcard'),(47,'Can delete id card',12,'delete_idcard'),(48,'Can view id card',12,'view_idcard'),(49,'Can add order ship',13,'add_ordership'),(50,'Can change order ship',13,'change_ordership'),(51,'Can delete order ship',13,'delete_ordership'),(52,'Can view order ship',13,'view_ordership'),(53,'Can add post',14,'add_post'),(54,'Can change post',14,'change_post'),(55,'Can delete post',14,'delete_post'),(56,'Can view post',14,'view_post'),(57,'Can add image item',15,'add_imageitem'),(58,'Can change image item',15,'change_imageitem'),(59,'Can delete image item',15,'delete_imageitem'),(60,'Can view image item',15,'view_imageitem'),(61,'Can add comment shipper',16,'add_commentshipper'),(62,'Can change comment shipper',16,'change_commentshipper'),(63,'Can delete comment shipper',16,'delete_commentshipper'),(64,'Can view comment shipper',16,'view_commentshipper'),(65,'Can add debt shipper',17,'add_debtshipper'),(66,'Can change debt shipper',17,'change_debtshipper'),(67,'Can delete debt shipper',17,'delete_debtshipper'),(68,'Can view debt shipper',17,'view_debtshipper'),(69,'Can add debt app',18,'add_debtapp'),(70,'Can change debt app',18,'change_debtapp'),(71,'Can delete debt app',18,'delete_debtapp'),(72,'Can view debt app',18,'view_debtapp'),(73,'Can add order ship detail',19,'add_ordershipdetail'),(74,'Can change order ship detail',19,'change_ordershipdetail'),(75,'Can delete order ship detail',19,'delete_ordershipdetail'),(76,'Can view order ship detail',19,'view_ordershipdetail');
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2021-08-19 08:46:09.474784','1','customer',1,'[{\"added\": {}}]',3,1),(2,'2021-08-19 08:46:19.385910','2','Shipper',1,'[{\"added\": {}}]',3,1),(3,'2021-08-19 08:55:00.601856','2','Shipper',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(4,'2021-08-19 08:55:11.174719','2','Shipper',2,'[]',3,1),(5,'2021-08-19 08:57:20.735065','1','customer',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(6,'2021-08-19 08:59:12.466705','2','name: customera',1,'[{\"added\": {}}, {\"added\": {\"name\": \"id card\", \"object\": \"Id card: 123456789055\"}}]',6,1),(7,'2021-08-19 09:00:22.918841','3','name: customerb',1,'[{\"added\": {}}, {\"added\": {\"name\": \"id card\", \"object\": \"Id card: 234567890123\"}}]',6,1),(8,'2021-08-19 09:01:46.841555','4','name: shipperc',1,'[{\"added\": {}}, {\"added\": {\"name\": \"id card\", \"object\": \"Id card: 456789012345\"}}]',6,1),(9,'2021-08-19 09:03:11.494019','5','name: shipperd',1,'[{\"added\": {}}, {\"added\": {\"name\": \"id card\", \"object\": \"Id card: 333333333333\"}}]',6,1),(10,'2021-08-19 14:15:56.312865','1','Category: Hàng điện tử.,\nDescription: Thiết bị điện tử',1,'[{\"added\": {}}]',8,1),(11,'2021-08-19 14:16:17.052035','2','Category: Hàng gia dụng,\nDescription: Đồ dùng gia đình',1,'[{\"added\": {}}]',8,1),(12,'2021-08-19 14:16:52.836860','3','Category: Thiết bị y tế,\nDescription: các loại trang thiết bị y tế',1,'[{\"added\": {}}]',8,1),(13,'2021-08-19 14:17:08.588948','4','Category: Hàng mỹ phẩm,\nDescription: Mỹ phẩm',1,'[{\"added\": {}}]',8,1),(14,'2021-08-19 14:17:31.696058','5','Category: Hồ sơ, tài liệu,\nDescription: các loại hồ sơ giấy tờ',1,'[{\"added\": {}}]',8,1),(15,'2021-08-19 14:18:00.580802','6','Category: Kho hàng,\nDescription: kho hàng',1,'[{\"added\": {}}]',8,1),(16,'2021-08-19 14:18:23.275882','7','Category: cửa hàng,\nDescription: Chuyển dời cửa hàng',1,'[{\"added\": {}}]',8,1),(17,'2021-08-19 14:18:42.490903','8','Category: Chuyển nhà,\nDescription: Chuyển nhà trọn gói',1,'[{\"added\": {}}]',8,1),(18,'2021-08-19 14:18:59.984126','9','Category: Chuyển văn phòng,\nDescription: trọn gói',1,'[{\"added\": {}}]',8,1),(19,'2021-08-19 14:20:10.338735','1','Address: 371 NK,\n Represent man: nguyễn Chí Tiến,\nPhone: 1111111111',1,'[{\"added\": {}}]',10,1),(20,'2021-08-19 14:20:29.997491','2','Address: 372 Nk,\n Represent man: Trần Hành,\nPhone: 2222222222',1,'[{\"added\": {}}]',10,1),(21,'2021-08-19 14:57:12.492854','2','Customer: A Nguyễn Văn,\nCategory product: abaShip.CategoryProductShip.None,\nCreated date: 2021-08-19 14:57:12.477916+00:00',1,'[{\"added\": {}}, {\"added\": {\"name\": \"image item\", \"object\": \"post: 5.0\"}}]',14,1),(22,'2021-08-19 15:50:01.835975','1','shipper: C,\nprice: 12000',1,'[{\"added\": {}}, {\"added\": {\"name\": \"order ship\", \"object\": \"customer: customera Nguy\\u1ec5n V\\u0103n,\\nshipper: C Nguy\\u1ec5n V\\u0103n,\\nstatus: NOTYETSHIPPED,\\ncreated date: 2021-08-19 15:50:01.830973+00:00\"}}]',7,1),(23,'2021-08-19 15:53:01.732267','1','shipper: C,\nprice: 12000.00',2,'[]',7,1),(24,'2021-08-19 15:53:30.723269','2','shipper: D,\nprice: 120000',1,'[{\"added\": {}}, {\"added\": {\"name\": \"order ship\", \"object\": \"customer: customera Nguy\\u1ec5n V\\u0103n,\\nshipper: D Tr\\u1ea7n,\\nstatus: NOTYETSHIPPED,\\ncreated date: 2021-08-19 15:53:30.719270+00:00\"}}]',7,1),(25,'2021-08-24 12:45:47.324566','2','Customer: A Nguyễn Văn,\nCategory product: abaShip.CategoryProductShip.None,\nCreated date: 2021-08-19 14:57:12.477916+00:00',2,'[{\"changed\": {\"fields\": [\"Active\"]}}]',14,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (7,'abaShip','auction'),(8,'abaShip','categoryproductship'),(16,'abaShip','commentshipper'),(18,'abaShip','debtapp'),(17,'abaShip','debtshipper'),(9,'abaShip','deduct'),(12,'abaShip','idcard'),(15,'abaShip','imageitem'),(13,'abaShip','ordership'),(19,'abaShip','ordershipdetail'),(14,'abaShip','post'),(10,'abaShip','stock'),(6,'abaShip','user'),(11,'abaShip','voucher'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(5,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2021-08-19 08:36:27.122890'),(2,'contenttypes','0002_remove_content_type_name','2021-08-19 08:36:27.315778'),(3,'auth','0001_initial','2021-08-19 08:36:27.811976'),(4,'auth','0002_alter_permission_name_max_length','2021-08-19 08:36:27.956804'),(5,'auth','0003_alter_user_email_max_length','2021-08-19 08:36:27.968617'),(6,'auth','0004_alter_user_username_opts','2021-08-19 08:36:27.979924'),(7,'auth','0005_alter_user_last_login_null','2021-08-19 08:36:27.991015'),(8,'auth','0006_require_contenttypes_0002','2021-08-19 08:36:27.996089'),(9,'auth','0007_alter_validators_add_error_messages','2021-08-19 08:36:28.006786'),(10,'auth','0008_alter_user_username_max_length','2021-08-19 08:36:28.018335'),(11,'auth','0009_alter_user_last_name_max_length','2021-08-19 08:36:28.030619'),(12,'auth','0010_alter_group_name_max_length','2021-08-19 08:36:28.055145'),(13,'auth','0011_update_proxy_permissions','2021-08-19 08:36:28.066969'),(14,'auth','0012_alter_user_first_name_max_length','2021-08-19 08:36:28.079978'),(15,'abaShip','0001_initial','2021-08-19 08:36:31.485844'),(16,'admin','0001_initial','2021-08-19 08:36:31.820576'),(17,'admin','0002_logentry_remove_auto_add','2021-08-19 08:36:31.847786'),(18,'admin','0003_logentry_add_action_flag_choices','2021-08-19 08:36:31.871792'),(19,'sessions','0001_initial','2021-08-19 08:36:31.927687'),(20,'abaShip','0002_auto_20210819_2136','2021-08-19 14:37:05.370184'),(21,'abaShip','0003_alter_ordership_status','2021-08-19 15:31:06.933243'),(22,'abaShip','0004_auto_20210819_2246','2021-08-19 15:47:00.508509');
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
INSERT INTO `django_session` VALUES ('ssukcapllsptndjr9xjyignphvq6e3ym','.eJxVjEEOwiAURO_C2hA_yCe6dO8ZyPABqRqalHZlvLtt0oVu5703bxWwzDUsPU9hSOqiSB1-twh55raB9EC7j1rGNk9D1Juid9r1bUz5dd3dv4OKXtfaMtiSIxRyxVMSomKEDRXHFnzGCrxIsZ7YsXHwAAuOJ0tsIjn1-QLRejdO:1mINIU:hp_b52kzWZvG0R6nxaJ0xXEgac9P7RuJ1P8ItvWk3kA','2021-09-07 03:40:22.998605');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'abashipdb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-24 21:03:47
