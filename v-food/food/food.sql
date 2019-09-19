-- phpMyAdmin SQL Dump
-- version phpStudy 2014
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2019 �?09 �?17 �?17:06
-- 服务器版本: 5.5.47
-- PHP 版本: 5.5.30

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `food`
--

-- --------------------------------------------------------

--
-- 表的结构 `pre_admin`
--

CREATE TABLE IF NOT EXISTS `pre_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(200) DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `salt` varchar(150) DEFAULT NULL COMMENT '密码盐',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `email` varchar(150) DEFAULT NULL COMMENT '邮箱',
  `register_time` int(11) DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='管理员表' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `pre_admin`
--

INSERT INTO `pre_admin` (`id`, `username`, `password`, `salt`, `avatar`, `email`, `register_time`) VALUES
(5, 'admin', '9e1f29869fecefc025e3c9c4016d6d91', '3579ABHcfm', '', 'email123123123@.com', 1567850356);

-- --------------------------------------------------------

--
-- 表的结构 `pre_cart`
--

CREATE TABLE IF NOT EXISTS `pre_cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `foodid` int(10) unsigned DEFAULT NULL,
  `foodnum` int(10) unsigned DEFAULT NULL,
  `userid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `key_foodid` (`foodid`) USING BTREE,
  KEY `key_userid` (`userid`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT AUTO_INCREMENT=30 ;

--
-- 转存表中的数据 `pre_cart`
--

INSERT INTO `pre_cart` (`id`, `foodid`, `foodnum`, `userid`) VALUES
(29, 4, 1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `pre_coupon`
--

CREATE TABLE IF NOT EXISTS `pre_coupon` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '优惠卷名称',
  `num` int(10) unsigned DEFAULT NULL COMMENT '优惠卷数量',
  `price` decimal(10,2) unsigned DEFAULT NULL COMMENT '优惠卷金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- 转存表中的数据 `pre_coupon`
--

INSERT INTO `pre_coupon` (`id`, `name`, `num`, `price`) VALUES
(13, '端午红包', 3, '15.00'),
(14, '新年红包', 1, '30.00');

-- --------------------------------------------------------

--
-- 表的结构 `pre_coupon_record`
--

CREATE TABLE IF NOT EXISTS `pre_coupon_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned DEFAULT NULL COMMENT '用户id',
  `password` varchar(255) DEFAULT NULL COMMENT '口令',
  `cid` int(10) unsigned DEFAULT NULL COMMENT '优惠卷活动id',
  `status` tinyint(3) unsigned DEFAULT NULL COMMENT '0未使用1已领取2已使用3已过期',
  `createtime` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `coupon_userid` (`userid`) USING BTREE,
  KEY `coupon_cid` (`cid`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='优惠卷使用记录表' AUTO_INCREMENT=11 ;

--
-- 转存表中的数据 `pre_coupon_record`
--

INSERT INTO `pre_coupon_record` (`id`, `userid`, `password`, `cid`, `status`, `createtime`) VALUES
(7, 1, '569BEFHIJNdghkm', 13, 2, 1568510162),
(8, NULL, '3679DEJLadghilm', 13, 0, 1568510162),
(9, NULL, '24678BEKbefhjlm', 13, 0, 1568510162),
(10, 1, '38AGHJKNabcejlm', 14, 3, 1568618350);

-- --------------------------------------------------------

--
-- 表的结构 `pre_food`
--

CREATE TABLE IF NOT EXISTS `pre_food` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `thumb` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `content` text,
  `cateid` int(10) unsigned DEFAULT NULL,
  `flag` enum('hot','new','top') DEFAULT 'new',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `key_cateid` (`cateid`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT AUTO_INCREMENT=56 ;

--
-- 转存表中的数据 `pre_food`
--

INSERT INTO `pre_food` (`id`, `name`, `thumb`, `price`, `content`, `cateid`, `flag`) VALUES
(1, '经典锅塌豆腐2', '/static/upload/banner1.jpg', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 1, 'top'),
(2, '经典锅塌豆腐\n', '/static/upload/banner2.jpg', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 1, 'top'),
(3, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 1, 'top'),
(4, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 1, 'top'),
(5, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 1, 'top'),
(6, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 1, 'hot'),
(7, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 1, 'hot'),
(8, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 1, 'hot'),
(9, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 1, 'hot'),
(10, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 1, 'hot'),
(11, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 2, 'hot'),
(12, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 2, 'hot'),
(13, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 2, 'hot'),
(14, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 2, 'hot'),
(15, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 2, 'hot'),
(16, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 2, 'new'),
(17, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 2, 'new'),
(18, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 2, 'new'),
(19, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 2, 'new'),
(20, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 2, 'new'),
(21, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 3, 'new'),
(22, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 3, 'new'),
(23, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 3, 'new'),
(24, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 3, 'new'),
(25, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 3, 'new'),
(26, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 3, 'new'),
(27, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 3, 'new'),
(28, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 3, 'new'),
(29, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 3, 'new'),
(30, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 3, 'new'),
(31, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(32, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(33, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(34, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(35, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(36, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(37, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(38, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(39, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(40, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(41, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(42, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(43, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(44, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(45, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(46, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(47, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(48, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(49, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(50, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 4, 'new'),
(51, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 6, 'new'),
(52, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 6, 'new'),
(53, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 6, 'new'),
(54, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 6, 'new'),
(55, '经典锅塌豆腐\n', 'https://res1.hoto.cn/02f5f82f59633f0df444eb88.jpg!default', '23.00', '“锅塌”是山东菜独有的一种烹调方法，它可做鱼，也可做肉，还可做豆腐和蔬菜。锅塌豆腐著名山东菜，成菜呈深黄色，外形整齐，入口鲜香,营养丰富。此菜原料层层叠起豆腐经过调料浸渍，蘸蛋液经油煎，加以鸡汤微火塌制，十分入味，豆腐蛋白质丰富，其生理价值比其他植物蛋白质高，可与肉类蛋白质媲美;含钙量也高，且易于吸收;虾子富含钙、磷等，有助于促进骨骼、牙齿、大脑等生长发育，并增强抵抗力，防止佝偻病、肌肉松弛等。', 6, 'new');

-- --------------------------------------------------------

--
-- 表的结构 `pre_foodcate`
--

CREATE TABLE IF NOT EXISTS `pre_foodcate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT AUTO_INCREMENT=17 ;

--
-- 转存表中的数据 `pre_foodcate`
--

INSERT INTO `pre_foodcate` (`id`, `name`) VALUES
(1, '粤菜'),
(2, '川菜'),
(3, '东北菜'),
(4, '咸香'),
(5, '烧烤'),
(6, '烤箱'),
(7, '面食'),
(8, '早餐'),
(9, '午餐'),
(10, '下午茶'),
(11, '水煮'),
(12, '聚会'),
(13, '中秋节'),
(14, '情人节'),
(15, '日本料理'),
(16, '韩国料理');

-- --------------------------------------------------------

--
-- 表的结构 `pre_order`
--

CREATE TABLE IF NOT EXISTS `pre_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ordersn` varchar(255) DEFAULT NULL COMMENT '订单号',
  `createtime` int(10) unsigned DEFAULT NULL COMMENT '下单时间',
  `ordertype` tinyint(255) DEFAULT '0' COMMENT '0立刻 1预约时间',
  `ordertime` int(10) unsigned DEFAULT '0' COMMENT '预约的时间',
  `price` decimal(10,2) DEFAULT NULL COMMENT '总价格',
  `status` int(255) unsigned DEFAULT '0' COMMENT '0 未支付\n1 已支付\n2 已取消\n3 就餐\n4 评价\n5 已完成',
  `content` text COMMENT '订单备注',
  `userid` int(10) unsigned DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `keyorder_userid` (`userid`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单表' AUTO_INCREMENT=37 ;

--
-- 转存表中的数据 `pre_order`
--

INSERT INTO `pre_order` (`id`, `ordersn`, `createtime`, `ordertype`, `ordertime`, `price`, `status`, `content`, `userid`) VALUES
(20, '1357CDEHIJKMabcefghj', 1568172720, 0, 1568172720, '1288.00', 5, '', 1),
(21, '16ACEGIJKLMNcdegijkl', 1568273277, 0, 1568273277, '276.00', 0, '', 1),
(22, '12489ADEFGILMahijklm', 1568273282, 0, 1568273282, '276.00', 5, '外卖小哥甩了头就跑了，不知道一个男的为什么他那么感兴趣', 1),
(23, '2368ABCDFHIJKLbcegij', 1568273431, 0, 1568273431, '184.00', 3, '', 1),
(24, '234678AFGHKLabcdeghm', 1568273506, 0, 1568273506, '322.00', 5, '', 1),
(25, '4578CFGHIKNacdefhjkm', 1568273681, 0, 1568273681, '460.00', 3, '', 1),
(26, '23489CEHJKMbcdghjklm', 1568273904, 0, 1568273904, '230.00', 5, '', 1),
(27, '13589ADEFGHJKdefijkm', 1568280498, 0, 1568280498, '138.00', 5, '', 1),
(28, '1235679BFHLNabdhijkl', 1568353049, 1, 1568908800, '92.00', 3, '', 1),
(29, '1789DEFGHIJKabeghilm', 1568622098, 0, 1568622098, '85.00', 3, '', 1),
(30, '134567CEFIJLMNbefgjl', 1568622942, 0, 1568622942, '31.00', 2, '', 1),
(31, '1578CDFGHKMNbcegijkm', 1568623077, 0, 1568623077, '31.00', 0, '', 1),
(32, '234569ABCDIKLacdghik', 1568623481, 0, 1568623481, '39.00', 0, '', 1),
(33, '1459BDEFHILMNbcefgkl', 1568623509, 0, 1568623509, '69.00', 0, '', 1),
(34, '2569BCDEFHKLadeijklm', 1568623583, 0, 1568623583, '69.00', 1, '', 1),
(35, '378BDEFIJKMbcefhiklm', 1568624124, 0, 1568624124, '23.00', 1, '', 1),
(36, '1345679BFIKMabcegikl', 1568626092, 0, 1568626092, '69.00', 1, '', 1);

-- --------------------------------------------------------

--
-- 表的结构 `pre_order_food`
--

CREATE TABLE IF NOT EXISTS `pre_order_food` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `orderid` int(10) unsigned DEFAULT NULL COMMENT '外键订单id',
  `foodid` int(10) unsigned DEFAULT NULL COMMENT '食品id',
  `foodnum` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `keyfood_orderid` (`orderid`) USING BTREE,
  KEY `keyfood_foodid` (`foodid`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT AUTO_INCREMENT=72 ;

--
-- 转存表中的数据 `pre_order_food`
--

INSERT INTO `pre_order_food` (`id`, `orderid`, `foodid`, `foodnum`) VALUES
(10, 20, 1, 6),
(11, 20, 6, 1),
(12, 20, 7, 12),
(13, 20, 3, 4),
(14, 20, 2, 18),
(15, 20, 4, 2),
(16, 20, 9, 9),
(17, 20, 5, 2),
(18, 20, 14, 2),
(19, 21, 1, 2),
(20, 21, 2, 2),
(21, 21, 8, 3),
(22, 21, 13, 2),
(23, 21, 15, 1),
(24, 21, 6, 2),
(25, 22, 1, 2),
(26, 22, 2, 2),
(27, 22, 8, 3),
(28, 22, 13, 2),
(29, 22, 15, 1),
(30, 22, 6, 2),
(31, 23, 6, 4),
(32, 23, 9, 3),
(33, 23, 8, 1),
(34, 24, 3, 3),
(35, 24, 4, 4),
(36, 24, 2, 3),
(37, 24, 1, 2),
(38, 24, 11, 2),
(39, 25, 32, 3),
(40, 25, 31, 2),
(41, 25, 7, 2),
(42, 25, 9, 3),
(43, 25, 8, 4),
(44, 25, 10, 4),
(45, 25, 11, 2),
(46, 26, 7, 1),
(47, 26, 6, 2),
(48, 26, 2, 7),
(49, 27, 6, 2),
(50, 27, 7, 2),
(51, 27, 1, 2),
(52, 28, 6, 1),
(53, 28, 2, 1),
(54, 28, 9, 2),
(55, 29, 1, 1),
(56, 29, 2, 1),
(57, 29, 3, 2),
(58, 29, 12, 1),
(59, 30, 6, 2),
(60, 31, 6, 2),
(61, 32, 6, 1),
(62, 32, 1, 1),
(63, 32, 2, 1),
(64, 33, 6, 1),
(65, 33, 1, 1),
(66, 33, 2, 1),
(67, 34, 7, 3),
(68, 35, 1, 1),
(69, 36, 7, 1),
(70, 36, 18, 1),
(71, 36, 6, 1);

-- --------------------------------------------------------

--
-- 表的结构 `pre_recharge_record`
--

CREATE TABLE IF NOT EXISTS `pre_recharge_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned DEFAULT NULL COMMENT '用户id',
  `money` decimal(10,2) unsigned DEFAULT NULL COMMENT '金额',
  `status` tinyint(3) unsigned DEFAULT NULL COMMENT '0 未审核 1已审核',
  `createtime` int(10) unsigned DEFAULT NULL COMMENT '充值时间',
  PRIMARY KEY (`id`),
  KEY `recharge_userid` (`userid`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='充值记录表' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `pre_recharge_record`
--

INSERT INTO `pre_recharge_record` (`id`, `userid`, `money`, `status`, `createtime`) VALUES
(3, 1, '10.00', 1, NULL),
(4, 1, '123.00', 1, 1568626005);

-- --------------------------------------------------------

--
-- 表的结构 `pre_socket`
--

CREATE TABLE IF NOT EXISTS `pre_socket` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `seat` varchar(255) CHARACTER SET gbk DEFAULT NULL COMMENT '座位号',
  `content` varchar(255) CHARACTER SET gbk DEFAULT NULL COMMENT '内容',
  `userid` int(10) unsigned DEFAULT NULL COMMENT '用户id',
  `createtime` int(11) unsigned DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(3) unsigned DEFAULT NULL COMMENT '0未通知1已通知',
  `type` int(11) unsigned DEFAULT '0' COMMENT '0餐具1发票',
  PRIMARY KEY (`id`),
  KEY `socket_userid` (`userid`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='消息表' AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `pre_socket`
--

INSERT INTO `pre_socket` (`id`, `seat`, `content`, `userid`, `createtime`, `status`, `type`) VALUES
(4, '123', '1,2,3,4,5', 1, 1568705348, 1, 0),
(5, '9999', '1,2,3', 1, 1568708360, 1, 0),
(6, '999', '0', 1, 1568708668, 1, 0),
(7, '99', NULL, 1, 1568708713, 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `pre_user`
--

CREATE TABLE IF NOT EXISTS `pre_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(150) DEFAULT NULL COMMENT '密码',
  `salt` varchar(100) DEFAULT NULL COMMENT '密码盐',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `sex` tinyint(4) DEFAULT '1' COMMENT '性别',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `createtime` int(11) DEFAULT NULL COMMENT '注册时间',
  `status` int(11) DEFAULT '0' COMMENT '0邮箱未验证，1邮箱已验证',
  `money` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '用户余额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户表' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `pre_user`
--

INSERT INTO `pre_user` (`id`, `username`, `password`, `salt`, `avatar`, `sex`, `email`, `createtime`, `status`, `money`) VALUES
(1, 'demo2', '3cc7b4850bd72870e3280d6bd7e749e9', 'rsxyCFJLMNT0245', '/static/upload/1568636767795717.jpg', 0, '790891601@qq.com', 1567684623, 1, '9995648.00');

--
-- 限制导出的表
--

--
-- 限制表 `pre_cart`
--
ALTER TABLE `pre_cart`
  ADD CONSTRAINT `forgin_foodid` FOREIGN KEY (`foodid`) REFERENCES `pre_food` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `forgin_userid` FOREIGN KEY (`userid`) REFERENCES `pre_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- 限制表 `pre_coupon_record`
--
ALTER TABLE `pre_coupon_record`
  ADD CONSTRAINT `foreign_coupon_cid` FOREIGN KEY (`cid`) REFERENCES `pre_coupon` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `foreign_coupon_userid` FOREIGN KEY (`userid`) REFERENCES `pre_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- 限制表 `pre_food`
--
ALTER TABLE `pre_food`
  ADD CONSTRAINT `forgin_cateid` FOREIGN KEY (`cateid`) REFERENCES `pre_foodcate` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- 限制表 `pre_order`
--
ALTER TABLE `pre_order`
  ADD CONSTRAINT `forginorder_userid` FOREIGN KEY (`userid`) REFERENCES `pre_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- 限制表 `pre_order_food`
--
ALTER TABLE `pre_order_food`
  ADD CONSTRAINT `forginfood_foodid` FOREIGN KEY (`foodid`) REFERENCES `pre_food` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `forginfood_orderid` FOREIGN KEY (`orderid`) REFERENCES `pre_order` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- 限制表 `pre_recharge_record`
--
ALTER TABLE `pre_recharge_record`
  ADD CONSTRAINT `foreign_recharge_userid` FOREIGN KEY (`userid`) REFERENCES `pre_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- 限制表 `pre_socket`
--
ALTER TABLE `pre_socket`
  ADD CONSTRAINT `foreign_socket_userid` FOREIGN KEY (`userid`) REFERENCES `pre_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
