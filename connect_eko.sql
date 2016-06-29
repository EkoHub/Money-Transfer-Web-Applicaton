-- MySQL dump 10.13  Distrib 5.6.27, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: connect_demo
-- ------------------------------------------------------
-- Server version	5.6.27-0ubuntu0.14.04.1

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
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add site',6,'add_site'),(17,'Can change site',6,'change_site'),(18,'Can delete site',6,'delete_site'),(19,'Can add log entry',7,'add_logentry'),(20,'Can change log entry',7,'change_logentry'),(21,'Can delete log entry',7,'delete_logentry'),(40,'Can add personal_ detail',14,'add_personal_detail'),(41,'Can change personal_ detail',14,'change_personal_detail'),(42,'Can delete personal_ detail',14,'delete_personal_detail'),(49,'Can add cellnumber_ detail',17,'add_cellnumber_detail'),(50,'Can change cellnumber_ detail',17,'change_cellnumber_detail'),(51,'Can delete cellnumber_ detail',17,'delete_cellnumber_detail'),(55,'Can add type',19,'add_type'),(56,'Can change type',19,'change_type'),(57,'Can delete type',19,'delete_type'),(61,'Can add login_ data',21,'add_login_data'),(62,'Can change login_ data',21,'change_login_data'),(63,'Can delete login_ data',21,'delete_login_data'),(64,'Can add agent',22,'add_agent'),(65,'Can change agent',22,'change_agent'),(66,'Can delete agent',22,'delete_agent'),(67,'Can add official_ detail',23,'add_official_detail'),(68,'Can change official_ detail',23,'change_official_detail'),(69,'Can delete official_ detail',23,'delete_official_detail'),(73,'Can add transaction_ cellnumber',25,'add_transaction_cellnumber'),(74,'Can change transaction_ cellnumber',25,'change_transaction_cellnumber'),(75,'Can delete transaction_ cellnumber',25,'delete_transaction_cellnumber'),(76,'Can add migration history',26,'add_migrationhistory'),(77,'Can change migration history',26,'change_migrationhistory'),(78,'Can delete migration history',26,'delete_migrationhistory'),(79,'Can add bank',27,'add_bank'),(80,'Can change bank',27,'change_bank'),(81,'Can delete bank',27,'delete_bank'),(103,'Can add agent_ type',35,'add_agent_type'),(104,'Can change agent_ type',35,'change_agent_type'),(105,'Can delete agent_ type',35,'delete_agent_type'),(112,'Can add cellnumber_ type',38,'add_cellnumber_type'),(113,'Can change cellnumber_ type',38,'change_cellnumber_type'),(114,'Can delete cellnumber_ type',38,'delete_cellnumber_type'),(118,'Can add transaction_ type',40,'add_transaction_type'),(119,'Can change transaction_ type',40,'change_transaction_type'),(120,'Can delete transaction_ type',40,'delete_transaction_type'),(133,'Can add bank_ transaction_ mapping',45,'add_bank_transaction_mapping'),(134,'Can change bank_ transaction_ mapping',45,'change_bank_transaction_mapping'),(135,'Can delete bank_ transaction_ mapping',45,'delete_bank_transaction_mapping'),(142,'Can add bank_ detail',48,'add_bank_detail'),(143,'Can change bank_ detail',48,'change_bank_detail'),(144,'Can delete bank_ detail',48,'delete_bank_detail'),(148,'Can add user_ type',50,'add_user_type'),(149,'Can change user_ type',50,'change_user_type'),(150,'Can delete user_ type',50,'delete_user_type'),(160,'Can add bank_ mapping',54,'add_bank_mapping'),(161,'Can change bank_ mapping',54,'change_bank_mapping'),(162,'Can delete bank_ mapping',54,'delete_bank_mapping'),(166,'Can add request_ log',56,'add_request_log'),(167,'Can change request_ log',56,'change_request_log'),(168,'Can delete request_ log',56,'delete_request_log'),(169,'Can add response_ log',57,'add_response_log'),(170,'Can change response_ log',57,'change_response_log'),(171,'Can delete response_ log',57,'delete_response_log'),(172,'Can add access attempt',58,'add_accessattempt'),(173,'Can change access attempt',58,'change_accessattempt'),(174,'Can delete access attempt',58,'delete_accessattempt'),(175,'Can add access log',59,'add_accesslog'),(176,'Can change access log',59,'change_accesslog'),(177,'Can delete access log',59,'delete_accesslog'),(178,'Can add follow',60,'add_follow'),(179,'Can change follow',60,'change_follow'),(180,'Can delete follow',60,'delete_follow'),(181,'Can add action',61,'add_action'),(182,'Can change action',61,'change_action'),(183,'Can delete action',61,'delete_action');
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
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$10000$OkAAru5WgvLS$0lyxY+YPs3lypurMEyc1PI1LuzGwxFGeXK5tKcvptWw=','2016-06-27 17:24:01',1,'kunal','','','',1,1,'2016-06-21 17:20:44'),(2,'pbkdf2_sha256$10000$4llYTZ7msdgH$AF/olscLMKWhOnfjRiqPlMQcnMof2gGxwzsk0Olt2HA=','2016-06-27 20:01:46',0,'6726152721','Siddharth','Jandial','',0,1,'2016-06-21 17:38:45');
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
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'content type','contenttypes','contenttype'),(5,'session','sessions','session'),(6,'site','sites','site'),(7,'log entry','admin','logentry'),(14,'personal_ detail','user','personal_detail'),(17,'cellnumber_ detail','user','cellnumber_detail'),(19,'type','user','type'),(21,'login_ data','user','login_data'),(22,'agent','agent','agent'),(23,'official_ detail','agent','official_detail'),(25,'transaction_ cellnumber','agent','transaction_cellnumber'),(26,'migration history','south','migrationhistory'),(27,'bank','master','bank'),(35,'agent_ type','master','agent_type'),(38,'cellnumber_ type','master','cellnumber_type'),(40,'transaction_ type','master','transaction_type'),(45,'bank_ transaction_ mapping','master','bank_transaction_mapping'),(48,'bank_ detail','master','bank_detail'),(50,'user_ type','master','user_type'),(54,'bank_ mapping','transaction','bank_mapping'),(56,'request_ log','transaction','request_log'),(57,'response_ log','transaction','response_log'),(58,'access attempt','axes','accessattempt'),(59,'access log','axes','accesslog'),(60,'follow','actstream','follow'),(61,'action','actstream','action');
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
INSERT INTO `django_session` VALUES ('0sz0vu7ah3j9xhkx46eslv7ti2ek17r2','Yjk3ZGJjZmZjZDNmOGI2MzQzNjZlOWNhZjliNTIyOGMyM2M2OWQzYjqAAn1xAShYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAlUNX2F1dGhfdXNlcl9pZIoBAlUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHUu','2016-06-24 17:12:39'),('3tdxxua5m7mt1rj5auzcslglah1pd49u','NGNiYzIzZmQ1YWM2YjEzNGNhZmVjZTg3MTBlYjExMWVmMjU3YTI5MDqAAn1xAShVEl9hdXRoX3VzZXJfYmFja2VuZFUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmRVDV9hdXRoX3VzZXJfaWSKAQJYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAnUu','2016-06-27 14:04:23'),('446jip1k9ny67sksk7cu4j1g7jsh77xp','ODU5MTRhNTMwNDE4NTYwMjZkZjdkMTJlNWNkZjBjYjI2M2Y0MmMyNzqAAn1xAS4=','2016-07-06 11:33:51'),('4wx2baysggi61ys2tqhkv50nhjjqsik8','NGNiYzIzZmQ1YWM2YjEzNGNhZmVjZTg3MTBlYjExMWVmMjU3YTI5MDqAAn1xAShVEl9hdXRoX3VzZXJfYmFja2VuZFUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmRVDV9hdXRoX3VzZXJfaWSKAQJYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAnUu','2016-06-24 19:00:46'),('6bkn1bjv2chorh9mfjpnq88pcjqnwqzg','NjFkMThlOTFlYmUyOGRhMDM4YTE3YjQ4MTBjZWQyZjhjZmZjYmNlOTqAAn1xAShYCgAAAHRlc3Rjb29raWVxAlgGAAAAd29ya2VkcQNYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAnUu','2016-06-27 18:07:43'),('6fxnl8h11xa2biiblzs5yq2ce7z9bdf4','YmZmMmYxZDJjNTg0OTdlYTZkNGI2ZDAyYWIyM2Y5MGIxNTkyZGNkMTqAAn1xAShYCgAAAHRlc3Rjb29raWVxAlgGAAAAd29ya2VkcQNYDwAAAF9zZXNzaW9uX2V4cGlyeXEETVgCdS4=','2016-06-21 19:17:39'),('86pkd74jxz2gzz4wwiblguqcbs6oy1cu','NjFkMThlOTFlYmUyOGRhMDM4YTE3YjQ4MTBjZWQyZjhjZmZjYmNlOTqAAn1xAShYCgAAAHRlc3Rjb29raWVxAlgGAAAAd29ya2VkcQNYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAnUu','2016-06-27 12:47:15'),('8uli7ckao8j17ozpkgm280sy317mo8jg','NTYyOTM0ZDcwNWQ4NGI1NWM3NGVkNjczYzhjYzRkYjNmNzM4MzAyZjqAAn1xAShVEl9hdXRoX3VzZXJfYmFja2VuZFUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmRVDV9hdXRoX3VzZXJfaWSKAQFYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAnUu','2016-06-27 12:20:48'),('9jcekk7i6qqoonrm0t2or8maanmxoc92','N2EyNDgwMjU2OTI2ZWQ1ODY5NTc5NjAxZjYwNTBiNGIzMmJiYzkwMDqAAn1xAVgPAAAAX3Nlc3Npb25fZXhwaXJ5TVgCcy4=','2016-06-22 11:51:24'),('9qxyqte0d4iqsbvbz2yitf8islw1gvj6','Yjk3ZGJjZmZjZDNmOGI2MzQzNjZlOWNhZjliNTIyOGMyM2M2OWQzYjqAAn1xAShYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAlUNX2F1dGhfdXNlcl9pZIoBAlUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHUu','2016-06-27 13:26:39'),('aj83q72hn59qm524i9634hj3kxdwu2xa','Yjk3ZGJjZmZjZDNmOGI2MzQzNjZlOWNhZjliNTIyOGMyM2M2OWQzYjqAAn1xAShYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAlUNX2F1dGhfdXNlcl9pZIoBAlUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHUu','2016-06-27 15:43:50'),('b85u0irn12vcd8fvqu2t18bnnqdb2y9x','Yzc5ZDMwYzM3Y2NjOGQxZWRmZThlNTAzYzIzM2Y3NjVhYzNmYzM4NjqAAn1xAShYCgAAAHRlc3Rjb29raWVYBgAAAHdvcmtlZFgPAAAAX3Nlc3Npb25fZXhwaXJ5TVgCdS4=','2016-06-24 15:58:23'),('cdybt04njdiw9v9r1aqs4j7et6prnqj4','NGNiYzIzZmQ1YWM2YjEzNGNhZmVjZTg3MTBlYjExMWVmMjU3YTI5MDqAAn1xAShVEl9hdXRoX3VzZXJfYmFja2VuZFUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmRVDV9hdXRoX3VzZXJfaWSKAQJYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAnUu','2016-06-27 13:33:12'),('d1phgoh5z9hgxu9o1i92wo9mumn3plra','ODU5MTRhNTMwNDE4NTYwMjZkZjdkMTJlNWNkZjBjYjI2M2Y0MmMyNzqAAn1xAS4=','2016-07-05 20:03:25'),('djw0vdvq0z4dljhyq6f774c06k2tvtbm','ODU5MTRhNTMwNDE4NTYwMjZkZjdkMTJlNWNkZjBjYjI2M2Y0MmMyNzqAAn1xAS4=','2016-07-05 22:38:39'),('ekquyp8mej8mvu114ym3aa2epme4yc5i','NzgxZjRjMTNhYTdmZThmMjEwN2MyOWI3NTNmOTI1NDM1ZjhiYjcyNTqAAn1xAShYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAlUNX2F1dGhfdXNlcl9pZIoBAVUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHUu','2016-06-27 15:16:15'),('iteawwe5dz4qlfjnkhfs03wrsrb0n94k','NGNiYzIzZmQ1YWM2YjEzNGNhZmVjZTg3MTBlYjExMWVmMjU3YTI5MDqAAn1xAShVEl9hdXRoX3VzZXJfYmFja2VuZFUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmRVDV9hdXRoX3VzZXJfaWSKAQJYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAnUu','2016-06-24 16:42:57'),('jzpnob0im216k0g6lumf58b9b22hzk87','NGNiYzIzZmQ1YWM2YjEzNGNhZmVjZTg3MTBlYjExMWVmMjU3YTI5MDqAAn1xAShVEl9hdXRoX3VzZXJfYmFja2VuZFUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmRVDV9hdXRoX3VzZXJfaWSKAQJYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAnUu','2016-06-27 12:53:20'),('keplebtgzqrs97b9qdwonz9fc3te4r9j','ODU5MTRhNTMwNDE4NTYwMjZkZjdkMTJlNWNkZjBjYjI2M2Y0MmMyNzqAAn1xAS4=','2016-07-11 17:57:25'),('khr8p78anfijjnnikqlnmh8ws1w0kkz2','Yjk3ZGJjZmZjZDNmOGI2MzQzNjZlOWNhZjliNTIyOGMyM2M2OWQzYjqAAn1xAShYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAlUNX2F1dGhfdXNlcl9pZIoBAlUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHUu','2016-06-22 19:00:08'),('kn7vocw2rs2a16cchk58scb8pnhp3a4v','Yjk3ZGJjZmZjZDNmOGI2MzQzNjZlOWNhZjliNTIyOGMyM2M2OWQzYjqAAn1xAShYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAlUNX2F1dGhfdXNlcl9pZIoBAlUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHUu','2016-06-27 17:34:21'),('lp3ew7p1r5i8weyn4t3l9mphw8x1va4l','NzgxZjRjMTNhYTdmZThmMjEwN2MyOWI3NTNmOTI1NDM1ZjhiYjcyNTqAAn1xAShYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAlUNX2F1dGhfdXNlcl9pZIoBAVUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHUu','2016-06-27 15:32:04'),('m498x79zjrmqdo4mvbqc4qn74eqtimyy','NzgxZjRjMTNhYTdmZThmMjEwN2MyOWI3NTNmOTI1NDM1ZjhiYjcyNTqAAn1xAShYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAlUNX2F1dGhfdXNlcl9pZIoBAVUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHUu','2016-06-21 19:01:23'),('oeajmko0zasw1opgq9lddkfawk536y5g','NzgxZjRjMTNhYTdmZThmMjEwN2MyOWI3NTNmOTI1NDM1ZjhiYjcyNTqAAn1xAShYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAlUNX2F1dGhfdXNlcl9pZIoBAVUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHUu','2016-06-24 17:01:30'),('ra8w40k14i8ugj72w9twm54brq2mituw','ODU5MTRhNTMwNDE4NTYwMjZkZjdkMTJlNWNkZjBjYjI2M2Y0MmMyNzqAAn1xAS4=','2016-07-08 16:30:52'),('toaj9vy2r8pikk33t9ekm880ohr95lwm','ODU5MTRhNTMwNDE4NTYwMjZkZjdkMTJlNWNkZjBjYjI2M2Y0MmMyNzqAAn1xAS4=','2016-07-08 17:30:34'),('u7a1sdj7n6knzh9d5ucvn01tgpai4qe7','NzgxZjRjMTNhYTdmZThmMjEwN2MyOWI3NTNmOTI1NDM1ZjhiYjcyNTqAAn1xAShYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAlUNX2F1dGhfdXNlcl9pZIoBAVUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHUu','2016-06-24 15:42:05'),('ucgd3tvnwyccbtrpv7q0df44nj0wb766','NGNiYzIzZmQ1YWM2YjEzNGNhZmVjZTg3MTBlYjExMWVmMjU3YTI5MDqAAn1xAShVEl9hdXRoX3VzZXJfYmFja2VuZFUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmRVDV9hdXRoX3VzZXJfaWSKAQJYDwAAAF9zZXNzaW9uX2V4cGlyeU1YAnUu','2016-06-24 16:42:37'),('wpb6u0e75slse1l4g47mz5bivcx8j7j3','ODU5MTRhNTMwNDE4NTYwMjZkZjdkMTJlNWNkZjBjYjI2M2Y0MmMyNzqAAn1xAS4=','2016-07-11 20:02:39');
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
  `request_text` varchar(500) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=453 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_request_log`
--

LOCK TABLES `transaction_request_log` WRITE;
/*!40000 ALTER TABLE `transaction_request_log` DISABLE KEYS */;
INSERT INTO `transaction_request_log` VALUES (1,2,2,2,12,6726152721,'123','2016-06-21 17:56:32',NULL),(2,2,2,2,12,6726152721,'123','2016-06-21 17:58:38',NULL),(3,2,2,2,12,6726152721,'123','2016-06-21 18:00:41',NULL),(4,2,2,2,3,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-21 18:00:51',21651466512251194),(5,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-21 18:00:53',21651466512253685),(6,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-21 18:00:54',21651466512254595),(7,2,2,2,12,6726152721,'123','2016-06-21 18:06:34',NULL),(8,2,2,2,3,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-21 18:06:43',21651466512603776),(9,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-21 18:06:44',21651466512604352),(10,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-21 18:06:45',21651466512605180),(11,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients/recipient_id','2016-06-21 18:06:52',21651466512612567),(12,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'100\', \'recipie','2016-06-21 18:07:51',21651466512671863),(13,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-21 18:07:53',21651466512673158),(14,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-21 18:07:59',21651466512679077),(15,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'100\', \'recipie','2016-06-21 18:16:45',21651466513205789),(16,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'100\', \'recipie','2016-06-21 18:17:15',21651466513235297),(17,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-21 18:17:16',21651466513236246),(18,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-21 18:17:17',21651466513237080),(19,2,2,2,3,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8427511775{}{\'initiator_id\': u\'672','2016-06-21 18:18:01',21651466513281327),(20,2,2,2,4,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8427511775{\'initiator_id\': u\'67261','2016-06-21 18:18:10',21651466513290984),(21,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/verification/otp:621{\'initiator_id\': u\'672615272','2016-06-21 18:18:25',21651466513305159),(22,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8427511775/recipients{}{\'initiator','2016-06-21 18:18:26',21651466513306032),(23,2,2,2,10,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8427511775{}{\'initiator_id\': u\'672','2016-06-21 18:18:26',21651466513306736),(24,2,2,2,12,6726152721,'123','2016-06-21 18:22:10',NULL),(25,2,2,2,12,6726152721,'123','2016-06-21 19:10:00',NULL),(26,2,2,2,6,6726152721,'okekeyinfo','2016-06-21 19:10:01',21651466516401217),(27,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 19:10:37',21651466516437758),(28,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128/recipients{}{\'initiator','2016-06-21 19:10:38',21651466516438632),(29,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 19:10:39',21651466516439052),(30,2,2,2,12,6726152721,'123','2016-06-21 19:19:01',NULL),(31,2,2,2,6,6726152721,'okekeyinfo','2016-06-21 19:19:02',21651466516942283),(32,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 19:19:10',21651466516950938),(33,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128/recipients{}{\'initiator','2016-06-21 19:19:11',21651466516951640),(34,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 19:19:11',21651466516951974),(35,2,2,2,12,6726152721,'123','2016-06-21 19:26:11',NULL),(36,2,2,2,6,6726152721,'okekeyinfo','2016-06-21 19:26:12',21651466517372138),(37,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 19:26:18',21651466517378104),(38,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128/recipients{}{\'initiator','2016-06-21 19:26:18',21651466517378967),(39,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 19:26:19',21651466517379465),(40,2,2,2,12,6726152721,'123','2016-06-21 19:28:12',NULL),(41,2,2,2,6,6726152721,'okekeyinfo','2016-06-21 19:28:13',21651466517493388),(42,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 19:28:19',21651466517499907),(43,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128/recipients{}{\'initiator','2016-06-21 19:28:20',21651466517500410),(44,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 19:28:20',21651466517500762),(45,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128/recipients/recipient_id','2016-06-21 19:28:25',21651466517505511),(46,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 19:28:32',21651466517512318),(47,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 19:28:35',21651466517515764),(48,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 19:28:40',21651466517520738),(49,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 19:28:43',21651466517523617),(50,2,2,2,1,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions/1246512{}{\'initiator_id\': \'mobile_number:6726','2016-06-21 19:30:14',21651466517614811),(51,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:32:12',21651466517732492),(52,2,2,2,16,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{\'initiator_id\': u\'67261','2016-06-21 19:32:17',21651466517737741),(53,2,2,2,12,6726152721,'123','2016-06-21 19:32:46',NULL),(54,2,2,2,6,6726152721,'okekeyinfo','2016-06-21 19:32:46',21651466517766583),(55,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:32:55',21651466517775017),(56,2,2,2,3,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/verification/otp:982{\'initiator_id\': u\'672615272','2016-06-21 19:33:16',21651466517796405),(57,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 19:33:16',21651466517796979),(58,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:33:17',21651466517797331),(59,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 19:33:22',21651466517802480),(60,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks/ifsc:SBIN/accounts/20178905203{\'initiator_id\': u\'672','2016-06-21 19:34:13',21651466517853864),(61,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients/acc_ifsc:201','2016-06-21 19:34:34',21651466517874539),(62,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 19:34:35',21651466517875107),(63,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:34:35',21651466517875463),(64,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients/recipient_id','2016-06-21 19:34:40',21651466517880170),(65,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'100\', \'recipie','2016-06-21 19:35:14',21651466517914005),(66,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 19:35:15',21651466517915205),(67,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:35:15',21651466517915595),(68,2,2,2,1,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions/12469474{}{\'initiator_id\': \'mobile_number:672','2016-06-21 19:35:25',21651466517925433),(69,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'100\', \'recipie','2016-06-21 19:40:20',21651466518220820),(70,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 19:40:22',21651466518222150),(71,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:40:22',21651466518222583),(72,2,2,2,1,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions/12469474{}{\'initiator_id\': \'mobile_number:672','2016-06-21 19:42:10',21651466518330046),(73,2,2,2,12,6726152721,'123','2016-06-21 19:50:18',NULL),(74,2,2,2,6,6726152721,'okekeyinfo','2016-06-21 19:50:19',21651466518819586),(75,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9474972128{}{\'initiator_id\': u\'672','2016-06-21 19:50:26',21651466518826192),(76,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:50:37',21651466518837944),(77,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 19:50:38',21651466518838623),(78,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:50:39',21651466518839158),(79,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-21 19:52:04',21651466518924419),(80,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-21 19:52:17',21651466518937893),(81,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 19:52:18',21651466518938572),(82,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 19:52:19',21651466518939007),(83,2,2,2,1,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions/12469494{}{\'initiator_id\': \'mobile_number:672','2016-06-21 19:52:54',21651466518974230),(84,2,2,2,12,6726152721,'123','2016-06-21 22:23:48',NULL),(85,2,2,2,6,6726152721,'okekeyinfo','2016-06-21 22:23:50',21651466528030418),(86,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 22:23:58',21651466528038667),(87,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128/recipients{}{\'initiator','2016-06-21 22:24:04',21651466528044833),(88,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9464972128{}{\'initiator_id\': u\'672','2016-06-21 22:24:06',21651466528046600),(89,2,2,2,12,6726152721,'123','2016-06-21 22:29:41',NULL),(90,2,2,2,6,6726152721,'okekeyinfo','2016-06-21 22:29:43',21651466528383946),(91,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 22:29:52',21651466528392569),(92,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 22:29:57',21651466528397133),(93,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 22:29:58',21651466528398773),(94,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 22:30:45',21651466528445474),(95,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 22:30:56',21651466528456099),(96,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 22:31:01',21651466528461704),(97,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 22:31:09',21651466528469864),(98,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 22:31:20',21651466528480315),(99,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 22:33:23',21651466528603055),(100,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 22:33:33',21651466528613267),(101,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients/recipient_id','2016-06-21 22:33:40',21651466528620686),(102,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 22:34:05',21651466528645647),(103,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks/ifsc:SBIN/accounts/20178905203{\'initiator_id\': u\'672','2016-06-21 22:35:01',21651466528701488),(104,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 22:35:04',21651466528704585),(105,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 22:35:06',21651466528706706),(106,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 22:35:15',21651466528715446),(107,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks/ifsc:SBIN/accounts/20178905243{\'initiator_id\': u\'672','2016-06-21 22:35:28',21651466528728622),(108,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients/acc_ifsc:201','2016-06-21 22:36:05',21651466528765458),(109,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 22:36:29',21651466528789608),(110,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 22:36:33',21651466528793209),(111,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-21 22:37:16',21651466528836583),(112,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428/recipients{}{\'initiator','2016-06-21 22:37:22',21651466528842846),(113,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8437143428{}{\'initiator_id\': u\'672','2016-06-21 22:37:25',21651466528845390),(114,2,2,2,1,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions/12469536{}{\'initiator_id\': \'mobile_number:672','2016-06-21 22:37:53',21651466528873206),(115,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8427511775{}{\'initiator_id\': u\'672','2016-06-21 22:38:18',21651466528898100),(116,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8427511775/recipients{}{\'initiator','2016-06-21 22:38:20',21651466528900917),(117,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:8427511775{}{\'initiator_id\': u\'672','2016-06-21 22:38:23',21651466528903271),(118,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-21 22:38:30',21651466528910515),(119,2,2,2,12,6726152721,'123','2016-06-22 11:33:24',NULL),(120,2,2,2,6,6726152721,'okekeyinfo','2016-06-22 11:33:25',21651466575405645),(121,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 11:33:36',21651466575416547),(122,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 11:33:44',21651466575424792),(123,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 11:33:45',21651466575425256),(124,2,2,2,12,6726152721,'123','2016-06-22 17:46:50',NULL),(125,2,2,2,6,6726152721,'okekeyinfo','2016-06-22 17:47:43',21651466597863347),(126,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 17:47:58',21651466597878350),(127,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 17:48:00',21651466597880354),(128,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 17:48:01',21651466597881055),(129,2,2,2,12,6726152721,'123','2016-06-22 17:48:31',NULL),(130,2,2,2,6,6726152721,'okekeyinfo','2016-06-22 17:48:32',21651466597912048),(131,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 17:48:36',21651466597916662),(132,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 17:48:37',21651466597917351),(133,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 17:48:38',21651466597918178),(134,2,2,2,12,6726152721,'123','2016-06-22 17:50:05',NULL),(135,2,2,2,6,6726152721,'okekeyinfo','2016-06-22 17:50:06',21651466598006417),(136,2,2,2,12,6726152721,'123','2016-06-22 17:55:08',NULL),(137,2,2,2,6,6726152721,'okekeyinfo','2016-06-22 17:55:09',21651466598309204),(138,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 17:55:13',21651466598313981),(139,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 17:55:14',21651466598314708),(140,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 17:55:15',21651466598315071),(141,2,2,2,12,6726152721,'123','2016-06-22 17:56:30',NULL),(142,2,2,2,6,6726152721,'okekeyinfo','2016-06-22 17:56:31',21651466598391358),(143,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 17:56:36',21651466598396311),(144,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 17:56:37',21651466598397183),(145,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 17:56:37',21651466598397501),(146,2,2,2,12,6726152721,'123','2016-06-22 17:57:58',NULL),(147,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 17:58:04',21651466598484864),(148,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 17:58:05',21651466598485601),(149,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 17:58:05',21651466598485961),(150,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'1\', \'recipient','2016-06-22 17:58:10',21651466598490535),(151,2,2,2,12,6726152721,'123','2016-06-22 17:59:28',NULL),(152,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 17:59:46',21651466598586648),(153,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 17:59:47',21651466598587353),(154,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 17:59:47',21651466598587742),(155,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'1\', \'recipient','2016-06-22 17:59:52',21651466598592709),(156,2,2,2,12,6726152721,'123','2016-06-22 18:02:55',NULL),(157,2,2,2,6,6726152721,'okekeyinfo','2016-06-22 18:02:55',21651466598775405),(158,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:02:59',21651466598779136),(159,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 18:02:59',21651466598779832),(160,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:03:00',21651466598780190),(161,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'1\', \'recipient','2016-06-22 18:03:15',21651466598795786),(162,2,2,2,12,6726152721,'123','2016-06-22 18:03:38',NULL),(163,2,2,2,6,6726152721,'okekeyinfo','2016-06-22 18:03:39',21651466598819562),(164,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:03:42',21651466598822452),(165,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 18:03:42',21651466598822862),(166,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:03:43',21651466598823292),(167,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'100\', \'recipie','2016-06-22 18:03:49',21651466598829184),(168,2,2,2,12,6726152721,'123','2016-06-22 18:04:44',NULL),(169,2,2,2,6,6726152721,'okekeyinfo','2016-06-22 18:04:44',21651466598884929),(170,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:04:48',21651466598888169),(171,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 18:04:48',21651466598888623),(172,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:04:48',21651466598888986),(173,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'50\', \'recipien','2016-06-22 18:04:56',21651466598896180),(174,2,2,2,12,6726152721,'123','2016-06-22 18:05:37',NULL),(175,2,2,2,6,6726152721,'okekeyinfo','2016-06-22 18:05:38',21651466598938217),(176,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:07:29',21651466599049523),(177,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 18:07:30',21651466599050077),(178,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:07:30',21651466599050427),(179,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'1\', \'recipient','2016-06-22 18:07:35',21651466599055057),(180,2,2,2,12,6726152721,'123','2016-06-22 18:12:26',NULL),(181,2,2,2,6,6726152721,'okekeyinfo','2016-06-22 18:12:28',21651466599348573),(182,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:13:18',21651466599398712),(183,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 18:13:19',21651466599399517),(184,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:13:19',21651466599399927),(185,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'50\', \'recipien','2016-06-22 18:13:31',21651466599411176),(186,2,2,2,12,6726152721,'123','2016-06-22 18:14:38',NULL),(187,2,2,2,6,6726152721,'okekeyinfo','2016-06-22 18:14:39',21651466599479017),(188,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:14:47',21651466599487572),(189,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 18:14:47',21651466599487962),(190,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:14:48',21651466599488359),(191,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'100\', \'recipie','2016-06-22 18:14:57',21651466599497162),(192,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 18:14:57',21651466599497874),(193,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:14:58',21651466599498198),(194,2,2,2,12,6726152721,'123','2016-06-22 18:20:19',NULL),(195,2,2,2,6,6726152721,'okekeyinfo','2016-06-22 18:20:20',21651466599820503),(196,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:20:29',21651466599829933),(197,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 18:20:30',21651466599830829),(198,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:20:31',21651466599831137),(199,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'1\', \'recipient','2016-06-22 18:20:38',21651466599838426),(200,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'50\', \'recipien','2016-06-22 18:20:47',21651466599847374),(201,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 18:20:48',21651466599848909),(202,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:20:49',21651466599849212),(203,2,2,2,12,6726152721,'123','2016-06-22 18:26:08',NULL),(204,2,2,2,6,6726152721,'okekeyinfo','2016-06-22 18:26:09',21651466600169518),(205,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:26:18',21651466600178784),(206,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 18:26:20',21651466600180171),(207,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:26:21',21651466600181256),(208,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'1\', \'recipient','2016-06-22 18:26:30',21651466600190389),(209,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:26:52',21651466600212769),(210,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 18:26:53',21651466600213440),(211,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:26:54',21651466600214368),(212,2,2,2,12,6726152721,'123','2016-06-22 18:28:47',NULL),(213,2,2,2,6,6726152721,'okekeyinfo','2016-06-22 18:28:48',21651466600328078),(214,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:28:56',21651466600336296),(215,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 18:28:57',21651466600337033),(216,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:28:58',21651466600338124),(217,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'1\', \'recipient','2016-06-22 18:29:05',21651466600345259),(218,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 18:29:06',21651466600346087),(219,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:29:06',21651466600346562),(220,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-22 18:29:13',21651466600353666),(221,2,2,2,12,6726152721,'123','2016-06-22 18:42:28',NULL),(222,2,2,2,6,6726152721,'okekeyinfo','2016-06-22 18:42:45',21651466601165828),(223,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:44:55',21651466601295548),(224,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 18:44:57',21651466601297110),(225,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:44:57',21651466601297493),(226,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-22 18:45:02',21651466601302794),(227,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'1\', \'recipient','2016-06-22 18:45:13',21651466601313867),(228,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 18:45:14',21651466601314352),(229,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:45:14',21651466601314758),(230,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'1\', \'recipient','2016-06-22 18:47:51',21651466601471588),(231,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-22 18:47:52',21651466601472052),(232,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-22 18:47:52',21651466601472821),(233,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-22 18:48:01',21651466601481791),(234,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-22 18:49:16',21651466601556166),(235,2,2,2,12,6726152721,'123','2016-06-24 15:31:18',NULL),(236,2,2,2,6,6726152721,'okekeyinfo','2016-06-24 15:32:19',21651466762539414),(237,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-24 15:32:26',21651466762546412),(238,2,2,2,12,6726152721,'123','2016-06-24 15:37:38',NULL),(239,2,2,2,6,6726152721,'okekeyinfo','2016-06-24 15:37:39',21651466762859198),(240,2,2,2,12,6726152721,'123','2016-06-24 15:44:47',NULL),(241,2,2,2,12,6726152721,'123','2016-06-24 15:46:26',NULL),(242,2,2,2,12,6726152721,'123','2016-06-24 15:46:34',NULL),(243,2,2,2,12,6726152721,'123','2016-06-24 16:10:05',NULL),(244,2,2,2,6,6726152721,'okekeyinfo','2016-06-24 16:10:06',21651466764806470),(245,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-24 16:10:11',21651466764811799),(246,2,2,2,12,6726152721,'123','2016-06-24 16:16:55',NULL),(247,2,2,2,6,6726152721,'okekeyinfo','2016-06-24 16:16:55',21651466765215519),(248,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-24 16:17:06',21651466765226752),(249,2,2,2,12,6726152721,'123','2016-06-24 16:21:07',NULL),(250,2,2,2,6,6726152721,'okekeyinfo','2016-06-24 16:21:08',21651466765468899),(251,2,2,2,12,6726152721,'123','2016-06-24 16:25:21',NULL),(252,2,2,2,6,6726152721,'okekeyinfo','2016-06-24 16:25:22',21651466765722452),(253,2,2,2,12,6726152721,'123','2016-06-24 16:25:41',NULL),(254,2,2,2,6,6726152721,'okekeyinfo','2016-06-24 16:25:42',21651466765742361),(255,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-24 16:25:46',21651466765746296),(256,2,2,2,12,6726152721,'123','2016-06-24 16:27:11',NULL),(257,2,2,2,6,6726152721,'okekeyinfo','2016-06-24 16:27:12',21651466765832412),(258,2,2,2,12,6726152721,'123','2016-06-24 16:31:27',NULL),(259,2,2,2,12,6726152721,'123','2016-06-24 16:32:15',NULL),(260,2,2,2,12,6726152721,'123','2016-06-24 16:32:41',NULL),(261,2,2,2,6,6726152721,'okekeyinfo','2016-06-24 16:32:42',21651466766162455),(262,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-24 16:32:57',21651466766177038),(263,2,2,2,12,6726152721,'123','2016-06-24 16:45:11',NULL),(264,2,2,2,6,6726152721,'okekeyinfo','2016-06-24 16:45:11',21651466766911783),(265,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-24 16:45:17',21651466766917866),(266,2,2,2,12,6726152721,'123','2016-06-24 16:45:47',NULL),(267,2,2,2,6,6726152721,'okekeyinfo','2016-06-24 16:45:47',21651466766947728),(268,2,2,2,12,6726152721,'123','2016-06-24 16:51:55',NULL),(269,2,2,2,6,6726152721,'okekeyinfo','2016-06-24 16:51:58',21651466767318150),(270,2,2,2,12,6726152721,'123','2016-06-24 16:58:01',NULL),(271,2,2,2,6,6726152721,'okekeyinfo','2016-06-24 16:58:02',21651466767682085),(272,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-24 16:58:07',21651466767687788),(273,2,2,2,12,6726152721,'123','2016-06-24 17:02:32',NULL),(274,2,2,2,6,6726152721,'okekeyinfo','2016-06-24 17:02:33',21651466767953999),(275,2,2,2,12,6726152721,'123','2016-06-24 17:30:21',NULL),(276,2,2,2,6,6726152721,'okekeyinfo','2016-06-24 17:30:22',21651466769622214),(277,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-24 17:30:26',21651466769626739),(278,2,2,2,12,6726152721,'123','2016-06-24 18:50:40',NULL),(279,2,2,2,6,6726152721,'okekeyinfo','2016-06-24 18:50:41',21651466774441339),(280,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-24 18:50:45',21651466774445646),(281,2,2,2,12,6726152721,'123','2016-06-27 12:08:51',NULL),(282,2,2,2,12,6726152721,'123','2016-06-27 12:09:48',NULL),(283,2,2,2,6,6726152721,'okekeyinfo','2016-06-27 12:09:59',21651467009599273),(284,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 12:10:56',21651467009656560),(285,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-27 12:11:11',21651467009671858),(286,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 12:11:14',21651467009674597),(287,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9906041299{}{\'initiator_id\': u\'672','2016-06-27 12:11:31',21651467009691265),(288,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532{}{\'initiator_id\': u\'672','2016-06-27 12:11:52',21651467009712959),(289,2,2,2,12,6726152721,'123','2016-06-27 12:13:43',NULL),(290,2,2,2,6,6726152721,'okekeyinfo','2016-06-27 12:13:43',21651467009823996),(291,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532{}{\'initiator_id\': u\'672','2016-06-27 12:13:49',21651467009829661),(292,2,2,2,16,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532{\'initiator_id\': u\'67261','2016-06-27 12:15:05',21651467009905201),(293,2,2,2,16,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532{\'initiator_id\': u\'67261','2016-06-27 12:15:36',21651467009936929),(294,2,2,2,3,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/verification/otp:299{\'initiator_id\': u\'672615272','2016-06-27 12:15:49',21651467009949290),(295,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532/recipients{}{\'initiator','2016-06-27 12:16:18',21651467009978184),(296,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532{}{\'initiator_id\': u\'672','2016-06-27 12:16:30',21651467009990372),(297,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-27 12:16:48',21651467010008160),(298,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-27 12:17:02',21651467010022420),(299,2,2,2,12,6726152721,'123','2016-06-27 12:21:35',NULL),(300,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532{}{\'initiator_id\': u\'672','2016-06-27 12:22:00',21651467010320833),(301,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532/recipients{}{\'initiator','2016-06-27 12:22:03',21651467010323065),(302,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532{}{\'initiator_id\': u\'672','2016-06-27 12:22:03',21651467010323667),(303,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-27 12:22:21',21651467010341724),(304,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks/ifsc:SBIN/accounts/31154882587{\'initiator_id\': u\'672','2016-06-27 12:27:36',21651467010656063),(305,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532/recipients/acc_ifsc:311','2016-06-27 12:30:00',21651467010800552),(306,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532/recipients/acc_ifsc:311','2016-06-27 12:30:26',21651467010826179),(307,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532/recipients{}{\'initiator','2016-06-27 12:30:34',21651467010834165),(308,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532{}{\'initiator_id\': u\'672','2016-06-27 12:30:40',21651467010840513),(309,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'50\', \'recipien','2016-06-27 12:30:49',21651467010849349),(310,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532/recipients{}{\'initiator','2016-06-27 12:31:05',21651467010865686),(311,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532{}{\'initiator_id\': u\'672','2016-06-27 12:31:07',21651467010867520),(312,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532/recipients/recipient_id','2016-06-27 12:31:23',21651467010883937),(313,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532/recipients/recipient_id','2016-06-27 12:31:58',21651467010918935),(314,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532/recipients/recipient_id','2016-06-27 12:34:28',21651467011068694),(315,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'100\', \'recipie','2016-06-27 12:34:47',21651467011087505),(316,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532/recipients{}{\'initiator','2016-06-27 12:34:48',21651467011088793),(317,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532{}{\'initiator_id\': u\'672','2016-06-27 12:34:49',21651467011089707),(318,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9898656532/recipients/recipient_id','2016-06-27 12:36:39',21651467011199631),(319,2,2,2,12,6726152721,'123','2016-06-27 12:42:32',NULL),(320,2,2,2,6,6726152721,'okekeyinfo','2016-06-27 12:42:33',21651467011553465),(321,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 12:42:39',21651467011559155),(322,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-27 12:42:48',21651467011568109),(323,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 12:42:53',21651467011573795),(324,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients/recipient_id','2016-06-27 12:43:03',21651467011583321),(325,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-27 12:43:19',21651467011599363),(326,2,2,2,12,6726152721,'123','2016-06-27 13:16:07',NULL),(327,2,2,2,6,6726152721,'okekeyinfo','2016-06-27 13:16:14',21651467013574074),(328,2,2,2,12,6726152721,'123','2016-06-27 13:16:27',NULL),(329,2,2,2,6,6726152721,'okekeyinfo','2016-06-27 13:16:33',21651467013593446),(330,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 13:16:39',21651467013599262),(331,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 13:17:08',21651467013628062),(332,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 13:17:43',21651467013663066),(333,2,2,2,16,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{\'initiator_id\': u\'67261','2016-06-27 13:18:22',21651467013702282),(334,2,2,2,16,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{\'initiator_id\': u\'67261','2016-06-27 13:18:45',21651467013725191),(335,2,2,2,16,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{\'initiator_id\': u\'67261','2016-06-27 13:19:46',21651467013786115),(336,2,2,2,3,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/verification/otp:780{\'initiator_id\': u\'672615272','2016-06-27 13:20:10',21651467013810808),(337,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953/recipients{}{\'initiator','2016-06-27 13:20:11',21651467013811529),(338,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 13:20:28',21651467013828999),(339,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 13:21:28',21651467013888213),(340,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 13:21:55',21651467013915777),(341,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-27 13:22:27',21651467013947085),(342,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 13:22:47',21651467013967174),(343,2,2,2,12,6726152721,'123','2016-06-27 13:36:33',NULL),(344,2,2,2,6,6726152721,'okekeyinfo','2016-06-27 13:36:38',21651467014798735),(345,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 13:36:48',21651467014808934),(346,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 13:37:17',21651467014837879),(347,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-27 13:37:44',21651467014864734),(348,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 13:37:52',21651467014872115),(349,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-27 13:39:13',21651467014953012),(350,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-27 13:41:50',21651467015110857),(351,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-27 13:46:47',21651467015407604),(352,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-27 13:48:25',21651467015505451),(353,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 13:48:45',21651467015525510),(354,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 13:49:57',21651467015597140),(355,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-27 13:51:06',21651467015666322),(356,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 13:52:38',21651467015758998),(357,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-27 13:53:07',21651467015787761),(358,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-27 13:53:34',21651467015814732),(359,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 13:53:57',21651467015837593),(360,2,2,2,12,6726152721,'123','2016-06-27 14:02:53',NULL),(361,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 14:03:24',21651467016404734),(362,2,2,2,12,6726152721,'123','2016-06-27 14:11:16',NULL),(363,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 14:12:04',21651467016924520),(364,2,2,2,12,6726152721,'123','2016-06-27 14:14:48',NULL),(365,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 14:15:19',21651467017119131),(366,2,2,2,12,6726152721,'123','2016-06-27 14:18:33',NULL),(367,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 14:19:10',21651467017350712),(368,2,2,2,12,6726152721,'123','2016-06-27 14:59:19',NULL),(369,2,2,2,6,6726152721,'okekeyinfo','2016-06-27 14:59:31',21651467019771560),(370,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 14:59:37',21651467019777986),(371,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-27 14:59:39',21651467019779446),(372,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 14:59:39',21651467019779886),(373,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-27 14:59:54',21651467019794257),(374,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator','2016-06-27 14:59:55',21651467019795643),(375,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'672','2016-06-27 14:59:56',21651467019796970),(376,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:00:06',21651467019806763),(377,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953/recipients{}{\'initiator','2016-06-27 15:00:10',21651467019810240),(378,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:00:11',21651467019811050),(379,2,2,2,1,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions/12472058{}{\'initiator_id\': \'mobile_number:672','2016-06-27 15:00:31',21651467019831685),(380,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-27 15:00:47',21651467019847479),(381,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks/ifsc:SBIN/accounts/31154882587{\'initiator_id\': u\'672','2016-06-27 15:01:40',21651467019900759),(382,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:06:51',21651467020211739),(383,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953/recipients{}{\'initiator','2016-06-27 15:06:52',21651467020212675),(384,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:06:52',21651467020212960),(385,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-27 15:06:55',21651467020215701),(386,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks/ifsc:SBIN/accounts/31154882587{\'initiator_id\': u\'672','2016-06-27 15:08:13',21651467020293223),(387,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:09:09',21651467020349125),(388,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953/recipients{}{\'initiator','2016-06-27 15:09:11',21651467020351125),(389,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:09:11',21651467020351495),(390,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-27 15:09:14',21651467020354745),(391,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks/ifsc:sbin/accounts/31154882587{\'initiator_id\': u\'672','2016-06-27 15:09:19',21651467020359388),(392,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:09:54',21651467020394887),(393,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953/recipients{}{\'initiator','2016-06-27 15:09:56',21651467020396354),(394,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:10:05',21651467020405054),(395,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-27 15:10:16',21651467020416243),(396,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:11:31',21651467020491044),(397,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953/recipients{}{\'initiator','2016-06-27 15:11:32',21651467020492854),(398,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:11:33',21651467020493700),(399,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-27 15:11:37',21651467020497209),(400,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks/ifsc:sbin/accounts/20017089211{\'initiator_id\': u\'672','2016-06-27 15:12:24',21651467020544394),(401,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks/ifsc:sbin/accounts/20017089211{\'initiator_id\': u\'672','2016-06-27 15:14:01',21651467020641964),(402,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953/recipients/acc_ifsc:200','2016-06-27 15:14:22',21651467020662901),(403,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953/recipients{}{\'initiator','2016-06-27 15:14:23',21651467020663572),(404,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:14:37',21651467020677541),(405,2,2,2,5,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks{}{\'initiator_id\': \'mobile_number:6726152721\', \'bank_','2016-06-27 15:16:08',21651467020768674),(406,2,2,2,15,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/banks/ifsc:sbin/accounts/20017089211{\'initiator_id\': u\'672','2016-06-27 15:16:19',21651467020779705),(407,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953/recipients{}{\'initiator','2016-06-27 15:16:20',21651467020780532),(408,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:16:21',21651467020781205),(409,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-27 15:16:25',21651467020785606),(410,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953/recipients{}{\'initiator','2016-06-27 15:16:32',21651467020792574),(411,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-27 15:16:38',21651467020798222),(412,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:16:38',21651467020798266),(413,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953/recipients{}{\'initiator','2016-06-27 15:16:39',21651467020799506),(414,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:16:45',21651467020805357),(415,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:19:23',21651467020963962),(416,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:19:48',21651467020988407),(417,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953/recipients{}{\'initiator','2016-06-27 15:19:56',21651467020996883),(418,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:20:18',21651467021018679),(419,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipien','2016-06-27 15:21:16',21651467021076118),(420,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953/recipients{}{\'initiator','2016-06-27 15:21:22',21651467021082612),(421,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9419107953{}{\'initiator_id\': u\'672','2016-06-27 15:21:28',21651467021088621),(422,2,2,2,12,6726152721,'123','2016-06-27 15:29:32',NULL),(423,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 15:30:09',21651467021609155),(424,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 15:30:15',21651467021615256),(425,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 15:30:15',21651467021615779),(426,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 15:30:43',21651467021643416),(427,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 15:30:51',21651467021651237),(428,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 15:31:12',21651467021672076),(429,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipient_id\': 10009150, \'client_ref_id\': \'03:31:57 PM\', \'initiator_id\': u\'6726152721\', \'customer_id\': u\'9888161889\', \'state\': 1, \'channel\': u\'2\'}{}','2016-06-27 15:31:57',21651467021717606),(430,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 15:32:22',21651467021742780),(431,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 15:32:42',21651467021762887),(432,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipient_id\': 10009150, \'client_ref_id\': \'03:32:50 PM\', \'initiator_id\': u\'6726152721\', \'customer_id\': u\'9888161889\', \'state\': 1, \'channel\': u\'2\'}{}','2016-06-27 15:32:50',21651467021770461),(433,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 15:33:02',21651467021782969),(434,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 15:33:23',21651467021803084),(435,2,2,2,12,6726152721,'123','2016-06-27 17:24:20',NULL),(436,2,2,2,6,6726152721,'okekeyinfo','2016-06-27 17:24:21',21651467028461318),(437,2,2,2,12,6726152721,'123','2016-06-27 17:56:41',NULL),(438,2,2,2,6,6726152721,'okekeyinfo','2016-06-27 17:56:42',21651467030402229),(439,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 17:56:46',21651467030406182),(440,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 17:56:49',21651467030409554),(441,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 17:56:51',21651467030411851),(442,2,2,2,11,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients/recipient_id:10009150{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 17:57:05',21651467030425630),(443,2,2,2,12,6726152721,'123','2016-06-27 17:57:21',NULL),(444,2,2,2,6,6726152721,'okekeyinfo','2016-06-27 17:57:21',21651467030441989),(445,2,2,2,12,6726152721,'123','2016-06-27 20:01:54',NULL),(446,2,2,2,6,6726152721,'okekeyinfo','2016-06-27 20:01:55',21651467037915672),(447,2,2,2,2,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 20:01:59',21651467037919847),(448,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 20:02:00',21651467037920876),(449,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 20:02:01',21651467037921387),(450,2,2,2,13,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/transactions{\'currency\': \'INR\', \'amount\': u\'10\', \'recipient_id\': 10009150, \'client_ref_id\': \'08:02:27 PM\', \'initiator_id\': u\'6726152721\', \'customer_id\': u\'9888161889\', \'state\': 1, \'channel\': u\'2\'}{}','2016-06-27 20:02:27',21651467037947679),(451,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889/recipients{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 20:02:28',21651467037948578),(452,2,2,2,14,6726152721,'https://staging.eko.co.in:25004/ekoapi/v1/customers/mobile_number:9888161889{}{\'initiator_id\': u\'6726152721\'}','2016-06-27 20:02:29',21651467037949424);
/*!40000 ALTER TABLE `transaction_request_log` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_response_log`
--

LOCK TABLES `transaction_response_log` WRITE;
/*!40000 ALTER TABLE `transaction_response_log` DISABLE KEYS */;
INSERT INTO `transaction_response_log` VALUES (1,1,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 17:56\nThanks Eko/-\n','2016-06-21 17:56:33'),(2,2,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 17:58\nThanks Eko/-\n','2016-06-21 17:58:38'),(3,3,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 18:00\nThanks Eko/-\n','2016-06-21 18:00:41'),(4,7,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 18:06\nThanks Eko/-\n','2016-06-21 18:06:34'),(5,24,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 18:22\nThanks Eko/-\n','2016-06-21 18:22:11'),(6,25,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 19:10\nThanks Eko/-\n','2016-06-21 19:10:01'),(7,26,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-21 19:10:01'),(8,30,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 19:19\nThanks Eko/-\n','2016-06-21 19:19:02'),(9,31,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-21 19:19:02'),(10,35,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 19:26\nThanks Eko/-\n','2016-06-21 19:26:11'),(11,36,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-21 19:26:12'),(12,40,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 19:28\nThanks Eko/-\n','2016-06-21 19:28:13'),(13,41,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-21 19:28:13'),(14,53,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 19:32\nThanks Eko/-\n','2016-06-21 19:32:46'),(15,54,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-21 19:32:46'),(16,73,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 19:50\nThanks Eko/-\n','2016-06-21 19:50:19'),(17,74,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-21 19:50:19'),(18,84,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 22:23\nThanks Eko/-\n','2016-06-21 22:23:50'),(19,85,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-21 22:23:52'),(20,89,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n21/06/16 22:29\nThanks Eko/-\n','2016-06-21 22:29:43'),(21,90,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-21 22:29:44'),(22,119,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 11:33\nThanks Eko/-\n','2016-06-22 11:33:25'),(23,120,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-22 11:33:31'),(24,124,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 17:47\nThanks Eko/-\n','2016-06-22 17:47:43'),(25,125,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-22 17:47:43'),(26,129,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 17:48\nThanks Eko/-\n','2016-06-22 17:48:31'),(27,130,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-22 17:48:32'),(28,134,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 17:50\nThanks Eko/-\n','2016-06-22 17:50:06'),(29,135,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-22 17:50:06'),(30,136,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 17:55\nThanks Eko/-\n','2016-06-22 17:55:09'),(31,137,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-22 17:55:09'),(32,141,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 17:56\nThanks Eko/-\n','2016-06-22 17:56:31'),(33,142,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-22 17:56:32'),(34,146,6726152721,'Application is not accessible, please try later. Thanks Eko\n','2016-06-22 17:57:58'),(35,151,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 17:59\nThanks Eko/-\n','2016-06-22 17:59:42'),(36,156,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 18:02\nThanks Eko/-\n','2016-06-22 18:02:55'),(37,157,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-22 18:02:55'),(38,162,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 18:03\nThanks Eko/-\n','2016-06-22 18:03:39'),(39,163,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-22 18:03:39'),(40,168,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 18:04\nThanks Eko/-\n','2016-06-22 18:04:44'),(41,169,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-22 18:04:45'),(42,174,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 18:05\nThanks Eko/-\n','2016-06-22 18:05:38'),(43,175,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-22 18:05:38'),(44,180,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 18:12\nThanks Eko/-\n','2016-06-22 18:12:28'),(45,181,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-22 18:12:29'),(46,186,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 18:14\nThanks Eko/-\n','2016-06-22 18:14:38'),(47,187,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-22 18:14:41'),(48,194,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 18:20\nThanks Eko/-\n','2016-06-22 18:20:20'),(49,195,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-22 18:20:20'),(50,203,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 18:26\nThanks Eko/-\n','2016-06-22 18:26:09'),(51,204,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-22 18:26:10'),(52,212,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 18:28\nThanks Eko/-\n','2016-06-22 18:28:47'),(53,213,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-22 18:28:48'),(54,221,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n22/06/16 18:42\nThanks Eko/-\n','2016-06-22 18:42:45'),(55,222,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-22 18:42:46'),(56,235,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 15:32\nThanks Eko/-\n','2016-06-24 15:32:19'),(57,236,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-24 15:32:19'),(58,238,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 15:37\nThanks Eko/-\n','2016-06-24 15:37:38'),(59,239,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-24 15:37:44'),(60,240,6726152721,'Application is not accessible, please try later. Thanks Eko\n','2016-06-24 15:44:47'),(61,241,6726152721,'Application is not accessible, please try later. Thanks Eko\n','2016-06-24 15:46:28'),(62,242,6726152721,'Application is not accessible, please try later. Thanks Eko\n','2016-06-24 15:46:34'),(63,243,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 16:10\nThanks Eko/-\n','2016-06-24 16:10:06'),(64,244,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-24 16:10:06'),(65,246,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 16:16\nThanks Eko/-\n','2016-06-24 16:16:55'),(66,247,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-24 16:16:55'),(67,249,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 16:21\nThanks Eko/-\n','2016-06-24 16:21:08'),(68,250,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-24 16:21:10'),(69,251,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 16:25\nThanks Eko/-\n','2016-06-24 16:25:22'),(70,252,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-24 16:25:22'),(71,253,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 16:25\nThanks Eko/-\n','2016-06-24 16:25:42'),(72,254,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-24 16:25:42'),(73,256,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 16:27\nThanks Eko/-\n','2016-06-24 16:27:12'),(74,257,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-24 16:27:12'),(75,258,6726152721,'Application is not accessible, please try later. Thanks Eko\n','2016-06-24 16:31:27'),(76,259,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 16:32\nThanks Eko/-\n','2016-06-24 16:32:37'),(77,260,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 16:32\nThanks Eko/-\n','2016-06-24 16:32:42'),(78,261,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-24 16:32:42'),(79,263,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 16:45\nThanks Eko/-\n','2016-06-24 16:45:11'),(80,264,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-24 16:45:12'),(81,266,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 16:45\nThanks Eko/-\n','2016-06-24 16:45:47'),(82,267,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-24 16:45:48'),(83,268,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 16:51\nThanks Eko/-\n','2016-06-24 16:51:57'),(84,269,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-24 16:51:58'),(85,270,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 16:58\nThanks Eko/-\n','2016-06-24 16:58:01'),(86,271,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-24 16:58:02'),(87,273,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 17:02\nThanks Eko/-\n','2016-06-24 17:02:33'),(88,274,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-24 17:02:39'),(89,275,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 17:30\nThanks Eko/-\n','2016-06-24 17:30:22'),(90,276,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-24 17:30:22'),(91,278,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n24/06/16 18:50\nThanks Eko/-\n','2016-06-24 18:50:41'),(92,279,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-24 18:50:41'),(93,281,6726152721,NULL,NULL),(94,282,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n27/06/16 12:09\nThanks Eko/-\n','2016-06-27 12:09:59'),(95,283,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-27 12:10:05'),(96,289,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n27/06/16 12:13\nThanks Eko/-\n','2016-06-27 12:13:43'),(97,290,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-27 12:13:44'),(98,299,6726152721,NULL,NULL),(99,319,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n27/06/16 12:42\nThanks Eko/-\n','2016-06-27 12:42:33'),(100,320,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-27 12:42:44'),(101,326,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n27/06/16 13:16\nThanks Eko/-\n','2016-06-27 13:16:13'),(102,328,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n27/06/16 13:16\nThanks Eko/-\n','2016-06-27 13:16:33'),(103,329,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-27 13:16:34'),(104,327,6726152721,NULL,NULL),(105,343,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n27/06/16 13:36\nThanks Eko/-\n','2016-06-27 13:36:38'),(106,344,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-27 13:36:39'),(107,360,6726152721,NULL,NULL),(108,362,6726152721,NULL,NULL),(109,364,6726152721,NULL,NULL),(110,366,6726152721,NULL,NULL),(111,368,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n27/06/16 14:59\nThanks, EKO/-\n','2016-06-27 14:59:31'),(112,369,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks, EKO/-\n','2016-06-27 14:59:33'),(113,422,6726152721,'There was a problem while processing your request. Please try again later. Thanks Eko\n','2016-06-27 15:29:47'),(114,423,6726152721,NULL,NULL),(115,424,6726152721,NULL,NULL),(116,425,6726152721,NULL,NULL),(117,426,6726152721,NULL,NULL),(118,427,6726152721,NULL,NULL),(119,428,6726152721,NULL,NULL),(120,429,6726152721,NULL,NULL),(121,430,6726152721,NULL,NULL),(122,432,6726152721,NULL,NULL),(123,431,6726152721,NULL,NULL),(124,433,6726152721,NULL,NULL),(125,434,6726152721,NULL,NULL),(126,435,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n27/06/16 17:24\nThanks Eko/-\n','2016-06-27 17:24:21'),(127,436,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-27 17:24:21'),(128,437,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n27/06/16 17:56\nThanks Eko/-\n','2016-06-27 17:56:42'),(129,438,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-27 17:56:43'),(130,439,6726152721,NULL,NULL),(131,440,6726152721,NULL,NULL),(132,441,6726152721,NULL,NULL),(133,442,6726152721,NULL,NULL),(134,443,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n27/06/16 17:57\nThanks Eko/-\n','2016-06-27 17:57:21'),(135,444,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-27 17:57:22'),(136,445,6726152721,'Bal:Rs.98857.00\nA/c: 6726152721\nActive Plan: Basic\nLast Okekey: 4\n27/06/16 20:01\nThanks Eko/-\n','2016-06-27 20:01:55'),(137,446,6726152721,'Book Number: 60000140\nTotal OkeKey: 50\nLast Used OkeKey: 4\nThanks Eko/-\n','2016-06-27 20:01:56'),(138,447,6726152721,NULL,NULL),(139,448,6726152721,NULL,NULL),(140,449,6726152721,NULL,NULL),(141,450,6726152721,NULL,NULL),(142,451,6726152721,NULL,NULL),(143,452,6726152721,NULL,NULL);
/*!40000 ALTER TABLE `transaction_response_log` ENABLE KEYS */;
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
INSERT INTO `user_login_data` VALUES (1,1,0,NULL,1,'0dm0wfestgztelcs6wj32vwo30x0g4x9',0),(2,2,0,NULL,0,NULL,0);
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

-- Dump completed on 2016-06-29 11:00:23
