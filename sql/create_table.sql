﻿DROP database if EXISTS findmusic;
CREATE DATABASE findmusic DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

use findmusic;

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


#
# Structure for table "hr_best_song"
#

DROP TABLE IF EXISTS `hr_best_song`;
CREATE TABLE `hr_best_song` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `area` varchar(50) DEFAULT NULL COMMENT '地区',
  `cate` varchar(30) DEFAULT NULL COMMENT '种类',
  `singer` varchar(100) DEFAULT NULL COMMENT '歌手',
  `song` varchar(100) DEFAULT NULL COMMENT '歌曲',
  `playurl` varchar(200) DEFAULT NULL COMMENT '播放链接',
  `migu_id` varchar(50) DEFAULT NULL COMMENT '咪咕音乐ID',
  `type` varchar(30) DEFAULT NULL COMMENT '类别',
  `status` varchar(30) DEFAULT NULL COMMENT '状态',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建者',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改者',
  `created_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_modified_date` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_singer` (`singer`),
  KEY `idx_song` (`song`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='推荐音乐表';

#
# Data for table "hr_best_song"
#

INSERT INTO `hr_best_song` VALUES (1,'港台','男','周杰伦','告白气球','http://120.27.157.19/ai-music-repo/港台/男/周杰伦/告白气球.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(2,'港台','男','周杰伦','稻香','http://120.27.157.19/ai-music-repo/港台/男/周杰伦/稻香.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(3,'港台','男','周杰伦','简单爱','http://120.27.157.19/ai-music-repo/港台/男/周杰伦/简单爱.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(4,'港台','男','周杰伦','青花瓷','http://120.27.157.19/ai-music-repo/港台/男/周杰伦/青花瓷.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(5,'港台','男','周杰伦','七里香','http://120.27.157.19/ai-music-repo/港台/男/周杰伦/七里香.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(6,'港台','男','周杰伦','蒲公英的约定','http://120.27.157.19/ai-music-repo/港台/男/周杰伦/蒲公英的约定.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(7,'内地','男','薛之谦','演员','http://120.27.157.19/ai-music-repo/内地/男/薛之谦/演员.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(8,'内地','男','薛之谦','方圆几里','http://120.27.157.19/ai-music-repo/内地/男/薛之谦/方圆几里.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(9,'内地','男','薛之谦','丑八怪','http://120.27.157.19/ai-music-repo/内地/男/薛之谦/丑八怪.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(10,'内地','男','薛之谦','哑巴','http://120.27.157.19/ai-music-repo/内地/男/薛之谦/哑巴.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(11,'内地','男','薛之谦','刚刚好','http://120.27.157.19/ai-music-repo/内地/男/薛之谦/刚刚好.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(12,'内地','男','薛之谦','你还要我怎样','http://120.27.157.19/ai-music-repo/内地/男/薛之谦/你还要我怎样.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(13,'内地','男','薛之谦','绅士','http://120.27.157.19/ai-music-repo/内地/男/薛之谦/绅士.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(14,'港台','女','田馥甄','你就不要想起我','http://120.27.157.19/ai-music-repo/港台/女/田馥甄/你就不要想起我.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(15,'港台','女','田馥甄','魔鬼中的天使','http://120.27.157.19/ai-music-repo/港台/女/田馥甄/魔鬼中的天使.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(16,'港台','女','田馥甄','小幸运','http://120.27.157.19/ai-music-repo/港台/女/田馥甄/小幸运.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(17,'港台','男','林俊杰','她说','http://120.27.157.19/ai-music-repo/港台/男/林俊杰/她说.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(18,'港台','男','林俊杰','可惜没如果','http://120.27.157.19/ai-music-repo/港台/男/林俊杰/可惜没如果.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(19,'港台','男','林俊杰','修炼爱情','http://120.27.157.19/ai-music-repo/港台/男/林俊杰/修炼爱情.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(20,'内地','男','毛不易','消愁','http://120.27.157.19/ai-music-repo/内地/男/毛不易/消愁.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(21,'内地','男','毛不易','盛夏','http://120.27.157.19/ai-music-repo/内地/男/毛不易/盛夏.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(22,'内地','男','李荣浩','老街','http://120.27.157.19/ai-music-repo/内地/男/李荣浩/老街.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(23,'内地','男','李荣浩','李白','http://120.27.157.19/ai-music-repo/内地/男/李荣浩/李白.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(24,'港台','男','陈奕迅','浮夸','http://120.27.157.19/ai-music-repo/港台/男/陈奕迅/浮夸.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(25,'港台','男','陈奕迅','红玫瑰','http://120.27.157.19/ai-music-repo/港台/男/陈奕迅/红玫瑰.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(26,'港台','男','陈奕迅','好久不见','http://120.27.157.19/ai-music-repo/港台/男/陈奕迅/好久不见.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(27,'港台','男','陈奕迅','爱情转移','http://120.27.157.19/ai-music-repo/港台/男/陈奕迅/爱情转移.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(28,'内地','男','汪苏泷','一笑倾城','http://120.27.157.19/ai-music-repo/内地/男/汪苏泷/一笑倾城.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(29,'内地','男','汪苏泷','小星星','http://120.27.157.19/ai-music-repo/内地/男/汪苏泷/小星星.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(30,'内地','男','汪苏泷','不分手的恋爱','http://120.27.157.19/ai-music-repo/内地/男/汪苏泷/不分手的恋爱.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(31,'港台','女','邓紫棋','我的秘密','http://120.27.157.19/ai-music-repo/港台/女/邓紫棋/我的秘密.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(32,'港台','女','邓紫棋','泡沫','http://120.27.157.19/ai-music-repo/港台/女/邓紫棋/泡沫.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(33,'港台','女','萧亚轩','类似爱情','http://120.27.157.19/ai-music-repo/港台/女/萧亚轩/类似爱情.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(34,'内地','女','陈粒','易燃易爆炸','http://120.27.157.19/ai-music-repo/内地/女/陈粒/易燃易爆炸.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(35,'内地','女','陈粒','奇妙能力歌','http://120.27.157.19/ai-music-repo/内地/女/陈粒/奇妙能力歌.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(36,'内地','男','许嵩','有何不可','http://120.27.157.19/ai-music-repo/内地/男/许嵩/有何不可.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(37,'内地','男','许嵩','山水之间','http://120.27.157.19/ai-music-repo/内地/男/许嵩/山水之间.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(38,'内地','男','赵雷','成都','http://120.27.157.19/ai-music-repo/内地/男/赵雷/成都.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(39,'港台','男','杨宗纬','凉凉','http://120.27.157.19/ai-music-repo/港台/男/杨宗纬/凉凉.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(40,'港台','男','杨宗纬','一次就好','http://120.27.157.19/ai-music-repo/港台/男/杨宗纬/一次就好.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(41,'内地','组合','房东的猫','秋酿','http://120.27.157.19/ai-music-repo/内地/组合/房东的猫/秋酿.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(42,'内地','组合','房东的猫','云烟成雨','http://120.27.157.19/ai-music-repo/内地/组合/房东的猫/云烟成雨.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(43,'内地','男','华晨宇','齐天','http://120.27.157.19/ai-music-repo/内地/男/华晨宇/齐天.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(44,'港台','组合','五月天','后来的我们','http://120.27.157.19/ai-music-repo/港台/组合/五月天/后来的我们.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(45,'港台','组合','五月天','倔强','http://120.27.157.19/ai-music-repo/港台/组合/五月天/倔强.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(46,'港台','组合','五月天','突然好想你','http://120.27.157.19/ai-music-repo/港台/组合/五月天/突然好想你.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(47,'港台','组合','五月天','好好','http://120.27.157.19/ai-music-repo/港台/组合/五月天/好好.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(48,'港台','组合','五月天','成名在望','http://120.27.157.19/ai-music-repo/港台/组合/五月天/成名在望.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(49,'港台','组合','五月天','黑暗骑士','http://120.27.157.19/ai-music-repo/港台/组合/五月天/黑暗骑士.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(50,'内地','男','朴树','平凡之路','http://120.27.157.19/ai-music-repo/内地/男/朴树/平凡之路.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(51,'内地','男','朴树','白桦林','http://120.27.157.19/ai-music-repo/内地/男/朴树/白桦林.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(52,'内地','男','任然','空空如也','http://120.27.157.19/ai-music-repo/内地/男/任然/空空如也.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(53,'内地','男','李玉刚','刚好遇见你','http://120.27.157.19/ai-music-repo/内地/男/李玉刚/刚好遇见你.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(54,'内地','女','金玟岐','岁月神偷','http://120.27.157.19/ai-music-repo/内地/女/金玟岐/岁月神偷.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(55,'内地','女','王菲','匆匆那年','http://120.27.157.19/ai-music-repo/内地/女/王菲/匆匆那年.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(56,'内地','女','王菲','红豆','http://120.27.157.19/ai-music-repo/内地/女/王菲/红豆.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(57,'内地','女','王菲','因为爱情','http://120.27.157.19/ai-music-repo/内地/女/王菲/因为爱情.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(58,'港台','女','莫文蔚','慢慢喜欢你','http://120.27.157.19/ai-music-repo/港台/女/莫文蔚/慢慢喜欢你.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(59,'港台','女','莫文蔚','阴天','http://120.27.157.19/ai-music-repo/港台/女/莫文蔚/阴天.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(60,'港台','女','莫文蔚','盛夏的果实','http://120.27.157.19/ai-music-repo/港台/女/莫文蔚/盛夏的果实.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(61,'内地','女','刘瑞琦','房间','http://120.27.157.19/ai-music-repo/内地/女/刘瑞琦/房间.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(62,'内地','男','徐良','后会无期','http://120.27.157.19/ai-music-repo/内地/男/徐良/后会无期.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(63,'内地','男','李健','贝加尔湖畔','http://120.27.157.19/ai-music-repo/内地/男/李健/贝加尔湖畔.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(64,'港台','男','林宥嘉','说谎','http://120.27.157.19/ai-music-repo/港台/男/林宥嘉/说谎.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(65,'港台','男','林宥嘉','浪费','http://120.27.157.19/ai-music-repo/港台/男/林宥嘉/浪费.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(66,'港台','男','林宥嘉','成全','http://120.27.157.19/ai-music-repo/港台/男/林宥嘉/成全.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(67,'港台','女','张芸京','偏爱','http://120.27.157.19/ai-music-repo/港台/女/张芸京/偏爱.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(68,'港台','女','张芸京','情人结','http://120.27.157.19/ai-music-repo/港台/女/张芸京/情人结.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(69,'内地','男','胡夏','夏至未至','http://120.27.157.19/ai-music-repo/内地/男/胡夏/夏至未至.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(70,'内地','女','丁当','我爱他','http://120.27.157.19/ai-music-repo/内地/女/丁当/我爱他.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(71,'内地','组合','牛奶咖啡','明天你好','http://120.27.157.19/ai-music-repo/内地/组合/牛奶咖啡/明天你好.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(72,'港台','组合','苏打绿','我好想你','http://120.27.157.19/ai-music-repo/港台/组合/苏打绿/我好想你.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(73,'港台','组合','苏打绿','小情歌','http://120.27.157.19/ai-music-repo/港台/组合/苏打绿/小情歌.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(74,'港台','组合','苏打绿','无与伦比的美丽','http://120.27.157.19/ai-music-repo/港台/组合/苏打绿/无与伦比的美丽.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(75,'港台','女','蔡健雅','达尔文','http://120.27.157.19/ai-music-repo/港台/女/蔡健雅/达尔文.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(76,'港台','女','蔡健雅','红色高跟鞋','http://120.27.157.19/ai-music-repo/港台/女/蔡健雅/红色高跟鞋.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(77,'港台','女','蔡健雅','若你碰到他','http://120.27.157.19/ai-music-repo/港台/女/蔡健雅/若你碰到他.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(78,'内地','女','李宇春','下个路口见','http://120.27.157.19/ai-music-repo/内地/女/李宇春/下个路口见.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(79,'港台','男','陈小春','独家记忆','http://120.27.157.19/ai-music-repo/港台/男/陈小春/独家记忆.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(80,'内地','男','周深','大鱼','http://120.27.157.19/ai-music-repo/内地/男/周深/大鱼.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(81,'港台','女','阿肆','世界上的另一个我','http://120.27.157.19/ai-music-repo/港台/女/阿肆/世界上的另一个我.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(82,'港台','女','阿肆','致姗姗来迟的你','http://120.27.157.19/ai-music-repo/港台/女/阿肆/致姗姗来迟的你.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(83,'港台','男','李宗盛','山丘','http://120.27.157.19/ai-music-repo/港台/男/李宗盛/山丘.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(84,'内地','男','马頔','南山南','http://120.27.157.19/ai-music-repo/内地/男/马頔/南山南.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(85,'内地','组合','好妹妹','你曾是少年','http://120.27.157.19/ai-music-repo/内地/组合/好妹妹/你曾是少年.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(86,'内地','组合','黑豹乐队','无地自容','http://120.27.157.19/ai-music-repo/内地/组合/黑豹乐队/无地自容.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(87,'内地','组合','唐朝','梦回唐朝','http://120.27.157.19/ai-music-repo/内地/组合/唐朝/梦回唐朝.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(88,'内地','组合','痛仰乐队','公路之歌','http://120.27.157.19/ai-music-repo/内地/组合/痛仰乐队/公路之歌.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(89,'内地','组合','痛仰乐队','再见杰克','http://120.27.157.19/ai-music-repo/内地/组合/痛仰乐队/再见杰克.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(90,'内地','组合','反光镜乐队','还我蔚蓝','http://120.27.157.19/ai-music-repo/内地/组合/反光镜乐队/还我蔚蓝.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(91,'内地','组合','反光镜乐队','嘿姑娘','http://120.27.157.19/ai-music-repo/内地/组合/反光镜乐队/嘿姑娘.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(92,'内地','女','jam','七月上','http://120.27.157.19/ai-music-repo/内地/女/jam/七月上.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(93,'内地','女','谢春花','借我','http://120.27.157.19/ai-music-repo/内地/女/谢春花/借我.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(94,'内地','女','岑宁儿','追光者','http://120.27.157.19/ai-music-repo/内地/女/岑宁儿/追光者.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(95,'内地','男','马良','往后余生','http://120.27.157.19/ai-music-repo/内地/男/马良/往后余生.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(96,'港台','女','许哲佩','气球','http://120.27.157.19/ai-music-repo/港台/女/许哲佩/气球.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(97,'内地','组合','扭曲机器','镜子中','http://120.27.157.19/ai-music-repo/内地/组合/扭曲机器/镜子中.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(98,'港台','女','陈绮贞','我喜欢上你时的内心活动 ','http://120.27.157.19/ai-music-repo/港台/女/陈绮贞/我喜欢上你时的内心活动 .m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(99,'港台','女','陈绮贞','旅行的意义','http://120.27.157.19/ai-music-repo/港台/女/陈绮贞/旅行的意义.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(100,'港台','女','杨千嬅','再见二丁目','http://120.27.157.19/ai-music-repo/港台/女/杨千嬅/再见二丁目.m4a',NULL,'cloud',NULL,NULL,NULL,NULL,NULL),(301,NULL,NULL,'周杰伦','告白气球',NULL,'60054704037','migu',NULL,NULL,NULL,NULL,NULL),(302,NULL,NULL,'周杰伦','稻香',NULL,'60054702010','migu',NULL,NULL,NULL,NULL,NULL),(303,NULL,NULL,'周杰伦','青花瓷',NULL,'60054701991','migu',NULL,NULL,NULL,NULL,NULL),(304,NULL,NULL,'周杰伦','七里香',NULL,'60054701934','migu',NULL,NULL,NULL,NULL,NULL),(305,NULL,NULL,'薛之谦','演员',NULL,'60084600638','migu',NULL,NULL,NULL,NULL,NULL),(306,NULL,NULL,'薛之谦','丑八怪',NULL,'60058623081','migu',NULL,NULL,NULL,NULL,NULL),(307,NULL,NULL,'薛之谦','你还要我怎样',NULL,'60058623085','migu',NULL,NULL,NULL,NULL,NULL),(308,NULL,NULL,'薛之谦','绅士',NULL,'60084600633','migu',NULL,NULL,NULL,NULL,NULL),(309,NULL,NULL,'田馥甄','你就不要想起我',NULL,'63793700804','migu',NULL,NULL,NULL,NULL,NULL),(310,NULL,NULL,'田馥甄','小幸运',NULL,'63793702465','migu',NULL,NULL,NULL,NULL,NULL),(311,NULL,NULL,'林俊杰','她说',NULL,'60058622891','migu',NULL,NULL,NULL,NULL,NULL),(312,NULL,NULL,'林俊杰','可惜没如果',NULL,'6005750V8CP','migu',NULL,NULL,NULL,NULL,NULL),(313,NULL,NULL,'陈奕迅','浮夸',NULL,'60075020337','migu',NULL,NULL,NULL,NULL,NULL),(314,NULL,NULL,'陈奕迅','红玫瑰',NULL,'60075095236','migu',NULL,NULL,NULL,NULL,NULL),(315,NULL,NULL,'陈奕迅','好久不见',NULL,'69910401107','migu',NULL,NULL,NULL,NULL,NULL),(316,NULL,NULL,'汪苏泷','一笑倾城',NULL,'69540400405','migu',NULL,NULL,NULL,NULL,NULL),(317,NULL,NULL,'汪苏泷','不分手的恋爱',NULL,'60078701344','migu',NULL,NULL,NULL,NULL,NULL),(318,NULL,NULL,'邓紫棋','泡沫',NULL,'63273401482','migu',NULL,NULL,NULL,NULL,NULL),(319,NULL,NULL,'萧亚轩','类似爱情',NULL,'60074972886','migu',NULL,NULL,NULL,NULL,NULL),(320,NULL,NULL,'许嵩','有何不可',NULL,'60084600375','migu',NULL,NULL,NULL,NULL,NULL),(321,NULL,NULL,'赵雷','成都',NULL,'69906700546','migu',NULL,NULL,NULL,NULL,NULL),(322,NULL,NULL,'杨宗纬','凉凉',NULL,'69910706717','migu',NULL,NULL,NULL,NULL,NULL),(323,NULL,NULL,'房东的猫','秋酿',NULL,'63291002307','migu',NULL,NULL,NULL,NULL,NULL),(324,NULL,NULL,'房东的猫','云烟成雨',NULL,'63291002315','migu',NULL,NULL,NULL,NULL,NULL),(325,NULL,NULL,'五月天','倔强',NULL,'63480214292','migu',NULL,NULL,NULL,NULL,NULL),(326,NULL,NULL,'五月天','突然好想你',NULL,'64049300173','migu',NULL,NULL,NULL,NULL,NULL),(327,NULL,NULL,'李玉刚','刚好遇见你',NULL,'63254101638','migu',NULL,NULL,NULL,NULL,NULL),(328,NULL,NULL,'金玟岐','岁月神偷',NULL,'6006550DHA0','migu',NULL,NULL,NULL,NULL,NULL),(329,NULL,NULL,'王菲','匆匆那年',NULL,'64381300001','migu',NULL,NULL,NULL,NULL,NULL),(330,NULL,NULL,'王菲','因为爱情',NULL,'60056699027','migu',NULL,NULL,NULL,NULL,NULL),(331,NULL,NULL,'莫文蔚','阴天',NULL,'63480205336','migu',NULL,NULL,NULL,NULL,NULL),(332,NULL,NULL,'莫文蔚','盛夏的果实',NULL,'63378003151','migu',NULL,NULL,NULL,NULL,NULL),(333,NULL,NULL,'刘瑞琦','房间',NULL,'64394800006','migu',NULL,NULL,NULL,NULL,NULL),(334,NULL,NULL,'徐良','后会无期',NULL,'60078701518','migu',NULL,NULL,NULL,NULL,NULL),(335,NULL,NULL,'李健','贝加尔湖畔',NULL,'6005751EG3J','migu',NULL,NULL,NULL,NULL,NULL),(336,NULL,NULL,'林宥嘉','说谎',NULL,'63793701614','migu',NULL,NULL,NULL,NULL,NULL),(337,NULL,NULL,'张芸京','偏爱',NULL,'6005751EDXK','migu',NULL,NULL,NULL,NULL,NULL),(338,NULL,NULL,'牛奶咖啡','明天你好',NULL,'64381000361','migu',NULL,NULL,NULL,NULL,NULL),(339,NULL,NULL,'苏打绿','我好想你',NULL,'6005660A1GS','migu',NULL,NULL,NULL,NULL,NULL),(340,NULL,NULL,'蔡健雅','红色高跟鞋',NULL,'60057702036','migu',NULL,NULL,NULL,NULL,NULL),(341,NULL,NULL,'李宇春','下个路口见',NULL,'60084641673','migu',NULL,NULL,NULL,NULL,NULL),(342,NULL,NULL,'陈小春','独家记忆',NULL,'60075024107','migu',NULL,NULL,NULL,NULL,NULL),(343,NULL,NULL,'阿肆','世界上的另一个我',NULL,'69917702808','migu',NULL,NULL,NULL,NULL,NULL),(344,NULL,NULL,'阿肆','致姗姗来迟的你',NULL,'60076256095','migu',NULL,NULL,NULL,NULL,NULL),(345,NULL,NULL,'李宗盛','山丘',NULL,'60070101130','migu',NULL,NULL,NULL,NULL,NULL),(346,NULL,NULL,'马頔','南山南',NULL,'69917703228','migu',NULL,NULL,NULL,NULL,NULL),(347,NULL,NULL,'反光镜乐队','还我蔚蓝',NULL,'60065558596','migu',NULL,NULL,NULL,NULL,NULL),(348,NULL,NULL,'马良','往后余生',NULL,'63254103179','migu',NULL,NULL,NULL,NULL,NULL),(349,NULL,NULL,'陈绮贞','旅行的意义',NULL,'63880600235','migu',NULL,NULL,NULL,NULL,NULL),(350,NULL,NULL,'杨千嬅','再见二丁目',NULL,'60075012139','migu',NULL,NULL,NULL,NULL,NULL);

-- update hr_best_song set type='cloud' where id <=100;
-- update hr_best_song set type='migu' where type is null;
-- update hr_best_song set playurl = concat('http://120.27.157.19/ai-music-repo/',ifnull(area,''),'/',ifnull(cate,''),'/',singer,'/',song,'.m4a') where type='cloud';
