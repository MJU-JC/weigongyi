-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- �������汾: 5.1.29
-- PHP �汾: 5.2.6

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
  `password` varchar(30)  NOT NULL COMMENT '��¼����',
  `name` varchar(20)  NOT NULL COMMENT '����',
  `gender` varchar(4)  NOT NULL COMMENT '�Ա�',
  `birthDate` varchar(20)  NULL COMMENT '��������',
  `userPhoto` varchar(60)  NOT NULL COMMENT '�û���Ƭ',
  `telephone` varchar(20)  NOT NULL COMMENT '��ϵ�绰',
  `email` varchar(50)  NOT NULL COMMENT '����',
  `address` varchar(80)  NULL COMMENT '��ͥ��ַ',
  `regTime` varchar(20)  NULL COMMENT 'ע��ʱ��',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_activityType` (
  `typeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '�����id',
  `typeName` varchar(20)  NOT NULL COMMENT '���������',
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_activityInfo` (
  `activityId` int(11) NOT NULL AUTO_INCREMENT COMMENT '�id',
  `typeObj` int(11) NOT NULL COMMENT '�����',
  `title` varchar(60)  NOT NULL COMMENT '�����',
  `activityPhoto` varchar(60)  NOT NULL COMMENT '�ͼƬ',
  `content` varchar(5000)  NOT NULL COMMENT '�����',
  `activityTime` varchar(50)  NOT NULL COMMENT '�ʱ��',
  PRIMARY KEY (`activityId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_signUp` (
  `signId` int(11) NOT NULL AUTO_INCREMENT COMMENT '����id',
  `activityObj` int(11) NOT NULL COMMENT '�����Ļ',
  `userObj` varchar(30)  NOT NULL COMMENT '������',
  `signUpVow` varchar(500)  NOT NULL COMMENT '��������',
  `signUpTime` varchar(20)  NULL COMMENT '����ʱ��',
  PRIMARY KEY (`signId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_donation` (
  `donationId` int(11) NOT NULL AUTO_INCREMENT COMMENT '���id',
  `userObj` varchar(30)  NOT NULL COMMENT '�����',
  `donationMoney` float NOT NULL COMMENT '�����',
  `dunationTime` varchar(20)  NULL COMMENT '���ʱ��',
  `dunationMemo` varchar(500)  NULL COMMENT '��ע',
  `sheHeState` varchar(20)  NOT NULL COMMENT '���״̬',
  PRIMARY KEY (`donationId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_leaveword` (
  `leaveWordId` int(11) NOT NULL AUTO_INCREMENT COMMENT '����id',
  `leaveTitle` varchar(80)  NOT NULL COMMENT '���Ա���',
  `leaveContent` varchar(2000)  NOT NULL COMMENT '��������',
  `userObj` varchar(30)  NOT NULL COMMENT '������',
  `leaveTime` varchar(20)  NULL COMMENT '����ʱ��',
  `replyContent` varchar(1000)  NULL COMMENT '����ظ�',
  `replyTime` varchar(20)  NULL COMMENT '�ظ�ʱ��',
  PRIMARY KEY (`leaveWordId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_news` (
  `newsId` int(11) NOT NULL AUTO_INCREMENT COMMENT '����id',
  `title` varchar(80)  NOT NULL COMMENT '���ű���',
  `newClass` varchar(30)  NOT NULL COMMENT '���ŷ���',
  `content` varchar(5000)  NOT NULL COMMENT '��������',
  `publishDate` varchar(20)  NULL COMMENT '����ʱ��',
  PRIMARY KEY (`newsId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_activityInfo ADD CONSTRAINT FOREIGN KEY (typeObj) REFERENCES t_activityType(typeId);
ALTER TABLE t_signUp ADD CONSTRAINT FOREIGN KEY (activityObj) REFERENCES t_activityInfo(activityId);
ALTER TABLE t_signUp ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_donation ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_leaveword ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


