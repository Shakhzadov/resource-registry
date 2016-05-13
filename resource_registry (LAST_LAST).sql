-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Час створення: Трв 12 2016 р., 21:18
-- Версія сервера: 5.5.49-0ubuntu0.14.04.1
-- Версія PHP: 5.5.9-1ubuntu4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База даних: `resource_registry`
--

DELIMITER $$
--
-- Функції
--
CREATE DEFINER=`root`@`localhost` FUNCTION `distance`(lat1 FLOAT, lng1 FLOAT, lat2 FLOAT, lng2 FLOAT) RETURNS float
BEGIN
	DECLARE pi80 FLOAT;
	DECLARE r FLOAT;
	DECLARE dlat FLOAT;
	DECLARE dlng FLOAT;
	DECLARE a FLOAT;
	DECLARE c FLOAT;
	DECLARE km FLOAT;
	
	SET pi80 = PI() / 180;
	SET lat1 = lat1 * pi80;
	SET lng1 = lng1 * pi80;
	SET lat2 = lat2 * pi80;
	SET lng2 = lng2 * pi80;
 
	SET r = 6372.797; 
	SET dlat = lat2 - lat1;
	SET dlng = lng2 - lng1;
	SET a = sin(dlat / 2) * sin(dlat / 2) + cos(lat1) * cos(lat2) * sin(dlng / 2) * sin(dlng / 2);
	SET c = 2 * atan2(sqrt(a), sqrt(1 - a));
	SET km = r * c;

  RETURN km;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблиці `attribute_class_view`
--

CREATE TABLE IF NOT EXISTS `attribute_class_view` (
  `view_id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  PRIMARY KEY (`view_id`),
  KEY `fk_attribute_class_view_resource_attribute1_idx` (`attribute_id`),
  KEY `fk_attribute_class_view_resource_class1_idx` (`class_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Дамп даних таблиці `attribute_class_view`
--

INSERT INTO `attribute_class_view` (`view_id`, `class_id`, `attribute_id`) VALUES
(1, 2, 8),
(2, 3, 9),
(3, 4, 10),
(4, 2, 11),
(5, 4, 11),
(6, 5, 12),
(7, 8, 13),
(8, 9, 13),
(9, 3, 11);

-- --------------------------------------------------------

--
-- Структура таблиці `community`
--

CREATE TABLE IF NOT EXISTS `community` (
  `community_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `prefix` varchar(50) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`community_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп даних таблиці `community`
--

INSERT INTO `community` (`community_id`, `name`, `prefix`, `notes`) VALUES
(1, 'second_community', '10000254:001', 'Town of Lviv'),
(2, 'first_community', '10000254:002', 'Town of Ivano-Frankivsk'),
(3, 'third_community', '10000255:001', 'Town of Uzhhorod');

-- --------------------------------------------------------

--
-- Структура таблиці `coordinates`
--

CREATE TABLE IF NOT EXISTS `coordinates` (
  `coord_id` int(11) NOT NULL AUTO_INCREMENT,
  `lat` float(18,15) DEFAULT NULL,
  `lng` float(18,15) DEFAULT NULL,
  `registration_number` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`coord_id`),
  KEY `fk_registration_number` (`registration_number`),
  KEY `lat_index` (`lat`),
  KEY `lng_index` (`lng`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Дамп даних таблиці `coordinates`
--

INSERT INTO `coordinates` (`coord_id`, `lat`, `lng`, `registration_number`) VALUES
(1, 49.834194183349610, 23.997549057006836, '804:23:17:026:0024'),
(2, 49.834537506103516, 23.999153137207030, '804:23:17:026:0024'),
(3, 49.834075927734375, 23.999399185180664, '804:23:17:026:0024'),
(4, 49.833740234375000, 23.997768402099610, '804:23:17:026:0024'),
(5, 49.834140777587890, 23.998472213745117, '804:23:17:026:0024'),
(6, 49.834064483642580, 23.997055053710938, '804:23:17:026:0025'),
(7, 49.834125518798830, 23.997291564941406, '804:23:17:026:0025'),
(8, 49.833652496337890, 23.997531890869140, '804:23:17:026:0025'),
(9, 49.833618164062500, 23.997312545776367, '804:23:17:026:0025'),
(10, 49.833671569824220, 23.997274398803710, '804:23:17:026:0025'),
(11, 49.833660125732420, 23.997241973876953, '804:23:17:026:0025'),
(12, 49.833866119384766, 23.997289657592773, '804:23:17:026:0025'),
(14, 49.833862304687500, 23.996072769165040, '804:23:17:026:0027'),
(15, 49.833930969238280, 23.996315002441406, '804:23:17:026:0027'),
(16, 49.833564758300780, 23.996545791625977, '804:23:17:026:0027'),
(17, 49.833492279052734, 23.996294021606445, '804:23:17:026:0027'),
(18, 49.833724975585940, 23.996315002441406, '804:23:17:026:0027'),
(19, 49.833641052246094, 23.999034881591797, '804:23:17:026:0028'),
(20, 49.833896636962890, 24.000085830688477, '804:23:17:026:0028'),
(21, 49.833766937255860, 24.000171661376953, '804:23:17:026:0028'),
(22, 49.833518981933594, 23.999103546142578, '804:23:17:026:0028'),
(23, 49.833625793457030, 23.999040603637695, '804:23:17:026:0028'),
(24, 49.833705902099610, 23.999605178833008, '804:23:17:026:0028');

-- --------------------------------------------------------

--
-- Структура таблиці `operation`
--

CREATE TABLE IF NOT EXISTS `operation` (
  `operation_id` int(11) NOT NULL AUTO_INCREMENT,
  `date_log` datetime NOT NULL,
  `type_id` int(11) NOT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `resource_id` int(11) NOT NULL,
  `before_change` text,
  PRIMARY KEY (`operation_id`),
  KEY `fk_transactions_transaction_type1_idx` (`type_id`),
  KEY `fk_transactions_users1_idx` (`user_id`),
  KEY `fk_operation_resource1_idx` (`resource_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Дамп даних таблиці `operation`
--

INSERT INTO `operation` (`operation_id`, `date_log`, `type_id`, `user_id`, `resource_id`, `before_change`) VALUES
(4, '2015-10-27 14:04:25', 2, 'Петренко Петро Петрович\nпаспортні дані : EE123456', 96, 'дата створення : 2015-10-04 -> 2015-10-11|'),
(5, '2015-10-27 14:05:54', 2, 'Петренко Петро Петрович\nпаспортні дані : EE123456', 96, 'дата створення : 1970-01-08 -> 2015-10-27|'),
(6, '2015-10-27 14:06:41', 2, 'Петренко Петро Петрович\nпаспортні дані : EE123456', 48, 'дата створення : 2015-10-27 -> 1970-01-01|'),
(7, '2015-10-27 14:07:09', 2, 'Петренко Петро Петрович\nпаспортні дані : EE123456', 48, 'дата створення : 1970-01-01 -> 1970-01-02|'),
(9, '2015-10-29 21:47:10', 2, 'Петро Петро Петро| \r\n	паспортні дані : EE 123456', 96, 'назва ресурсу: Митрополивчі сади->Митрополивчі сад|'),
(10, '2015-10-29 21:47:47', 2, 'Петро Петро Петро| \r\n	паспортні дані : EE 123456', 97, 'назва ресурсу: Піскові Озера->Піскові Озера Старі|'),
(11, '2015-10-29 21:48:09', 2, '', 99, 'назва ресурсу: Стрий Самбір->Самбір|');

-- --------------------------------------------------------

--
-- Структура таблиці `operation_type`
--

CREATE TABLE IF NOT EXISTS `operation_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп даних таблиці `operation_type`
--

INSERT INTO `operation_type` (`type_id`, `name`) VALUES
(1, 'Створення ресурсу'),
(2, 'Редагування ресурсу'),
(3, 'Видалення ресурсу');

-- --------------------------------------------------------

--
-- Структура таблиці `parameter`
--

CREATE TABLE IF NOT EXISTS `parameter` (
  `parameter_id` int(11) NOT NULL AUTO_INCREMENT,
  `value` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  PRIMARY KEY (`parameter_id`),
  KEY `fk_stats_resources1_idx` (`resource_id`),
  KEY `fk_stats_resource_attributes1_idx` (`attribute_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=276 ;

--
-- Дамп даних таблиці `parameter`
--

INSERT INTO `parameter` (`parameter_id`, `value`, `resource_id`, `attribute_id`) VALUES
(271, 0, 239, 4),
(272, 0, 240, 4),
(274, 0, 242, 4),
(275, 0, 243, 4);

-- --------------------------------------------------------

--
-- Структура таблиці `personal_data`
--

CREATE TABLE IF NOT EXISTS `personal_data` (
  `personal_data_id` int(11) NOT NULL AUTO_INCREMENT,
  `last_name` varchar(40) NOT NULL,
  `first_name` varchar(40) NOT NULL,
  `middle_name` varchar(40) NOT NULL,
  `passport_series` varchar(5) NOT NULL,
  `passport_number` varchar(10) NOT NULL,
  `address` varchar(100) NOT NULL,
  `registrar_key` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`personal_data_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=174 ;

--
-- Дамп даних таблиці `personal_data`
--

INSERT INTO `personal_data` (`personal_data_id`, `last_name`, `first_name`, `middle_name`, `passport_series`, `passport_number`, `address`, `registrar_key`) VALUES
(1, 'Михайлів-Давиденко', 'Дмитро', 'Юрійович', 'NM', '123456', 'Львів', NULL),
(2, 'Крикун', 'Ірина', 'Василівна', 'NM2', '123451', 'Lvi2', '804:23:17:026:'),
(41, 'Дяків', 'Богдан', 'Ростиславович', 'dd', '11111', 'd', NULL),
(43, 'Чупринка', 'Іван', 'Васильович', 'AA', '111111', 'Aaaa', NULL),
(44, 'Римар', 'Степан', 'Кирилович', 'AA', '111111', 'Aaaa', NULL),
(45, 'Боднар', 'Володимир', 'Степанович', 'AA', '111111', 'Aaaa', NULL),
(53, 'Чайка', 'Ганна', 'Іванівна', 'AA', '111111', 'Aaaa', NULL),
(58, 'Костин', 'Андрій', 'Вікторович', 'AA', '111111', 'Aaaa', NULL),
(60, 'Трембіта', 'Лариса', 'Любомирівна', 'AA', '111111', 'Aaaa', NULL),
(61, 'Стойко', 'Роман', 'Гаврилович', 'AA', '111111', 'Aaaa', NULL),
(64, 'Кличко', 'Сергій', 'Несторович', 'AA', '111111', 'Aaaa', NULL),
(65, 'Сенсей', 'Світлана', 'Панасівна', 'AA', '111111', 'Aaaa', NULL),
(67, 'Стартер', 'Віталій', 'Орестович', 'AA', '11111', 'Aaaa', NULL),
(68, 'Красій', 'Кирило', 'Олексійович', 'AA', '111111', 'Aaaa', NULL),
(69, 'Коровко', 'Алла', 'Михайлівна', 'AA', '111112', 'Bbbbb', NULL),
(70, 'Сидір', 'Ганна', 'Ярославівна', 'AA', '77777', 'lviv', NULL),
(71, 'Самсонова', 'Наталія', 'Володимирівна', 'CC', '222222', 'Aaaa', NULL),
(72, 'Смірнова', 'Неля', 'Остафівна', 'DD', '333333', 'Bfff', NULL),
(73, 'Сергієнко', 'Стефанія', 'Сидорівна', 'AA', '111111', 'Aaaa', NULL),
(74, 'Редько', 'Валентина', 'Сергіївна', 'AA', '111111', 'Aaaa', NULL),
(75, 'Стефанів', 'Ангелія', 'Борисівна', 'AA', '11111', 'Aaa123', NULL),
(94, 'Шаламай', 'Ірина', 'Валеріївна', 'TE', '123456', 'test36', NULL),
(97, 'Рибалко', 'Ігор', 'Несторович', 'TE', '56565', 'test37', NULL),
(98, 'Жовнір', 'Григорій', 'Ростиславович', 'TE', '56565', 'test37', NULL),
(101, 'Балагура', 'Нестор', 'Степанович', 'TE', '56565', 'test37', NULL),
(102, 'Забадай', 'Іван', 'Іванович', 'kh', 'khkuh', 'kuhkuh', NULL),
(103, 'Румун', 'Ростислав', 'Григорович', 'kh', 'khkuh', 'kuhkuh', NULL),
(104, 'Армен', 'Василь', 'Арсенович', 'kh', 'khkuh', 'kuhkuh', NULL),
(105, 'Секунда', 'Григорій', 'Романович', 'kh', 'khkuh', 'kuhkuh', NULL),
(106, 'Василько', 'Нестор', 'Васильович', 'kh', 'khkuh', 'kuhkuh', NULL),
(107, 'Петров', 'Петро', 'Петрович', 'КН', '374826374', 'Виговського 67', '804:23:17:026:'),
(108, 'Павлик', 'Василь', 'Вікторович', 'КН', '374826374', 'Виговського 67', '804:23:17:026:'),
(109, 'Ходарко', 'Анастасія', 'Андріївна', 'tg', 'bgbg', 'bgbg', '804:23:17:026:'),
(111, 'Шевчук', 'Віталій', 'Сергійович', 'КС', '123', 'Адреса', NULL),
(112, 'Петренко', 'Олександр', 'Іванович', 'КС', '34536574', 'виговського 7', NULL),
(113, 'Павелко', 'Андрій', 'Олександрович', 'EE', '123456', '29000, м. Хмельницький, вул. Героїв Майдану, 17, кв. 17', '804:23:17:026:'),
(114, 'Лимар', 'Анатолій', 'Дмитрович', 'ME', '55555', 'Lv', NULL),
(115, 'Рибалко', 'Костянтин', 'Сергійович', 'FT', '6644', 'Lviv', NULL),
(116, 'Петрів', 'Роман', 'Віталійович', 'KK', '5555', 'Lviv', NULL),
(117, 'Коваль', 'Олександр', 'Гаврилович', 'KA', '77777', 'Addr', NULL),
(118, 'Опар', 'Ярослав', 'Володимирович', 'DD', '33333', 's', NULL),
(119, 'Крижанівський', 'Богдан', 'Борисович', 'DD', '33333', 's', NULL),
(120, 'Андрійко', 'Василь', 'Васильович', 'DD', '33333', 's', NULL),
(121, 'Богдан', 'Богдан', 'Опанасович', 'DD', '33333', 's', NULL),
(122, 'Грабар', 'Роман', 'Іванович', 'МЕ', '11111', 'м.Самбір., Шухевича 53', '804:23:17:026:'),
(123, 'Васильєв', 'Володимир', 'Володимирович', 'МЕ', '1234', 'Дніпропетровськ вул, Червоний камінь., Україна', NULL),
(124, 'Трутенко', 'Тетяна', 'Терентіївна', 'МЕ', '55555', 'Тест', NULL),
(125, 'Вар''ят', 'Степан', 'Сергійович', 'ТЕСТ', 'ТЕСТ', 'ТЕСТ', NULL),
(126, 'Середько', 'Федір', 'Мирославович', 'ЬУ', 'ЬК', 'ЬК', NULL),
(127, 'Андрюшенко', 'Іван', 'Миколайович', 'МЕ', '55555', 'м.Київ., Україна', NULL),
(128, 'Андрейко', 'Віктор', 'Мирославович', 'МЕ', '55555', 'м.Київ., Україна', NULL),
(129, 'Андрейко', 'Ольга', 'Любомирівна', 'ИУ', '3333', 'ло', NULL),
(130, 'Сачко', 'Сергій', 'Григорович', 'ТУ', '33333', 'фі', NULL),
(131, 'Селезень', 'Назар', 'Ігорович', 'ТУ', '33333', 'фі', NULL),
(132, 'Жадько', 'Євген', 'Любомирович', 'Му', '44444', 'ло', NULL),
(133, 'Микита', 'Іван', 'Євгенійович', 'м', '77777', 'р', NULL),
(134, 'Коваль', 'Павло', 'Панасійович', 'МЕ', '55555', 'м. Львів ., вул.,Смаль-Стоцького', NULL),
(135, 'Ковальський', 'Володимир', 'Віталійович', 'МЕ', '55555', 'м. Львів ., вул.,Смаль-стоцького', NULL),
(136, 'Староженко', 'Галина', 'Олексіївна', 'МЕ', '55555', 'р', NULL),
(137, 'Назаренко', 'Василь', 'Васильович', 'МЕ', '5555', 'Львів', NULL),
(138, 'Сікорська', 'Віра', 'Тарасівна', 'МЕ', '5555', 'Львів', NULL),
(139, 'Голобородько', 'Тарас', 'Олексійович', 'МЕ', '12345', 'Львів', NULL),
(140, 'Грабич', 'Олексій', 'Михайлович', 'МЕ', '55555', 'м., Київ', NULL),
(141, 'Грабля', 'Валентина', 'Василівна', 'МЕ', '55555', 'м., Київ', NULL),
(142, 'Контора', 'Кирило', 'Костянтинович', 'МЕ', '5555', 'м.Київ', NULL),
(143, 'Кружка', 'Сергій', 'Олександрович', 'МЕ', '55555', 'м.Київ', NULL),
(144, 'Камбала', 'Наталія', 'Петрівна', 'МЕ', '55555', 'м.Київ', NULL),
(145, 'Юзик', 'Світлана', 'Андріївна', 'МЕ', '55555', 'м.Київ', NULL),
(146, 'Король', 'Світлана', 'Арсеніївна', 'Ме', '55555', 'Петро', NULL),
(147, 'Левон', 'Альберто', 'Насірович', 'ві', '55555', 'ра', NULL),
(148, 'Яків', 'Альберт', 'Арсенович', 'МЕ', '66666', 'ОРЛР', NULL),
(149, 'Федоришин', 'Оксана', 'Олегівна', 'МЕ', '66655', 'фів', NULL),
(150, 'Соломко', 'Олег', 'Степанович', 'ММ', '55555', 'лорло', NULL),
(151, 'Мазепа', 'Марина', 'Олександрівна', 'VR', '88888', 'kjh', NULL),
(152, 'Крик', 'Назарій', 'Борисович', 'VR', '88888', 'kjh', NULL),
(153, 'Баран', 'Олексій', 'Вікторович', 'ММ', '55555', 'лорло', NULL),
(154, 'Крисюк', 'Віктор', 'Панасович', 'ZZ', '77777', 'kjhkj', NULL),
(155, 'Коробка', 'Дмитро', 'Станіславович', 'BR', '88888', 'kjhkj', NULL),
(156, 'Чуйко', 'Віталія', 'Дмитрівна', 'BR', '77774', 'jhjk', NULL),
(157, 'Коптев', 'Степан', 'Михайлович', 'BBD', 'jlkjl', 'jkjlj', NULL),
(158, 'Каряка', 'Григорій', 'Кирилович', 'ew', '88888', 'kjk', NULL),
(159, 'Круглов', 'Сергій', 'Степанович', 'NN', '77777', 'kjhk', NULL),
(160, 'Кружка', 'Борислав', 'Харитонович', 'BB', '77777', 'kjhk', NULL),
(161, 'Забужко', 'Ігор', 'Олексійович', 'MM', '66666', 'jhgj', NULL),
(162, 'Зайка', 'Ростислав', 'Станіславович', 'BB', '66666', 'h', NULL),
(163, 'Пакля', 'Рахім', 'Чакхійович', 'vt', '2323', 'jkhjkhk', NULL),
(164, 'Гора', 'Романа', 'Іванівна', 'МЕ', '23233', 'SAN FRANCISCO', NULL),
(165, 'Цихмейструк', 'Софія', 'Сергіївна', 'VT', '66666', 'RRR', NULL),
(166, 'Перебийніс', 'Василь', 'Іванович', 'МЕ', '55555', 'м.Самбір., Львівська обл.', NULL),
(167, 'Калина', 'Іванна', 'Федорівна', 'МЕ', '55555', 'м.Самбір., Львівська обл.', '804:23:17:026:'),
(168, 'Лисикевич', 'Володимир', 'Володимирович', 'ME', '55555', 'Львів., Володимира Великого, 63', NULL),
(169, 'Коваль', 'Валерій', 'Анатолійович', 'МЕ', '12345', 'Львів., вул. Шевченка 56', NULL),
(170, 'Кириченко', 'Тетяна', 'Василівна', 'МЕ', '55555', 'Самбір ., вул. Шухевича 68', NULL),
(171, 'Нікель', 'Василь', 'Євгенійович', 'МЕ', '6666', 'Львів', NULL),
(172, 'Сердюк', 'Олександр', 'Олександрович', 'КВ', '139406', 'м.Львів', NULL),
(173, 'Ваврик', 'Іван', 'Олексійович', 'пп', '8888', 'м. Львів вул. Низинна', NULL);

-- --------------------------------------------------------


--
-- Table structure for table `request`
--

CREATE TABLE IF NOT EXISTS `request` (
  `req_id` int(11) NOT NULL AUTO_INCREMENT,
  `res_id` int(11) DEFAULT NULL,
  `type` smallint(6) NOT NULL,
  `sender` int(11) NOT NULL,
  `create_time` int(11) DEFAULT NULL,
  `reciever` int(11) DEFAULT NULL,
  `complete_time` int(11) DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`req_id`),
  KEY `fk_req_resource` (`res_id`),
  KEY `fk_req_sender` (`sender`),
  KEY `fk_req_reciever` (`reciever`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `request`
--

INSERT INTO `request` (`req_id`, `res_id`, `type`, `sender`, `create_time`, `reciever`, `complete_time`, `status`) VALUES
(1, 185, 0, 27, 1462879231, 7, NULL, 0),
(2, 208, 0, 23, 1462886868, 22, 1462887868, 1),
(3, NULL, 1, 22, 1462876868, 31, 1462877000, 2),
(4, NULL, 1, 22, 1462876968, 31, 1462877100, 2),
(5, NULL, 1, 22, 1462876968, 31, 1462877100, 2),
(6, NULL, 1, 22, 1462876968, 31, 1462877100, 2),
(8, NULL, 1, 22, 1462876968, 31, 1462877100, 2),
(9, NULL, 1, 22, 1462876968, 31, 1462877100, 2);


--
-- Структура таблиці `resource`
--

CREATE TABLE IF NOT EXISTS `resource` (
  `resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `class_id` int(11) NOT NULL,
  `coordinates` text NOT NULL,
  `coords_center_lat` float NOT NULL,
  `coords_center_lng` float NOT NULL,
  `owner_data_id` int(11) DEFAULT NULL,
  `reason` text NOT NULL,
  `date` date DEFAULT NULL,
  `registrar_data_id` int(11) DEFAULT NULL COMMENT 'Для контролювання особи дії над ресурсом',
  `registration_number` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`resource_id`),
  UNIQUE KEY `registration_number` (`registration_number`),
  KEY `fk_resource_resource_class1_idx` (`class_id`),
  KEY `fk_resource_personal_data1_idx` (`owner_data_id`),
  KEY `registrar_data_id` (`registrar_data_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=244 ;

--
-- Дамп даних таблиці `resource`
--

INSERT INTO `resource` (`resource_id`, `name`, `class_id`, `coordinates`, `coords_center_lat`, `coords_center_lng`, `owner_data_id`, `reason`, `date`, `registrar_data_id`, `registration_number`) VALUES
(185, 'Сквер', 1, '[[49.837110740852815,24.012501686811447],[49.83668517739605,24.013724774122235],[49.8366609582249,24.013821333646774],[49.836650578576425,24.01390716433525],[49.83699310580031,24.014620631933212],[49.83704154379776,24.01465281844139],[49.83710036130087,24.01466891169548],[49.837169558271775,24.01466891169548],[49.837249134665896,24.01467427611351],[49.83731833142388,24.01467427611351],[49.83740136740278,24.01466891169548],[49.837487863062485,24.01465281844139],[49.83754668002271,24.014620631933212],[49.837619336168906,24.014561623334885],[49.83768507258808,24.014502614736557],[49.83772659028046,24.01440069079399],[49.837768107937194,24.014239758253098],[49.83778194714817,24.014111012220383],[49.83777502754318,24.01395007967949],[49.83775772852634,24.013842791318893],[49.83773005008655,24.01370331645012],[49.83763663523526,24.01346728205681],[49.83737368875899,24.012791365385056],[49.83718331656395,24.012319967150685]]', 49.8372, 24.0136, 166, '', '2015-11-10', 113, '804:23:17:026:0021'),
(186, 'пл. Св. Юри', 1, '[[49.83654497093241,24.013875648379326],[49.83655016076826,24.013964161276817],[49.83660897886909,24.01398293673992],[49.836629738181685,24.014007076621052],[49.83688749890436,24.014548882842064],[49.83694285673268,24.014674946665764],[49.83694631659485,24.014696404337883],[49.83694112680151,24.014725908637047],[49.836939396870285,24.014758095145226],[49.83693420707619,24.014801010489464],[49.83692728734987,24.014846608042717],[49.83691517782646,24.014884158968925],[49.83690306829999,24.014913663268086],[49.83695150638765,24.014951214194298],[49.8369688056929,24.014927074313164],[49.83699129478049,24.014913663268086],[49.83711065976259,24.01486001908779],[49.837169477181625,24.014849290251732],[49.83738744699307,24.014846608042717],[49.83745145381457,24.014841243624687],[49.83746875294097,24.014851972460747],[49.83756735784329,24.01501290500164],[49.8377023716309,24.015248268842697],[49.83774042950333,24.01518926024437],[49.83775080891789,24.01514634490013],[49.83774734911328,24.01494786143303],[49.83777848734581,24.014824479818344],[49.83783038435545,24.014604538679123],[49.83784768334628,24.014486521482468],[49.837861522534496,24.014347046613693],[49.83787536171876,24.01421293616295],[49.83787536171876,24.014094918966293],[49.83787882151418,24.01395007967949],[49.83789612048771,24.013821333646774],[49.83792025795133,24.01374153792858],[49.83795312596755,24.013674482703205],[49.838005022789744,24.013623520731926],[49.83803443096426,24.013575240969658],[49.838043080423965,24.01350550353527],[49.83806210922984,24.013339206576347],[49.83808113802824,24.01314340531826],[49.83812438526943,24.012733027338978],[49.83807248857535,24.012706205248833],[49.83805345977355,24.012837633490562],[49.838039620640274,24.01291809976101],[49.838029241287714,24.012947604060173],[49.83799464342976,24.01298515498638],[49.837624444800085,24.01287518441677],[49.837619255079524,24.012840315699577],[49.8376279046135,24.012805446982384],[49.83761233545125,24.01279203593731],[49.83761406535842,24.01274912059307],[49.83749124179605,24.012698158621788],[49.837461833291144,24.0126820653677],[49.837437614508985,24.01265524327755],[49.83729922123538,24.012285098433495],[49.83729057164262,24.012228772044182],[49.8372923015613,24.012086614966393],[49.83730614090846,24.011933729052544],[49.83720407562999,24.01190958917141],[49.83703973277977,24.012091979384422],[49.83709682035948,24.012242183089256],[49.83719196617589,24.012317284941673],[49.837382257247086,24.012837633490562],[49.837574277478005,24.013328477740288],[49.83768326159419,24.013596698641777],[49.83771612977149,24.013687893748283],[49.83774380821926,24.01375763118267],[49.837750727828734,24.0138354152441],[49.837755917535176,24.013923928141594],[49.83775937733915,24.0140151232481],[49.83775937733915,24.0140875428915],[49.83775245773092,24.014170691370964],[49.837738618511494,24.014253839850422],[49.83771785967493,24.014363810420036],[49.837697100829445,24.014422819018364],[49.83766596254453,24.014473780989647],[49.83763309433312,24.01451401412487],[49.837588116744485,24.01456229388714],[49.83753794938469,24.014610573649406],[49.8374895118845,24.01465080678463],[49.83742896494102,24.014666900038716],[49.8373476589262,24.01467762887478],[49.83727846221017,24.01468299329281],[49.83722310476606,24.014685675501823],[49.837153907871794,24.01468835771084],[49.83712276923705,24.01468835771084],[49.83707952110002,24.01468299329281],[49.83703800285206,24.014661535620686],[49.83699821449764,24.014626666903492],[49.83694804652584,24.014548882842064],[49.836859819966435,24.014345034956932],[49.836769863308746,24.014165326952934],[49.83669547594618,24.01400439441204],[49.836655687309936,24.013942703604698]]', 49.8372, 24.0136, 122, '', '2015-11-10', 113, '804:23:17:026:0022'),
(208, 'пл. Юри 8', 1, '[[49.837482673327266,24.012512415647507],[49.83747229385514,24.01272162795067],[49.83749651261995,24.012753814458847],[49.83758300810946,24.012780636548996],[49.8375855218823,24.012821540236473],[49.83762184993987,24.012832269072533],[49.83762357984671,24.012861773371696],[49.837649528441624,24.012872502207756],[49.83766163778115,24.012915417551994],[49.837993778483,24.0130066126585],[49.83801626709389,24.012993201613426],[49.83803183612605,24.012966379523277],[49.83803702580234,24.01292346417904],[49.83806297417537,24.012714251875877],[49.83767201721261,24.012574777007103],[49.83748691701703,24.0125023573637]]', 49.8378, 24.0128, NULL, 'паспорт громадянина України   ,виданий на ім''я     2015.11.11', '2015-11-11', 113, '804:23:17:026:0023'),
(239, 'Стадіон', 1, '[[49.83419329628141,23.99754837155342],[49.8345358409111,23.999152332544327],[49.83407565413169,23.999399095773697],[49.833740026425765,23.997768312692642]]', 0, 0, NULL, 'паспорт громадянина України   ,виданий на ім''я     2016.05.11', '2016-05-11', 113, '804:23:17:026:0024'),
(240, 'Будинок поблизу', 1, '[[49.834065273928275,23.99705484509468],[49.834124095051514,23.99729087948799],[49.83365352406218,23.99753227829933],[49.833618923073416,23.99731233716011],[49.83367082454726,23.997274786233902],[49.83366044425695,23.99724259972572]]', 0, 0, NULL, 'паспорт громадянина України   ,виданий на ім''я     2016.05.11', '2016-05-11', 113, '804:23:17:026:0025'),
(242, 'Ще один будинок', 1, '[[49.83386112947486,23.99607315659523],[49.833930331081035,23.99631455540657],[49.8335635614399,23.99654522538185],[49.83349089919974,23.99629309773445]]', 0, 0, NULL, 'паспорт громадянина України   ,виданий на ім''я     2016.05.11', '2016-05-11', 113, '804:23:17:026:0027'),
(243, 'Новий будинок', 1, '[[49.83363968366966,23.99903431534767],[49.83389573029033,24.00008574128151],[49.83376770714943,24.000171571969986],[49.83351858006602,23.99910405278206],[49.83362584327315,23.9990396797657]]', 0, 0, NULL, 'паспорт громадянина України   ,виданий на ім''я     2016.05.12', '2016-05-12', 113, '804:23:17:026:0028');

-- --------------------------------------------------------

--
-- Структура таблиці `resource_attribute`
--

CREATE TABLE IF NOT EXISTS `resource_attribute` (
  `attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `is_global` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`attribute_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Дамп даних таблиці `resource_attribute`
--

INSERT INTO `resource_attribute` (`attribute_id`, `name`, `is_global`) VALUES
(1, 'length', 1),
(2, 'width', 1),
(3, 'height', 1),
(4, 'square', 1),
(5, 'volume', 1),
(6, 'weight', 1),
(7, 'perimeter', 1),
(8, 'depth', 0),
(9, 'disposition depth', 0),
(10, 'climate zone', 0),
(11, 'temperature', 0),
(12, 'humidity', 0),
(13, 'quantity', 0);

-- --------------------------------------------------------

--
-- Структура таблиці `resource_class`
--

CREATE TABLE IF NOT EXISTS `resource_class` (
  `class_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `activation_status` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Дамп даних таблиці `resource_class`
--

INSERT INTO `resource_class` (`class_id`, `name`, `activation_status`) VALUES
(1, 'земельні ресурси', 1),
(2, 'водні ресурси', 1),
(3, 'надра', 1),
(4, 'клімат', 1),
(5, 'повітряний простір', 1),
(6, 'атмосферні ресурси', 1),
(7, 'радіочастотний ресурс', 1),
(8, 'фауна ', 1),
(9, 'флора ', 1),
(10, 'альтернативні джерела енергії', 1);

-- --------------------------------------------------------

--
-- Структура таблиці `role`
--

CREATE TABLE IF NOT EXISTS `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп даних таблиці `role`
--

INSERT INTO `role` (`role_id`, `name`) VALUES
(1, 'user'),
(2, 'registrar'),
(3, 'admin'),
(4, 'commissioner');

-- --------------------------------------------------------

--
-- Структура таблиці `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `auth_key` varchar(32) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `password_reset_token` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `user_data_id` int(11) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `community_id` int(11) DEFAULT NULL,
  `activation_status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`),
  KEY `role_id` (`user_data_id`),
  KEY `role_id_2` (`role_id`),
  KEY `fk_user_community` (`community_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=41 ;

--
-- Дамп даних таблиці `user`
--

INSERT INTO `user` (`user_id`, `username`, `auth_key`, `password_hash`, `password_reset_token`, `email`, `user_data_id`, `role_id`, `community_id`, `activation_status`) VALUES
(1, 'admin', 'mPLobHQJkMV7pdw6JM5azks9n-Fkx9EY', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'demo@mail.net', 1, 3, NULL, 0),
(3, 'registrar1', 'pdw6JM5azks9n-Fkx9EYmPLobHQJkMV7', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', 'F7NFSAPun1hooVGJGpUGgaUpPcJ4iEEu_1444824168', 'zhenyast@yandex.ru', 2, 2, 2, 1),
(7, 'admin1', 'sBZlLkpEbikELmURWCopgN-lYiqU7UYu', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'zhenyast@yandex.ru', 170, 3, NULL, 1),
(8, 'user1', 'LTrS-nd6GOp4NAuWsqLPMGRmTXyhnRoR', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'test@gmail.com', 65, 1, 1, 1),
(9, 'user2', 'v0HLQsttxqamwDDszxTmGrio0KjVFASu', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'test@gmail.com', 67, 1, 2, 1),
(10, 'user3', 'nzns3KZbmVNEERTeqbyWSmiA8iIsZCuy', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'test@gmail.com', 68, 1, 3, 1),
(11, 'user4', 'D3Hwd61ihElNoSZqYdbm6tY7MiR9TKMN', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'test@gmail.com', 69, 1, 1, 1),
(12, 'user5', 'FEdVtOX6YBUSBDkGwBmlkRs7MvKS1rNS', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'test@gmail.com', 70, 1, 2, 1),
(14, 'user6', 'CnJoAGaGgNUzWFs1douSRUhI-7nCQofg', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'test@gmail.com', 71, 1, 3, 1),
(15, 'user7', 'iWVndxR_sQaVRTNgvgKNsgLlJB1pNzDk', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'test@gmail.com', 72, 1, 1, 1),
(16, 'user8', 'J9pL0T5YDbPSK7mn0O0FRYndbFFxAgEX', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'test@gmail.com', 73, 1, 2, 1),
(17, 'user9', '2b1-_u4Gb-BcDIlQTwwxOFSXypfeLuMP', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'personalDataModel@ya.ru', 74, 1, 3, 1),
(18, 'user10', 'ecuUkIjIbI-a_JL3dk5clnLTBu6NMPxm', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'test@mail.ru', 75, 1, 1, 1),
(20, 'user11', 'vLNM1wxWKgQN27Ggot6mt2i08QxEI1dk', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'vasya@ya.ru', 131, 1, 2, 1),
(21, 'user12', 'ucDnNXLbL4cqo6EEezyEeUoC37NuU47n', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'test36@mail.ru', 132, 1, 3, 1),
(22, 'user13', '0hRs_b4To10q9QejQ3wS0ATzNMUKmSHy', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'test37@mail.ru', 133, 1, 1, 1),
(23, 'user14', 'eJWSGRi2nyz9wPviMJw0lH1ixy5IrtMi', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'vitashev@bk.ru', 134, 1, 2, 1),
(24, 'user', 'ODBf-XUPupYGk4iss935XhIECg-nbwok', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'rerse@ya.ri', 135, 1, 3, 1),
(25, 'registrar2', 'VYNlikVL5ZSiCPZp3XL6NZ_nr4cl9Pr3', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'registerresource@gmail.com', 107, 2, 2, 1),
(26, 'registrar3', 'AE5fW3PCbNY3D5jGAtAiAGXd0ezMdy-q', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'registerresource@gmail.com', 108, 2, 3, 1),
(27, 'registrar4', 'Fxl0xfdMGVrzpPj8c1_uNtAwAAf5t90T', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'gtrgrt@ya.ru', 109, 2, 1, 1),
(28, 'registrar5', 'kq1OSpQweIhZ3kfF5f6fAM2_kM9H5h3E', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'registerresource@gmail.com', 167, 2, 2, 1),
(29, 'registrar', 'nh1R7g-MHLNcBOFuP_Jn8N0q_9E3K50z', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'test69@mail.ru', 113, 2, 1, 1),
(30, 'registrar6', 'r9ZSVEms7lozWO7Guo_K3ZiyaxRyQD3M', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'gith@gmail.com', 122, 2, 3, 0),
(31, 'commissioner', 'mPLobHQJkMV7pdw6JM5azks9n-Fkx9EY', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'first_commissioner@mail.ru', 115, 4, 1, 1),
(38, 'commissioner1', 'mPLobHQJkMV7pdw6JM5azks9n-Fkx9EY', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'second_commissioner@mail.ru', 116, 4, 2, 1),
(40, 'commissioner2', 'mPLobHQJkMV7pdw6JM5azks9n-Fkx9EY', '$2y$13$/qKMqvRxreJoaI2Zpqee2.TjYGI57vsSbkzGOAZSYUp.DyoerZrEO', NULL, 'third_commissioner@mail.ru', 117, 4, 3, 1);

--
-- Обмеження зовнішнього ключа збережених таблиць
--

--
-- Обмеження зовнішнього ключа таблиці `attribute_class_view`
--
ALTER TABLE `attribute_class_view`
  ADD CONSTRAINT `fk_attribute_class_view_resource_attribute1` FOREIGN KEY (`attribute_id`) REFERENCES `resource_attribute` (`attribute_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_attribute_class_view_resource_class1` FOREIGN KEY (`class_id`) REFERENCES `resource_class` (`class_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Обмеження зовнішнього ключа таблиці `coordinates`
--
ALTER TABLE `coordinates`
  ADD CONSTRAINT `fk_registration_number` FOREIGN KEY (`registration_number`) REFERENCES `resource` (`registration_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `operation`
--
ALTER TABLE `operation`
  ADD CONSTRAINT `fk_transactions_transaction_type1` FOREIGN KEY (`type_id`) REFERENCES `operation_type` (`type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Обмеження зовнішнього ключа таблиці `parameter`
--
ALTER TABLE `parameter`
  ADD CONSTRAINT `fk_stats_resources1` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`resource_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stats_resource_attributes1` FOREIGN KEY (`attribute_id`) REFERENCES `resource_attribute` (`attribute_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `request`
--
ALTER TABLE `request`
  ADD CONSTRAINT `fk_req_reciever` FOREIGN KEY (`reciever`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `fk_req_resource` FOREIGN KEY (`res_id`) REFERENCES `resource` (`resource_id`),
  ADD CONSTRAINT `fk_req_sender` FOREIGN KEY (`sender`) REFERENCES `user` (`user_id`);

--
-- Обмеження зовнішнього ключа таблиці `resource`
--
ALTER TABLE `resource`
  ADD CONSTRAINT `fk_resource_personal_data1` FOREIGN KEY (`owner_data_id`) REFERENCES `personal_data` (`personal_data_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_resource_resource_class1` FOREIGN KEY (`class_id`) REFERENCES `resource_class` (`class_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Обмеження зовнішнього ключа таблиці `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_user_community` FOREIGN KEY (`community_id`) REFERENCES `community` (`community_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`user_data_id`) REFERENCES `personal_data` (`personal_data_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
