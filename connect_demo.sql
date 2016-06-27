-- MySQL dump 10.13  Distrib 5.5.49, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: connect_demo
-- ------------------------------------------------------
-- Server version	5.5.49-0ubuntu0.14.04.1

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
-- Table structure for table `actstream_action`
--

DROP TABLE IF EXISTS `actstream_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actstream_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `actor_content_type_id` int(11) NOT NULL,
  `actor_object_id` varchar(255) NOT NULL,
  `verb` varchar(255) NOT NULL,
  `description` longtext,
  `target_content_type_id` int(11) DEFAULT NULL,
  `target_object_id` varchar(255) DEFAULT NULL,
  `action_object_content_type_id` int(11) DEFAULT NULL,
  `action_object_object_id` varchar(255) DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  `public` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `actstream_action_3df58830` (`actor_content_type_id`),
  KEY `actstream_action_276d0c93` (`target_content_type_id`),
  KEY `actstream_action_f6b51263` (`action_object_content_type_id`),
  CONSTRAINT `action_object_content_type_id_refs_id_357b994e` FOREIGN KEY (`action_object_content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `actor_content_type_id_refs_id_357b994e` FOREIGN KEY (`actor_content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `target_content_type_id_refs_id_357b994e` FOREIGN KEY (`target_content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actstream_action`
--

LOCK TABLES `actstream_action` WRITE;
/*!40000 ALTER TABLE `actstream_action` DISABLE KEYS */;
/*!40000 ALTER TABLE `actstream_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actstream_follow`
--

DROP TABLE IF EXISTS `actstream_follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actstream_follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `object_id` varchar(255) NOT NULL,
  `actor_only` tinyint(1) NOT NULL,
  `started` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`content_type_id`,`object_id`),
  KEY `actstream_follow_6340c63c` (`user_id`),
  KEY `actstream_follow_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_5cf623fd` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_40a75718` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actstream_follow`
--

LOCK TABLES `actstream_follow` WRITE;
/*!40000 ALTER TABLE `actstream_follow` DISABLE KEYS */;
INSERT INTO `actstream_follow` VALUES (1,1,3,'2',0,'2016-06-21 17:39:13');
/*!40000 ALTER TABLE `actstream_follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agent_agent`
--

DROP TABLE IF EXISTS `agent_agent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agent_agent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `agent_type_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `prime_cell_id` int(11) DEFAULT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `agent_agent_6340c63c` (`user_id`),
  KEY `agent_agent_3a3bb5b0` (`agent_type_id`),
  KEY `agent_agent_410d0aac` (`parent_id`),
  KEY `agent_agent_1383fa7a` (`prime_cell_id`),
  KEY `agent_agent_74d4252d` (`shop_id`),
  CONSTRAINT `agent_type_id_refs_id_888aef33` FOREIGN KEY (`agent_type_id`) REFERENCES `master_agent_type` (`id`),
  CONSTRAINT `parent_id_refs_id_a30e56a1` FOREIGN KEY (`parent_id`) REFERENCES `agent_agent` (`id`),
  CONSTRAINT `prime_cell_id_refs_id_c680f950` FOREIGN KEY (`prime_cell_id`) REFERENCES `user_cellnumber_detail` (`id`),
  CONSTRAINT `shop_id_refs_id_6d9a9ee7` FOREIGN KEY (`shop_id`) REFERENCES `user_shop_detail` (`id`),
  CONSTRAINT `user_id_refs_id_69948e7a` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agent_agent`
--

LOCK TABLES `agent_agent` WRITE;
/*!40000 ALTER TABLE `agent_agent` DISABLE KEYS */;
INSERT INTO `agent_agent` VALUES (1,1,1,1,NULL,NULL,1),(2,2,4,1,NULL,NULL,1);
/*!40000 ALTER TABLE `agent_agent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agent_bcdetail`
--

DROP TABLE IF EXISTS `agent_bcdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agent_bcdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bcName` varchar(100) NOT NULL,
  `bcId` int(11) NOT NULL,
  `bank_id` int(11) NOT NULL,
  `agent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `agent_bcdetail_df49f419` (`bank_id`),
  KEY `agent_bcdetail_44625c0c` (`agent_id`),
  CONSTRAINT `agent_id_refs_id_61a5abd3` FOREIGN KEY (`agent_id`) REFERENCES `agent_agent` (`id`),
  CONSTRAINT `bank_id_refs_id_835ed04d` FOREIGN KEY (`bank_id`) REFERENCES `master_bank` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agent_bcdetail`
--

LOCK TABLES `agent_bcdetail` WRITE;
/*!40000 ALTER TABLE `agent_bcdetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `agent_bcdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agent_official_detail`
--

DROP TABLE IF EXISTS `agent_official_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agent_official_detail` (
  `agent_id` int(11) NOT NULL,
  `bank_id` int(11) DEFAULT NULL,
  `cspcode` varchar(20) DEFAULT NULL,
  `cyberplat_term_id` varchar(100) DEFAULT NULL,
  `is_tatkal_allowed` tinyint(1) NOT NULL,
  `is_blacklisted` tinyint(1) NOT NULL,
  PRIMARY KEY (`agent_id`),
  KEY `agent_official_detail_df49f419` (`bank_id`),
  CONSTRAINT `agent_id_refs_id_254e6f0d` FOREIGN KEY (`agent_id`) REFERENCES `agent_agent` (`id`),
  CONSTRAINT `bank_id_refs_id_5c1e21ba` FOREIGN KEY (`bank_id`) REFERENCES `master_bank` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agent_official_detail`
--

LOCK TABLES `agent_official_detail` WRITE;
/*!40000 ALTER TABLE `agent_official_detail` DISABLE KEYS */;
INSERT INTO `agent_official_detail` VALUES (2,2,'99023131','',0,0);
/*!40000 ALTER TABLE `agent_official_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agent_transaction_cellnumber`
--

DROP TABLE IF EXISTS `agent_transaction_cellnumber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agent_transaction_cellnumber` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agent_id` int(11) NOT NULL,
  `cell_number_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `agent_transaction_cellnumber_44625c0c` (`agent_id`),
  KEY `agent_transaction_cellnumber_b1ca33bf` (`cell_number_id`),
  CONSTRAINT `agent_id_refs_id_50cf1519` FOREIGN KEY (`agent_id`) REFERENCES `agent_agent` (`id`),
  CONSTRAINT `cell_number_id_refs_id_e969f084` FOREIGN KEY (`cell_number_id`) REFERENCES `user_cellnumber_detail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agent_transaction_cellnumber`
--

LOCK TABLES `agent_transaction_cellnumber` WRITE;
/*!40000 ALTER TABLE `agent_transaction_cellnumber` DISABLE KEYS */;
INSERT INTO `agent_transaction_cellnumber` VALUES (1,2,1,1);
/*!40000 ALTER TABLE `agent_transaction_cellnumber` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `group_id_refs_id_f4b32aac` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_6ba0f519` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add site',6,'add_site'),(17,'Can change site',6,'change_site'),(18,'Can delete site',6,'delete_site'),(19,'Can add log entry',7,'add_logentry'),(20,'Can change log entry',7,'change_logentry'),(21,'Can delete log entry',7,'delete_logentry'),(22,'Can add location_ type',8,'add_location_type'),(23,'Can change location_ type',8,'change_location_type'),(24,'Can delete location_ type',8,'delete_location_type'),(25,'Can add location',9,'add_location'),(26,'Can change location',9,'change_location'),(27,'Can delete location',9,'delete_location'),(28,'Can add tracking_ type',10,'add_tracking_type'),(29,'Can change tracking_ type',10,'change_tracking_type'),(30,'Can delete tracking_ type',10,'delete_tracking_type'),(31,'Can add tracking',11,'add_tracking'),(32,'Can change tracking',11,'change_tracking'),(33,'Can delete tracking',11,'delete_tracking'),(34,'Can add activity_ type',12,'add_activity_type'),(35,'Can change activity_ type',12,'change_activity_type'),(36,'Can delete activity_ type',12,'delete_activity_type'),(37,'Can add activity',13,'add_activity'),(38,'Can change activity',13,'change_activity'),(39,'Can delete activity',13,'delete_activity'),(40,'Can add personal_ detail',14,'add_personal_detail'),(41,'Can change personal_ detail',14,'change_personal_detail'),(42,'Can delete personal_ detail',14,'delete_personal_detail'),(43,'Can add shop_ detail',15,'add_shop_detail'),(44,'Can change shop_ detail',15,'change_shop_detail'),(45,'Can delete shop_ detail',15,'delete_shop_detail'),(46,'Can add shop_ timing',16,'add_shop_timing'),(47,'Can change shop_ timing',16,'change_shop_timing'),(48,'Can delete shop_ timing',16,'delete_shop_timing'),(49,'Can add cellnumber_ detail',17,'add_cellnumber_detail'),(50,'Can change cellnumber_ detail',17,'change_cellnumber_detail'),(51,'Can delete cellnumber_ detail',17,'delete_cellnumber_detail'),(52,'Can add sms_ log',18,'add_sms_log'),(53,'Can change sms_ log',18,'change_sms_log'),(54,'Can delete sms_ log',18,'delete_sms_log'),(55,'Can add type',19,'add_type'),(56,'Can change type',19,'change_type'),(57,'Can delete type',19,'delete_type'),(58,'Can add sysuser',20,'add_sysuser'),(59,'Can change sysuser',20,'change_sysuser'),(60,'Can delete sysuser',20,'delete_sysuser'),(61,'Can add login_ data',21,'add_login_data'),(62,'Can change login_ data',21,'change_login_data'),(63,'Can delete login_ data',21,'delete_login_data'),(64,'Can add agent',22,'add_agent'),(65,'Can change agent',22,'change_agent'),(66,'Can delete agent',22,'delete_agent'),(67,'Can add official_ detail',23,'add_official_detail'),(68,'Can change official_ detail',23,'change_official_detail'),(69,'Can delete official_ detail',23,'delete_official_detail'),(70,'Can add bc detail',24,'add_bcdetail'),(71,'Can change bc detail',24,'change_bcdetail'),(72,'Can delete bc detail',24,'delete_bcdetail'),(73,'Can add transaction_ cellnumber',25,'add_transaction_cellnumber'),(74,'Can change transaction_ cellnumber',25,'change_transaction_cellnumber'),(75,'Can delete transaction_ cellnumber',25,'delete_transaction_cellnumber'),(76,'Can add migration history',26,'add_migrationhistory'),(77,'Can change migration history',26,'change_migrationhistory'),(78,'Can delete migration history',26,'delete_migrationhistory'),(79,'Can add bank',27,'add_bank'),(80,'Can change bank',27,'change_bank'),(81,'Can delete bank',27,'delete_bank'),(82,'Can add address_ type',28,'add_address_type'),(83,'Can change address_ type',28,'change_address_type'),(84,'Can delete address_ type',28,'delete_address_type'),(85,'Can add competition',29,'add_competition'),(86,'Can change competition',29,'change_competition'),(87,'Can delete competition',29,'delete_competition'),(88,'Can add country',30,'add_country'),(89,'Can change country',30,'change_country'),(90,'Can delete country',30,'delete_country'),(91,'Can add state',31,'add_state'),(92,'Can change state',31,'change_state'),(93,'Can delete state',31,'delete_state'),(94,'Can add district',32,'add_district'),(95,'Can change district',32,'change_district'),(96,'Can delete district',32,'delete_district'),(97,'Can add city',33,'add_city'),(98,'Can change city',33,'change_city'),(99,'Can delete city',33,'delete_city'),(100,'Can add pincode',34,'add_pincode'),(101,'Can change pincode',34,'change_pincode'),(102,'Can delete pincode',34,'delete_pincode'),(103,'Can add agent_ type',35,'add_agent_type'),(104,'Can change agent_ type',35,'change_agent_type'),(105,'Can delete agent_ type',35,'delete_agent_type'),(106,'Can add address',36,'add_address'),(107,'Can change address',36,'change_address'),(108,'Can delete address',36,'delete_address'),(109,'Can add branch',37,'add_branch'),(110,'Can change branch',37,'change_branch'),(111,'Can delete branch',37,'delete_branch'),(112,'Can add cellnumber_ type',38,'add_cellnumber_type'),(113,'Can change cellnumber_ type',38,'change_cellnumber_type'),(114,'Can delete cellnumber_ type',38,'delete_cellnumber_type'),(115,'Can add posm',39,'add_posm'),(116,'Can change posm',39,'change_posm'),(117,'Can delete posm',39,'delete_posm'),(118,'Can add transaction_ type',40,'add_transaction_type'),(119,'Can change transaction_ type',40,'change_transaction_type'),(120,'Can delete transaction_ type',40,'delete_transaction_type'),(121,'Can add circle',41,'add_circle'),(122,'Can change circle',41,'change_circle'),(123,'Can delete circle',41,'delete_circle'),(124,'Can add payment_ frequency',42,'add_payment_frequency'),(125,'Can change payment_ frequency',42,'change_payment_frequency'),(126,'Can delete payment_ frequency',42,'delete_payment_frequency'),(127,'Can add csp_ type',43,'add_csp_type'),(128,'Can change csp_ type',43,'change_csp_type'),(129,'Can delete csp_ type',43,'delete_csp_type'),(130,'Can add rounding_ mode',44,'add_rounding_mode'),(131,'Can change rounding_ mode',44,'change_rounding_mode'),(132,'Can delete rounding_ mode',44,'delete_rounding_mode'),(133,'Can add bank_ transaction_ mapping',45,'add_bank_transaction_mapping'),(134,'Can change bank_ transaction_ mapping',45,'change_bank_transaction_mapping'),(135,'Can delete bank_ transaction_ mapping',45,'delete_bank_transaction_mapping'),(136,'Can add department',46,'add_department'),(137,'Can change department',46,'change_department'),(138,'Can delete department',46,'delete_department'),(139,'Can add designation',47,'add_designation'),(140,'Can change designation',47,'change_designation'),(141,'Can delete designation',47,'delete_designation'),(142,'Can add bank_ detail',48,'add_bank_detail'),(143,'Can change bank_ detail',48,'change_bank_detail'),(144,'Can delete bank_ detail',48,'delete_bank_detail'),(145,'Can add bank_ ifsc',49,'add_bank_ifsc'),(146,'Can change bank_ ifsc',49,'change_bank_ifsc'),(147,'Can delete bank_ ifsc',49,'delete_bank_ifsc'),(148,'Can add user_ type',50,'add_user_type'),(149,'Can change user_ type',50,'change_user_type'),(150,'Can delete user_ type',50,'delete_user_type'),(151,'Can add log',51,'add_log'),(152,'Can change log',51,'change_log'),(153,'Can delete log',51,'delete_log'),(154,'Can add param',52,'add_param'),(155,'Can change param',52,'change_param'),(156,'Can delete param',52,'delete_param'),(157,'Can add requesttext_ syntax',53,'add_requesttext_syntax'),(158,'Can change requesttext_ syntax',53,'change_requesttext_syntax'),(159,'Can delete requesttext_ syntax',53,'delete_requesttext_syntax'),(160,'Can add bank_ mapping',54,'add_bank_mapping'),(161,'Can change bank_ mapping',54,'change_bank_mapping'),(162,'Can delete bank_ mapping',54,'delete_bank_mapping'),(163,'Can add additional_ detail',55,'add_additional_detail'),(164,'Can change additional_ detail',55,'change_additional_detail'),(165,'Can delete additional_ detail',55,'delete_additional_detail'),(166,'Can add request_ log',56,'add_request_log'),(167,'Can change request_ log',56,'change_request_log'),(168,'Can delete request_ log',56,'delete_request_log'),(169,'Can add response_ log',57,'add_response_log'),(170,'Can change response_ log',57,'change_response_log'),(171,'Can delete response_ log',57,'delete_response_log'),(172,'Can add access attempt',58,'add_accessattempt'),(173,'Can change access attempt',58,'change_accessattempt'),(174,'Can delete access attempt',58,'delete_accessattempt'),(175,'Can add access log',59,'add_accesslog'),(176,'Can change access log',59,'change_accesslog'),(177,'Can delete access log',59,'delete_accesslog'),(178,'Can add follow',60,'add_follow'),(179,'Can change follow',60,'change_follow'),(180,'Can delete follow',60,'delete_follow'),(181,'Can add action',61,'add_action'),(182,'Can change action',61,'change_action'),(183,'Can delete action',61,'delete_action');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$10000$OkAAru5WgvLS$0lyxY+YPs3lypurMEyc1PI1LuzGwxFGeXK5tKcvptWw=','2016-06-21 22:29:06',1,'kunal','','','',1,1,'2016-06-21 17:20:44'),(2,'pbkdf2_sha256$10000$4llYTZ7msdgH$AF/olscLMKWhOnfjRiqPlMQcnMof2gGxwzsk0Olt2HA=','2016-06-21 22:29:39',0,'6726152721','Siddharth','Jandial','',0,1,'2016-06-21 17:38:45');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`),
  CONSTRAINT `group_id_refs_id_274b862c` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_40c41112` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_35d9ac25` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_4dc23c39` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `axes_accessattempt`
--

DROP TABLE IF EXISTS `axes_accessattempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `axes_accessattempt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_agent` varchar(255) NOT NULL,
  `ip_address` char(39) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `trusted` tinyint(1) NOT NULL,
  `http_accept` varchar(1025) NOT NULL,
  `path_info` varchar(255) NOT NULL,
  `attempt_time` datetime NOT NULL,
  `get_data` longtext NOT NULL,
  `post_data` longtext NOT NULL,
  `failures_since_start` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `axes_accessattempt`
--

LOCK TABLES `axes_accessattempt` WRITE;
/*!40000 ALTER TABLE `axes_accessattempt` DISABLE KEYS */;
INSERT INTO `axes_accessattempt` VALUES (1,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36','127.0.0.1','kunal',1,'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8','/admin/','2016-06-21 19:26:36','\n---------\n','username=kunal\ncsrfmiddlewaretoken=6uoohs6RP2jDSMnTfxQ05GgrQ4UFNMEO\nthis_is_the_login_form=1\nnext=/admin/\n---------\nusername=kunal\ncsrfmiddlewaretoken=6uoohs6RP2jDSMnTfxQ05GgrQ4UFNMEO\nthis_is_the_login_form=1\nnext=/admin/',0);
/*!40000 ALTER TABLE `axes_accessattempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `axes_accesslog`
--

DROP TABLE IF EXISTS `axes_accesslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `axes_accesslog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_agent` varchar(255) NOT NULL,
  `ip_address` char(39) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `trusted` tinyint(1) NOT NULL,
  `http_accept` varchar(1025) NOT NULL,
  `path_info` varchar(255) NOT NULL,
  `attempt_time` datetime NOT NULL,
  `logout_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `axes_accesslog`
--

LOCK TABLES `axes_accesslog` WRITE;
/*!40000 ALTER TABLE `axes_accesslog` DISABLE KEYS */;
INSERT INTO `axes_accesslog` VALUES (1,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36','127.0.0.1','kunal',1,'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8','/admin/','2016-06-21 17:37:35','2016-06-21 17:55:48'),(2,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36','127.0.0.1','kunal',1,'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8','/admin/','2016-06-21 17:56:54','2016-06-21 17:58:12'),(3,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36','127.0.0.1','kunal',1,'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8','/admin/','2016-06-21 17:59:03','2016-06-21 18:00:17'),(4,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36','127.0.0.1','kunal',1,'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8','/admin/','2016-06-21 18:25:59',NULL),(5,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36','127.0.0.1','kunal',1,'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8','/admin/','2016-06-21 19:07:44','2016-06-21 19:09:10'),(6,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36','127.0.0.1','kunal',1,'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8','/admin/master/bank_detail/','2016-06-21 19:14:36','2016-06-21 19:18:44'),(7,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36','127.0.0.1','kunal',1,'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8','/admin/','2016-06-21 19:19:31','2016-06-21 19:25:51'),(8,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36','127.0.0.1','kunal',0,'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8','/admin/','2016-06-21 19:26:36',NULL),(9,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36','127.0.0.1','kunal',1,'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8','/admin/','2016-06-21 19:26:40','2016-06-21 19:27:59'),(10,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36','127.0.0.1','kunal',1,'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8','/admin/','2016-06-21 20:02:03','2016-06-21 20:03:11'),(11,'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:38.0) Gecko/20100101 Firefox/38.0','127.0.0.1','kunal',1,'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8','/admin/','2016-06-21 22:22:06','2016-06-21 22:22:44'),(12,'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:38.0) Gecko/20100101 Firefox/38.0','127.0.0.1','kunal',1,'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8','/admin/','2016-06-21 22:23:15','2016-06-21 22:23:28'),(13,'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:38.0) Gecko/20100101 Firefox/38.0','127.0.0.1','kunal',1,'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8','/admin/','2016-06-21 22:24:41','2016-06-21 22:28:10'),(14,'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:38.0) Gecko/20100101 Firefox/38.0','127.0.0.1','kunal',1,'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8','/admin/','2016-06-21 22:29:06','2016-06-21 22:29:19');
/*!40000 ALTER TABLE `axes_accesslog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_93d2d1f8` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c0d12874` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2016-06-21 17:38:45',1,3,'2','sample_user',1,''),(2,'2016-06-21 17:39:13',1,22,'2','2 : Retailer : sample_user',1,''),(3,'2016-06-21 17:40:01',1,38,'1','Primary',1,''),(4,'2016-06-21 17:40:12',1,38,'2','Alternate',1,''),(5,'2016-06-21 17:41:49',1,17,'1','6726152721 : sample_user',1,''),(6,'2016-06-21 17:43:50',1,40,'1','Transaction Enquiry',1,''),(7,'2016-06-21 17:44:38',1,40,'2','Sender Inquiry',1,''),(8,'2016-06-21 17:45:08',1,40,'3','Sender Enrolment Verification',1,''),(9,'2016-06-21 17:45:37',1,40,'4','Sender Enrolment Resend OTP',1,''),(10,'2016-06-21 17:46:03',1,40,'5','Bank Config Inquiry',1,''),(11,'2016-06-21 17:46:22',1,40,'6','Booklet Inquiry',1,''),(12,'2016-06-21 17:46:41',1,40,'7','Booklet Registration',1,''),(13,'2016-06-21 17:47:11',1,40,'8','Transaction SOS Inquiry',1,''),(14,'2016-06-21 17:47:32',1,40,'9','User Info Lookup',1,''),(15,'2016-06-21 17:47:53',1,40,'10','Account Number Lookup',1,''),(16,'2016-06-21 17:48:12',1,40,'11','Recipient Individual Inquiry',1,''),(17,'2016-06-21 17:48:36',1,40,'12','Balance Inquiry',1,''),(18,'2016-06-21 17:48:47',1,40,'13','Money Transfer',1,''),(19,'2016-06-21 17:49:01',1,40,'14','Recipient Inquiry',1,''),(20,'2016-06-21 17:49:21',1,40,'15','Recipient Registration',1,''),(21,'2016-06-21 17:49:49',1,40,'16','Sender Enrolment',1,''),(22,'2016-06-21 17:50:13',1,54,'1','Bank_Mapping object',1,''),(23,'2016-06-21 17:50:27',1,54,'1','Bank_Mapping object',2,'Changed agent_sms_flag.'),(24,'2016-06-21 17:50:41',1,54,'2','Bank_Mapping object',1,''),(25,'2016-06-21 17:50:54',1,54,'3','Bank_Mapping object',1,''),(26,'2016-06-21 17:51:08',1,54,'4','Bank_Mapping object',1,''),(27,'2016-06-21 17:51:22',1,54,'5','Bank_Mapping object',1,''),(28,'2016-06-21 17:51:45',1,54,'6','Bank_Mapping object',1,''),(29,'2016-06-21 17:51:57',1,54,'7','Bank_Mapping object',1,''),(30,'2016-06-21 17:52:21',1,54,'8','Bank_Mapping object',1,''),(31,'2016-06-21 17:52:31',1,54,'9','Bank_Mapping object',1,''),(32,'2016-06-21 17:52:38',1,54,'10','Bank_Mapping object',1,''),(33,'2016-06-21 17:52:47',1,54,'11','Bank_Mapping object',1,''),(34,'2016-06-21 17:52:57',1,54,'12','Bank_Mapping object',1,''),(35,'2016-06-21 17:53:05',1,54,'13','Bank_Mapping object',1,''),(36,'2016-06-21 17:53:18',1,54,'14','Bank_Mapping object',1,''),(37,'2016-06-21 17:53:26',1,54,'15','Bank_Mapping object',1,''),(38,'2016-06-21 17:53:35',1,54,'16','Bank_Mapping object',1,''),(39,'2016-06-21 17:53:57',1,25,'1','6726152721 : sample_user : 2 : Retailer : sample_user',1,''),(40,'2016-06-21 17:54:33',1,23,'2','2 : ',1,''),(41,'2016-06-21 17:57:27',1,3,'2','6726152721',2,'Changed username and password.'),(42,'2016-06-21 18:00:13',1,3,'2','6726152721',2,'Changed password, first_name and last_name.'),(43,'2016-06-21 18:34:49',1,35,'6','SE',1,''),(44,'2016-06-21 18:34:58',1,35,'7','ICSP',1,''),(45,'2016-06-21 18:45:05',1,38,'2','Alternate1',2,'Changed name.'),(46,'2016-06-21 18:49:37',1,23,'2','2 : 99023131',2,'Changed cspcode.'),(47,'2016-06-21 19:16:05',1,48,'1','Bank_Detail object',1,''),(48,'2016-06-21 19:16:51',1,48,'2','Bank_Detail object',1,''),(49,'2016-06-21 19:27:10',1,48,'3','Bank_Detail object',1,''),(50,'2016-06-21 19:27:43',1,48,'4','Bank_Detail object',1,''),(51,'2016-06-21 22:26:48',1,48,'78','Bank_Detail object',3,''),(52,'2016-06-21 22:27:53',1,48,'41','Bank_Detail object',3,'');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'content type','contenttypes','contenttype'),(5,'session','sessions','session'),(6,'site','sites','site'),(7,'log entry','admin','logentry'),(8,'location_ type','user','location_type'),(9,'location','user','location'),(10,'tracking_ type','user','tracking_type'),(11,'tracking','user','tracking'),(12,'activity_ type','user','activity_type'),(13,'activity','user','activity'),(14,'personal_ detail','user','personal_detail'),(15,'shop_ detail','user','shop_detail'),(16,'shop_ timing','user','shop_timing'),(17,'cellnumber_ detail','user','cellnumber_detail'),(18,'sms_ log','user','sms_log'),(19,'type','user','type'),(20,'sysuser','user','sysuser'),(21,'login_ data','user','login_data'),(22,'agent','agent','agent'),(23,'official_ detail','agent','official_detail'),(24,'bc detail','agent','bcdetail'),(25,'transaction_ cellnumber','agent','transaction_cellnumber'),(26,'migration history','south','migrationhistory'),(27,'bank','master','bank'),(28,'address_ type','master','address_type'),(29,'competition','master','competition'),(30,'country','master','country'),(31,'state','master','state'),(32,'district','master','district'),(33,'city','master','city'),(34,'pincode','master','pincode'),(35,'agent_ type','master','agent_type'),(36,'address','master','address'),(37,'branch','master','branch'),(38,'cellnumber_ type','master','cellnumber_type'),(39,'posm','master','posm'),(40,'transaction_ type','master','transaction_type'),(41,'circle','master','circle'),(42,'payment_ frequency','master','payment_frequency'),(43,'csp_ type','master','csp_type'),(44,'rounding_ mode','master','rounding_mode'),(45,'bank_ transaction_ mapping','master','bank_transaction_mapping'),(46,'department','master','department'),(47,'designation','master','designation'),(48,'bank_ detail','master','bank_detail'),(49,'bank_ ifsc','master','bank_ifsc'),(50,'user_ type','master','user_type'),(51,'log','transaction','log'),(52,'param','transaction','param'),(53,'requesttext_ syntax','transaction','requesttext_syntax'),(54,'bank_ mapping','transaction','bank_mapping'),(55,'additional_ detail','transaction','additional_detail'),(56,'request_ log','transaction','request_log'),(57,'response_ log','transaction','response_log'),(58,'access attempt','axes','accessattempt'),(59,'access log','axes','accesslog'),(60,'follow','actstream','follow'),(61,'action','actstream','action');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('6fxnl8h11xa2biiblzs5yq2ce7z9bdf4','YmZmMmYxZDJjNTg0OTdlYTZkNGI2ZDAyYWIyM2Y5MGIxNTkyZGNkMTqAAn1xAShYCgAAAHRlc3Rjb29raWVxAlgGAAAAd29ya2VkcQNYDwAAAF9zZXNzaW9uX2V4cGlyeXEETVgCdS4=','2016-06-21 19:17:39'),('d1phgoh5z9hgxu9o1i92wo9mumn3plra','ODU5MTRhNTMwNDE4NTYwMjZkZjdkMTJlNWNkZjBjYjI2M2Y0MmMyNzqAAn1xAS4=','2016-07-05 20:03:25'),('djw0vdvq0z4dljhyq6f774c06k2tvtbm','ODU5MTRhNTMwNDE4NTYwMjZkZjdkMTJlNWNkZjBjYjI2M2Y0MmMyNzqAAn1xAS4=','2016-07-05 22:38:39'),('m498x79zjrmqdo4mvbqc4qn74eqtimyy','NzgxZjRjMTNhYTdmZThmMjEwN2MyOWI3NTNmOTI1NDM1ZjhiYjcyNTqAAn1xAShYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAlUNX2F1dGhfdXNlcl9pZIoBAVUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHUu','2016-06-21 19:01:23');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_address`
--

DROP TABLE IF EXISTS `master_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address_type_id` int(11) NOT NULL,
  `line1` varchar(50) NOT NULL,
  `line2` varchar(50) NOT NULL,
  `landmark` varchar(30) NOT NULL,
  `city_id` int(11) NOT NULL,
  `pincode` int(11) DEFAULT NULL,
  `district_id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `latitude` decimal(8,5) DEFAULT NULL,
  `longitude` decimal(8,5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `master_address_4b4cf59f` (`address_type_id`),
  KEY `master_address_b376980e` (`city_id`),
  KEY `master_address_13b5b160` (`district_id`),
  KEY `master_address_5654bf12` (`state_id`),
  KEY `master_address_d860be3c` (`country_id`),
  CONSTRAINT `address_type_id_refs_id_74c2a618` FOREIGN KEY (`address_type_id`) REFERENCES `master_address_type` (`id`),
  CONSTRAINT `city_id_refs_id_720de74e` FOREIGN KEY (`city_id`) REFERENCES `master_city` (`id`),
  CONSTRAINT `country_id_refs_id_05ad1156` FOREIGN KEY (`country_id`) REFERENCES `master_country` (`id`),
  CONSTRAINT `district_id_refs_id_3e40362c` FOREIGN KEY (`district_id`) REFERENCES `master_district` (`id`),
  CONSTRAINT `state_id_refs_id_04ea6041` FOREIGN KEY (`state_id`) REFERENCES `master_state` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_address`
--

LOCK TABLES `master_address` WRITE;
/*!40000 ALTER TABLE `master_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_address_type`
--

DROP TABLE IF EXISTS `master_address_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_address_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `desc` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_address_type`
--

LOCK TABLES `master_address_type` WRITE;
/*!40000 ALTER TABLE `master_address_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_address_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_agent_type`
--

DROP TABLE IF EXISTS `master_agent_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_agent_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `descr` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_agent_type`
--

LOCK TABLES `master_agent_type` WRITE;
/*!40000 ALTER TABLE `master_agent_type` DISABLE KEYS */;
INSERT INTO `master_agent_type` VALUES (1,'Root',''),(2,'BC',''),(3,'Distributor',''),(4,'Retailer',''),(5,'FoS',''),(6,'SE','SE'),(7,'ICSP','ICSP');
/*!40000 ALTER TABLE `master_agent_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_bank`
--

DROP TABLE IF EXISTS `master_bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `descr` varchar(100) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `short_name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_bank`
--

LOCK TABLES `master_bank` WRITE;
/*!40000 ALTER TABLE `master_bank` DISABLE KEYS */;
INSERT INTO `master_bank` VALUES (1,'STATE BANK OF INDIA','',0,''),(2,'ICICI BANK LTD','',0,''),(3,'YES BANK','',0,''),(4,'ABHYUDAYA CO-OP BANK LTD','',0,''),(5,'ABU DHABI COMMERCIAL BANK','',0,''),(6,'ALLAHABAD BANK','',0,''),(7,'ANDHRA BANK','',0,''),(8,'AXIS BANK','',0,''),(9,'BANK OF AMERICA','',0,''),(10,'BANK OF BAHRAIN AND KUWAIT','',0,''),(11,'BANK OF BARODA','',0,''),(12,'BANK OF CEYLON','',0,''),(13,'BANK OF INDIA','',0,''),(14,'BANK OF MAHARASHTRA','',0,''),(15,'BANK OF TOKYO-MITSUBISHI UFJ LTD','',0,''),(16,'BARCLAYS BANK PLC','',0,''),(17,'BASSEIN CATHOLIC CO-OP BANK LTD','',0,''),(18,'BNP PARIBAS','',0,''),(19,'CANARA BANK','',0,''),(20,'CATHOLIC SYRIAN BANK LTD','',0,''),(21,'CENTRAL BANK OF INDIA','',0,''),(22,'CHINATRUST COMMERCIAL BANK','',0,''),(23,'CITIBANK NA','',0,''),(24,'CITIZEN CREDIT CO-OP BANK LTD','',0,''),(25,'CITY UNION BANK LTD','',0,''),(26,'CORPORATION BANK','',0,''),(27,'CREDIT AGRICOLE CORP N INVSMNT BANK','',0,''),(28,'DBS BANK LTD','',0,''),(29,'DENA BANK','',0,''),(30,'DEUTSCHE BANK AG','',0,''),(31,'DEVELOPMENT BANK OF SINGAPORE (DBS)','',0,''),(32,'DEVELOPMENT CREDIT BANK LIMITED','',0,''),(33,'DHANLAXMI BANK LTD','',0,''),(34,'DICGC','',0,''),(35,'DOMBIVLI NAGARI SAHAKARI BANK LIMITED','',0,''),(36,'FIRSTRAND BANK LIMITED','',0,''),(37,'HDFC BANK LTD','',0,''),(38,'HSBC','',0,''),(39,'IDBI BANK LTD','',0,''),(40,'INDIAN BANK','',0,''),(41,'INDIAN OVERSEAS BANK','',0,''),(42,'INDUSIND BANK LIMITED','',0,''),(43,'ING VYSYA BANK','',0,''),(44,'JANAKALYAN SAHAKARI BANK LTD','',0,''),(45,'JANATA SAHAKARI BANK LTD (PUNE)','',0,''),(46,'JPMORGAN CHASE BANK NA','',0,''),(47,'KANGRA CENTRAL CO-OP BANK LIMITED (THE)','',0,''),(48,'KAPOLE CO OP BANK','',0,''),(49,'KARNATAKA BANK LTD','',0,''),(50,'KARUR VYSYA BANK','',0,''),(51,'KOTAK MAHINDRA BANK','',0,''),(52,'MAHANAGAR CO-OP BANK LTD','',0,''),(53,'MAHARASHTRA STATE CO OPERATIVE BANK','',0,''),(54,'MASHREQ BANK PSC','',0,''),(55,'MIZUHO CORPORATE BANK LTD','',0,''),(56,'NEW  INDIA CO-OPERATIVE  BANK  LTD','',0,''),(57,'NKGSB CO-OP BANK LTD','',0,''),(58,'NUTAN NAGARIK SAHAKARI BANK LTD','',0,''),(59,'OMAN INTERNATIONAL BANK SAOG','',0,''),(60,'ORIENTAL BANK OF COMMERCE','',0,''),(61,'PARSIK JANATA SAHAKARI BANK LTD','',0,''),(62,'PRATHAMA BANK','',0,''),(63,'PUNJAB AND MAHARASHTRA CO-OP BANK LTD','',0,''),(64,'PUNJAB AND SIND BANK','',0,''),(65,'PUNJAB NATIONAL BANK','',0,''),(66,'RAJKOT NAGARIK SAHAKARI BANK LTD','',0,''),(67,'RESERVE BANK OF INDIA','',0,''),(68,'SHINHAN BANK','',0,''),(69,'SOCIETE GENERALE','',0,''),(70,'SOUTH INDIAN BANK','',0,''),(71,'STANDARD CHARTERED BANK','',0,''),(72,'STATE BANK OF BIKANER AND JAIPUR','',0,''),(73,'STATE BANK OF HYDERABAD','',0,''),(74,'STATE BANK OF MAURITIUS LTD','',0,''),(75,'STATE BANK OF MYSORE','',0,''),(76,'STATE BANK OF PATIALA','',0,''),(77,'STATE BANK OF TRAVANCORE','',0,''),(78,'SYNDICATE BANK','',0,''),(79,'TAMILNAD MERCANTILE BANK LTD','',0,''),(80,'THE A.P. MAHESH CO-OP URBAN BANK LTD.','',0,''),(81,'THE AHMEDABAD MERCANTILE CO-OPERATIVE BANK LTD','',0,''),(82,'THE BANK OF NOVA SCOTIA','',0,''),(83,'THE BHARAT CO-OPERATIVE BANK (MUMBAI) LTD','',0,''),(84,'THE COSMOS CO-OPERATIVE BANK LTD','',0,''),(85,'THE FEDERAL BANK LTD','',0,''),(86,'THE GREATER BOMBAY CO-OP BANK LTD','',0,''),(87,'THE JAMMU AND KASHMIR BANK LTD','',0,''),(88,'THE KALUPUR COMMERCIAL CO OP BANK LTD','',0,''),(89,'THE KALYAN JANATA SAHAKARI BANK LTD','',0,''),(90,'The Kangra Co-Operative Bank Ltd','',0,''),(91,'THE KARAD URBAN CO-OP BANK LTD','',0,''),(92,'THE KARNATAKA STATE APEX COOP BANK','',0,''),(93,'THE KARNATAKA STATE CO-OPERATIVE APEX BANK LTD BANGALORE','',0,''),(94,'THE LAKSHMI VILAS BANK LTD','',0,''),(95,'THE MEHSANA URBAN COOPERATIVE BANK LTD','',0,''),(96,'THE NAINITAL BANK LIMITED','',0,''),(97,'THE NASIK MERCHANTS CO-OP BANK LTD','',0,''),(98,'THE NASIK MERCHANTS CO-OP BANK LTD. NASHIK','',0,''),(99,'THE RATNAKAR BANK LTD','',0,''),(100,'THE ROYAL BANK OF SCOTLAND','',0,''),(101,'THE SARASWAT CO-OPERATIVE BANK LTD','',0,''),(102,'THE SHAMRAO VITHAL CO-OPERATIVE BANK','',0,''),(103,'THE SURAT PEOPLES CO-OPERATIVE BANK','',0,''),(104,'THE TAMILNADU STATE APEX COOPERATVE BANK','',0,''),(105,'THE THANE JANATA SAHAKARI BANK LTD','',0,''),(106,'UBS AG','',0,''),(107,'UCO BANK','',0,''),(108,'UNION BANK OF INDIA','',0,''),(109,'UNITED BANK OF INDIA','',0,''),(110,'VIJAYA BANK','',0,''),(111,'WEST BENGAL STATE CO-OPERATIVE BANK','',0,'');
/*!40000 ALTER TABLE `master_bank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_bank_detail`
--

DROP TABLE IF EXISTS `master_bank_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_bank_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_id` int(11) NOT NULL,
  `identifier` varchar(10) DEFAULT NULL,
  `account_number_length` int(11) DEFAULT NULL,
  `account_number_validate_flag` tinyint(1) NOT NULL,
  `ifsc_prefix` varchar(10) DEFAULT NULL,
  `ifsc_suffix_length` int(11) DEFAULT NULL,
  `ifsc_autoconstruct_flag` tinyint(1) NOT NULL,
  `neft_allowed_flag` tinyint(1) NOT NULL,
  `imps_allowed_flag` tinyint(1) NOT NULL,
  `frequency_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `master_bank_detail_df49f419` (`bank_id`),
  CONSTRAINT `bank_id_refs_id_53993523` FOREIGN KEY (`bank_id`) REFERENCES `master_bank` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_bank_detail`
--

LOCK TABLES `master_bank_detail` WRITE;
/*!40000 ALTER TABLE `master_bank_detail` DISABLE KEYS */;
INSERT INTO `master_bank_detail` VALUES (1,1,'SBIN',11,0,'NULL',0,1,1,1,43),(2,2,'ICIC',12,0,'ICIC000',4,1,1,1,36),(3,5,'HDFC',14,0,'NULL',0,1,1,1,31),(4,6,'PUNB',16,0,'NULL',0,1,1,1,42),(5,4,'ABHY',0,0,NULL,NULL,0,1,0,NULL),(6,5,'ADCB',0,0,NULL,NULL,0,1,0,NULL),(7,6,'ALLA',11,0,NULL,NULL,0,1,0,37),(8,7,'ANDB',15,0,'ANDB000',4,0,1,1,32),(9,8,'UTIB',15,0,NULL,NULL,0,1,1,30),(10,9,'BOFA',0,0,NULL,NULL,0,1,0,NULL),(11,10,'BBKM',0,0,NULL,NULL,0,1,0,NULL),(12,11,'BARB',14,0,NULL,NULL,0,1,1,38),(13,12,'BCEY',0,0,NULL,NULL,0,1,0,NULL),(14,13,'BKID',15,0,NULL,NULL,0,1,1,41),(15,14,'BOM0',0,0,NULL,NULL,0,1,0,NULL),(16,14,'MAHB',11,0,NULL,NULL,0,1,0,18),(17,15,'BOTM',0,0,NULL,NULL,0,1,0,NULL),(18,16,'BARC',0,0,NULL,NULL,0,1,0,NULL),(19,17,'BACB',0,0,NULL,NULL,0,1,1,NULL),(20,18,'BNPA',0,0,NULL,NULL,0,1,1,NULL),(21,19,'CNRB',13,0,'CNRB000',4,0,1,1,33),(22,20,'CSBK',18,0,NULL,NULL,0,1,0,NULL),(23,21,'CBIN',10,0,NULL,NULL,0,1,1,40),(24,22,'CTCB',0,0,NULL,NULL,0,1,0,NULL),(25,23,'CITI',10,0,NULL,NULL,0,1,1,13),(26,24,'CCBL',0,0,NULL,NULL,0,1,0,NULL),(27,25,'CIUB',16,0,'CIUB0000',3,0,1,0,NULL),(28,26,'CORP',15,0,'CORP000',4,0,1,1,21),(29,27,'CRLY',0,0,NULL,NULL,0,1,0,NULL),(30,28,'DBSS',0,0,NULL,NULL,0,1,0,NULL),(31,29,'BKDN',12,0,NULL,NULL,0,1,1,22),(32,30,'DEUT',15,0,NULL,NULL,0,1,0,NULL),(33,31,'DBSS',10,0,NULL,NULL,0,1,1,NULL),(34,32,'DCBL',14,0,NULL,NULL,0,1,1,3),(35,33,'DLXB',16,0,NULL,NULL,0,1,0,4),(36,34,'DICG',0,0,NULL,NULL,0,1,0,NULL),(37,35,'DNSB',0,0,NULL,NULL,0,1,1,NULL),(38,36,'FIRN',0,0,NULL,NULL,0,1,0,NULL),(39,37,'HDFC',14,0,NULL,NULL,0,1,1,31),(40,38,'HSBC',12,0,NULL,NULL,0,1,1,NULL),(42,39,'IBKL',15,0,'IBKL0000',3,0,1,1,23),(43,40,'IDIB',9,0,NULL,NULL,0,1,1,24),(44,41,'IOBA',15,0,'IOBA000',4,0,1,0,20),(45,41,'IOBA',15,0,'IOBA000',4,0,1,0,20),(46,42,'INDB',13,0,'INDB000',4,0,1,1,NULL),(47,43,'VYSA',12,0,'VYSA000',4,0,1,1,10),(48,44,'JSBL',0,0,NULL,NULL,0,1,0,NULL),(49,45,'JSBP',0,0,NULL,NULL,0,1,1,NULL),(50,46,'CHAS',0,0,NULL,NULL,0,1,0,NULL),(51,47,'KACE',11,0,NULL,NULL,0,1,0,NULL),(52,48,'KCBL',0,0,NULL,NULL,0,1,0,NULL),(53,49,'KARB',0,0,'KARB0000',3,0,1,0,14),(54,50,'KVBL',16,0,'KVBL000',4,0,1,1,17),(55,51,'KKBK',14,0,NULL,NULL,0,1,1,11),(56,52,'MCBL',0,0,NULL,NULL,0,1,0,NULL),(57,53,'MSCI',0,0,NULL,NULL,0,1,0,NULL),(58,54,'MSHQ',0,0,NULL,NULL,0,1,0,NULL),(59,55,'MHCB',0,0,NULL,NULL,0,1,0,NULL),(60,56,'NICB',0,0,NULL,NULL,0,1,0,NULL),(61,57,'NKGS',0,0,NULL,NULL,0,1,1,NULL),(62,58,'NNSB',0,0,NULL,NULL,0,1,0,NULL),(63,59,'OIBA',0,0,NULL,NULL,0,1,0,NULL),(64,60,'ORBC',14,0,'ORBC010',4,0,1,1,29),(65,61,'PJSB',0,0,NULL,NULL,0,1,0,NULL),(66,62,'PRTH',11,0,NULL,NULL,0,1,0,NULL),(67,63,'PMCB',0,0,NULL,NULL,0,1,1,NULL),(68,64,'PSIB',0,0,NULL,NULL,0,1,0,12),(69,65,'PUNB',16,0,NULL,NULL,0,1,1,42),(70,66,'RNSB',0,0,NULL,NULL,0,1,0,NULL),(71,67,'RBIS',0,0,NULL,NULL,0,1,0,NULL),(72,68,'SHBK',0,0,NULL,NULL,0,1,0,NULL),(73,69,'SOGE',0,0,NULL,NULL,0,1,0,NULL),(74,70,'SIBL',16,0,'SIBL000',4,0,1,1,7),(75,71,'SCBL',11,0,NULL,NULL,0,1,0,2),(76,72,'SBBJ',11,0,NULL,NULL,0,1,1,26),(77,73,'SBHY',11,0,NULL,NULL,0,1,1,34),(79,75,'STCB',0,0,NULL,NULL,0,1,0,NULL),(80,74,'SBMY',11,0,NULL,NULL,0,1,1,6),(81,76,'STBP',11,0,NULL,NULL,0,1,1,25),(82,77,'SBTR',11,0,NULL,NULL,0,1,1,15),(83,78,'SYNB',14,0,'SYNB000',4,0,1,1,27),(84,79,'TMBL',15,0,NULL,NULL,0,1,1,NULL),(85,80,'APMC',0,0,NULL,NULL,0,1,1,NULL),(86,81,'AMCB',0,0,NULL,NULL,0,1,0,NULL),(87,82,'NOSC',0,0,NULL,NULL,0,1,0,NULL),(88,83,'BCBM',0,0,NULL,NULL,0,1,0,NULL),(89,84,'COSB',15,0,NULL,NULL,0,1,1,NULL),(90,85,'FDRL',14,0,'FDRL000',4,0,1,1,16),(91,86,'GBCB',0,0,NULL,NULL,0,1,1,NULL),(92,87,'JAKA',0,0,NULL,NULL,0,1,1,9),(93,88,'KCCB',0,0,NULL,NULL,0,1,0,NULL),(94,89,'KJSB',0,0,NULL,NULL,0,1,0,NULL),(95,90,'KANG',14,0,NULL,NULL,0,1,0,NULL),(96,91,'KUCB',0,0,NULL,NULL,0,1,0,NULL),(97,92,'KSBC',0,0,NULL,NULL,0,1,0,NULL),(98,93,'KSCB',0,0,NULL,NULL,0,1,0,NULL),(99,94,'LAVB',16,0,NULL,NULL,0,1,0,NULL),(100,95,'MSNU',0,0,NULL,NULL,0,1,1,NULL),(101,96,'NTBL',0,0,NULL,NULL,0,1,1,NULL),(102,98,'NMCB',12,0,NULL,NULL,0,1,1,NULL),(103,97,'NMCB',0,0,NULL,NULL,0,1,0,NULL),(104,99,'RATN',16,0,NULL,NULL,0,1,0,NULL),(105,100,'ABNA',0,0,NULL,NULL,0,1,0,NULL),(106,101,'SRCB',16,0,NULL,NULL,0,1,1,NULL),(107,102,'SVCB',0,0,NULL,NULL,0,1,0,NULL),(108,103,'SPCB',0,0,NULL,NULL,0,1,0,NULL),(109,104,'TNSC',0,0,NULL,NULL,0,1,0,NULL),(110,105,'TJSB',0,0,NULL,NULL,0,1,1,NULL),(111,106,'UBSW',0,0,NULL,NULL,0,1,0,NULL),(112,107,'UCBA',14,0,'UCBA000',4,0,1,1,35),(113,108,'UBIN',15,0,NULL,NULL,0,1,1,39),(114,109,'UTIB',13,0,NULL,NULL,0,1,0,30),(115,109,'UTBI',0,0,NULL,NULL,0,1,1,28),(116,110,'VIJB',15,0,'VIJB000',4,0,1,1,19),(117,111,'WBSC',0,0,NULL,NULL,0,1,0,5),(118,3,'YESB',15,0,'YESB000',4,0,1,1,8);
/*!40000 ALTER TABLE `master_bank_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_bank_ifsc`
--

DROP TABLE IF EXISTS `master_bank_ifsc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_bank_ifsc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_id` int(11) NOT NULL,
  `bank_detail_id` int(11) NOT NULL,
  `ifsc_code` varchar(20) DEFAULT NULL,
  `micr_code` varchar(20) DEFAULT NULL,
  `branch_name` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `city_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `master_bank_ifsc_df49f419` (`bank_id`),
  KEY `master_bank_ifsc_3b897a37` (`bank_detail_id`),
  KEY `master_bank_ifsc_b376980e` (`city_id`),
  KEY `master_bank_ifsc_13b5b160` (`district_id`),
  KEY `master_bank_ifsc_5654bf12` (`state_id`),
  CONSTRAINT `bank_detail_id_refs_id_389b33e8` FOREIGN KEY (`bank_detail_id`) REFERENCES `master_bank_detail` (`id`),
  CONSTRAINT `bank_id_refs_id_00145b62` FOREIGN KEY (`bank_id`) REFERENCES `master_bank` (`id`),
  CONSTRAINT `city_id_refs_id_d0d23499` FOREIGN KEY (`city_id`) REFERENCES `master_city` (`id`),
  CONSTRAINT `district_id_refs_id_c30b257b` FOREIGN KEY (`district_id`) REFERENCES `master_district` (`id`),
  CONSTRAINT `state_id_refs_id_622d71d0` FOREIGN KEY (`state_id`) REFERENCES `master_state` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_bank_ifsc`
--

LOCK TABLES `master_bank_ifsc` WRITE;
/*!40000 ALTER TABLE `master_bank_ifsc` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_bank_ifsc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_bank_transaction_mapping`
--

DROP TABLE IF EXISTS `master_bank_transaction_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_bank_transaction_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tx_type_id` int(11) NOT NULL,
  `bank_id` int(11) NOT NULL,
  `reference_tx_type` int(11) NOT NULL,
  `commission_flag` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `master_bank_transaction_mapping_a2bb4c10` (`tx_type_id`),
  KEY `master_bank_transaction_mapping_df49f419` (`bank_id`),
  CONSTRAINT `bank_id_refs_id_e8af669c` FOREIGN KEY (`bank_id`) REFERENCES `master_bank` (`id`),
  CONSTRAINT `tx_type_id_refs_id_521b37a9` FOREIGN KEY (`tx_type_id`) REFERENCES `master_transaction_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_bank_transaction_mapping`
--

LOCK TABLES `master_bank_transaction_mapping` WRITE;
/*!40000 ALTER TABLE `master_bank_transaction_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_bank_transaction_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_branch`
--

DROP TABLE IF EXISTS `master_branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_branch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_id` int(11) NOT NULL,
  `name` varchar(15) NOT NULL,
  `descr` varchar(100) NOT NULL,
  `address_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `master_branch_df49f419` (`bank_id`),
  KEY `master_branch_3ac8a70a` (`address_id`),
  CONSTRAINT `address_id_refs_id_e6bfe7ca` FOREIGN KEY (`address_id`) REFERENCES `master_address` (`id`),
  CONSTRAINT `bank_id_refs_id_85bc1275` FOREIGN KEY (`bank_id`) REFERENCES `master_bank` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_branch`
--

LOCK TABLES `master_branch` WRITE;
/*!40000 ALTER TABLE `master_branch` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_cellnumber_type`
--

DROP TABLE IF EXISTS `master_cellnumber_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_cellnumber_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `descr` varchar(100) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_cellnumber_type`
--

LOCK TABLES `master_cellnumber_type` WRITE;
/*!40000 ALTER TABLE `master_cellnumber_type` DISABLE KEYS */;
INSERT INTO `master_cellnumber_type` VALUES (1,'Primary','primary number',1),(2,'Alternate1','Alternate number',1);
/*!40000 ALTER TABLE `master_cellnumber_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_circle`
--

DROP TABLE IF EXISTS `master_circle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_circle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `circle_id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `bank_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `master_circle_df49f419` (`bank_id`),
  CONSTRAINT `bank_id_refs_id_e2303c99` FOREIGN KEY (`bank_id`) REFERENCES `master_bank` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_circle`
--

LOCK TABLES `master_circle` WRITE;
/*!40000 ALTER TABLE `master_circle` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_circle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_city`
--

DROP TABLE IF EXISTS `master_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `state_id` int(11) DEFAULT NULL,
  `country_id` int(11) NOT NULL,
  `district_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `master_city_5654bf12` (`state_id`),
  KEY `master_city_d860be3c` (`country_id`),
  KEY `master_city_13b5b160` (`district_id`),
  CONSTRAINT `country_id_refs_id_a1217015` FOREIGN KEY (`country_id`) REFERENCES `master_country` (`id`),
  CONSTRAINT `district_id_refs_id_63d57eaa` FOREIGN KEY (`district_id`) REFERENCES `master_district` (`id`),
  CONSTRAINT `state_id_refs_id_0156448d` FOREIGN KEY (`state_id`) REFERENCES `master_state` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_city`
--

LOCK TABLES `master_city` WRITE;
/*!40000 ALTER TABLE `master_city` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_competition`
--

DROP TABLE IF EXISTS `master_competition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_competition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `descr` varchar(100) NOT NULL,
  `short_code` varchar(20) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_competition`
--

LOCK TABLES `master_competition` WRITE;
/*!40000 ALTER TABLE `master_competition` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_competition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_country`
--

DROP TABLE IF EXISTS `master_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_country`
--

LOCK TABLES `master_country` WRITE;
/*!40000 ALTER TABLE `master_country` DISABLE KEYS */;
INSERT INTO `master_country` VALUES (1,'India',1);
/*!40000 ALTER TABLE `master_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_csp_type`
--

DROP TABLE IF EXISTS `master_csp_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_csp_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `csp_type_id` int(11) NOT NULL,
  `agent_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `master_csp_type_3a3bb5b0` (`agent_type_id`),
  CONSTRAINT `agent_type_id_refs_id_f96e01aa` FOREIGN KEY (`agent_type_id`) REFERENCES `master_agent_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_csp_type`
--

LOCK TABLES `master_csp_type` WRITE;
/*!40000 ALTER TABLE `master_csp_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_csp_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_department`
--

DROP TABLE IF EXISTS `master_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_department`
--

LOCK TABLES `master_department` WRITE;
/*!40000 ALTER TABLE `master_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_designation`
--

DROP TABLE IF EXISTS `master_designation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_designation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_designation`
--

LOCK TABLES `master_designation` WRITE;
/*!40000 ALTER TABLE `master_designation` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_designation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_district`
--

DROP TABLE IF EXISTS `master_district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_district` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `state_id` int(11) DEFAULT NULL,
  `country_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `master_district_5654bf12` (`state_id`),
  KEY `master_district_d860be3c` (`country_id`),
  CONSTRAINT `country_id_refs_id_6edf1565` FOREIGN KEY (`country_id`) REFERENCES `master_country` (`id`),
  CONSTRAINT `state_id_refs_id_aee1a10f` FOREIGN KEY (`state_id`) REFERENCES `master_state` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_district`
--

LOCK TABLES `master_district` WRITE;
/*!40000 ALTER TABLE `master_district` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_payment_frequency`
--

DROP TABLE IF EXISTS `master_payment_frequency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_payment_frequency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_payment_frequency`
--

LOCK TABLES `master_payment_frequency` WRITE;
/*!40000 ALTER TABLE `master_payment_frequency` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_payment_frequency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_pincode`
--

DROP TABLE IF EXISTS `master_pincode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_pincode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` int(11) NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  `district_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `master_pincode_b376980e` (`city_id`),
  KEY `master_pincode_13b5b160` (`district_id`),
  KEY `master_pincode_5654bf12` (`state_id`),
  KEY `master_pincode_d860be3c` (`country_id`),
  CONSTRAINT `city_id_refs_id_3057ea85` FOREIGN KEY (`city_id`) REFERENCES `master_city` (`id`),
  CONSTRAINT `country_id_refs_id_d02744aa` FOREIGN KEY (`country_id`) REFERENCES `master_country` (`id`),
  CONSTRAINT `district_id_refs_id_e1cc59b7` FOREIGN KEY (`district_id`) REFERENCES `master_district` (`id`),
  CONSTRAINT `state_id_refs_id_fbb8179e` FOREIGN KEY (`state_id`) REFERENCES `master_state` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_pincode`
--

LOCK TABLES `master_pincode` WRITE;
/*!40000 ALTER TABLE `master_pincode` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_pincode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_posm`
--

DROP TABLE IF EXISTS `master_posm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_posm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `descr` varchar(100) NOT NULL,
  `short_code` varchar(15) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_posm`
--

LOCK TABLES `master_posm` WRITE;
/*!40000 ALTER TABLE `master_posm` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_posm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_rounding_mode`
--

DROP TABLE IF EXISTS `master_rounding_mode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_rounding_mode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `description` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_rounding_mode`
--

LOCK TABLES `master_rounding_mode` WRITE;
/*!40000 ALTER TABLE `master_rounding_mode` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_rounding_mode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_state`
--

DROP TABLE IF EXISTS `master_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `country_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `master_state_d860be3c` (`country_id`),
  CONSTRAINT `country_id_refs_id_dbf3ed1d` FOREIGN KEY (`country_id`) REFERENCES `master_country` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_state`
--

LOCK TABLES `master_state` WRITE;
/*!40000 ALTER TABLE `master_state` DISABLE KEYS */;
INSERT INTO `master_state` VALUES (1,'Andaman & Nicobar Islands',1,1),(2,'Andhra Pradesh',1,1),(3,'Arunachal Pradesh',1,1),(4,'Assam',1,1),(5,'Bihar',1,1),(6,'Chandigarh',1,1),(7,'Chhattisgarh',1,1),(8,'Dadra & Nagar Haveli',1,1),(9,'Daman & Diu',1,1),(10,'Delhi',1,1),(11,'Goa',1,1),(12,'Gujarat',1,1),(13,'Haryana',1,1),(14,'Himachal Pradesh',1,1),(15,'Jammu & Kashmir',1,1),(16,'Jharkhand',1,1),(17,'Karnataka',1,1),(18,'Kerala',1,1),(19,'Lakshadweep',1,1),(20,'Madhya Pradesh',1,1),(21,'Maharashtra',1,1),(22,'Manipur',1,1),(23,'Meghalaya',1,1),(24,'Mizoram',1,1),(25,'Nagaland',1,1),(26,'Orissa',1,1),(27,'Pondicherry',1,1),(28,'Punjab',1,1),(29,'Rajasthan',1,1),(30,'Sikkim',1,1),(31,'Tamil Nadu',1,1),(32,'Tripura',1,1),(33,'Uttar Pradesh',1,1),(34,'Uttaranchal',1,1),(35,'West Bengal',1,1);
/*!40000 ALTER TABLE `master_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_transaction_type`
--

DROP TABLE IF EXISTS `master_transaction_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_transaction_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(250) NOT NULL,
  `display_name` varchar(50) DEFAULT NULL,
  `short_code` varchar(20) DEFAULT NULL,
  `display_color` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_transaction_type`
--

LOCK TABLES `master_transaction_type` WRITE;
/*!40000 ALTER TABLE `master_transaction_type` DISABLE KEYS */;
INSERT INTO `master_transaction_type` VALUES (1,'Transaction Enquiry','Transaction Enquiry',NULL,NULL,NULL),(2,'Sender Inquiry','Sender Inquiry',NULL,NULL,NULL),(3,'Sender Enrolment Verification','Sender Enrolment Verification',NULL,NULL,NULL),(4,'Sender Enrolment Resend OTP','Sender Enrolment Resend OTP',NULL,NULL,NULL),(5,'Bank Config Inquiry','Bank Config Inquiry',NULL,NULL,NULL),(6,'Booklet Inquiry','Booklet Inquiry',NULL,NULL,NULL),(7,'Booklet Registration','Booklet Registration',NULL,NULL,NULL),(8,'Transaction SOS Inquiry','Transaction SOS Inquiry',NULL,NULL,NULL),(9,'User Info Lookup','User Info Lookup',NULL,NULL,NULL),(10,'Account Number Lookup','Account Number Lookup',NULL,NULL,NULL),(11,'Recipient Individual Inquiry','Recipient Individual Inquiry',NULL,NULL,NULL),(12,'Balance Inquiry','Balance Inquiry',NULL,NULL,NULL),(13,'Money Transfer','Money Transfer',NULL,NULL,NULL),(14,'Recipient Inquiry','Recipient Inquiry',NULL,NULL,NULL),(15,'Recipient Registration','Recipient Registration',NULL,NULL,NULL),(16,'Sender Enrolment','Sender Enrolment',NULL,NULL,NULL);
/*!40000 ALTER TABLE `master_transaction_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_user_type`
--

DROP TABLE IF EXISTS `master_user_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_user_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `descr` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_user_type`
--

LOCK TABLES `master_user_type` WRITE;
/*!40000 ALTER TABLE `master_user_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_user_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `south_migrationhistory`
--

DROP TABLE IF EXISTS `south_migrationhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `south_migrationhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(255) NOT NULL,
  `migration` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `south_migrationhistory`
--

LOCK TABLES `south_migrationhistory` WRITE;
/*!40000 ALTER TABLE `south_migrationhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `south_migrationhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_additional_detail`
--

DROP TABLE IF EXISTS `transaction_additional_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_additional_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_type_id` int(11) NOT NULL,
  `bank_id` int(11) NOT NULL,
  `customer_mobile` bigint(20) DEFAULT NULL,
  `amount` int(11) NOT NULL,
  `log_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_additional_detail_6a705dc1` (`transaction_type_id`),
  KEY `transaction_additional_detail_df49f419` (`bank_id`),
  KEY `transaction_additional_detail_695186c0` (`log_id`),
  CONSTRAINT `bank_id_refs_id_153e4e26` FOREIGN KEY (`bank_id`) REFERENCES `master_bank` (`id`),
  CONSTRAINT `log_id_refs_id_f83b90aa` FOREIGN KEY (`log_id`) REFERENCES `transaction_log` (`id`),
  CONSTRAINT `transaction_type_id_refs_id_48debc66` FOREIGN KEY (`transaction_type_id`) REFERENCES `master_transaction_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_additional_detail`
--

LOCK TABLES `transaction_additional_detail` WRITE;
/*!40000 ALTER TABLE `transaction_additional_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_additional_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_bank_mapping`
--

DROP TABLE IF EXISTS `transaction_bank_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_bank_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_type_id` int(11) NOT NULL,
  `bank_id` int(11) NOT NULL,
  `agent_sms_flag` tinyint(1) NOT NULL,
  `active_flag` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_bank_mapping_6a705dc1` (`transaction_type_id`),
  KEY `transaction_bank_mapping_df49f419` (`bank_id`),
  CONSTRAINT `bank_id_refs_id_181e755c` FOREIGN KEY (`bank_id`) REFERENCES `master_bank` (`id`),
  CONSTRAINT `transaction_type_id_refs_id_5ef59c2e` FOREIGN KEY (`transaction_type_id`) REFERENCES `master_transaction_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_bank_mapping`
--

LOCK TABLES `transaction_bank_mapping` WRITE;
/*!40000 ALTER TABLE `transaction_bank_mapping` DISABLE KEYS */;
INSERT INTO `transaction_bank_mapping` VALUES (1,1,2,0,1),(2,2,2,0,1),(3,3,2,0,1),(4,4,2,0,1),(5,5,2,0,1),(6,6,2,0,1),(7,7,2,0,1),(8,8,2,0,1),(9,9,2,0,1),(10,10,2,0,1),(11,11,2,0,1),(12,12,2,0,1),(13,13,2,0,1),(14,14,2,0,1),(15,15,2,0,1),(16,16,2,0,1);
/*!40000 ALTER TABLE `transaction_bank_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_log`
--

DROP TABLE IF EXISTS `transaction_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `bank_id` int(11) NOT NULL,
  `transaction_type_id` int(11) NOT NULL,
  `origination_address` varchar(15) NOT NULL,
  `request_text` varchar(100) NOT NULL,
  `response` varchar(500) DEFAULT NULL,
  `request_timestamp` datetime NOT NULL,
  `response_timestamp` datetime NOT NULL,
  `connect_tid` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_log_6340c63c` (`user_id`),
  KEY `transaction_log_44625c0c` (`agent_id`),
  KEY `transaction_log_df49f419` (`bank_id`),
  KEY `transaction_log_6a705dc1` (`transaction_type_id`),
  CONSTRAINT `agent_id_refs_id_7f3a1cab` FOREIGN KEY (`agent_id`) REFERENCES `agent_agent` (`id`),
  CONSTRAINT `bank_id_refs_id_390c2d62` FOREIGN KEY (`bank_id`) REFERENCES `master_bank` (`id`),
  CONSTRAINT `transaction_type_id_refs_id_e6d6e810` FOREIGN KEY (`transaction_type_id`) REFERENCES `master_transaction_type` (`id`),
  CONSTRAINT `user_id_refs_id_7b3ae9dc` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_log`
--

LOCK TABLES `transaction_log` WRITE;
/*!40000 ALTER TABLE `transaction_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_param`
--

DROP TABLE IF EXISTS `transaction_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `display_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_param`
--

LOCK TABLES `transaction_param` WRITE;
/*!40000 ALTER TABLE `transaction_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_request_log`
--

DROP TABLE IF EXISTS `transaction_request_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_request_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `agent_id` int(11) DEFAULT NULL,
  `bank_id` int(11) DEFAULT NULL,
  `transaction_type_id` int(11) DEFAULT NULL,
  `origination_address` decimal(15,0) NOT NULL,
  `request_text` varchar(100) NOT NULL,
  `request_timestamp` datetime DEFAULT NULL,
  `connect_tid` decimal(30,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_request_log_6340c63c` (`user_id`),
  KEY `transaction_request_log_44625c0c` (`agent_id`),
  KEY `transaction_request_log_df49f419` (`bank_id`),
  KEY `transaction_request_log_6a705dc1` (`transaction_type_id`),
  CONSTRAINT `agent_id_refs_id_a83fc0cb` FOREIGN KEY (`agent_id`) REFERENCES `agent_agent` (`id`),
  CONSTRAINT `bank_id_refs_id_c816d4dd` FOREIGN KEY (`bank_id`) REFERENCES `master_bank` (`id`),
  CONSTRAINT `transaction_type_id_refs_id_757a0329` FOREIGN KEY (`transaction_type_id`) REFERENCES `master_transaction_type` (`id`),
  CONSTRAINT `user_id_refs_id_6c7e4f00` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_request_log`
--

LOCK TABLES `transaction_request_log` WRITE;
/*!40000 ALTER TABLE `transaction_request_log` DISABLE KEYS */;
INSERT INTO `transaction_request_log` VALUES (1,2,2,2,12,6726152721,'123','2016-06-21 17:56:32',NULL),(2,2,2,2,12,6726152721,'123','2016-06-21 17:58:38',NULL),(3,2,2,2,12,6726152721,'123','2016-06-21 18:00:41',NULL),(4,2,2,2,3,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-21 18:00:51',21651466512251194),(5,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-21 18:00:53',21651466512253685),(6,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-21 18:00:54',21651466512254595),(7,2,2,2,12,6726152721,'123','2016-06-21 18:06:34',NULL),(8,2,2,2,3,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-21 18:06:43',21651466512603776),(9,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-21 18:06:44',21651466512604352),(10,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-21 18:06:45',21651466512605180),(11,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients/recipient_id','2016-06-21 18:06:52',21651466512612567),(12,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'100\', \'recipie','2016-06-21 18:07:51',21651466512671863),(13,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-21 18:07:53',21651466512673158),(14,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-21 18:07:59',21651466512679077),(15,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'100\', \'recipie','2016-06-21 18:16:45',21651466513205789),(16,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'100\', \'recipie','2016-06-21 18:17:15',21651466513235297),(17,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-21 18:17:16',21651466513236246),(18,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-21 18:17:17',21651466513237080),(19,2,2,2,3,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8427511775{}{\'initiator_id\': u\'672','2016-06-21 18:18:01',21651466513281327),(20,2,2,2,4,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8427511775{\'initiator_id\': u\'67261','2016-06-21 18:18:10',21651466513290984),(21,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/verification/otp:621{\'initiator_id\': u\'672615272','2016-06-21 18:18:25',21651466513305159),(22,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8427511775/recipients{}{\'initiator','2016-06-21 18:18:26',21651466513306032),(23,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8427511775{}{\'initiator_id\': u\'672','2016-06-21 18:18:26',21651466513306736),(24,2,2,2,12,6726152721,'123','2016-06-21 18:22:10',NULL),(25,2,2,2,12,6726152721,'123','2016-06-21 19:10:00',NULL),(26,2,2,2,6,6726152721,'okekeyinfo','2016-06-21 19:10:01',21651466516401217),(27,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 19:10:37',21651466516437758),(28,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128/recipients{}{\'initiator','2016-06-21 19:10:38',21651466516438632),(29,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 19:10:39',21651466516439052),(30,2,2,2,12,6726152721,'123','2016-06-21 19:19:01',NULL),(31,2,2,2,6,6726152721,'okekeyinfo','2016-06-21 19:19:02',21651466516942283),(32,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 19:19:10',21651466516950938),(33,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128/recipients{}{\'initiator','2016-06-21 19:19:11',21651466516951640),(34,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 19:19:11',21651466516951974),(35,2,2,2,12,6726152721,'123','2016-06-21 19:26:11',NULL),(36,2,2,2,6,6726152721,'okekeyinfo','2016-06-21 19:26:12',21651466517372138),(37,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 19:26:18',21651466517378104),(38,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128/recipients{}{\'initiator','2016-06-21 19:26:18',21651466517378967),(39,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 19:26:19',21651466517379465),(40,2,2,2,12,6726152721,'123','2016-06-21 19:28:12',NULL),(41,2,2,2,6,6726152721,'okekeyinfo','2016-06-21 19:28:13',21651466517493388),(42,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 19:28:19',21651466517499907),(43,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128/recipients{}{\'initiator','2016-06-21 19:28:20',21651466517500410),(44,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 19:28:20',21651466517500762),(45,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128/recipients/recipient_id','2016-06-21 19:28:25',21651466517505511),(46,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 19:28:32',21651466517512318),(47,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 19:28:35',21651466517515764),(48,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 19:28:40',21651466517520738),(49,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 19:28:43',21651466517523617),(50,2,2,2,1,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions/1246512{}{\'initiator_id\': \'mobile_number:6726','2016-06-21 19:30:14',21651466517614811),(51,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:32:12',21651466517732492),(52,2,2,2,16,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{\'initiator_id\': u\'67261','2016-06-21 19:32:17',21651466517737741),(53,2,2,2,12,6726152721,'123','2016-06-21 19:32:46',NULL),(54,2,2,2,6,6726152721,'okekeyinfo','2016-06-21 19:32:46',21651466517766583),(55,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:32:55',21651466517775017),(56,2,2,2,3,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/verification/otp:982{\'initiator_id\': u\'672615272','2016-06-21 19:33:16',21651466517796405),(57,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 19:33:16',21651466517796979),(58,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:33:17',21651466517797331),(59,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 19:33:22',21651466517802480),(60,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks/ifsc:SBIN/accounts/20178905203{\'initiator_id\': u\'672','2016-06-21 19:34:13',21651466517853864),(61,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients/acc_ifsc:201','2016-06-21 19:34:34',21651466517874539),(62,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 19:34:35',21651466517875107),(63,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:34:35',21651466517875463),(64,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients/recipient_id','2016-06-21 19:34:40',21651466517880170),(65,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'100\', \'recipie','2016-06-21 19:35:14',21651466517914005),(66,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 19:35:15',21651466517915205),(67,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:35:15',21651466517915595),(68,2,2,2,1,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions/12469474{}{\'initiator_id\': \'mobile_number:672','2016-06-21 19:35:25',21651466517925433),(69,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'100\', \'recipie','2016-06-21 19:40:20',21651466518220820),(70,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 19:40:22',21651466518222150),(71,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:40:22',21651466518222583),(72,2,2,2,1,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions/12469474{}{\'initiator_id\': \'mobile_number:672','2016-06-21 19:42:10',21651466518330046),(73,2,2,2,12,6726152721,'123','2016-06-21 19:50:18',NULL),(74,2,2,2,6,6726152721,'okekeyinfo','2016-06-21 19:50:19',21651466518819586),(75,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9474972128{}{\'initiator_id\': u\'672','2016-06-21 19:50:26',21651466518826192),(76,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:50:37',21651466518837944),(77,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 19:50:38',21651466518838623),(78,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:50:39',21651466518839158),(79,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-21 19:52:04',21651466518924419),(80,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-21 19:52:17',21651466518937893),(81,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 19:52:18',21651466518938572),(82,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:52:19',21651466518939007),(83,2,2,2,1,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions/12469494{}{\'initiator_id\': \'mobile_number:672','2016-06-21 19:52:54',21651466518974230),(84,2,2,2,12,6726152721,'123','2016-06-21 22:23:48',NULL),(85,2,2,2,6,6726152721,'okekeyinfo','2016-06-21 22:23:50',21651466528030418),(86,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 22:23:58',21651466528038667),(87,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128/recipients{}{\'initiator','2016-06-21 22:24:04',21651466528044833),(88,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 22:24:06',21651466528046600),(89,2,2,2,12,6726152721,'123','2016-06-21 22:29:41',NULL),(90,2,2,2,6,6726152721,'okekeyinfo','2016-06-21 22:29:43',21651466528383946),(91,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 22:29:52',21651466528392569),(92,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 22:29:57',21651466528397133),(93,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 22:29:58',21651466528398773),(94,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 22:30:45',21651466528445474),(95,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 22:30:56',21651466528456099),(96,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 22:31:01',21651466528461704),(97,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 22:31:09',21651466528469864),(98,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 22:31:20',21651466528480315),(99,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 22:33:23',21651466528603055),(100,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 22:33:33',21651466528613267),(101,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients/recipient_id','2016-06-21 22:33:40',21651466528620686),(102,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 22:34:05',21651466528645647),(103,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks/ifsc:SBIN/accounts/20178905203{\'initiator_id\': u\'672','2016-06-21 22:35:01',21651466528701488),(104,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 22:35:04',21651466528704585),(105,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 22:35:06',21651466528706706),(106,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 22:35:15',21651466528715446),(107,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks/ifsc:SBIN/accounts/20178905243{\'initiator_id\': u\'672','2016-06-21 22:35:28',21651466528728622),(108,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients/acc_ifsc:201','2016-06-21 22:36:05',21651466528765458),(109,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 22:36:29',21651466528789608),(110,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 22:36:33',21651466528793209),(111,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-21 22:37:16',21651466528836583),(112,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 22:37:22',21651466528842846),(113,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 22:37:25',21651466528845390),(114,2,2,2,1,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions/12469536{}{\'initiator_id\': \'mobile_number:672','2016-06-21 22:37:53',21651466528873206),(115,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8427511775{}{\'initiator_id\': u\'672','2016-06-21 22:38:18',21651466528898100),(116,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8427511775/recipients{}{\'initiator','2016-06-21 22:38:20',21651466528900917),(117,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8427511775{}{\'initiator_id\': u\'672','2016-06-21 22:38:23',21651466528903271),(118,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 22:38:30',21651466528910515);
/*!40000 ALTER TABLE `transaction_request_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_requesttext_syntax`
--

DROP TABLE IF EXISTS `transaction_requesttext_syntax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_requesttext_syntax` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_type_id` int(11) NOT NULL,
  `bank_id` int(11) NOT NULL,
  `sequence` int(11) NOT NULL,
  `param_id` int(11) DEFAULT NULL,
  `display_name` varchar(50) DEFAULT NULL,
  `optional_flag` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_requesttext_syntax_6a705dc1` (`transaction_type_id`),
  KEY `transaction_requesttext_syntax_df49f419` (`bank_id`),
  KEY `transaction_requesttext_syntax_4312057b` (`param_id`),
  CONSTRAINT `bank_id_refs_id_34fc7252` FOREIGN KEY (`bank_id`) REFERENCES `master_bank` (`id`),
  CONSTRAINT `param_id_refs_id_8d27801a` FOREIGN KEY (`param_id`) REFERENCES `transaction_param` (`id`),
  CONSTRAINT `transaction_type_id_refs_id_007cbf92` FOREIGN KEY (`transaction_type_id`) REFERENCES `master_transaction_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_requesttext_syntax`
--

LOCK TABLES `transaction_requesttext_syntax` WRITE;
/*!40000 ALTER TABLE `transaction_requesttext_syntax` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_requesttext_syntax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_response_log`
--

DROP TABLE IF EXISTS `transaction_response_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_response_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `request_log_id` int(11) NOT NULL,
  `origination_address` decimal(15,0) NOT NULL,
  `response` varchar(500) DEFAULT NULL,
  `response_timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_response_log_207b76ec` (`request_log_id`),
  CONSTRAINT `request_log_id_refs_id_9d559bc2` FOREIGN KEY (`request_log_id`) REFERENCES `transaction_request_log` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_response_log`
--

LOCK TABLES `transaction_response_log` WRITE;
/*!40000 ALTER TABLE `transaction_response_log` DISABLE KEYS */;
INSERT INTO `transaction_response_log` VALUES (1,1,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 17:56\nThanks Eko/-\n','2016-06-21 17:56:33'),(2,2,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 17:58\nThanks Eko/-\n','2016-06-21 17:58:38'),(3,3,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 18:00\nThanks Eko/-\n','2016-06-21 18:00:41'),(4,7,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 18:06\nThanks Eko/-\n','2016-06-21 18:06:34'),(5,24,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 18:22\nThanks Eko/-\n','2016-06-21 18:22:11'),(6,25,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 19:10\nThanks Eko/-\n','2016-06-21 19:10:01'),(7,26,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-21 19:10:01'),(8,30,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 19:19\nThanks Eko/-\n','2016-06-21 19:19:02'),(9,31,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-21 19:19:02'),(10,35,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 19:26\nThanks Eko/-\n','2016-06-21 19:26:11'),(11,36,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-21 19:26:12'),(12,40,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 19:28\nThanks Eko/-\n','2016-06-21 19:28:13'),(13,41,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-21 19:28:13'),(14,53,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 19:32\nThanks Eko/-\n','2016-06-21 19:32:46'),(15,54,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-21 19:32:46'),(16,73,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 19:50\nThanks Eko/-\n','2016-06-21 19:50:19'),(17,74,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-21 19:50:19'),(18,84,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 22:23\nThanks Eko/-\n','2016-06-21 22:23:50'),(19,85,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-21 22:23:52'),(20,89,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 22:29\nThanks Eko/-\n','2016-06-21 22:29:43'),(21,90,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-21 22:29:44');
/*!40000 ALTER TABLE `transaction_response_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_activity`
--

DROP TABLE IF EXISTS `user_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tracking_id` int(11) NOT NULL,
  `activity_type_id` int(11) NOT NULL,
  `value` varchar(200) DEFAULT NULL,
  `master_content_type_id` int(11) DEFAULT NULL,
  `master_object_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_activity_ce05d275` (`tracking_id`),
  KEY `user_activity_82e56eca` (`activity_type_id`),
  KEY `user_activity_60af7b52` (`master_content_type_id`),
  CONSTRAINT `activity_type_id_refs_id_8b237624` FOREIGN KEY (`activity_type_id`) REFERENCES `user_activity_type` (`id`),
  CONSTRAINT `master_content_type_id_refs_id_5a18aea4` FOREIGN KEY (`master_content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `tracking_id_refs_id_60cbff3a` FOREIGN KEY (`tracking_id`) REFERENCES `user_tracking` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_activity`
--

LOCK TABLES `user_activity` WRITE;
/*!40000 ALTER TABLE `user_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_activity_type`
--

DROP TABLE IF EXISTS `user_activity_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_activity_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tracking_type_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `descr` varchar(200) NOT NULL,
  `has_master_table` tinyint(1) NOT NULL,
  `master_content_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_activity_type_91a3dae1` (`tracking_type_id`),
  KEY `user_activity_type_60af7b52` (`master_content_type_id`),
  CONSTRAINT `master_content_type_id_refs_id_15f6184d` FOREIGN KEY (`master_content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `tracking_type_id_refs_id_8f74e954` FOREIGN KEY (`tracking_type_id`) REFERENCES `user_tracking_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_activity_type`
--

LOCK TABLES `user_activity_type` WRITE;
/*!40000 ALTER TABLE `user_activity_type` DISABLE KEYS */;
INSERT INTO `user_activity_type` VALUES (1,1,'Cash Pickup','Fos checks in (tracking) and picks up cash (activity)',0,NULL),(2,2,'Cash Deposit','Fos checks in (tracking) and deposits cash (activity)',0,NULL),(3,2,'Form Pickup','Fos checks out (tracking) and picks up forms (activity)',1,NULL),(4,2,'Competition Check','Fos checks out (tracking) and marks competition nearby (activity)',1,35);
/*!40000 ALTER TABLE `user_activity_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_cellnumber_detail`
--

DROP TABLE IF EXISTS `user_cellnumber_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_cellnumber_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `cellnumber` varchar(13) NOT NULL,
  `cellnumber_type_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_cellnumber_detail_6340c63c` (`user_id`),
  KEY `user_cellnumber_detail_53cc3c17` (`cellnumber_type_id`),
  CONSTRAINT `cellnumber_type_id_refs_id_38853513` FOREIGN KEY (`cellnumber_type_id`) REFERENCES `master_cellnumber_type` (`id`),
  CONSTRAINT `user_id_refs_id_caa4b557` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_cellnumber_detail`
--

LOCK TABLES `user_cellnumber_detail` WRITE;
/*!40000 ALTER TABLE `user_cellnumber_detail` DISABLE KEYS */;
INSERT INTO `user_cellnumber_detail` VALUES (1,2,'6726152721',1,1);
/*!40000 ALTER TABLE `user_cellnumber_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_location`
--

DROP TABLE IF EXISTS `user_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location_type_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `user_id` int(11) NOT NULL,
  `line1` varchar(200) DEFAULT NULL,
  `line2` varchar(200) DEFAULT NULL,
  `landmark` varchar(200) DEFAULT NULL,
  `city` varchar(200) DEFAULT NULL,
  `pincode` int(10) unsigned DEFAULT NULL,
  `district` varchar(200) DEFAULT NULL,
  `state` varchar(200) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_location_49c965ed` (`location_type_id`),
  KEY `user_location_6340c63c` (`user_id`),
  CONSTRAINT `location_type_id_refs_id_0810c1fc` FOREIGN KEY (`location_type_id`) REFERENCES `user_location_type` (`id`),
  CONSTRAINT `user_id_refs_id_33c07f65` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_location`
--

LOCK TABLES `user_location` WRITE;
/*!40000 ALTER TABLE `user_location` DISABLE KEYS */;
INSERT INTO `user_location` VALUES (1,1,'not known',1,'not known','not known','not known','not known',0,'not known','not known',0.0000000,0.0000000,0);
/*!40000 ALTER TABLE `user_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_location_type`
--

DROP TABLE IF EXISTS `user_location_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_location_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `descr` varchar(200) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_location_type`
--

LOCK TABLES `user_location_type` WRITE;
/*!40000 ALTER TABLE `user_location_type` DISABLE KEYS */;
INSERT INTO `user_location_type` VALUES (1,'other','not defined',1),(2,'shop','shop or offices for retailers and distributors mostly',1),(3,'bank branch','bank branches address',1);
/*!40000 ALTER TABLE `user_location_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_login_data`
--

DROP TABLE IF EXISTS `user_login_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_login_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `failed_login_attempts` int(11) DEFAULT NULL,
  `last_failed_login_time` datetime DEFAULT NULL,
  `logged_in_flag` tinyint(1) NOT NULL,
  `active_session_key` varchar(100) DEFAULT NULL,
  `account_locked_flag` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_login_data_6340c63c` (`user_id`),
  CONSTRAINT `user_id_refs_id_45b7ab14` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_login_data`
--

LOCK TABLES `user_login_data` WRITE;
/*!40000 ALTER TABLE `user_login_data` DISABLE KEYS */;
INSERT INTO `user_login_data` VALUES (1,1,0,NULL,1,'v56f4myhcmb0gtslqr1hhkye0yb29d8t',0),(2,2,0,NULL,0,NULL,0);
/*!40000 ALTER TABLE `user_login_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_personal_detail`
--

DROP TABLE IF EXISTS `user_personal_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_personal_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `marital_status` varchar(20) NOT NULL,
  `edu_qual` varchar(30) NOT NULL,
  `citizenship` varchar(30) NOT NULL,
  `handicapped_detail` varchar(50) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `dob` date NOT NULL,
  `num_children` int(11) DEFAULT NULL,
  `pan_number` varchar(15) NOT NULL,
  `service_tax_number` varchar(20) NOT NULL,
  `census_code` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_personal_detail_6340c63c` (`user_id`),
  CONSTRAINT `user_id_refs_id_9cf27c48` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_personal_detail`
--

LOCK TABLES `user_personal_detail` WRITE;
/*!40000 ALTER TABLE `user_personal_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_personal_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_shop_detail`
--

DROP TABLE IF EXISTS `user_shop_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_shop_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `address_id` int(11) DEFAULT NULL,
  `years_working` int(11) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `owner` varchar(30) NOT NULL,
  `is_rented` tinyint(1) NOT NULL,
  `footfall` int(11) DEFAULT NULL,
  `number_of_employees` int(11) DEFAULT NULL,
  `debit_card_accept` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_shop_detail_6340c63c` (`user_id`),
  KEY `user_shop_detail_3ac8a70a` (`address_id`),
  CONSTRAINT `address_id_refs_id_d15ef82e` FOREIGN KEY (`address_id`) REFERENCES `user_location` (`id`),
  CONSTRAINT `user_id_refs_id_cf145eb4` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_shop_detail`
--

LOCK TABLES `user_shop_detail` WRITE;
/*!40000 ALTER TABLE `user_shop_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_shop_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_shop_timing`
--

DROP TABLE IF EXISTS `user_shop_timing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_shop_timing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL,
  `opening_time` varchar(10) NOT NULL,
  `closing_time` varchar(10) NOT NULL,
  `lunch_time` varchar(10) NOT NULL,
  `weekly_day_off` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_shop_timing_74d4252d` (`shop_id`),
  CONSTRAINT `shop_id_refs_id_feeb3c38` FOREIGN KEY (`shop_id`) REFERENCES `user_shop_detail` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_shop_timing`
--

LOCK TABLES `user_shop_timing` WRITE;
/*!40000 ALTER TABLE `user_shop_timing` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_shop_timing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_sms_log`
--

DROP TABLE IF EXISTS `user_sms_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_sms_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tracking_id` int(11) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `to_cell` varchar(13) NOT NULL,
  `response_text` varchar(500) NOT NULL,
  `channel_user_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `status` int(11) DEFAULT NULL,
  `delivered_at` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_sms_log_ce05d275` (`tracking_id`),
  KEY `user_sms_log_8005e431` (`activity_id`),
  CONSTRAINT `activity_id_refs_id_70d7fba2` FOREIGN KEY (`activity_id`) REFERENCES `user_activity` (`id`),
  CONSTRAINT `tracking_id_refs_id_972f92b1` FOREIGN KEY (`tracking_id`) REFERENCES `user_tracking` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_sms_log`
--

LOCK TABLES `user_sms_log` WRITE;
/*!40000 ALTER TABLE `user_sms_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_sms_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_sysuser`
--

DROP TABLE IF EXISTS `user_sysuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_sysuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `user_type_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_sysuser_6340c63c` (`user_id`),
  KEY `user_sysuser_f96a0352` (`user_type_id`),
  CONSTRAINT `user_id_refs_id_13386943` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `user_type_id_refs_id_57bd2748` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_sysuser`
--

LOCK TABLES `user_sysuser` WRITE;
/*!40000 ALTER TABLE `user_sysuser` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_sysuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tracking`
--

DROP TABLE IF EXISTS `user_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_tracking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `tracking_type_id` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  `location_id` int(11) NOT NULL,
  `tracking_ref_id` int(11) DEFAULT NULL,
  `latitude` decimal(8,5) DEFAULT NULL,
  `longitude` decimal(8,5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_tracking_6340c63c` (`user_id`),
  KEY `user_tracking_91a3dae1` (`tracking_type_id`),
  KEY `user_tracking_afbb987d` (`location_id`),
  KEY `user_tracking_5a9dd73b` (`tracking_ref_id`),
  CONSTRAINT `location_id_refs_id_8086b78d` FOREIGN KEY (`location_id`) REFERENCES `user_location` (`id`),
  CONSTRAINT `tracking_ref_id_refs_id_ee7e7c4b` FOREIGN KEY (`tracking_ref_id`) REFERENCES `user_tracking` (`id`),
  CONSTRAINT `tracking_type_id_refs_id_c35d27ef` FOREIGN KEY (`tracking_type_id`) REFERENCES `user_tracking_type` (`id`),
  CONSTRAINT `user_id_refs_id_9c3543b6` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tracking`
--

LOCK TABLES `user_tracking` WRITE;
/*!40000 ALTER TABLE `user_tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tracking_type`
--

DROP TABLE IF EXISTS `user_tracking_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_tracking_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `descr` varchar(200) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tracking_type`
--

LOCK TABLES `user_tracking_type` WRITE;
/*!40000 ALTER TABLE `user_tracking_type` DISABLE KEYS */;
INSERT INTO `user_tracking_type` VALUES (1,'FOS Check In','Fos reaches certain location',1),(2,'FOS Check Out','FOS leaves a certain location',1);
/*!40000 ALTER TABLE `user_tracking_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_type`
--

DROP TABLE IF EXISTS `user_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `user_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_type_6340c63c` (`user_id`),
  KEY `user_type_f96a0352` (`user_type_id`),
  CONSTRAINT `user_id_refs_id_9a66028b` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `user_type_id_refs_id_c14a2588` FOREIGN KEY (`user_type_id`) REFERENCES `master_user_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_type`
--

LOCK TABLES `user_type` WRITE;
/*!40000 ALTER TABLE `user_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-22 10:42:08
