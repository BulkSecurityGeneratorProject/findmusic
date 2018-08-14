
#
# Structure for table "jhi_authority"
#

CREATE TABLE `jhi_authority` (
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "jhi_authority"
#

INSERT INTO `jhi_authority` VALUES ('ROLE_ADMIN'),('ROLE_USER');


#
# Structure for table "jhi_persistent_audit_event"
#

CREATE TABLE `jhi_persistent_audit_event` (
  `event_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `principal` varchar(100) NOT NULL,
  `event_date` timestamp NULL DEFAULT NULL,
  `event_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `idx_persistent_audit_event` (`principal`,`event_date`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

#
# Data for table "jhi_persistent_audit_event"
#

INSERT INTO `jhi_persistent_audit_event` VALUES (1,'admin','2018-03-23 18:01:54','AUTHENTICATION_SUCCESS'),(2,'admin','2018-03-23 18:35:53','AUTHENTICATION_SUCCESS'),(3,'admin','2018-03-23 18:37:59','AUTHENTICATION_SUCCESS'),(4,'admin','2018-03-23 19:03:12','AUTHENTICATION_SUCCESS'),(5,'admin','2018-03-26 18:21:33','AUTHENTICATION_SUCCESS'),(6,'admin','2018-03-27 10:20:41','AUTHENTICATION_SUCCESS'),(7,'admin','2018-03-27 10:37:22','AUTHENTICATION_SUCCESS'),(8,'admin','2018-03-27 14:56:14','AUTHENTICATION_SUCCESS'),(9,'admin','2018-03-27 15:16:51','AUTHENTICATION_SUCCESS'),(10,'admin','2018-03-28 11:07:49','AUTHENTICATION_SUCCESS');



CREATE TABLE `jhi_persistent_audit_evt_data` (
  `event_id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`event_id`,`name`),
  KEY `idx_persistent_audit_evt_data` (`event_id`),
  CONSTRAINT `fk_evt_pers_audit_evt_data` FOREIGN KEY (`event_id`) REFERENCES `jhi_persistent_audit_event` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `jhi_social_user_connection` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `provider_id` varchar(255) NOT NULL,
  `provider_user_id` varchar(255) NOT NULL,
  `rank` bigint(20) NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `profile_url` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `access_token` varchar(255) NOT NULL,
  `secret` varchar(255) DEFAULT NULL,
  `refresh_token` varchar(255) DEFAULT NULL,
  `expire_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`provider_id`,`provider_user_id`),
  UNIQUE KEY `user_id_2` (`user_id`,`provider_id`,`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "jhi_social_user_connection"
#



#
# Structure for table "jhi_user"
#

CREATE TABLE `jhi_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `login` varchar(100) NOT NULL,
  `password_hash` varchar(60) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `image_url` varchar(256) DEFAULT NULL,
  `activated` bit(1) NOT NULL,
  `lang_key` varchar(6) DEFAULT NULL,
  `activation_key` varchar(20) DEFAULT NULL,
  `reset_key` varchar(20) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reset_date` timestamp NULL DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_user_login` (`login`),
  UNIQUE KEY `idx_user_login` (`login`),
  UNIQUE KEY `ux_user_email` (`email`),
  UNIQUE KEY `idx_user_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

#
# Data for table "jhi_user"
#

INSERT INTO `jhi_user` VALUES (1,'system','$2a$10$mE.qmcV0mFU5NcKh73TZx.z4ueI/.bDWbj0T1BYyqP481kGGarKLG','System','System','system@localhost','',b'1','en',NULL,NULL,'system','2018-03-23 11:18:39',NULL,'system',NULL),(2,'anonymoususer','$2a$10$j8S5d7Sr7.8VTOYNviDPOeWX8KcYILUVJBsYV83Y5NtECayypx9lO','Anonymous','User','anonymous@localhost','',b'1','en',NULL,NULL,'system','2018-03-23 11:18:39',NULL,'system',NULL),(3,'admin','$2a$10$gSAhZrxMllrbgj/kkK9UceBPpChGWJA7SYIb1Mqo.n5aNLq1/oRrC','Administrator','Administrator','admin@localhost','',b'1','en',NULL,NULL,'system','2018-03-23 11:18:39',NULL,'system',NULL),(4,'user','$2a$10$VEjxo0jq2YG9Rbk2HmX9S.k1uZBGYUHdUcid3g/vfiEl7lwWgOH/K','User','User','user@localhost','',b'1','en',NULL,NULL,'system','2018-03-23 11:18:39',NULL,'system',NULL),(5,'test','$2a$10$zjE8xokIb131yibbydQbU.DuVPEneEjGlnWK2Wts/e/VZa.VQb3YW','test','test','test@test.com',NULL,b'1','en',NULL,'06557647426655101865','admin','2018-03-23 17:52:20','2018-03-23 17:52:20','admin','2018-03-23 17:52:40');



#
# Structure for table "jhi_user_authority"
#

CREATE TABLE `jhi_user_authority` (
  `user_id` bigint(20) NOT NULL,
  `authority_name` varchar(50) NOT NULL,
  PRIMARY KEY (`user_id`,`authority_name`),
  KEY `fk_authority_name` (`authority_name`),
  CONSTRAINT `fk_authority_name` FOREIGN KEY (`authority_name`) REFERENCES `jhi_authority` (`name`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `jhi_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "jhi_user_authority"
#

INSERT INTO `jhi_user_authority` VALUES (1,'ROLE_ADMIN'),(1,'ROLE_USER'),(3,'ROLE_ADMIN'),(3,'ROLE_USER'),(4,'ROLE_USER'),(5,'ROLE_USER');

