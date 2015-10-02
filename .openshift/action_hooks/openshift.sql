-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Окт 02 2015 г., 20:31
-- Версия сервера: 5.5.44-0ubuntu0.14.04.1
-- Версия PHP: 5.5.9-1ubuntu4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `mediawiki`
--

-- --------------------------------------------------------

--
-- Структура таблицы `archive`
--

CREATE TABLE IF NOT EXISTS `archive` (
  `ar_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ar_namespace` int(11) NOT NULL DEFAULT '0',
  `ar_title` varbinary(255) NOT NULL DEFAULT '',
  `ar_text` mediumblob NOT NULL,
  `ar_comment` varbinary(767) NOT NULL,
  `ar_user` int(10) unsigned NOT NULL DEFAULT '0',
  `ar_user_text` varbinary(255) NOT NULL,
  `ar_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `ar_minor_edit` tinyint(4) NOT NULL DEFAULT '0',
  `ar_flags` tinyblob NOT NULL,
  `ar_rev_id` int(10) unsigned DEFAULT NULL,
  `ar_text_id` int(10) unsigned DEFAULT NULL,
  `ar_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ar_len` int(10) unsigned DEFAULT NULL,
  `ar_page_id` int(10) unsigned DEFAULT NULL,
  `ar_parent_id` int(10) unsigned DEFAULT NULL,
  `ar_sha1` varbinary(32) NOT NULL DEFAULT '',
  `ar_content_model` varbinary(32) DEFAULT NULL,
  `ar_content_format` varbinary(64) DEFAULT NULL,
  PRIMARY KEY (`ar_id`),
  KEY `name_title_timestamp` (`ar_namespace`,`ar_title`,`ar_timestamp`),
  KEY `usertext_timestamp` (`ar_user_text`,`ar_timestamp`),
  KEY `ar_revid` (`ar_rev_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `cat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat_title` varbinary(255) NOT NULL,
  `cat_pages` int(11) NOT NULL DEFAULT '0',
  `cat_subcats` int(11) NOT NULL DEFAULT '0',
  `cat_files` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `cat_title` (`cat_title`),
  KEY `cat_pages` (`cat_pages`)
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `categorylinks`
--

CREATE TABLE IF NOT EXISTS `categorylinks` (
  `cl_from` int(10) unsigned NOT NULL DEFAULT '0',
  `cl_to` varbinary(255) NOT NULL DEFAULT '',
  `cl_sortkey` varbinary(230) NOT NULL DEFAULT '',
  `cl_sortkey_prefix` varbinary(255) NOT NULL DEFAULT '',
  `cl_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cl_collation` varbinary(32) NOT NULL DEFAULT '',
  `cl_type` enum('page','subcat','file') NOT NULL DEFAULT 'page',
  UNIQUE KEY `cl_from` (`cl_from`,`cl_to`),
  KEY `cl_sortkey` (`cl_to`,`cl_type`,`cl_sortkey`,`cl_from`),
  KEY `cl_timestamp` (`cl_to`,`cl_timestamp`),
  KEY `cl_collation` (`cl_collation`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `change_tag`
--

CREATE TABLE IF NOT EXISTS `change_tag` (
  `ct_rc_id` int(11) DEFAULT NULL,
  `ct_log_id` int(11) DEFAULT NULL,
  `ct_rev_id` int(11) DEFAULT NULL,
  `ct_tag` varbinary(255) NOT NULL,
  `ct_params` blob,
  UNIQUE KEY `change_tag_rc_tag` (`ct_rc_id`,`ct_tag`),
  UNIQUE KEY `change_tag_log_tag` (`ct_log_id`,`ct_tag`),
  UNIQUE KEY `change_tag_rev_tag` (`ct_rev_id`,`ct_tag`),
  KEY `change_tag_tag_id` (`ct_tag`,`ct_rc_id`,`ct_rev_id`,`ct_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `externallinks`
--

CREATE TABLE IF NOT EXISTS `externallinks` (
  `el_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `el_from` int(10) unsigned NOT NULL DEFAULT '0',
  `el_to` blob NOT NULL,
  `el_index` blob NOT NULL,
  PRIMARY KEY (`el_id`),
  KEY `el_from` (`el_from`,`el_to`(40)),
  KEY `el_to` (`el_to`(60),`el_from`),
  KEY `el_index` (`el_index`(60))
) ENGINE=InnoDB  DEFAULT CHARSET=binary AUTO_INCREMENT=10 ;

--
-- Дамп данных таблицы `externallinks`
--

INSERT INTO `externallinks` (`el_id`, `el_from`, `el_to`, `el_index`) VALUES
(1, 1, 0x2f2f6d6574612e77696b696d656469612e6f72672f77696b692f48656c703a436f6e74656e7473, 0x687474703a2f2f6f72672e77696b696d656469612e6d6574612e2f77696b692f48656c703a436f6e74656e7473),
(2, 1, 0x2f2f6d6574612e77696b696d656469612e6f72672f77696b692f48656c703a436f6e74656e7473, 0x68747470733a2f2f6f72672e77696b696d656469612e6d6574612e2f77696b692f48656c703a436f6e74656e7473),
(3, 1, 0x2f2f7777772e6d6564696177696b692e6f72672f77696b692f5370656369616c3a4d794c616e67756167652f4d616e75616c3a436f6e66696775726174696f6e5f73657474696e6773, 0x687474703a2f2f6f72672e6d6564696177696b692e7777772e2f77696b692f5370656369616c3a4d794c616e67756167652f4d616e75616c3a436f6e66696775726174696f6e5f73657474696e6773),
(4, 1, 0x2f2f7777772e6d6564696177696b692e6f72672f77696b692f5370656369616c3a4d794c616e67756167652f4d616e75616c3a436f6e66696775726174696f6e5f73657474696e6773, 0x68747470733a2f2f6f72672e6d6564696177696b692e7777772e2f77696b692f5370656369616c3a4d794c616e67756167652f4d616e75616c3a436f6e66696775726174696f6e5f73657474696e6773),
(5, 1, 0x2f2f7777772e6d6564696177696b692e6f72672f77696b692f5370656369616c3a4d794c616e67756167652f4d616e75616c3a464151, 0x687474703a2f2f6f72672e6d6564696177696b692e7777772e2f77696b692f5370656369616c3a4d794c616e67756167652f4d616e75616c3a464151),
(6, 1, 0x2f2f7777772e6d6564696177696b692e6f72672f77696b692f5370656369616c3a4d794c616e67756167652f4d616e75616c3a464151, 0x68747470733a2f2f6f72672e6d6564696177696b692e7777772e2f77696b692f5370656369616c3a4d794c616e67756167652f4d616e75616c3a464151),
(7, 1, 0x68747470733a2f2f6c697374732e77696b696d656469612e6f72672f6d61696c6d616e2f6c697374696e666f2f6d6564696177696b692d616e6e6f756e6365, 0x68747470733a2f2f6f72672e77696b696d656469612e6c697374732e2f6d61696c6d616e2f6c697374696e666f2f6d6564696177696b692d616e6e6f756e6365),
(8, 1, 0x2f2f7777772e6d6564696177696b692e6f72672f77696b692f5370656369616c3a4d794c616e67756167652f4c6f63616c69736174696f6e235472616e736c6174696f6e5f7265736f7572636573, 0x687474703a2f2f6f72672e6d6564696177696b692e7777772e2f77696b692f5370656369616c3a4d794c616e67756167652f4c6f63616c69736174696f6e235472616e736c6174696f6e5f7265736f7572636573),
(9, 1, 0x2f2f7777772e6d6564696177696b692e6f72672f77696b692f5370656369616c3a4d794c616e67756167652f4c6f63616c69736174696f6e235472616e736c6174696f6e5f7265736f7572636573, 0x68747470733a2f2f6f72672e6d6564696177696b692e7777772e2f77696b692f5370656369616c3a4d794c616e67756167652f4c6f63616c69736174696f6e235472616e736c6174696f6e5f7265736f7572636573);

-- --------------------------------------------------------

--
-- Структура таблицы `filearchive`
--

CREATE TABLE IF NOT EXISTS `filearchive` (
  `fa_id` int(11) NOT NULL AUTO_INCREMENT,
  `fa_name` varbinary(255) NOT NULL DEFAULT '',
  `fa_archive_name` varbinary(255) DEFAULT '',
  `fa_storage_group` varbinary(16) DEFAULT NULL,
  `fa_storage_key` varbinary(64) DEFAULT '',
  `fa_deleted_user` int(11) DEFAULT NULL,
  `fa_deleted_timestamp` binary(14) DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `fa_deleted_reason` varbinary(767) DEFAULT '',
  `fa_size` int(10) unsigned DEFAULT '0',
  `fa_width` int(11) DEFAULT '0',
  `fa_height` int(11) DEFAULT '0',
  `fa_metadata` mediumblob,
  `fa_bits` int(11) DEFAULT '0',
  `fa_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE') DEFAULT NULL,
  `fa_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart','chemical') DEFAULT 'unknown',
  `fa_minor_mime` varbinary(100) DEFAULT 'unknown',
  `fa_description` varbinary(767) DEFAULT NULL,
  `fa_user` int(10) unsigned DEFAULT '0',
  `fa_user_text` varbinary(255) DEFAULT NULL,
  `fa_timestamp` binary(14) DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `fa_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `fa_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`fa_id`),
  KEY `fa_name` (`fa_name`,`fa_timestamp`),
  KEY `fa_storage_group` (`fa_storage_group`,`fa_storage_key`),
  KEY `fa_deleted_timestamp` (`fa_deleted_timestamp`),
  KEY `fa_user_timestamp` (`fa_user_text`,`fa_timestamp`),
  KEY `fa_sha1` (`fa_sha1`(10))
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `image`
--

CREATE TABLE IF NOT EXISTS `image` (
  `img_name` varbinary(255) NOT NULL DEFAULT '',
  `img_size` int(10) unsigned NOT NULL DEFAULT '0',
  `img_width` int(11) NOT NULL DEFAULT '0',
  `img_height` int(11) NOT NULL DEFAULT '0',
  `img_metadata` mediumblob NOT NULL,
  `img_bits` int(11) NOT NULL DEFAULT '0',
  `img_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE') DEFAULT NULL,
  `img_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart','chemical') NOT NULL DEFAULT 'unknown',
  `img_minor_mime` varbinary(100) NOT NULL DEFAULT 'unknown',
  `img_description` varbinary(767) NOT NULL,
  `img_user` int(10) unsigned NOT NULL DEFAULT '0',
  `img_user_text` varbinary(255) NOT NULL,
  `img_timestamp` varbinary(14) NOT NULL DEFAULT '',
  `img_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`img_name`),
  KEY `img_usertext_timestamp` (`img_user_text`,`img_timestamp`),
  KEY `img_size` (`img_size`),
  KEY `img_timestamp` (`img_timestamp`),
  KEY `img_sha1` (`img_sha1`(10)),
  KEY `img_media_mime` (`img_media_type`,`img_major_mime`,`img_minor_mime`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `imagelinks`
--

CREATE TABLE IF NOT EXISTS `imagelinks` (
  `il_from` int(10) unsigned NOT NULL DEFAULT '0',
  `il_from_namespace` int(11) NOT NULL DEFAULT '0',
  `il_to` varbinary(255) NOT NULL DEFAULT '',
  UNIQUE KEY `il_from` (`il_from`,`il_to`),
  KEY `il_to` (`il_to`,`il_from`),
  KEY `il_backlinks_namespace` (`il_to`,`il_from_namespace`,`il_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `interwiki`
--

CREATE TABLE IF NOT EXISTS `interwiki` (
  `iw_prefix` varbinary(32) NOT NULL,
  `iw_url` blob NOT NULL,
  `iw_api` blob NOT NULL,
  `iw_wikiid` varbinary(64) NOT NULL,
  `iw_local` tinyint(1) NOT NULL,
  `iw_trans` tinyint(4) NOT NULL DEFAULT '0',
  UNIQUE KEY `iw_prefix` (`iw_prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

--
-- Дамп данных таблицы `interwiki`
--

INSERT INTO `interwiki` (`iw_prefix`, `iw_url`, `iw_api`, `iw_wikiid`, `iw_local`, `iw_trans`) VALUES
('acronym', 0x687474703a2f2f7777772e6163726f6e796d66696e6465722e636f6d2f7e2f7365617263682f61662e617370783f737472696e673d6578616374264163726f6e796d3d2431, '', '', 0, 0),
('advogato', 0x687474703a2f2f7777772e6164766f6761746f2e6f72672f2431, '', '', 0, 0),
('arxiv', 0x687474703a2f2f7777772e61727869762e6f72672f6162732f2431, '', '', 0, 0),
('c2find', 0x687474703a2f2f63322e636f6d2f6367692f77696b693f46696e64506167652676616c75653d2431, '', '', 0, 0),
('cache', 0x687474703a2f2f7777772e676f6f676c652e636f6d2f7365617263683f713d63616368653a2431, '', '', 0, 0),
('commons', 0x68747470733a2f2f636f6d6d6f6e732e77696b696d656469612e6f72672f77696b692f2431, 0x68747470733a2f2f636f6d6d6f6e732e77696b696d656469612e6f72672f772f6170692e706870, '', 0, 0),
('dictionary', 0x687474703a2f2f7777772e646963742e6f72672f62696e2f446963743f44617461626173653d2a26466f726d3d44696374312653747261746567793d2a2651756572793d2431, '', '', 0, 0),
('docbook', 0x687474703a2f2f77696b692e646f63626f6f6b2e6f72672f2431, '', '', 0, 0),
('doi', 0x687474703a2f2f64782e646f692e6f72672f2431, '', '', 0, 0),
('drumcorpswiki', 0x687474703a2f2f7777772e6472756d636f72707377696b692e636f6d2f2431, 0x687474703a2f2f6472756d636f72707377696b692e636f6d2f6170692e706870, '', 0, 0),
('dwjwiki', 0x687474703a2f2f7777772e737562657269632e6e65742f6367692d62696e2f64776a2f77696b692e6367693f2431, '', '', 0, 0),
('elibre', 0x687474703a2f2f656e6369636c6f70656469612e75732e65732f696e6465782e7068702f2431, 0x687474703a2f2f656e6369636c6f70656469612e75732e65732f6170692e706870, '', 0, 0),
('emacswiki', 0x687474703a2f2f7777772e656d61637377696b692e6f72672f6367692d62696e2f77696b692e706c3f2431, '', '', 0, 0),
('foldoc', 0x687474703a2f2f666f6c646f632e6f72672f3f2431, '', '', 0, 0),
('foxwiki', 0x687474703a2f2f666f782e77696b69732e636f6d2f77632e646c6c3f57696b697e2431, '', '', 0, 0),
('freebsdman', 0x687474703a2f2f7777772e467265654253442e6f72672f6367692f6d616e2e6367693f6170726f706f733d312671756572793d2431, '', '', 0, 0),
('gej', 0x687474703a2f2f7777772e6573706572616e746f2e64652f64656a2e6d616c6e6f76612f616b746976696b696f2e706c3f2431, '', '', 0, 0),
('gentoo-wiki', 0x687474703a2f2f67656e746f6f2d77696b692e636f6d2f2431, '', '', 0, 0),
('google', 0x687474703a2f2f7777772e676f6f676c652e636f6d2f7365617263683f713d2431, '', '', 0, 0),
('googlegroups', 0x687474703a2f2f67726f7570732e676f6f676c652e636f6d2f67726f7570733f713d2431, '', '', 0, 0),
('hammondwiki', 0x687474703a2f2f7777772e64616972696b692e6f72672f48616d6d6f6e6457696b692f2431, '', '', 0, 0),
('hrwiki', 0x687474703a2f2f7777772e687277696b692e6f72672f77696b692f2431, 0x687474703a2f2f7777772e687277696b692e6f72672f772f6170692e706870, '', 0, 0),
('imdb', 0x687474703a2f2f7777772e696d64622e636f6d2f66696e643f713d24312674743d6f6e, '', '', 0, 0),
('jargonfile', 0x687474703a2f2f73756e69722e6f72672f617070732f6d6574612e706c3f77696b693d4a6172676f6e46696c652672656469726563743d2431, '', '', 0, 0),
('kmwiki', 0x687474703a2f2f6b6d77696b692e77696b697370616365732e636f6d2f2431, '', '', 0, 0),
('linuxwiki', 0x687474703a2f2f6c696e757877696b692e64652f2431, '', '', 0, 0),
('lojban', 0x687474703a2f2f7777772e6c6f6a62616e2e6f72672f74696b692f74696b692d696e6465782e7068703f706167653d2431, '', '', 0, 0),
('lqwiki', 0x687474703a2f2f77696b692e6c696e75787175657374696f6e732e6f72672f77696b692f2431, '', '', 0, 0),
('lugkr', 0x687474703a2f2f7777772e6c75672d6b722e64652f77696b692f2431, '', '', 0, 0),
('meatball', 0x687474703a2f2f7777772e7573656d6f642e636f6d2f6367692d62696e2f6d622e706c3f2431, '', '', 0, 0),
('mediawikiwiki', 0x68747470733a2f2f7777772e6d6564696177696b692e6f72672f77696b692f2431, 0x68747470733a2f2f7777772e6d6564696177696b692e6f72672f772f6170692e706870, '', 0, 0),
('mediazilla', 0x68747470733a2f2f6275677a696c6c612e77696b696d656469612e6f72672f2431, '', '', 0, 0),
('memoryalpha', 0x687474703a2f2f656e2e6d656d6f72792d616c7068612e6f72672f77696b692f2431, 0x687474703a2f2f656e2e6d656d6f72792d616c7068612e6f72672f6170692e706870, '', 0, 0),
('metawiki', 0x687474703a2f2f73756e69722e6f72672f617070732f6d6574612e706c3f2431, '', '', 0, 0),
('metawikimedia', 0x68747470733a2f2f6d6574612e77696b696d656469612e6f72672f77696b692f2431, 0x68747470733a2f2f6d6574612e77696b696d656469612e6f72672f772f6170692e706870, '', 0, 0),
('mozillawiki', 0x687474703a2f2f77696b692e6d6f7a696c6c612e6f72672f2431, 0x68747470733a2f2f77696b692e6d6f7a696c6c612e6f72672f6170692e706870, '', 0, 0),
('mw', 0x68747470733a2f2f7777772e6d6564696177696b692e6f72672f77696b692f2431, 0x68747470733a2f2f7777772e6d6564696177696b692e6f72672f772f6170692e706870, '', 0, 0),
('oeis', 0x687474703a2f2f6f6569732e6f72672f2431, '', '', 0, 0),
('openwiki', 0x687474703a2f2f6f70656e77696b692e636f6d2f6f772e6173703f2431, '', '', 0, 0),
('ppr', 0x687474703a2f2f63322e636f6d2f6367692f77696b693f2431, '', '', 0, 0),
('pythoninfo', 0x687474703a2f2f77696b692e707974686f6e2e6f72672f6d6f696e2f2431, '', '', 0, 0),
('rfc', 0x687474703a2f2f7777772e7266632d656469746f722e6f72672f7266632f72666324312e747874, '', '', 0, 0),
('s23wiki', 0x687474703a2f2f7332332e6f72672f77696b692f2431, 0x687474703a2f2f7332332e6f72672f772f6170692e706870, '', 0, 0),
('seattlewireless', 0x687474703a2f2f73656174746c65776972656c6573732e6e65742f2431, '', '', 0, 0),
('senseislibrary', 0x687474703a2f2f73656e736569732e786d702e6e65742f3f2431, '', '', 0, 0),
('shoutwiki', 0x687474703a2f2f7777772e73686f757477696b692e636f6d2f77696b692f2431, 0x687474703a2f2f7777772e73686f757477696b692e636f6d2f772f6170692e706870, '', 0, 0),
('sourceforge', 0x687474703a2f2f736f75726365666f7267652e6e65742f2431, '', '', 0, 0),
('sourcewatch', 0x687474703a2f2f7777772e736f7572636577617463682e6f72672f696e6465782e7068703f7469746c653d2431, 0x687474703a2f2f7777772e736f7572636577617463682e6f72672f6170692e706870, '', 0, 0),
('squeak', 0x687474703a2f2f77696b692e73717565616b2e6f72672f73717565616b2f2431, '', '', 0, 0),
('tejo', 0x687474703a2f2f7777772e74656a6f2e6f72672f76696b696f2f2431, '', '', 0, 0),
('theopedia', 0x687474703a2f2f7777772e7468656f70656469612e636f6d2f2431, '', '', 0, 0),
('tmbw', 0x687474703a2f2f7777772e746d62772e6e65742f77696b692f2431, 0x687474703a2f2f746d62772e6e65742f77696b692f6170692e706870, '', 0, 0),
('tmnet', 0x687474703a2f2f7777772e746563686e6f6d616e69666573746f732e6e65742f3f2431, '', '', 0, 0),
('twiki', 0x687474703a2f2f7477696b692e6f72672f6367692d62696e2f766965772f2431, '', '', 0, 0),
('uea', 0x687474703a2f2f7565612e6f72672f76696b696f2f696e6465782e7068702f2431, 0x687474703a2f2f7565612e6f72672f76696b696f2f6170692e706870, '', 0, 0),
('uncyclopedia', 0x687474703a2f2f656e2e756e6379636c6f70656469612e636f2f77696b692f2431, 0x687474703a2f2f656e2e756e6379636c6f70656469612e636f2f772f6170692e706870, '', 0, 0),
('unreal', 0x687474703a2f2f77696b692e6265796f6e64756e7265616c2e636f6d2f2431, 0x687474703a2f2f77696b692e6265796f6e64756e7265616c2e636f6d2f772f6170692e706870, '', 0, 0),
('usemod', 0x687474703a2f2f7777772e7573656d6f642e636f6d2f6367692d62696e2f77696b692e706c3f2431, '', '', 0, 0),
('webseitzwiki', 0x687474703a2f2f776562736569747a2e666c7578656e742e636f6d2f77696b692f2431, '', '', 0, 0),
('wiki', 0x687474703a2f2f63322e636f6d2f6367692f77696b693f2431, '', '', 0, 0),
('wikia', 0x687474703a2f2f7777772e77696b69612e636f6d2f77696b692f2431, '', '', 0, 0),
('wikibooks', 0x68747470733a2f2f656e2e77696b69626f6f6b732e6f72672f77696b692f2431, 0x68747470733a2f2f656e2e77696b69626f6f6b732e6f72672f772f6170692e706870, '', 0, 0),
('wikif1', 0x687474703a2f2f7777772e77696b6966312e6f72672f2431, '', '', 0, 0),
('wikihow', 0x687474703a2f2f7777772e77696b69686f772e636f6d2f2431, 0x687474703a2f2f7777772e77696b69686f772e636f6d2f6170692e706870, '', 0, 0),
('wikimedia', 0x68747470733a2f2f77696b696d65646961666f756e646174696f6e2e6f72672f77696b692f2431, 0x68747470733a2f2f77696b696d65646961666f756e646174696f6e2e6f72672f772f6170692e706870, '', 0, 0),
('wikinews', 0x68747470733a2f2f656e2e77696b696e6577732e6f72672f77696b692f2431, 0x68747470733a2f2f656e2e77696b696e6577732e6f72672f772f6170692e706870, '', 0, 0),
('wikinfo', 0x687474703a2f2f77696b696e666f2e636f2f456e676c6973682f696e6465782e7068702f2431, '', '', 0, 0),
('wikipedia', 0x68747470733a2f2f656e2e77696b6970656469612e6f72672f77696b692f2431, 0x68747470733a2f2f656e2e77696b6970656469612e6f72672f772f6170692e706870, '', 0, 0),
('wikiquote', 0x68747470733a2f2f656e2e77696b6971756f74652e6f72672f77696b692f2431, 0x68747470733a2f2f656e2e77696b6971756f74652e6f72672f772f6170692e706870, '', 0, 0),
('wikisource', 0x68747470733a2f2f77696b69736f757263652e6f72672f77696b692f2431, 0x68747470733a2f2f77696b69736f757263652e6f72672f772f6170692e706870, '', 0, 0),
('wikispecies', 0x68747470733a2f2f737065636965732e77696b696d656469612e6f72672f77696b692f2431, 0x68747470733a2f2f737065636965732e77696b696d656469612e6f72672f772f6170692e706870, '', 0, 0),
('wikiversity', 0x68747470733a2f2f656e2e77696b69766572736974792e6f72672f77696b692f2431, 0x68747470733a2f2f656e2e77696b69766572736974792e6f72672f772f6170692e706870, '', 0, 0),
('wikivoyage', 0x68747470733a2f2f656e2e77696b69766f796167652e6f72672f77696b692f2431, 0x68747470733a2f2f656e2e77696b69766f796167652e6f72672f772f6170692e706870, '', 0, 0),
('wikt', 0x68747470733a2f2f656e2e77696b74696f6e6172792e6f72672f77696b692f2431, 0x68747470733a2f2f656e2e77696b74696f6e6172792e6f72672f772f6170692e706870, '', 0, 0),
('wiktionary', 0x68747470733a2f2f656e2e77696b74696f6e6172792e6f72672f77696b692f2431, 0x68747470733a2f2f656e2e77696b74696f6e6172792e6f72672f772f6170692e706870, '', 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `ipblocks`
--

CREATE TABLE IF NOT EXISTS `ipblocks` (
  `ipb_id` int(11) NOT NULL AUTO_INCREMENT,
  `ipb_address` tinyblob NOT NULL,
  `ipb_user` int(10) unsigned NOT NULL DEFAULT '0',
  `ipb_by` int(10) unsigned NOT NULL DEFAULT '0',
  `ipb_by_text` varbinary(255) NOT NULL DEFAULT '',
  `ipb_reason` varbinary(767) NOT NULL,
  `ipb_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `ipb_auto` tinyint(1) NOT NULL DEFAULT '0',
  `ipb_anon_only` tinyint(1) NOT NULL DEFAULT '0',
  `ipb_create_account` tinyint(1) NOT NULL DEFAULT '1',
  `ipb_enable_autoblock` tinyint(1) NOT NULL DEFAULT '1',
  `ipb_expiry` varbinary(14) NOT NULL DEFAULT '',
  `ipb_range_start` tinyblob NOT NULL,
  `ipb_range_end` tinyblob NOT NULL,
  `ipb_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `ipb_block_email` tinyint(1) NOT NULL DEFAULT '0',
  `ipb_allow_usertalk` tinyint(1) NOT NULL DEFAULT '0',
  `ipb_parent_block_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`ipb_id`),
  UNIQUE KEY `ipb_address` (`ipb_address`(255),`ipb_user`,`ipb_auto`,`ipb_anon_only`),
  KEY `ipb_user` (`ipb_user`),
  KEY `ipb_range` (`ipb_range_start`(8),`ipb_range_end`(8)),
  KEY `ipb_timestamp` (`ipb_timestamp`),
  KEY `ipb_expiry` (`ipb_expiry`),
  KEY `ipb_parent_block_id` (`ipb_parent_block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `iwlinks`
--

CREATE TABLE IF NOT EXISTS `iwlinks` (
  `iwl_from` int(10) unsigned NOT NULL DEFAULT '0',
  `iwl_prefix` varbinary(20) NOT NULL DEFAULT '',
  `iwl_title` varbinary(255) NOT NULL DEFAULT '',
  UNIQUE KEY `iwl_from` (`iwl_from`,`iwl_prefix`,`iwl_title`),
  KEY `iwl_prefix_title_from` (`iwl_prefix`,`iwl_title`,`iwl_from`),
  KEY `iwl_prefix_from_title` (`iwl_prefix`,`iwl_from`,`iwl_title`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `job`
--

CREATE TABLE IF NOT EXISTS `job` (
  `job_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `job_cmd` varbinary(60) NOT NULL DEFAULT '',
  `job_namespace` int(11) NOT NULL,
  `job_title` varbinary(255) NOT NULL,
  `job_timestamp` varbinary(14) DEFAULT NULL,
  `job_params` blob NOT NULL,
  `job_random` int(10) unsigned NOT NULL DEFAULT '0',
  `job_attempts` int(10) unsigned NOT NULL DEFAULT '0',
  `job_token` varbinary(32) NOT NULL DEFAULT '',
  `job_token_timestamp` varbinary(14) DEFAULT NULL,
  `job_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`job_id`),
  KEY `job_sha1` (`job_sha1`),
  KEY `job_cmd_token` (`job_cmd`,`job_token`,`job_random`),
  KEY `job_cmd_token_id` (`job_cmd`,`job_token`,`job_id`),
  KEY `job_cmd` (`job_cmd`,`job_namespace`,`job_title`,`job_params`(128)),
  KEY `job_timestamp` (`job_timestamp`)
) ENGINE=InnoDB  DEFAULT CHARSET=binary AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `job`
--

INSERT INTO `job` (`job_id`, `job_cmd`, `job_namespace`, `job_title`, `job_timestamp`, `job_params`, `job_random`, `job_attempts`, `job_token`, `job_token_timestamp`, `job_sha1`) VALUES
(1, 'recentChangesUpdate', -1, 'RecentChanges', '20151002172846', 0x613a313a7b733a343a2274797065223b733a353a227075726765223b7d, 2143697184, 0, '', NULL, '8ferf1wspb3h3lzdb9i3fqnhvidfu9q'),
(2, 'recentChangesUpdate', -1, 'RecentChanges', '20151002172846', 0x613a313a7b733a343a2274797065223b733a31313a226361636865557064617465223b7d, 955733599, 0, '', NULL, 't0ui7t0cg0b9prp29q7plzaevrijg70');

-- --------------------------------------------------------

--
-- Структура таблицы `l10n_cache`
--

CREATE TABLE IF NOT EXISTS `l10n_cache` (
  `lc_lang` varbinary(32) NOT NULL,
  `lc_key` varbinary(255) NOT NULL,
  `lc_value` mediumblob NOT NULL,
  KEY `lc_lang_key` (`lc_lang`,`lc_key`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `langlinks`
--

CREATE TABLE IF NOT EXISTS `langlinks` (
  `ll_from` int(10) unsigned NOT NULL DEFAULT '0',
  `ll_lang` varbinary(20) NOT NULL DEFAULT '',
  `ll_title` varbinary(255) NOT NULL DEFAULT '',
  UNIQUE KEY `ll_from` (`ll_from`,`ll_lang`),
  KEY `ll_lang` (`ll_lang`,`ll_title`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `logging`
--

CREATE TABLE IF NOT EXISTS `logging` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log_type` varbinary(32) NOT NULL DEFAULT '',
  `log_action` varbinary(32) NOT NULL DEFAULT '',
  `log_timestamp` binary(14) NOT NULL DEFAULT '19700101000000',
  `log_user` int(10) unsigned NOT NULL DEFAULT '0',
  `log_user_text` varbinary(255) NOT NULL DEFAULT '',
  `log_namespace` int(11) NOT NULL DEFAULT '0',
  `log_title` varbinary(255) NOT NULL DEFAULT '',
  `log_page` int(10) unsigned DEFAULT NULL,
  `log_comment` varbinary(767) NOT NULL DEFAULT '',
  `log_params` blob NOT NULL,
  `log_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`log_id`),
  KEY `type_time` (`log_type`,`log_timestamp`),
  KEY `user_time` (`log_user`,`log_timestamp`),
  KEY `page_time` (`log_namespace`,`log_title`,`log_timestamp`),
  KEY `times` (`log_timestamp`),
  KEY `log_user_type_time` (`log_user`,`log_type`,`log_timestamp`),
  KEY `log_page_id_time` (`log_page`,`log_timestamp`),
  KEY `type_action` (`log_type`,`log_action`,`log_timestamp`),
  KEY `log_user_text_type_time` (`log_user_text`,`log_type`,`log_timestamp`),
  KEY `log_user_text_time` (`log_user_text`,`log_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `log_search`
--

CREATE TABLE IF NOT EXISTS `log_search` (
  `ls_field` varbinary(32) NOT NULL,
  `ls_value` varbinary(255) NOT NULL,
  `ls_log_id` int(10) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `ls_field_val` (`ls_field`,`ls_value`,`ls_log_id`),
  KEY `ls_log_id` (`ls_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `module_deps`
--

CREATE TABLE IF NOT EXISTS `module_deps` (
  `md_module` varbinary(255) NOT NULL,
  `md_skin` varbinary(32) NOT NULL,
  `md_deps` mediumblob NOT NULL,
  UNIQUE KEY `md_module_skin` (`md_module`,`md_skin`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `msg_resource`
--

CREATE TABLE IF NOT EXISTS `msg_resource` (
  `mr_resource` varbinary(255) NOT NULL,
  `mr_lang` varbinary(32) NOT NULL,
  `mr_blob` mediumblob NOT NULL,
  `mr_timestamp` binary(14) NOT NULL,
  UNIQUE KEY `mr_resource_lang` (`mr_resource`,`mr_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `msg_resource_links`
--

CREATE TABLE IF NOT EXISTS `msg_resource_links` (
  `mrl_resource` varbinary(255) NOT NULL,
  `mrl_message` varbinary(255) NOT NULL,
  UNIQUE KEY `mrl_message_resource` (`mrl_message`,`mrl_resource`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `objectcache`
--

CREATE TABLE IF NOT EXISTS `objectcache` (
  `keyname` varbinary(255) NOT NULL DEFAULT '',
  `value` mediumblob,
  `exptime` datetime DEFAULT NULL,
  PRIMARY KEY (`keyname`),
  KEY `exptime` (`exptime`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

--
-- Дамп данных таблицы `objectcache`
--

INSERT INTO `objectcache` (`keyname`, `value`, `exptime`) VALUES
('mediawiki:pcache:idhash:1-0!*!*!*!*!*!*', 0xbd57e96edb4610ce6f3dc58645d003917848f241c90202d7895df8506325f969acc991b435b94bec2e2dab41803e429fb14fd2d9e552a62807489a22f425ceb5dfcccee5ab388c626f4aa5027955eaa2d45e3c08e28f2a1ec65e3e8307ed8d541cee45fdd81b1793b1d252f0c5e40252463fb03b469654915b004e549924a0d4bcccb235615c699a6590f6c6be53e98c7dd42f26c782ab32d3442f818c2991901d795ccc459689954734950bd047decd6d46f99d47928c2a75e4210e909c66441b446429617ee4f97e0e9af656082337787a422e7cf3e69f4256c4789006ae95377987cefda8c89b92a530f6e984cc854488f83ba79a094ef0bb548c2f2c2863812831d72b2aa1676177c6cb087d2f28af01e5abee12689a310e1e61e991f706b4460b37e8b7d4907a1347208e807140f5c9385fc588552b48ecc9055dc0917741192753fce811c738f2c2274c6c2b4fc63ec2ea8ccb6c32ced8c444f3ebc2b75aad7a3672c6e5c7e85d1790309ac517eb73ca1725c2f22f282f9182219db345296dd46e54050f03bc4527359d644c6913efb18ff03adf09e3eb57bf7b8dfcc4d75d08df90744bad0b15fbbef14db5722fa72ccb29b73c935efe067897722e4a9e40131aa200aa80183573cddf375ce722a178a2bdb21f6692729555d72a418952622d7b132703e411b4299d35f249e60c6d108f7d4cc44e67fcbcdb259d4b584da7e851ce34fa5908a93bc7d3774463b4b0d4502d26412f080e4cbe0b9eaace5b30beb4d8871bf6148d48611a0c9e7fcf14c37a205ca440128cab8e49df0f03fb6c8b2e8003a6654bf8e0515828fdcf5f7fc30316678a3d21c94a1453ec4f83c08f82c3fd701891dbb506d599415e608c80e08d9439b696cfc89db2c5129426d6a832159142a1973189fc41d039792800a9f780b56fba2e99635ed8ba71e00203aed3ed6e62692f078159538f466db0aad8929f5ebcccd54bbcac4cbdd40ee6cf1db483417c41f0311f02629f907449570beccf8d43aee93d18ff6b50094d6c2bd44b72076bb249a9b8b09c98a5d8f89771d80d9efff2f8454c100d2eec587941a2201c228628dc8f0e0643cb94602e0fd1b394841d6200d80133c06953a7e639e377ca1bd118e7d027e485c83b46871642326833ce78ca12aa856c320233bb98cea01e608771a3c7e2fb9e39ae758c5572b16bd2a306fd2c6d70f6cdf1395a6c4a1f20f135cbe01aa84c965785b9d926df387ae26a77836068066e1f417ee9481bb1384437f6fbf1ffd8c69dd1e1e03f19357dd759d84358dfda276b0f0fbe0ecc1774356bd95cc5d0a60f5e8531f654d26113bbae46ad37ba8d8391d339c535e20996c99f4bf1c6ac3d72bd453dc54de10ccbb261dfa4c98548cb0cdac95151af13c90adde4f51f797abdad36dcb02eb0ebb512d2e8fda6aa2b7f4f653bb3aba5ef5488a6f79889f9072a7995164daa73da52c3f8234327293af3d17aa44592c13d649b4c8a3df78e87c55e64fea28b766972c16cad38ae367999df82746aa15799623c8587260df1cca5c8b529f44691dfd4456e626f3ab298cf31c72da8fd7e7500e5c952c81688cdee36fa5457f2096e5bcee599b803e3f7ad75cde6c7548a02a4de6a4a466b76757c3abb3837e611420d053b926b8c75c7dbee8f5e6d16d54f38bdcd0c92eab408213f6b2ee9cf4cdf8387a9c858b26e9cd30f76045fd9b51cd29d56141decc89ac66487cbaf54d347c927ac9e9bc9fed60e9f5ad666417868ee1779d560ea26288d6ebb2bb423df7c8e826db115564d4beed0738e37e58ac2cd7e33cdad2f5195842ceedba4c39f6ab28f9c87dbda9b756057ff6057bfdf6fe9e3b2506d0a6e5130f37fcb48e08cb885c01a89b68dd4e3b95e22bec4463b0c9b25c02e165bda91d31e541e0c7614abe5a35e3aeccef1e4f1a1898133d1ba7cdcb0ee11f93126dfdd1f34b9c3daa9fb5db49b2aaf33ba68779d77cd84bc1c5565f31ea4b20dd5e640d8dbeb0d36b5736cb68e99cb90cfd44e54cbe18ac54c0bbeb4ffbad6d4b76ef5384bdd08f817, '2015-10-03 17:28:45'),
('mediawiki:pcache:idoptions:1', 0x458dc10ac2301044ff653fa0ec8624c6c9513c782a887a2f36600ed5d215514affdd4428de86f78699165bd0aebbded2290f89e0302bc48086b3a6be1d9ff971578a1d18f3a208455cd2a48552d4d226697c636b162eeebf548905191627cc46362658f7a366ededdf639e3e143382b7ccd5f9d51dd32bd797435fbdc4e50b, '2015-10-03 17:28:45');

-- --------------------------------------------------------

--
-- Структура таблицы `oldimage`
--

CREATE TABLE IF NOT EXISTS `oldimage` (
  `oi_name` varbinary(255) NOT NULL DEFAULT '',
  `oi_archive_name` varbinary(255) NOT NULL DEFAULT '',
  `oi_size` int(10) unsigned NOT NULL DEFAULT '0',
  `oi_width` int(11) NOT NULL DEFAULT '0',
  `oi_height` int(11) NOT NULL DEFAULT '0',
  `oi_bits` int(11) NOT NULL DEFAULT '0',
  `oi_description` varbinary(767) NOT NULL,
  `oi_user` int(10) unsigned NOT NULL DEFAULT '0',
  `oi_user_text` varbinary(255) NOT NULL,
  `oi_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `oi_metadata` mediumblob NOT NULL,
  `oi_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE') DEFAULT NULL,
  `oi_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart','chemical') NOT NULL DEFAULT 'unknown',
  `oi_minor_mime` varbinary(100) NOT NULL DEFAULT 'unknown',
  `oi_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `oi_sha1` varbinary(32) NOT NULL DEFAULT '',
  KEY `oi_usertext_timestamp` (`oi_user_text`,`oi_timestamp`),
  KEY `oi_name_timestamp` (`oi_name`,`oi_timestamp`),
  KEY `oi_name_archive_name` (`oi_name`,`oi_archive_name`(14)),
  KEY `oi_sha1` (`oi_sha1`(10))
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `page`
--

CREATE TABLE IF NOT EXISTS `page` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_namespace` int(11) NOT NULL,
  `page_title` varbinary(255) NOT NULL,
  `page_restrictions` tinyblob NOT NULL,
  `page_is_redirect` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `page_is_new` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `page_random` double unsigned NOT NULL,
  `page_touched` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `page_links_updated` varbinary(14) DEFAULT NULL,
  `page_latest` int(10) unsigned NOT NULL,
  `page_len` int(10) unsigned NOT NULL,
  `page_content_model` varbinary(32) DEFAULT NULL,
  `page_lang` varbinary(35) DEFAULT NULL,
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `name_title` (`page_namespace`,`page_title`),
  KEY `page_random` (`page_random`),
  KEY `page_len` (`page_len`),
  KEY `page_redirect_namespace_len` (`page_is_redirect`,`page_namespace`,`page_len`)
) ENGINE=InnoDB  DEFAULT CHARSET=binary AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `page`
--

INSERT INTO `page` (`page_id`, `page_namespace`, `page_title`, `page_restrictions`, `page_is_redirect`, `page_is_new`, `page_random`, `page_touched`, `page_links_updated`, `page_latest`, `page_len`, `page_content_model`, `page_lang`) VALUES
(1, 0, 'Main_Page', '', 0, 1, 0.681223696424, '20151002172845', '20151002172845', 1, 592, 'wikitext', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `pagelinks`
--

CREATE TABLE IF NOT EXISTS `pagelinks` (
  `pl_from` int(10) unsigned NOT NULL DEFAULT '0',
  `pl_from_namespace` int(11) NOT NULL DEFAULT '0',
  `pl_namespace` int(11) NOT NULL DEFAULT '0',
  `pl_title` varbinary(255) NOT NULL DEFAULT '',
  UNIQUE KEY `pl_from` (`pl_from`,`pl_namespace`,`pl_title`),
  KEY `pl_namespace` (`pl_namespace`,`pl_title`,`pl_from`),
  KEY `pl_backlinks_namespace` (`pl_namespace`,`pl_title`,`pl_from_namespace`,`pl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `page_props`
--

CREATE TABLE IF NOT EXISTS `page_props` (
  `pp_page` int(11) NOT NULL,
  `pp_propname` varbinary(60) NOT NULL,
  `pp_value` blob NOT NULL,
  `pp_sortkey` float DEFAULT NULL,
  UNIQUE KEY `pp_page_propname` (`pp_page`,`pp_propname`),
  UNIQUE KEY `pp_propname_page` (`pp_propname`,`pp_page`),
  UNIQUE KEY `pp_propname_sortkey_page` (`pp_propname`,`pp_sortkey`,`pp_page`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `page_restrictions`
--

CREATE TABLE IF NOT EXISTS `page_restrictions` (
  `pr_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pr_page` int(11) NOT NULL,
  `pr_type` varbinary(60) NOT NULL,
  `pr_level` varbinary(60) NOT NULL,
  `pr_cascade` tinyint(4) NOT NULL,
  `pr_user` int(11) DEFAULT NULL,
  `pr_expiry` varbinary(14) DEFAULT NULL,
  PRIMARY KEY (`pr_id`),
  UNIQUE KEY `pr_pagetype` (`pr_page`,`pr_type`),
  KEY `pr_typelevel` (`pr_type`,`pr_level`),
  KEY `pr_level` (`pr_level`),
  KEY `pr_cascade` (`pr_cascade`)
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `protected_titles`
--

CREATE TABLE IF NOT EXISTS `protected_titles` (
  `pt_namespace` int(11) NOT NULL,
  `pt_title` varbinary(255) NOT NULL,
  `pt_user` int(10) unsigned NOT NULL,
  `pt_reason` varbinary(767) DEFAULT NULL,
  `pt_timestamp` binary(14) NOT NULL,
  `pt_expiry` varbinary(14) NOT NULL DEFAULT '',
  `pt_create_perm` varbinary(60) NOT NULL,
  UNIQUE KEY `pt_namespace_title` (`pt_namespace`,`pt_title`),
  KEY `pt_timestamp` (`pt_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `querycache`
--

CREATE TABLE IF NOT EXISTS `querycache` (
  `qc_type` varbinary(32) NOT NULL,
  `qc_value` int(10) unsigned NOT NULL DEFAULT '0',
  `qc_namespace` int(11) NOT NULL DEFAULT '0',
  `qc_title` varbinary(255) NOT NULL DEFAULT '',
  KEY `qc_type` (`qc_type`,`qc_value`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `querycachetwo`
--

CREATE TABLE IF NOT EXISTS `querycachetwo` (
  `qcc_type` varbinary(32) NOT NULL,
  `qcc_value` int(10) unsigned NOT NULL DEFAULT '0',
  `qcc_namespace` int(11) NOT NULL DEFAULT '0',
  `qcc_title` varbinary(255) NOT NULL DEFAULT '',
  `qcc_namespacetwo` int(11) NOT NULL DEFAULT '0',
  `qcc_titletwo` varbinary(255) NOT NULL DEFAULT '',
  KEY `qcc_type` (`qcc_type`,`qcc_value`),
  KEY `qcc_title` (`qcc_type`,`qcc_namespace`,`qcc_title`),
  KEY `qcc_titletwo` (`qcc_type`,`qcc_namespacetwo`,`qcc_titletwo`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `querycache_info`
--

CREATE TABLE IF NOT EXISTS `querycache_info` (
  `qci_type` varbinary(32) NOT NULL DEFAULT '',
  `qci_timestamp` binary(14) NOT NULL DEFAULT '19700101000000',
  UNIQUE KEY `qci_type` (`qci_type`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `recentchanges`
--

CREATE TABLE IF NOT EXISTS `recentchanges` (
  `rc_id` int(11) NOT NULL AUTO_INCREMENT,
  `rc_timestamp` varbinary(14) NOT NULL DEFAULT '',
  `rc_user` int(10) unsigned NOT NULL DEFAULT '0',
  `rc_user_text` varbinary(255) NOT NULL,
  `rc_namespace` int(11) NOT NULL DEFAULT '0',
  `rc_title` varbinary(255) NOT NULL DEFAULT '',
  `rc_comment` varbinary(767) NOT NULL DEFAULT '',
  `rc_minor` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_bot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_new` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_cur_id` int(10) unsigned NOT NULL DEFAULT '0',
  `rc_this_oldid` int(10) unsigned NOT NULL DEFAULT '0',
  `rc_last_oldid` int(10) unsigned NOT NULL DEFAULT '0',
  `rc_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_source` varbinary(16) NOT NULL DEFAULT '',
  `rc_patrolled` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_ip` varbinary(40) NOT NULL DEFAULT '',
  `rc_old_len` int(11) DEFAULT NULL,
  `rc_new_len` int(11) DEFAULT NULL,
  `rc_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_logid` int(10) unsigned NOT NULL DEFAULT '0',
  `rc_log_type` varbinary(255) DEFAULT NULL,
  `rc_log_action` varbinary(255) DEFAULT NULL,
  `rc_params` blob,
  PRIMARY KEY (`rc_id`),
  KEY `rc_timestamp` (`rc_timestamp`),
  KEY `rc_namespace_title` (`rc_namespace`,`rc_title`),
  KEY `rc_cur_id` (`rc_cur_id`),
  KEY `new_name_timestamp` (`rc_new`,`rc_namespace`,`rc_timestamp`),
  KEY `rc_ip` (`rc_ip`),
  KEY `rc_ns_usertext` (`rc_namespace`,`rc_user_text`),
  KEY `rc_user_text` (`rc_user_text`,`rc_timestamp`)
) ENGINE=InnoDB  DEFAULT CHARSET=binary AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `recentchanges`
--

INSERT INTO `recentchanges` (`rc_id`, `rc_timestamp`, `rc_user`, `rc_user_text`, `rc_namespace`, `rc_title`, `rc_comment`, `rc_minor`, `rc_bot`, `rc_new`, `rc_cur_id`, `rc_this_oldid`, `rc_last_oldid`, `rc_type`, `rc_source`, `rc_patrolled`, `rc_ip`, `rc_old_len`, `rc_new_len`, `rc_deleted`, `rc_logid`, `rc_log_type`, `rc_log_action`, `rc_params`) VALUES
(1, '20151002172845', 0, 'MediaWiki default', 0, 'Main_Page', '', 0, 0, 1, 1, 1, 0, 1, 'mw.new', 0, '127.0.0.1', 0, 592, 0, 0, NULL, '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `redirect`
--

CREATE TABLE IF NOT EXISTS `redirect` (
  `rd_from` int(10) unsigned NOT NULL DEFAULT '0',
  `rd_namespace` int(11) NOT NULL DEFAULT '0',
  `rd_title` varbinary(255) NOT NULL DEFAULT '',
  `rd_interwiki` varbinary(32) DEFAULT NULL,
  `rd_fragment` varbinary(255) DEFAULT NULL,
  PRIMARY KEY (`rd_from`),
  KEY `rd_ns_title` (`rd_namespace`,`rd_title`,`rd_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `revision`
--

CREATE TABLE IF NOT EXISTS `revision` (
  `rev_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rev_page` int(10) unsigned NOT NULL,
  `rev_text_id` int(10) unsigned NOT NULL,
  `rev_comment` varbinary(767) NOT NULL,
  `rev_user` int(10) unsigned NOT NULL DEFAULT '0',
  `rev_user_text` varbinary(255) NOT NULL DEFAULT '',
  `rev_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `rev_minor_edit` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rev_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rev_len` int(10) unsigned DEFAULT NULL,
  `rev_parent_id` int(10) unsigned DEFAULT NULL,
  `rev_sha1` varbinary(32) NOT NULL DEFAULT '',
  `rev_content_model` varbinary(32) DEFAULT NULL,
  `rev_content_format` varbinary(64) DEFAULT NULL,
  PRIMARY KEY (`rev_id`),
  UNIQUE KEY `rev_page_id` (`rev_page`,`rev_id`),
  KEY `rev_timestamp` (`rev_timestamp`),
  KEY `page_timestamp` (`rev_page`,`rev_timestamp`),
  KEY `user_timestamp` (`rev_user`,`rev_timestamp`),
  KEY `usertext_timestamp` (`rev_user_text`,`rev_timestamp`),
  KEY `page_user_timestamp` (`rev_page`,`rev_user`,`rev_timestamp`)
) ENGINE=InnoDB  DEFAULT CHARSET=binary MAX_ROWS=10000000 AVG_ROW_LENGTH=1024 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `revision`
--

INSERT INTO `revision` (`rev_id`, `rev_page`, `rev_text_id`, `rev_comment`, `rev_user`, `rev_user_text`, `rev_timestamp`, `rev_minor_edit`, `rev_deleted`, `rev_len`, `rev_parent_id`, `rev_sha1`, `rev_content_model`, `rev_content_format`) VALUES
(1, 1, 1, '', 0, 'MediaWiki default', '20151002172845', 0, 0, 592, 0, 'glba3g2evzm40dqnqxegze66eqibkvb', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `searchindex`
--

CREATE TABLE IF NOT EXISTS `searchindex` (
  `si_page` int(10) unsigned NOT NULL,
  `si_title` varchar(255) NOT NULL DEFAULT '',
  `si_text` mediumtext NOT NULL,
  UNIQUE KEY `si_page` (`si_page`),
  FULLTEXT KEY `si_title` (`si_title`),
  FULLTEXT KEY `si_text` (`si_text`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `searchindex`
--

INSERT INTO `searchindex` (`si_page`, `si_title`, `si_text`) VALUES
(1, 'main page', ' mediawiki hasu800 been successfully installed. consult theu800 metau82ewikimediau82eorgu800 wiki help contents user user''su800 guide foru800 information onu800 using theu800 wiki software. getting started getting started getting started wwwu800u82emediawikiu82eorgu800 wiki special mylanguage manual configuration_settings configuration settings list wwwu800u82emediawikiu82eorgu800 wiki special mylanguage manual faqu800 mediawiki faqu800 mediawiki release mailing list wwwu800u82emediawikiu82eorgu800 wiki special mylanguage localisation#translation_resources localise mediawiki foru800 your language ');

-- --------------------------------------------------------

--
-- Структура таблицы `sites`
--

CREATE TABLE IF NOT EXISTS `sites` (
  `site_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_global_key` varbinary(32) NOT NULL,
  `site_type` varbinary(32) NOT NULL,
  `site_group` varbinary(32) NOT NULL,
  `site_source` varbinary(32) NOT NULL,
  `site_language` varbinary(32) NOT NULL,
  `site_protocol` varbinary(32) NOT NULL,
  `site_domain` varbinary(255) NOT NULL,
  `site_data` blob NOT NULL,
  `site_forward` tinyint(1) NOT NULL,
  `site_config` blob NOT NULL,
  PRIMARY KEY (`site_id`),
  UNIQUE KEY `sites_global_key` (`site_global_key`),
  KEY `sites_type` (`site_type`),
  KEY `sites_group` (`site_group`),
  KEY `sites_source` (`site_source`),
  KEY `sites_language` (`site_language`),
  KEY `sites_protocol` (`site_protocol`),
  KEY `sites_domain` (`site_domain`),
  KEY `sites_forward` (`site_forward`)
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_identifiers`
--

CREATE TABLE IF NOT EXISTS `site_identifiers` (
  `si_site` int(10) unsigned NOT NULL,
  `si_type` varbinary(32) NOT NULL,
  `si_key` varbinary(32) NOT NULL,
  UNIQUE KEY `site_ids_type` (`si_type`,`si_key`),
  KEY `site_ids_site` (`si_site`),
  KEY `site_ids_key` (`si_key`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `site_stats`
--

CREATE TABLE IF NOT EXISTS `site_stats` (
  `ss_row_id` int(10) unsigned NOT NULL,
  `ss_total_edits` bigint(20) unsigned DEFAULT '0',
  `ss_good_articles` bigint(20) unsigned DEFAULT '0',
  `ss_total_pages` bigint(20) DEFAULT '-1',
  `ss_users` bigint(20) DEFAULT '-1',
  `ss_active_users` bigint(20) DEFAULT '-1',
  `ss_images` int(11) DEFAULT '0',
  UNIQUE KEY `ss_row_id` (`ss_row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

--
-- Дамп данных таблицы `site_stats`
--

INSERT INTO `site_stats` (`ss_row_id`, `ss_total_edits`, `ss_good_articles`, `ss_total_pages`, `ss_users`, `ss_active_users`, `ss_images`) VALUES
(1, 1, 0, 1, 1, -1, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `tag_summary`
--

CREATE TABLE IF NOT EXISTS `tag_summary` (
  `ts_rc_id` int(11) DEFAULT NULL,
  `ts_log_id` int(11) DEFAULT NULL,
  `ts_rev_id` int(11) DEFAULT NULL,
  `ts_tags` blob NOT NULL,
  UNIQUE KEY `tag_summary_rc_id` (`ts_rc_id`),
  UNIQUE KEY `tag_summary_log_id` (`ts_log_id`),
  UNIQUE KEY `tag_summary_rev_id` (`ts_rev_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `templatelinks`
--

CREATE TABLE IF NOT EXISTS `templatelinks` (
  `tl_from` int(10) unsigned NOT NULL DEFAULT '0',
  `tl_from_namespace` int(11) NOT NULL DEFAULT '0',
  `tl_namespace` int(11) NOT NULL DEFAULT '0',
  `tl_title` varbinary(255) NOT NULL DEFAULT '',
  UNIQUE KEY `tl_from` (`tl_from`,`tl_namespace`,`tl_title`),
  KEY `tl_namespace` (`tl_namespace`,`tl_title`,`tl_from`),
  KEY `tl_backlinks_namespace` (`tl_namespace`,`tl_title`,`tl_from_namespace`,`tl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `text`
--

CREATE TABLE IF NOT EXISTS `text` (
  `old_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `old_text` mediumblob NOT NULL,
  `old_flags` tinyblob NOT NULL,
  PRIMARY KEY (`old_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=binary MAX_ROWS=10000000 AVG_ROW_LENGTH=10240 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `text`
--

INSERT INTO `text` (`old_id`, `old_text`, `old_flags`) VALUES
(1, 0x3c7374726f6e673e4d6564696157696b6920686173206265656e207375636365737366756c6c7920696e7374616c6c65642e3c2f7374726f6e673e0a0a436f6e73756c7420746865205b2f2f6d6574612e77696b696d656469612e6f72672f77696b692f48656c703a436f6e74656e7473205573657227732047756964655d20666f7220696e666f726d6174696f6e206f6e207573696e67207468652077696b6920736f6674776172652e0a0a3d3d2047657474696e672073746172746564203d3d0a2a205b2f2f7777772e6d6564696177696b692e6f72672f77696b692f5370656369616c3a4d794c616e67756167652f4d616e75616c3a436f6e66696775726174696f6e5f73657474696e677320436f6e66696775726174696f6e2073657474696e6773206c6973745d0a2a205b2f2f7777772e6d6564696177696b692e6f72672f77696b692f5370656369616c3a4d794c616e67756167652f4d616e75616c3a464151204d6564696157696b69204641515d0a2a205b68747470733a2f2f6c697374732e77696b696d656469612e6f72672f6d61696c6d616e2f6c697374696e666f2f6d6564696177696b692d616e6e6f756e6365204d6564696157696b692072656c65617365206d61696c696e67206c6973745d0a2a205b2f2f7777772e6d6564696177696b692e6f72672f77696b692f5370656369616c3a4d794c616e67756167652f4c6f63616c69736174696f6e235472616e736c6174696f6e5f7265736f7572636573204c6f63616c697365204d6564696157696b6920666f7220796f7572206c616e67756167655d, 0x7574662d38);

-- --------------------------------------------------------

--
-- Структура таблицы `transcache`
--

CREATE TABLE IF NOT EXISTS `transcache` (
  `tc_url` varbinary(255) NOT NULL,
  `tc_contents` blob,
  `tc_time` binary(14) NOT NULL,
  UNIQUE KEY `tc_url_idx` (`tc_url`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `updatelog`
--

CREATE TABLE IF NOT EXISTS `updatelog` (
  `ul_key` varbinary(255) NOT NULL,
  `ul_value` blob,
  PRIMARY KEY (`ul_key`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

--
-- Дамп данных таблицы `updatelog`
--

INSERT INTO `updatelog` (`ul_key`, `ul_value`) VALUES
('filearchive-fa_major_mime-patch-fa_major_mime-chemical.sql', NULL),
('image-img_major_mime-patch-img_major_mime-chemical.sql', NULL),
('oldimage-oi_major_mime-patch-oi_major_mime-chemical.sql', NULL),
('updatelist-1.25.2-14438069260', 0x613a303a7b7d),
('user_former_groups-ufg_group-patch-ufg_group-length-increase-255.sql', NULL),
('user_groups-ug_group-patch-ug_group-length-increase-255.sql', NULL),
('user_properties-up_property-patch-up_property.sql', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `uploadstash`
--

CREATE TABLE IF NOT EXISTS `uploadstash` (
  `us_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `us_user` int(10) unsigned NOT NULL,
  `us_key` varbinary(255) NOT NULL,
  `us_orig_path` varbinary(255) NOT NULL,
  `us_path` varbinary(255) NOT NULL,
  `us_source_type` varbinary(50) DEFAULT NULL,
  `us_timestamp` varbinary(14) NOT NULL,
  `us_status` varbinary(50) NOT NULL,
  `us_chunk_inx` int(10) unsigned DEFAULT NULL,
  `us_props` blob,
  `us_size` int(10) unsigned NOT NULL,
  `us_sha1` varbinary(31) NOT NULL,
  `us_mime` varbinary(255) DEFAULT NULL,
  `us_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE') DEFAULT NULL,
  `us_image_width` int(10) unsigned DEFAULT NULL,
  `us_image_height` int(10) unsigned DEFAULT NULL,
  `us_image_bits` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`us_id`),
  UNIQUE KEY `us_key` (`us_key`),
  KEY `us_user` (`us_user`),
  KEY `us_timestamp` (`us_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varbinary(255) NOT NULL DEFAULT '',
  `user_real_name` varbinary(255) NOT NULL DEFAULT '',
  `user_password` tinyblob NOT NULL,
  `user_newpassword` tinyblob NOT NULL,
  `user_newpass_time` binary(14) DEFAULT NULL,
  `user_email` tinyblob NOT NULL,
  `user_touched` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `user_token` binary(32) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `user_email_authenticated` binary(14) DEFAULT NULL,
  `user_email_token` binary(32) DEFAULT NULL,
  `user_email_token_expires` binary(14) DEFAULT NULL,
  `user_registration` binary(14) DEFAULT NULL,
  `user_editcount` int(11) DEFAULT NULL,
  `user_password_expires` varbinary(14) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `user_email_token` (`user_email_token`),
  KEY `user_email` (`user_email`(50))
) ENGINE=InnoDB  DEFAULT CHARSET=binary AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `user_real_name`, `user_password`, `user_newpassword`, `user_newpass_time`, `user_email`, `user_touched`, `user_token`, `user_email_authenticated`, `user_email_token`, `user_email_token_expires`, `user_registration`, `user_editcount`, `user_password_expires`) VALUES
(1, 'Admin', '', 0x3a70626b6466323a7368613235363a31303030303a3132383a363852324f42742b71686e616e6752504475723474673d3d3a66326b635854566c7650764f306c764e2b6161335671727367374e785934365974466c6d6b305869785867546c7672726f6373555448384b36514962416275556a515776417870526643696d494f695754797931426e364875514f4b792f6f746131324d67332b50767a4f6f56584f367668677542576e445a326a46466c676f4373414c74502b7469685344487557357a4141326a5967596e597142385144733351597066356c697267593d, '', NULL, 0x6578616d706c65406578616d706c652e636f6d, '20151002172849', '12c6a4762b329cdafa0bc75064a6ea01', NULL, NULL, NULL, '20151002172843', 0, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `user_former_groups`
--

CREATE TABLE IF NOT EXISTS `user_former_groups` (
  `ufg_user` int(10) unsigned NOT NULL DEFAULT '0',
  `ufg_group` varbinary(255) NOT NULL DEFAULT '',
  UNIQUE KEY `ufg_user_group` (`ufg_user`,`ufg_group`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `user_groups`
--

CREATE TABLE IF NOT EXISTS `user_groups` (
  `ug_user` int(10) unsigned NOT NULL DEFAULT '0',
  `ug_group` varbinary(255) NOT NULL DEFAULT '',
  UNIQUE KEY `ug_user_group` (`ug_user`,`ug_group`),
  KEY `ug_group` (`ug_group`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

--
-- Дамп данных таблицы `user_groups`
--

INSERT INTO `user_groups` (`ug_user`, `ug_group`) VALUES
(1, 'bureaucrat'),
(1, 'sysop');

-- --------------------------------------------------------

--
-- Структура таблицы `user_newtalk`
--

CREATE TABLE IF NOT EXISTS `user_newtalk` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `user_ip` varbinary(40) NOT NULL DEFAULT '',
  `user_last_timestamp` varbinary(14) DEFAULT NULL,
  KEY `user_id` (`user_id`),
  KEY `user_ip` (`user_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `user_properties`
--

CREATE TABLE IF NOT EXISTS `user_properties` (
  `up_user` int(11) NOT NULL,
  `up_property` varbinary(255) NOT NULL,
  `up_value` blob,
  UNIQUE KEY `user_properties_user_property` (`up_user`,`up_property`),
  KEY `user_properties_property` (`up_property`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `valid_tag`
--

CREATE TABLE IF NOT EXISTS `valid_tag` (
  `vt_tag` varbinary(255) NOT NULL,
  PRIMARY KEY (`vt_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Структура таблицы `watchlist`
--

CREATE TABLE IF NOT EXISTS `watchlist` (
  `wl_user` int(10) unsigned NOT NULL,
  `wl_namespace` int(11) NOT NULL DEFAULT '0',
  `wl_title` varbinary(255) NOT NULL DEFAULT '',
  `wl_notificationtimestamp` varbinary(14) DEFAULT NULL,
  UNIQUE KEY `wl_user` (`wl_user`,`wl_namespace`,`wl_title`),
  KEY `namespace_title` (`wl_namespace`,`wl_title`),
  KEY `wl_user_notificationtimestamp` (`wl_user`,`wl_notificationtimestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
