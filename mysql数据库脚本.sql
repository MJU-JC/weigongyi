-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(30)  NOT NULL COMMENT 'user_name',
  `password` varchar(30)  NOT NULL COMMENT '登录密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `userPhoto` varchar(60)  NOT NULL COMMENT '用户照片',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `email` varchar(50)  NOT NULL COMMENT '邮箱',
  `address` varchar(80)  NULL COMMENT '家庭地址',
  `regTime` varchar(20)  NULL COMMENT '注册时间',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_activityType` (
  `typeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '活动类型id',
  `typeName` varchar(20)  NOT NULL COMMENT '活动类型名称',
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_activityInfo` (
  `activityId` int(11) NOT NULL AUTO_INCREMENT COMMENT '活动id',
  `typeObj` int(11) NOT NULL COMMENT '活动类型',
  `title` varchar(60)  NOT NULL COMMENT '活动主题',
  `activityPhoto` varchar(60)  NOT NULL COMMENT '活动图片',
  `content` varchar(5000)  NOT NULL COMMENT '活动内容',
  `activityTime` varchar(50)  NOT NULL COMMENT '活动时间',
  PRIMARY KEY (`activityId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_signUp` (
  `signId` int(11) NOT NULL AUTO_INCREMENT COMMENT '报名id',
  `activityObj` int(11) NOT NULL COMMENT '报名的活动',
  `userObj` varchar(30)  NOT NULL COMMENT '报名人',
  `signUpVow` varchar(500)  NOT NULL COMMENT '报名宣誓',
  `signUpTime` varchar(20)  NULL COMMENT '报名时间',
  PRIMARY KEY (`signId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_donation` (
  `donationId` int(11) NOT NULL AUTO_INCREMENT COMMENT '捐款id',
  `userObj` varchar(30)  NOT NULL COMMENT '捐款人',
  `donationMoney` float NOT NULL COMMENT '捐款金额',
  `dunationTime` varchar(20)  NULL COMMENT '捐款时间',
  `dunationMemo` varchar(500)  NULL COMMENT '捐款备注',
  `sheHeState` varchar(20)  NOT NULL COMMENT '审核状态',
  PRIMARY KEY (`donationId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_leaveword` (
  `leaveWordId` int(11) NOT NULL AUTO_INCREMENT COMMENT '留言id',
  `leaveTitle` varchar(80)  NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000)  NOT NULL COMMENT '留言内容',
  `userObj` varchar(30)  NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20)  NULL COMMENT '留言时间',
  `replyContent` varchar(1000)  NULL COMMENT '管理回复',
  `replyTime` varchar(20)  NULL COMMENT '回复时间',
  PRIMARY KEY (`leaveWordId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_news` (
  `newsId` int(11) NOT NULL AUTO_INCREMENT COMMENT '新闻id',
  `title` varchar(80)  NOT NULL COMMENT '新闻标题',
  `newClass` varchar(30)  NOT NULL COMMENT '新闻分类',
  `content` varchar(5000)  NOT NULL COMMENT '新闻内容',
  `publishDate` varchar(20)  NULL COMMENT '发布时间',
  PRIMARY KEY (`newsId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_activityInfo ADD CONSTRAINT FOREIGN KEY (typeObj) REFERENCES t_activityType(typeId);
ALTER TABLE t_signUp ADD CONSTRAINT FOREIGN KEY (activityObj) REFERENCES t_activityInfo(activityId);
ALTER TABLE t_signUp ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_donation ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_leaveword ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


