-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 26-10-2011 a las 01:17:51
-- Versión del servidor: 5.5.16
-- Versión de PHP: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `muucms`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_ads`
--

DROP TABLE IF EXISTS `muu_ads`;
CREATE TABLE IF NOT EXISTS `muu_ads` (
  `ID_Ad` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_User` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Title` varchar(100) NOT NULL,
  `Position` varchar(15) NOT NULL DEFAULT 'Right',
  `Banner` varchar(250) NOT NULL,
  `URL` varchar(250) NOT NULL,
  `Code` text NOT NULL,
  `Clicks` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Start_Date` int(11) NOT NULL DEFAULT '0',
  `End_Date` int(11) NOT NULL DEFAULT '0',
  `Time` mediumint(8) NOT NULL DEFAULT '5000',
  `Principal` tinyint(1) NOT NULL DEFAULT '0',
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Ad`),
  KEY `ID_User` (`ID_User`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `muu_ads`
--

INSERT INTO `muu_ads` (`ID_Ad`, `ID_User`, `Title`, `Position`, `Banner`, `URL`, `Code`, `Clicks`, `Start_Date`, `End_Date`, `Time`, `Principal`, `Situation`) VALUES
(1, 1, 'Anuncio 1', 'Top', 'www/lib/files/images/ads/de3a6_a0011-publicidad.png', 'http://www.zanphp.com', '', 0, 1317405693, 1319824893, 5000, 1, 'Active'),
(2, 1, 'Anuncio 2', 'Top', 'www/lib/files/images/ads/75d0f_bd47c-logoseptiembre.jpg', 'http://www.milkzoft.com', '', 0, 1317406037, 1319825237, 5000, 0, 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_applications`
--

DROP TABLE IF EXISTS `muu_applications`;
CREATE TABLE IF NOT EXISTS `muu_applications` (
  `ID_Application` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(45) NOT NULL,
  `Slug` varchar(45) NOT NULL,
  `CPanel` tinyint(1) NOT NULL DEFAULT '1',
  `Adding` tinyint(1) NOT NULL,
  `BeDefault` tinyint(1) NOT NULL DEFAULT '1',
  `Comments` tinyint(1) NOT NULL DEFAULT '0',
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Application`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

--
-- Volcado de datos para la tabla `muu_applications`
--

INSERT INTO `muu_applications` (`ID_Application`, `Title`, `Slug`, `CPanel`, `Adding`, `BeDefault`, `Comments`, `Situation`) VALUES
(1, 'Ads', 'ads', 1, 1, 0, 0, 'Active'),
(2, 'Applications', 'applications', 1, 1, 0, 0, 'Inactive'),
(3, 'Blog', 'blog', 1, 1, 1, 1, 'Active'),
(4, 'Categories', 'categories', 1, 1, 0, 0, 'Active'),
(5, 'Comments', 'comments', 1, 0, 0, 1, 'Active'),
(6, 'Configuration', 'configuration', 1, 0, 0, 0, 'Active'),
(7, 'Feedback', 'feedback', 1, 0, 0, 0, 'Active'),
(8, 'Forums', 'forums', 1, 1, 1, 0, 'Active'),
(9, 'Gallery', 'gallery', 1, 1, 1, 1, 'Active'),
(10, 'Links', 'links', 1, 1, 1, 0, 'Active'),
(11, 'Messages', 'messages', 1, 1, 0, 0, 'Active'),
(12, 'Pages', 'pages', 1, 1, 1, 0, 'Active'),
(13, 'Polls', 'polls', 1, 1, 0, 0, 'Active'),
(14, 'Support', 'support', 1, 1, 0, 0, 'Active'),
(15, 'Tags', 'tags', 1, 1, 0, 0, 'Active'),
(16, 'URL', 'url', 1, 1, 0, 0, 'Active'),
(17, 'Users', 'users', 1, 1, 0, 0, 'Active'),
(18, 'Videos', 'videos', 1, 1, 1, 0, 'Active'),
(19, 'Works', 'works', 1, 1, 1, 0, 'Active'),
(20, 'Hotels', 'hotels', 1, 1, 1, 0, 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_blog`
--

DROP TABLE IF EXISTS `muu_blog`;
CREATE TABLE IF NOT EXISTS `muu_blog` (
  `ID_Post` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_User` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ID_URL` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Title` varchar(250) NOT NULL,
  `Slug` varchar(250) NOT NULL,
  `Content` text NOT NULL,
  `Author` varchar(50) NOT NULL,
  `Start_Date` int(11) NOT NULL DEFAULT '0',
  `Text_Date` varchar(40) NOT NULL,
  `Year` varchar(4) NOT NULL,
  `Month` varchar(2) NOT NULL,
  `Day` varchar(2) NOT NULL,
  `Views` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Image_Small` varchar(250) DEFAULT NULL,
  `Image_Medium` varchar(250) NOT NULL,
  `Comments` mediumint(8) NOT NULL DEFAULT '0',
  `Enable_Comments` tinyint(1) NOT NULL DEFAULT '0',
  `Language` varchar(20) NOT NULL DEFAULT 'Spanish',
  `Pwd` varchar(40) NOT NULL,
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Post`),
  KEY `ID_User` (`ID_User`),
  KEY `ID_URL` (`ID_URL`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `muu_blog`
--

INSERT INTO `muu_blog` (`ID_Post`, `ID_User`, `ID_URL`, `Title`, `Slug`, `Content`, `Author`, `Start_Date`, `Text_Date`, `Year`, `Month`, `Day`, `Views`, `Image_Small`, `Image_Medium`, `Comments`, `Enable_Comments`, `Language`, `Pwd`, `Situation`) VALUES
(1, 1, 1, 'Villa Panamericana abre sus puertas en Guadalajara', 'villa-panamericana-abre-sus-puertas-en-guadalajara', '<p>Las chicas del equipo mexicano de balonmano bromean afuera del comedor. Al fondo, el edificio 4 de la Villa Panamericana ya est&aacute; adornado con banderas nacionales. Ah&iacute; estar&aacute;n todos los deportistas de este pa&iacute;s durante Guadalajara 2011.</p>\r\n<p><!-- pagebreak -->En una de las vialidades, frente a los departamentos que albergar&aacute;n a los deportistas mexicanos, la selecci&oacute;n nacional de judo estalla en una carcajada. Vanessa Zambotti reparti&oacute; chicles entre sus compa&ntilde;eros. Eran de picante. Cayeron en su trampa. No puede parar de re&iacute;r.</p>\r\n<p>Es el buen ambiente que se vive en la Villa Panamericana, que desde ayer se convirti&oacute; oficialmente en la casa de aproximadamente seis mil atletas que competir&aacute;n en Guadalajara 2011, luego de un acto protocolario en que fue entregado el complejo habitacional a la Organizaci&oacute;n Deportiva Panamericana.</p>\r\n<p>En la Plaza de las Banderas, el gobernador de Jalisco y presidente del Comit&eacute; Organizador de los Juegos Panamericanos (Copag), Emilio Gonz&aacute;lez M&aacute;rquez, hizo la entrega formal de la Villa. "Los problemas se han solucionado, los obst&aacute;culos se han resuelto, todos los contratiempos han quedado atr&aacute;s y queda ahora s&oacute;lo el entusiasmo de estos juegos que est&aacute;n ya muy cerca de dar inicio", dijo el mandatario estatal.</p>\r\n<p>"En este lugar, atletas de 42 pa&iacute;ses forjar&aacute;n esa ilusi&oacute;n de llevar triunfos deportivos a sus respectivos pa&iacute;ses. En este lugar es donde se dar&aacute; esa convivencia, reconoci&eacute;ndonos como iguales, como hermanos", a&ntilde;adi&oacute; Gonz&aacute;lez M&aacute;rquez, visiblemente emocionado ante la cercan&iacute;a de la justa continental, que arranca el 14 de octubre.</p>\r\n<p>Mario V&aacute;zquez Ra&ntilde;a, presidente de la Organizaci&oacute;n Deportiva Panamericana (Odepa), fue el encargado de recibir la casa que ya abri&oacute; sus puertas a los atletas de todo el continente. Reconoci&oacute; que tuvo dudas durante el proceso, pero ahora est&aacute; satisfecho de lo que ha encontrado.</p>\r\n<p>"Hicimos un recorrido (por distintas instalaciones panamericanas) y sin duda tuve que decir que es una categor&iacute;a que supera los Juegos Ol&iacute;mpicos. Les puedo decir que me siento satisfecho de todo lo que se ha hecho, porque cuando venimos aqu&iacute; y vimos el terreno (para la Villa), la situaci&oacute;n era como para ponerse a llorar, los d&iacute;as se ven&iacute;an encima y nunca hubiera so&ntilde;ado que hoy tuvi&eacute;ramos esto terminado", admiti&oacute;.</p>\r\n<p>Enseguida, cadetes del Colegio del Aire izaron las primeras banderas de la Villa Panamericana: la de los Juegos de Guadalajara 2011, la del Comit&eacute; Ol&iacute;mpico Internacional y la de la Organizaci&oacute;n Deportiva Panamericana. Las tres ondean ya y en los pr&oacute;ximos d&iacute;as se les unir&aacute;n las de 42 pa&iacute;ses que luchar&aacute;n desde el 14 de octubre por alcanzar la gloria.</p>', 'Carlos Santana', 1317791460, 'Miércoles, 05 de Octubre de 2011', '2011', '10', '05', 11, 'www/lib/files/images/blog/small_b50bb_villac.jpg', 'www/lib/files/images/blog/medium_b50bb_villac.jpg', 0, 1, 'Spanish', '', 'Active'),
(2, 1, 1, 'Un muerto tras choques en Arizona por tormenta de arena', 'un-muerto-tras-choques-en-arizona-por-tormenta-de-arena', '<p><span id="contentNote">Una cegadora tormenta de arena caus&oacute; el martes <strong>tres colisiones m&uacute;ltiples</strong> en una transitada carrera de Arizona que dejaron al menos un muerto y 15 lesionados, informaron las autoridades.<br /> <!-- pagebreak --><br /> El Departamento de Seguridad P&uacute;blica de Arizona dijo que 24 veh&iacute;culos participaron en los tres choques sobre la Interestatal 10.Las dos primeras colisiones ocurrieron poco despu&eacute;s del mediod&iacute;a cerca de la localidad de Picacho, casi a la mitad del tramo entre Phoenix y Tucson. <br /> <br /> En esos incidentes hubo 16 unidades involucradas, incluyendo camiones con remolque.El vocero de Seguridad P&uacute;blica, Bart Graves, indic&oacute; que dos personas lesionadas en esos choques estaban en situaci&oacute;n "muy cr&iacute;tica" . <br /> <br /> La densa concentraci&oacute;n de arena en la atm&oacute;sfera impidi&oacute; que las autoridades utilizasen helic&oacute;pteros para llevarlas al hospital.<br /> <br /> La tercera colisi&oacute;n tuvo lugar entre ocho veh&iacute;culos casi dos horas despu&eacute;s al norte de la poblaci&oacute;n de Casa Grande. Graves dijo que no hubo muertos en este caso pero que dos personas sufrieron lesiones graves, pero sin riesgo mortal.</span></p>', 'Carlos Santana', 1318666102, 'Sábado, 15 de Octubre de 2011', '2011', '10', '15', 6, '', '', 0, 1, 'Spanish', '', 'Active'),
(3, 1, 1, 'Helicóptero se estrella en río Este de Nueva York', 'helicoptero-se-estrella-en-rio-este-de-nueva-york', '<p>Un helic&oacute;ptero se estrell&oacute; hoy en el r&iacute;o Este de Nueva York con cinco personas a bordo, de las que ya han sido rescatadas cuatro de ellas, y que ha ocasionado un fuerte despliegue de seguridad en la zona.<!-- pagebreak --></p>\r\n<p>Un portavoz policial confirm&oacute; a el accidente ocurri&oacute; en el helipuerto, que se ubica a la altura de la calle 34, y que por el momento no est&aacute;n claras las causas del incidente, que seg&uacute;n diversos medios estar&iacute;a relacionado con el despegue de la aeronave.</p>\r\n<p>Por su parte, un portavoz del Departamento de Bomberos de Nueva York confirm&oacute; que dos de las v&iacute;ctimas del accidente han sido trasladadas al cercano Hospital Bellevue, mientras que una tercera contin&uacute;a en el lugar del suceso, aunque se desconoce el estado de todas ellas.</p>\r\n<p>La operaci&oacute;n de rescate ha hecho que se trasladaran hasta la zona m&aacute;s de una docena de embarcaciones del servicio de guardacostas y de la Polic&iacute;a de Nueva York.</p>\r\n<p>La aeronave ha quedado completamente sumergida en aguas del r&iacute;o Este de Nueva York y varios equipos de submarinistas buscan a la quinta v&iacute;ctima.<br /> El portavoz de la Polic&iacute;a de Nueva York, Paul Browne, se&ntilde;al&oacute; a la prensa que la nave siniestrada es un helic&oacute;ptero comercial del tipo Bell 206.</p>\r\n<p>Las escenas que muestran las cadenas de televisi&oacute;n estadounidenses, con numerosas embarcaciones de rescate, recuerdan a la operaci&oacute;n que desplegaron el 15 de enero de 2009, cuando un avi&oacute;n de la aerol&iacute;nea US Airways se precipit&oacute; sobre las aguas del r&iacute;o Hudson (en el oeste de Nueva York) y la pericia de su piloto, el capit&aacute;n Chesley Sullenberger, salv&oacute; a las 155 personas a bordo.</p>', 'Carlos Santana', 1318666119, 'Sábado, 15 de Octubre de 2011', '2011', '10', '15', 3, '', '', 0, 1, 'Spanish', '', 'Active'),
(5, 1, 1, 'nueva entrada de prueba', 'nueva-entrada-de-prueba', '<p>nueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de</p>\r\n<p><!-- pagebreak --> pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de pruebanueva entrada de prueba</p>', 'Carlos Santana', 1318666142, 'Sábado, 15 de Octubre de 2011', '2011', '10', '15', 3, '', '', 0, 1, 'Spanish', '', 'Active'),
(6, 1, 1, 'entrada dos', 'entrada-dos', '<p>entrada dosentrada dosentrada dosentrada dosentrada dosentrada dosentrada dosentrada dosentrada dos</p>', 'Carlos Santana', 1318664792, 'Sábado, 15 de Octubre de 2011', '2011', '10', '15', 37, '', '', 0, 1, 'Spanish', '', 'Active'),
(7, 1, 1, 'steve jobs', 'steve-jobs', '<p>steve jobssteve jobssteve jobssteve jobssteve jobssteve jobssteve jobssteve jobssteve jobssteve jobsv</p>', 'Carlos Santana', 1318666825, 'Sábado, 15 de Octubre de 2011', '2011', '10', '15', 10, '', '', 0, 1, 'Spanish', '', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_categories`
--

DROP TABLE IF EXISTS `muu_categories`;
CREATE TABLE IF NOT EXISTS `muu_categories` (
  `ID_Category` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Parent` tinyint(4) DEFAULT '0',
  `Title` varchar(90) DEFAULT NULL,
  `Slug` varchar(90) DEFAULT NULL,
  `Language` varchar(10) DEFAULT NULL,
  `Situation` varchar(15) DEFAULT 'Active',
  PRIMARY KEY (`ID_Category`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Volcado de datos para la tabla `muu_categories`
--

INSERT INTO `muu_categories` (`ID_Category`, `ID_Parent`, `Title`, `Slug`, `Language`, `Situation`) VALUES
(1, 0, 'Noticias Internacionales', 'noticias-internacionales', 'Spanish', 'Active'),
(2, 0, 'Noticias Nacionales', 'noticias-nacionales', 'Spanish', 'Active'),
(3, 0, 'Noticias Estatales', 'noticias-estatales', 'Spanish', 'Active'),
(4, 0, 'Noticias Locales', 'noticias-locales', 'Spanish', 'Active'),
(5, 0, 'Deportes Extremos', 'deportes-extremos', 'Spanish', 'Active'),
(6, 0, 'Baloncesto', 'baloncesto', 'Spanish', 'Active'),
(7, 0, 'Box', 'box', 'Spanish', 'Active'),
(8, 0, 'Lucha Libre', 'lucha-libre', 'Spanish', 'Active'),
(9, 0, 'Fútbol', 'futbol', 'Spanish', 'Active'),
(10, 0, 'Muay Thai', 'muay-thai', 'Spanish', 'Active'),
(11, 0, 'Surfing', 'surfing', 'Spanish', 'Active'),
(12, 0, 'Voleyball', 'voleyball', 'Spanish', 'Active'),
(13, 0, 'Espectáculos', 'espectaculos', 'Spanish', 'Active'),
(14, 0, 'Ellas', 'ellas', 'Spanish', 'Active'),
(15, 0, 'Ellos', 'ellos', 'Spanish', 'Active'),
(16, 0, 'Antros', 'antros', 'Spanish', 'Active'),
(17, 0, 'Cumpleaños', 'cumpleanos', 'Spanish', 'Active'),
(18, 0, 'Bautizos', 'bautizos', 'Spanish', 'Active'),
(19, 0, 'XV Años', 'xv-anos', 'Spanish', 'Active'),
(20, 0, 'Bodas', 'bodas', 'Spanish', 'Active'),
(21, 0, 'Infantil', 'infantil', 'Spanish', 'Active'),
(22, 0, 'Cúpido', 'cupido', 'Spanish', 'Active'),
(23, 0, 'Playas', 'playas', 'Spanish', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_comments`
--

DROP TABLE IF EXISTS `muu_comments`;
CREATE TABLE IF NOT EXISTS `muu_comments` (
  `ID_Comment` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_User` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Comment` text NOT NULL,
  `Start_Date` int(11) NOT NULL,
  `Text_Date` varchar(40) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Email` varchar(60) NOT NULL,
  `Website` varchar(80) NOT NULL,
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Comment`),
  KEY `ID_User` (`ID_User`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_configuration`
--

DROP TABLE IF EXISTS `muu_configuration`;
CREATE TABLE IF NOT EXISTS `muu_configuration` (
  `ID_Configuration` tinyint(1) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Slogan_English` varchar(100) NOT NULL,
  `Slogan_Spanish` varchar(100) NOT NULL,
  `Slogan_French` varchar(100) NOT NULL,
  `Slogan_Portuguese` varchar(100) NOT NULL,
  `URL` varchar(60) NOT NULL,
  `Lang` varchar(2) NOT NULL DEFAULT 'en',
  `Language` varchar(25) NOT NULL DEFAULT 'English',
  `Theme` varchar(25) NOT NULL DEFAULT 'ZanPHP',
  `Gallery` varchar(30) NOT NULL DEFAULT 'Basic',
  `Validation` varchar(15) NOT NULL DEFAULT 'Super Admin',
  `Application` varchar(30) NOT NULL DEFAULT 'Blog',
  `Message` text NOT NULL,
  `Activation` varchar(10) NOT NULL DEFAULT 'Nobody',
  `Email_Recieve` varchar(50) NOT NULL,
  `Email_Send` varchar(50) NOT NULL DEFAULT '@domain.com',
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Configuration`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `muu_configuration`
--

INSERT INTO `muu_configuration` (`ID_Configuration`, `Name`, `Slogan_English`, `Slogan_Spanish`, `Slogan_French`, `Slogan_Portuguese`, `URL`, `Lang`, `Language`, `Theme`, `Gallery`, `Validation`, `Application`, `Message`, `Activation`, `Email_Recieve`, `Email_Send`, `Situation`) VALUES
(1, 'Vision 7', 'Vision 7', 'Vision 7', 'Vision 7', 'Vision 7', 'http://localhost/vision7', 'es', 'Spanish', 'vision7', '1', 'Inactive', 'blog', '<p>Ups! sorry return later XD</p>', 'Admin', 'caarloshugo@gmail.com', 'webmaster@milkzoft.com', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_feedback`
--

DROP TABLE IF EXISTS `muu_feedback`;
CREATE TABLE IF NOT EXISTS `muu_feedback` (
  `ID_Feedback` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_User` mediumint(8) unsigned DEFAULT '0',
  `Name` varchar(100) NOT NULL,
  `Email` varchar(60) NOT NULL,
  `Company` varchar(50) NOT NULL,
  `Phone` varchar(16) NOT NULL,
  `City` varchar(50) NOT NULL,
  `Subject` varchar(200) NOT NULL,
  `Message` text NOT NULL,
  `Start_Date` int(11) NOT NULL,
  `Text_Date` varchar(60) NOT NULL,
  `Situation` varchar(15) NOT NULL DEFAULT 'Unread',
  PRIMARY KEY (`ID_Feedback`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

--
-- Volcado de datos para la tabla `muu_feedback`
--

INSERT INTO `muu_feedback` (`ID_Feedback`, `ID_User`, `Name`, `Email`, `Company`, `Phone`, `City`, `Subject`, `Message`, `Start_Date`, `Text_Date`, `Situation`) VALUES
(1, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318458453, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(2, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318458459, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(3, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318458578, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(4, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318458648, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(5, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318458661, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(6, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318458703, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(7, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318458809, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(8, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318458846, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(9, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318458856, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(10, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318458862, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(11, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318458885, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(12, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318458895, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(13, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318458963, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(14, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318459063, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(15, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318459170, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(16, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318459178, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(17, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318459182, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(18, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318459189, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(19, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318459196, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(20, 0, 'Carlos Hugo', 'carlos.hugo.gonzalez.castell@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318459223, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(21, 0, 'Carlos Hugo', 'carlos.hugo.gonzalez.castell@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318459832, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(22, 0, 'Carlos Hugo', 'carlos.hugo.gonzalez.castell@gmail.com', '', '', '', 'Saludos', 'pHola/p', 1318460202, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(23, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', 'Carlos', '330852', '', 'Caaros hugo', 'pasdasd/p', 1318460275, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(24, 0, 'Carlos Hugo', 'caarloshugo@gmail.com', 'Carlos', '330852', '', 'Caaros hugo', '<p>asdasd</p>', 1318460495, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(25, 0, 'Carlos Hugo Gónzalez', 'caarloshugo@gmail.com', 'Carlos Hugo Gónzalez', '330258', '', 'Carlos Hugo Gónzalez', '<p><strong>Carlos Hugo G&oacute;nzalez</strong></p>\r\n<p>&nbsp;</p>\r\n<ul>\r\n<li>sd</li>\r\n<li>sdsd</li>\r\n<li>sdf</li>\r\n<li>sdf</li>\r\n<li>dsf</li>\r\n</ul>', 1318460542, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(26, 0, 'Carlos Hugo Gónzalez', 'caarloshugo@gmail.com', 'Carlos Hugo Gónzalez', '330258', '', 'Carlos Hugo Gónzalez', '<p><strong>Carlos Hugo G&oacute;nzalez</strong></p>\r\n<p>&nbsp;</p>\r\n<ul>\r\n<li>sd</li>\r\n<li>sdsd</li>\r\n<li>sdf</li>\r\n<li>sdf</li>\r\n<li>dsf</li>\r\n</ul>', 1318460677, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(27, 0, 'Carlos Hugo Gónzalez', 'azapedia@gmail.com', 'Carlos Hugo Gónzalez', '330258', '', 'Carlos Hugo Gónzalez', '<p><strong>Carlos Hugo G&oacute;nzalez</strong></p>\r\n<p>&nbsp;</p>\r\n<ul>\r\n<li>sd</li>\r\n<li>sdsd</li>\r\n<li>sdf</li>\r\n<li>sdf</li>\r\n<li>dsf</li>\r\n</ul>', 1318460697, 'Jueves, 13 de Octubre de 2011', 'Read'),
(28, 0, 'Carlos Hugo Gónzalez', 'azapedia@gmail.com', 'Carlos Hugo Gónzalez', '330258', '', 'Carlos Hugo Gónzalez', '<p><strong>Carlos Hugo G&oacute;nzalez</strong></p>\r\n<p>&nbsp;</p>\r\n<ul>\r\n<li>sd</li>\r\n<li>sdsd</li>\r\n<li>sdf</li>\r\n<li>sdf</li>\r\n<li>dsf</li>\r\n</ul>', 1318461334, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(29, 0, 'Carlos Hugo Gónzalez', 'azapedia@gmail.com', 'Carlos Hugo Gónzalez', '330258', '', 'Carlos Hugo Gónzalez', '<p><strong>Carlos Hugo G&oacute;nzalez</strong></p>\r\n<p>&nbsp;</p>\r\n<ul>\r\n<li>sd</li>\r\n<li>sdsd</li>\r\n<li>sdf</li>\r\n<li>sdf</li>\r\n<li>dsf</li>\r\n</ul>', 1318461348, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(30, 0, 'Carlos Hugo Gónzalez', 'azapedia@gmail.com', 'Carlos Hugo Gónzalez', '330258', '', 'Carlos Hugo Gónzalez', '<p><strong>Carlos Hugo G&oacute;nzalez</strong></p>\r\n<p>&nbsp;</p>\r\n<ul>\r\n<li>sd</li>\r\n<li>sdsd</li>\r\n<li>sdf</li>\r\n<li>sdf</li>\r\n<li>dsf</li>\r\n</ul>', 1318461414, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(31, 0, 'Carlos Hugo Gónzalez', 'azapedia@gmail.com', 'Carlos Hugo Gónzalez', '330258', '', 'Carlos Hugo Gónzalez', '<p><strong>Carlos Hugo G&oacute;nzalez</strong></p>\r\n<p>&nbsp;</p>\r\n<ul>\r\n<li>sd</li>\r\n<li>sdsd</li>\r\n<li>sdf</li>\r\n<li>sdf</li>\r\n<li>dsf</li>\r\n</ul>', 1318461474, 'Jueves, 13 de Octubre de 2011', 'Inactive'),
(32, 0, 'Carlos Hugo Gónzalez', 'azapedia@gmail.com', 'Carlos Hugo Gónzalez', '330258', '', 'Carlos Hugo Gónzalez', '<p><strong>Carlos Hugo G&oacute;nzalez</strong></p>\r\n<p>&nbsp;</p>\r\n<ul>\r\n<li>sd</li>\r\n<li>sdsd</li>\r\n<li>sdf</li>\r\n<li>sdf</li>\r\n<li>dsf</li>\r\n</ul>', 1318461529, 'Jueves, 13 de Octubre de 2011', 'Read'),
(33, 0, 'Carlos Hugo Gónzalez', 'mounse.urzua@gmail.com', 'Carlos Hugo Gónzalez', '330258', '', 'Carlos Hugo Gónzalez', '<p><strong>Carlos Hugo G&oacute;nzalez</strong></p>\r\n<p>&nbsp;</p>\r\n<ul>\r\n<li>sd</li>\r\n<li>sdsd</li>\r\n<li>sdf</li>\r\n<li>sdf</li>\r\n<li>dsf</li>\r\n</ul>', 1318463047, 'Jueves, 13 de Octubre de 2011', 'Read'),
(34, 0, 'Carlos Hugo Gónzalez', 'mounse.urzua@gmail.com', 'Carlos Hugo Gónzalez', '330258', '', 'Carlos Hugo Gónzalez', '<p><strong>Carlos Hugo G&oacute;nzalez</strong></p>\r\n<p>&nbsp;</p>\r\n<ul>\r\n<li>sd</li>\r\n<li>sdsd</li>\r\n<li>sdf</li>\r\n<li>sdf</li>\r\n<li>dsf</li>\r\n</ul>', 1318463090, 'Jueves, 13 de Octubre de 2011', 'Read'),
(35, 0, 'Carlos Hugo Gónzalez', 'monse.urzua@gmail.com', 'Carlos Hugo Gónzalez', '330258', '', 'Carlos Hugo Gónzalez', '<p><strong>Carlos Hugo G&oacute;nzalez</strong></p>\r\n<p>&nbsp;</p>\r\n<ul>\r\n<li>sd</li>\r\n<li>sdsd</li>\r\n<li>sdf</li>\r\n<li>sdf</li>\r\n<li>dsf</li>\r\n</ul>', 1318463162, 'Jueves, 13 de Octubre de 2011', 'Read'),
(36, 0, 'Carlos Hugo Gónzalez', 'caarloshugo@gmail.com', 'Carlos Hugo Gónzalez', '330258', '', 'Carlos Hugo Gónzalez', '<p><strong>Carlos Hugo G&oacute;nzalez</strong></p>\r\n<p>&nbsp;</p>\r\n<ul>\r\n<li>sd</li>\r\n<li>sdsd</li>\r\n<li>sdf</li>\r\n<li>sdf</li>\r\n<li>dsf</li>\r\n</ul>', 1318463470, 'Jueves, 13 de Octubre de 2011', 'Read');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_forums`
--

DROP TABLE IF EXISTS `muu_forums`;
CREATE TABLE IF NOT EXISTS `muu_forums` (
  `ID_Forum` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(120) NOT NULL,
  `Slug` varchar(120) NOT NULL,
  `Description` varchar(250) NOT NULL,
  `Topics` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Replies` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Last_Reply` int(11) unsigned NOT NULL DEFAULT '0',
  `Last_Date` varchar(50) NOT NULL,
  `Language` varchar(20) NOT NULL DEFAULT 'Spanish',
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Forum`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `muu_forums`
--

INSERT INTO `muu_forums` (`ID_Forum`, `Title`, `Slug`, `Description`, `Topics`, `Replies`, `Last_Reply`, `Last_Date`, `Language`, `Situation`) VALUES
(1, 'Programación', 'programación', 'asdasaasñdlqwleñ3423$%$&$/&%YW$"#R!!""""''''''addsadasd', 0, 0, 0, '', 'Spanish', 'Active'),
(2, 'New Forum', 'new-forum', 'asdsadasdasd', 1, 1, 2, '', 'English', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_forums_posts`
--

DROP TABLE IF EXISTS `muu_forums_posts`;
CREATE TABLE IF NOT EXISTS `muu_forums_posts` (
  `ID_Post` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_User` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ID_Forum` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ID_Parent` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Title` varchar(150) NOT NULL,
  `Slug` varchar(150) NOT NULL,
  `Content` text NOT NULL,
  `Author` varchar(50) NOT NULL,
  `Start_Date` int(11) unsigned NOT NULL DEFAULT '0',
  `Text_Date` varchar(50) NOT NULL,
  `Hour` varchar(15) NOT NULL DEFAULT '00:00:00',
  `Visits` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Topic` tinyint(1) NOT NULL DEFAULT '0',
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Post`),
  KEY `ID_User` (`ID_User`),
  KEY `ID_Forum` (`ID_Forum`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `muu_forums_posts`
--

INSERT INTO `muu_forums_posts` (`ID_Post`, `ID_User`, `ID_Forum`, `ID_Parent`, `Title`, `Slug`, `Content`, `Author`, `Start_Date`, `Text_Date`, `Hour`, `Visits`, `Topic`, `Situation`) VALUES
(1, 1, 2, 0, 'sadasdasdasd', 'sadasdasdasd', '<p>lkasdkasjdkasjdaksd</p>', 'Carlos Santana', 1314834397, 'Thursday, September 01, 2011', '01:46:37', 5, 1, '1'),
(2, 1, 2, 1, 'Re: sadasdasdasd', 're-sadasdasdasd', '<p>sadsadasdasd</p>', 'Carlos Santana', 1314834408, 'Thursday, September 01, 2011', '01:46:48', 0, 0, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_gallery`
--

DROP TABLE IF EXISTS `muu_gallery`;
CREATE TABLE IF NOT EXISTS `muu_gallery` (
  `ID_Image` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_User` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Title` varchar(100) NOT NULL,
  `Slug` varchar(100) NOT NULL,
  `Description` varchar(250) NOT NULL,
  `Small` varchar(255) NOT NULL,
  `Medium` varchar(255) NOT NULL,
  `Original` varchar(255) NOT NULL,
  `Album` varchar(50) NOT NULL DEFAULT 'None',
  `Album_Slug` varchar(150) NOT NULL DEFAULT 'None',
  `Start_Date` int(11) NOT NULL,
  `Text_Date` varchar(50) NOT NULL,
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Image`),
  KEY `ID_User` (`ID_User`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_gallery_themes`
--

DROP TABLE IF EXISTS `muu_gallery_themes`;
CREATE TABLE IF NOT EXISTS `muu_gallery_themes` (
  `ID_Gallery_Theme` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(50) NOT NULL,
  `Slug` varchar(50) NOT NULL,
  `Description` varchar(200) NOT NULL,
  PRIMARY KEY (`ID_Gallery_Theme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_hotels`
--

DROP TABLE IF EXISTS `muu_hotels`;
CREATE TABLE IF NOT EXISTS `muu_hotels` (
  `ID_Hotel` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Parent` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Name` varchar(255) NOT NULL,
  `Slug` varchar(255) NOT NULL,
  `Category` varchar(45) DEFAULT '5 Estrellas',
  `Emails_Reservation` varchar(250) DEFAULT NULL,
  `Address` varchar(255) NOT NULL,
  `Country` varchar(100) NOT NULL,
  `District` varchar(100) NOT NULL,
  `Town` varchar(100) NOT NULL,
  `City` varchar(100) DEFAULT NULL,
  `Zip_Code` varchar(10) DEFAULT NULL,
  `Telephone` varchar(45) NOT NULL,
  `Area` varchar(10) DEFAULT NULL,
  `Views` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Website` varchar(255) DEFAULT NULL,
  `Latitude` varchar(20) DEFAULT NULL,
  `Longitude` varchar(20) DEFAULT NULL,
  `Author` varchar(50) NOT NULL,
  `Start_Date` int(11) NOT NULL,
  `Text_Date` varchar(40) NOT NULL,
  `Language` varchar(20) NOT NULL DEFAULT 'Spanish',
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Hotel`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `muu_hotels`
--

INSERT INTO `muu_hotels` (`ID_Hotel`, `ID_Parent`, `Name`, `Slug`, `Category`, `Emails_Reservation`, `Address`, `Country`, `District`, `Town`, `City`, `Zip_Code`, `Telephone`, `Area`, `Views`, `Website`, `Latitude`, `Longitude`, `Author`, `Start_Date`, `Text_Date`, `Language`, `Situation`) VALUES
(2, 0, 'Hotel de prueba', 'hotel-de-prueba', '5 estrellas', 'caarloshugo@gmail.com', 'Rio papalopan 46', 'México', 'Colima', 'Colima', 'Colima', '28973', '3308320', '312', 0, 'http://www.zanphp.com', '19.246623104620177', '-103.71214497987057', 'Carlos Santana', 1319584644, 'Miércoles, 26 de Octubre de 2011', 'Spanish', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_hotels_amenities`
--

DROP TABLE IF EXISTS `muu_hotels_amenities`;
CREATE TABLE IF NOT EXISTS `muu_hotels_amenities` (
  `ID_Amenity` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(250) NOT NULL,
  `Slug` varchar(250) NOT NULL,
  `Image` varchar(250) NOT NULL,
  `Language` varchar(20) NOT NULL DEFAULT 'Spanish',
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Amenity`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_hotels_contacts`
--

DROP TABLE IF EXISTS `muu_hotels_contacts`;
CREATE TABLE IF NOT EXISTS `muu_hotels_contacts` (
  `ID_Contact` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Hotel` mediumint(8) unsigned NOT NULL,
  `Contact_Manager` text,
  `Contact_Principal` text,
  `Contact_Accounting` text,
  `Contact_Reservation` text,
  `Contact_Property` text,
  PRIMARY KEY (`ID_Contact`),
  KEY `fk_muu_hotels_contacts_1` (`ID_Hotel`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `muu_hotels_contacts`
--

INSERT INTO `muu_hotels_contacts` (`ID_Contact`, `ID_Hotel`, `Contact_Manager`, `Contact_Principal`, `Contact_Accounting`, `Contact_Reservation`, `Contact_Property`) VALUES
(1, 2, '', '', '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_hotels_information`
--

DROP TABLE IF EXISTS `muu_hotels_information`;
CREATE TABLE IF NOT EXISTS `muu_hotels_information` (
  `ID_Hotel_Information` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Hotel` mediumint(8) unsigned NOT NULL,
  `Room_Number` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Year_Construction` varchar(5) DEFAULT NULL,
  `Year_Remodelation` varchar(5) DEFAULT NULL,
  `Agency_Commision` varchar(5) DEFAULT NULL,
  `In_Time` varchar(10) DEFAULT NULL,
  `Out_Time` varchar(10) DEFAULT NULL,
  `Max_Year_Children` tinyint(1) DEFAULT NULL,
  `Min_Days_Reservation` tinyint(1) DEFAULT NULL,
  `Days_Prev_Reservation` tinyint(1) DEFAULT NULL,
  `Days_Prev_Cancelation` tinyint(1) DEFAULT NULL,
  `Airport` text,
  `Near_Citys` text,
  `City_Activities` text,
  `Hotel_Activities` text,
  `Hotel_Near_Activities` text,
  `Restaurants_Bar` text,
  `Rooms_Information` text,
  `Hotel_Ubication` text,
  `Rates_Information` text,
  PRIMARY KEY (`ID_Hotel_Information`),
  KEY `fk_muu_hotels_information_1` (`ID_Hotel`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `muu_hotels_information`
--

INSERT INTO `muu_hotels_information` (`ID_Hotel_Information`, `ID_Hotel`, `Room_Number`, `Year_Construction`, `Year_Remodelation`, `Agency_Commision`, `In_Time`, `Out_Time`, `Max_Year_Children`, `Min_Days_Reservation`, `Days_Prev_Reservation`, `Days_Prev_Cancelation`, `Airport`, `Near_Citys`, `City_Activities`, `Hotel_Activities`, `Hotel_Near_Activities`, `Restaurants_Bar`, `Rooms_Information`, `Hotel_Ubication`, `Rates_Information`) VALUES
(1, 2, 46, '1986', '', '', '', '', 0, 0, 0, 0, '<p>cercano</p>', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_hotels_policy`
--

DROP TABLE IF EXISTS `muu_hotels_policy`;
CREATE TABLE IF NOT EXISTS `muu_hotels_policy` (
  `ID_Policy` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Hotel` mediumint(8) unsigned NOT NULL,
  `Cancellation_Policy` text,
  `No_Arrival_Policy` text,
  `Extra_Person_Policy` text,
  `Childrens_Policy` text,
  `Pets_Policy` text,
  `Pre_Policy` text,
  PRIMARY KEY (`ID_Policy`),
  KEY `fk_muu_hotels_policy_1` (`ID_Hotel`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `muu_hotels_policy`
--

INSERT INTO `muu_hotels_policy` (`ID_Policy`, `ID_Hotel`, `Cancellation_Policy`, `No_Arrival_Policy`, `Extra_Person_Policy`, `Childrens_Policy`, `Pets_Policy`, `Pre_Policy`) VALUES
(1, 2, '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_hotels_rates`
--

DROP TABLE IF EXISTS `muu_hotels_rates`;
CREATE TABLE IF NOT EXISTS `muu_hotels_rates` (
  `ID_Rate` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `Start_Date` int(11) NOT NULL,
  `End_Date` int(11) NOT NULL,
  `Start_Date_Text` varchar(45) NOT NULL,
  `End_Date_Text` varchar(45) NOT NULL,
  `Name` varchar(150) NOT NULL,
  `Cost` varchar(10) NOT NULL,
  `Language` varchar(20) NOT NULL DEFAULT 'Spanish',
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Rate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_hotels_rooms`
--

DROP TABLE IF EXISTS `muu_hotels_rooms`;
CREATE TABLE IF NOT EXISTS `muu_hotels_rooms` (
  `ID_Room` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(250) NOT NULL,
  `Slug` varchar(250) NOT NULL,
  `Bed_Type` varchar(250) NOT NULL,
  `Max_Occupation` tinyint(1) NOT NULL,
  `Number_Rooms` varchar(5) NOT NULL,
  `Description` text NOT NULL,
  `Language` varchar(20) NOT NULL DEFAULT 'Spanish',
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Room`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_links`
--

DROP TABLE IF EXISTS `muu_links`;
CREATE TABLE IF NOT EXISTS `muu_links` (
  `ID_Link` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_User` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Title` varchar(50) NOT NULL,
  `URL` varchar(100) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `Follow` tinyint(1) NOT NULL DEFAULT '1',
  `Position` varchar(10) NOT NULL DEFAULT 'Web Friend',
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Link`),
  KEY `ID_User` (`ID_User`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `muu_links`
--

INSERT INTO `muu_links` (`ID_Link`, `ID_User`, `Title`, `URL`, `Description`, `Follow`, `Position`, `Situation`) VALUES
(1, 1, 'ZanPHP', 'http://www.zanphp.com/', 'ZanPHP Framework PHP5', 1, 'Directory', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_logs`
--

DROP TABLE IF EXISTS `muu_logs`;
CREATE TABLE IF NOT EXISTS `muu_logs` (
  `ID_Log` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_User` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ID_Record` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Table_Name` varchar(50) NOT NULL,
  `Activity` varchar(100) NOT NULL,
  `Query` text NOT NULL,
  `Start_Date` datetime NOT NULL,
  PRIMARY KEY (`ID_Log`),
  KEY `ID_User` (`ID_User`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_messages`
--

DROP TABLE IF EXISTS `muu_messages`;
CREATE TABLE IF NOT EXISTS `muu_messages` (
  `ID_Message` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Parent` mediumint(8) unsigned NOT NULL,
  `ID_From_User` mediumint(8) unsigned NOT NULL,
  `ID_To_User` mediumint(8) unsigned NOT NULL,
  `Title` varchar(100) NOT NULL,
  `Slug` varchar(150) NOT NULL,
  `Message` text NOT NULL,
  `Start_Date` int(11) NOT NULL,
  `Text_Date` varchar(60) NOT NULL,
  `Situation` varchar(15) NOT NULL DEFAULT 'Unread',
  PRIMARY KEY (`ID_Message`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_mural`
--

DROP TABLE IF EXISTS `muu_mural`;
CREATE TABLE IF NOT EXISTS `muu_mural` (
  `ID_Mural` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Post` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Title` varchar(200) NOT NULL,
  `URL` varchar(250) NOT NULL,
  `Image` varchar(250) NOT NULL,
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Mural`),
  KEY `ID_Post` (`ID_Post`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `muu_mural`
--

INSERT INTO `muu_mural` (`ID_Mural`, `ID_Post`, `Title`, `URL`, `Image`, `Situation`) VALUES
(1, 1, 'Villa Panamericana abre sus puertas en Guadalajara', 'http://localhost/muucms/index.php/es/blog/2011/10/05/villa-panamericana-abre-sus-puertas-en-guadalajara', 'www/lib/files/images/mural/b50bb_85f3d-casas.jpg', 'Active'),
(2, 2, 'Un muerto tras choques en Arizona por tormenta de arena', 'http://localhost/muucms/index.php/es/blog/2011/10/05/un-muerto-tras-choques-en-arizona-por-tormenta-de-arena', 'www/lib/files/images/mural/df352_muralillo.png', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_pages`
--

DROP TABLE IF EXISTS `muu_pages`;
CREATE TABLE IF NOT EXISTS `muu_pages` (
  `ID_Page` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_User` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ID_Translation` mediumint(8) NOT NULL DEFAULT '0',
  `Title` varchar(100) NOT NULL,
  `Slug` varchar(100) NOT NULL,
  `Content` text NOT NULL,
  `Views` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Language` varchar(20) NOT NULL,
  `Principal` tinyint(1) NOT NULL DEFAULT '0',
  `Start_Date` int(11) NOT NULL,
  `Text_Date` varchar(40) NOT NULL,
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Page`),
  KEY `ID_User` (`ID_User`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `muu_pages`
--

INSERT INTO `muu_pages` (`ID_Page`, `ID_User`, `ID_Translation`, `Title`, `Slug`, `Content`, `Views`, `Language`, `Principal`, `Start_Date`, `Text_Date`, `Situation`) VALUES
(1, 1, 0, 'About', 'about', '<p>AboutAboutAboutAboutAboutAboutAboutAboutAboutAboutAboutAboutAbout</p>\r\n<p>AboutAboutAboutAboutAboutAboutAboutAboutAboutAbo</p>\r\n<p>utAboutAboutAboutAboutAboutAboutAboutAboutAboutAbo</p>\r\n<p>utAboutAboutAboutAboutAboutAboutAboutAboutAboutAboutAboutAboutAb</p>\r\n<p>outAboutAboutAboutAbout</p>', 0, 'English', 0, 1318712936, 'Saturday, October 15, 2011', 'Active'),
(2, 1, 0, 'About', 'about', '<p>AboutAboutAboutAboutAboutAboutAboutAboutAbout</p>\r\n<p>AboutAboutAboutAboutAboutAboutAboutAboutAboutAboutAboutv</p>\r\n<p>AboutAboutAboutAboutAboutAboutAboutAboutAboutAboutAboutv</p>\r\n<p>AboutAboutAboutAboutAboutAboutAboutAboutvv</p>', 0, 'Spanish', 0, 1318717031, 'Domingo, 16 de Octubre de 2011', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_polls`
--

DROP TABLE IF EXISTS `muu_polls`;
CREATE TABLE IF NOT EXISTS `muu_polls` (
  `ID_Poll` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_User` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Title` varchar(255) NOT NULL,
  `Type` varchar(10) DEFAULT 'Simple',
  `Start_Date` int(11) NOT NULL,
  `Text_Date` varchar(40) NOT NULL,
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Poll`),
  KEY `ID_User` (`ID_User`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `muu_polls`
--

INSERT INTO `muu_polls` (`ID_Poll`, `ID_User`, `Title`, `Type`, `Start_Date`, `Text_Date`, `Situation`) VALUES
(1, 1, '¿Qué pedo?', 'Simple', 1317848411, 'Miércoles, 05 de Octubre de 2011', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_polls_answers`
--

DROP TABLE IF EXISTS `muu_polls_answers`;
CREATE TABLE IF NOT EXISTS `muu_polls_answers` (
  `ID_Answer` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Poll` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Answer` varchar(100) NOT NULL,
  `Votes` mediumint(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID_Answer`),
  KEY `ID_Poll` (`ID_Poll`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `muu_polls_answers`
--

INSERT INTO `muu_polls_answers` (`ID_Answer`, `ID_Poll`, `Answer`, `Votes`) VALUES
(1, 1, 'Que paso', 0),
(2, 1, 'Quien sabe', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_polls_ips`
--

DROP TABLE IF EXISTS `muu_polls_ips`;
CREATE TABLE IF NOT EXISTS `muu_polls_ips` (
  `ID_Poll` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `IP` varchar(15) NOT NULL,
  `Start_Date` int(11) unsigned NOT NULL DEFAULT '0',
  `End_Date` int(11) unsigned NOT NULL DEFAULT '0',
  KEY `ID_Poll` (`ID_Poll`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_privileges`
--

DROP TABLE IF EXISTS `muu_privileges`;
CREATE TABLE IF NOT EXISTS `muu_privileges` (
  `ID_Privilege` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `Privilege` varchar(25) NOT NULL DEFAULT 'Member',
  PRIMARY KEY (`ID_Privilege`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `muu_privileges`
--

INSERT INTO `muu_privileges` (`ID_Privilege`, `Privilege`) VALUES
(1, 'Super Admin'),
(2, 'Admin'),
(3, 'Moderator'),
(4, 'Member');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_re_categories_applications`
--

DROP TABLE IF EXISTS `muu_re_categories_applications`;
CREATE TABLE IF NOT EXISTS `muu_re_categories_applications` (
  `ID_Category2Application` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Application` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ID_Category` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID_Category2Application`),
  KEY `ID_Application` (`ID_Application`),
  KEY `ID_Category` (`ID_Category`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Volcado de datos para la tabla `muu_re_categories_applications`
--

INSERT INTO `muu_re_categories_applications` (`ID_Category2Application`, `ID_Application`, `ID_Category`) VALUES
(1, 3, 1),
(2, 3, 2),
(3, 3, 3),
(4, 3, 4),
(5, 3, 5),
(6, 3, 6),
(7, 3, 7),
(8, 3, 8),
(9, 3, 9),
(10, 3, 10),
(11, 3, 11),
(12, 3, 12),
(13, 3, 13),
(14, 3, 14),
(15, 3, 15),
(16, 3, 16),
(17, 3, 17),
(18, 3, 18),
(19, 3, 19),
(20, 3, 20),
(21, 3, 21),
(22, 3, 22),
(23, 3, 23);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_re_categories_records`
--

DROP TABLE IF EXISTS `muu_re_categories_records`;
CREATE TABLE IF NOT EXISTS `muu_re_categories_records` (
  `ID_Category2Application` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ID_Record` mediumint(8) unsigned NOT NULL DEFAULT '0',
  KEY `ID_Category2Application` (`ID_Category2Application`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `muu_re_categories_records`
--

INSERT INTO `muu_re_categories_records` (`ID_Category2Application`, `ID_Record`) VALUES
(2, 1),
(1, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_re_comments_applications`
--

DROP TABLE IF EXISTS `muu_re_comments_applications`;
CREATE TABLE IF NOT EXISTS `muu_re_comments_applications` (
  `ID_Comment2Application` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Application` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ID_Comment` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID_Comment2Application`),
  KEY `ID_Application` (`ID_Application`),
  KEY `ID_Comment` (`ID_Comment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_re_comments_records`
--

DROP TABLE IF EXISTS `muu_re_comments_records`;
CREATE TABLE IF NOT EXISTS `muu_re_comments_records` (
  `ID_Comment2Application` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ID_Record` mediumint(8) unsigned NOT NULL DEFAULT '0',
  KEY `ID_Comment2Application` (`ID_Comment2Application`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_re_hotels_amenities`
--

DROP TABLE IF EXISTS `muu_re_hotels_amenities`;
CREATE TABLE IF NOT EXISTS `muu_re_hotels_amenities` (
  `ID_Amenity` mediumint(8) unsigned NOT NULL,
  `ID_Hotel` mediumint(8) unsigned NOT NULL,
  KEY `fk_muu_re_hotels_amenities_1` (`ID_Amenity`),
  KEY `fk_muu_re_hotels_amenities_2` (`ID_Hotel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_re_hotels_rates`
--

DROP TABLE IF EXISTS `muu_re_hotels_rates`;
CREATE TABLE IF NOT EXISTS `muu_re_hotels_rates` (
  `ID_Rate` mediumint(8) unsigned NOT NULL,
  `ID_Hotel` mediumint(8) unsigned NOT NULL,
  KEY `fk_muu_re_hotels_rates_1` (`ID_Rate`),
  KEY `fk_muu_re_hotels_rates_2` (`ID_Hotel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_re_hotels_rooms`
--

DROP TABLE IF EXISTS `muu_re_hotels_rooms`;
CREATE TABLE IF NOT EXISTS `muu_re_hotels_rooms` (
  `ID_Room` mediumint(8) unsigned NOT NULL,
  `ID_Hotel` mediumint(8) unsigned NOT NULL,
  KEY `fk_muu_re_hotels_rooms_1` (`ID_Room`),
  KEY `fk_muu_re_hotels_rooms_2` (`ID_Hotel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_re_permissions_privileges`
--

DROP TABLE IF EXISTS `muu_re_permissions_privileges`;
CREATE TABLE IF NOT EXISTS `muu_re_permissions_privileges` (
  `ID_Privilege` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ID_Application` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Adding` tinyint(1) NOT NULL DEFAULT '0',
  `Deleting` tinyint(1) NOT NULL DEFAULT '0',
  `Editing` tinyint(1) NOT NULL DEFAULT '0',
  `Viewing` tinyint(1) NOT NULL DEFAULT '0',
  KEY `ID_Privilege` (`ID_Privilege`),
  KEY `ID_Application` (`ID_Application`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `muu_re_permissions_privileges`
--

INSERT INTO `muu_re_permissions_privileges` (`ID_Privilege`, `ID_Application`, `Adding`, `Deleting`, `Editing`, `Viewing`) VALUES
(1, 1, 1, 1, 1, 1),
(1, 2, 1, 1, 1, 1),
(1, 3, 1, 1, 1, 1),
(1, 4, 1, 1, 1, 1),
(1, 5, 1, 1, 1, 1),
(1, 6, 1, 1, 1, 1),
(1, 7, 1, 1, 1, 1),
(1, 8, 1, 1, 1, 1),
(1, 9, 1, 1, 1, 1),
(1, 10, 1, 1, 1, 1),
(1, 11, 1, 1, 1, 1),
(1, 12, 1, 1, 1, 1),
(1, 13, 1, 1, 1, 1),
(1, 14, 1, 1, 1, 1),
(1, 15, 1, 1, 1, 1),
(1, 16, 1, 1, 1, 1),
(1, 17, 1, 1, 1, 1),
(1, 18, 1, 1, 1, 1),
(1, 19, 1, 1, 1, 1),
(2, 1, 1, 1, 1, 1),
(2, 2, 0, 0, 0, 0),
(2, 3, 1, 1, 1, 1),
(2, 4, 1, 1, 1, 1),
(2, 5, 0, 0, 0, 0),
(2, 6, 0, 0, 0, 0),
(2, 7, 0, 0, 0, 1),
(2, 8, 1, 1, 1, 1),
(2, 9, 1, 1, 1, 1),
(2, 10, 1, 1, 1, 1),
(2, 11, 1, 0, 1, 1),
(2, 12, 1, 1, 1, 1),
(2, 13, 1, 0, 0, 0),
(2, 14, 1, 1, 1, 1),
(2, 15, 1, 1, 1, 1),
(2, 16, 1, 1, 1, 1),
(2, 17, 1, 1, 1, 1),
(2, 18, 1, 1, 1, 1),
(2, 19, 1, 1, 1, 1),
(3, 1, 0, 0, 0, 0),
(3, 2, 0, 0, 0, 0),
(3, 3, 1, 0, 0, 1),
(3, 4, 1, 0, 0, 0),
(3, 5, 0, 0, 0, 0),
(3, 6, 0, 0, 0, 0),
(3, 7, 0, 0, 0, 0),
(3, 8, 1, 0, 0, 1),
(3, 9, 0, 0, 0, 0),
(3, 10, 0, 0, 0, 0),
(3, 11, 1, 0, 0, 1),
(3, 12, 0, 0, 0, 0),
(3, 13, 0, 0, 0, 0),
(3, 14, 0, 0, 0, 0),
(3, 15, 1, 0, 0, 1),
(3, 16, 1, 0, 0, 1),
(3, 17, 0, 0, 0, 0),
(3, 18, 1, 0, 0, 1),
(3, 19, 0, 0, 0, 0),
(4, 1, 0, 0, 0, 0),
(4, 2, 0, 0, 0, 0),
(4, 3, 0, 0, 0, 0),
(4, 4, 0, 0, 0, 0),
(4, 5, 0, 0, 0, 0),
(4, 6, 0, 0, 0, 0),
(4, 7, 0, 0, 0, 0),
(4, 8, 0, 0, 0, 0),
(4, 9, 0, 0, 0, 0),
(4, 10, 0, 0, 0, 0),
(4, 11, 0, 0, 0, 0),
(4, 12, 0, 0, 0, 0),
(4, 13, 0, 0, 0, 0),
(4, 14, 0, 0, 0, 0),
(4, 15, 0, 0, 0, 0),
(4, 16, 0, 0, 0, 0),
(4, 17, 0, 0, 0, 0),
(4, 18, 0, 0, 0, 0),
(4, 19, 0, 0, 0, 0),
(1, 20, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_re_privileges_users`
--

DROP TABLE IF EXISTS `muu_re_privileges_users`;
CREATE TABLE IF NOT EXISTS `muu_re_privileges_users` (
  `ID_Privilege` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ID_User` mediumint(8) unsigned NOT NULL DEFAULT '0',
  KEY `ID_Privilege` (`ID_Privilege`),
  KEY `ID_User` (`ID_User`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `muu_re_privileges_users`
--

INSERT INTO `muu_re_privileges_users` (`ID_Privilege`, `ID_User`) VALUES
(1, 1),
(4, 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_re_tags_applications`
--

DROP TABLE IF EXISTS `muu_re_tags_applications`;
CREATE TABLE IF NOT EXISTS `muu_re_tags_applications` (
  `ID_Tag2Application` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Application` mediumint(8) unsigned NOT NULL,
  `ID_Tag` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`ID_Tag2Application`),
  KEY `ID_Application` (`ID_Application`),
  KEY `ID_Tag` (`ID_Tag`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `muu_re_tags_applications`
--

INSERT INTO `muu_re_tags_applications` (`ID_Tag2Application`, `ID_Application`, `ID_Tag`) VALUES
(1, 3, 1),
(2, 3, 2),
(3, 3, 3),
(4, 3, 4),
(5, 3, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_re_tags_records`
--

DROP TABLE IF EXISTS `muu_re_tags_records`;
CREATE TABLE IF NOT EXISTS `muu_re_tags_records` (
  `ID_Tag2Application` mediumint(8) unsigned NOT NULL,
  `ID_Record` mediumint(8) unsigned NOT NULL,
  KEY `ID_Tag2Application` (`ID_Tag2Application`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `muu_re_tags_records`
--

INSERT INTO `muu_re_tags_records` (`ID_Tag2Application`, `ID_Record`) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(3, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_support`
--

DROP TABLE IF EXISTS `muu_support`;
CREATE TABLE IF NOT EXISTS `muu_support` (
  `ID_Ticket` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_User` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ID_Parent` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Title` varchar(250) NOT NULL,
  `Slug` varchar(250) NOT NULL,
  `Content` text NOT NULL,
  `Image` varchar(255) NOT NULL,
  `Code` varchar(10) NOT NULL,
  `Start_Date` int(11) NOT NULL DEFAULT '0',
  `Text_Date` varchar(40) NOT NULL,
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Ticket`),
  KEY `ID_User` (`ID_User`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_tags`
--

DROP TABLE IF EXISTS `muu_tags`;
CREATE TABLE IF NOT EXISTS `muu_tags` (
  `ID_Tag` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `Slug` varchar(255) NOT NULL,
  `Situation` varchar(15) NOT NULL DEFAULT 'Acitve',
  PRIMARY KEY (`ID_Tag`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `muu_tags`
--

INSERT INTO `muu_tags` (`ID_Tag`, `Title`, `Slug`, `Situation`) VALUES
(1, 'Panamericanos', 'panamericanos', 'Acitve'),
(2, 'Guadalajara', 'guadalajara', 'Acitve'),
(3, 'Accidentes', 'accidentes', 'Acitve'),
(4, 'Aviones', 'aviones', 'Acitve'),
(5, 'Helicopteros', 'helicopteros', 'Acitve');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_tokens`
--

DROP TABLE IF EXISTS `muu_tokens`;
CREATE TABLE IF NOT EXISTS `muu_tokens` (
  `ID_Token` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_User` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Token` varchar(40) NOT NULL,
  `Action` varchar(50) NOT NULL,
  `Start_Date` int(11) unsigned NOT NULL DEFAULT '0',
  `End_Date` int(11) unsigned NOT NULL DEFAULT '0',
  `Situation` varchar(10) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Token`),
  KEY `ID_User` (`ID_User`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_url`
--

DROP TABLE IF EXISTS `muu_url`;
CREATE TABLE IF NOT EXISTS `muu_url` (
  `ID_URL` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `URL` varchar(255) NOT NULL,
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_URL`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Volcado de datos para la tabla `muu_url`
--

INSERT INTO `muu_url` (`ID_URL`, `URL`, `Situation`) VALUES
(1, 'http://localhost/tudestino/index.php/es/blog/2011/09/30/publicacion-1', 'Active'),
(2, 'http://127.0.0.1/tudestino/index.php/es/blog/2011/10/02/se-estrello-un-avion', 'Active'),
(3, 'http://127.0.0.1/tudestino/index.php/es/blog/2011/10/02/una-noticia-de-espectaculos', 'Active'),
(4, 'http://127.0.0.1/tudestino/index.php/es/blog/2011/10/02/nueva-publicacion', 'Active'),
(5, 'http://127.0.0.1/tudestino/index.php/es/blog/2011/10/02/publicacion-1', 'Active'),
(6, 'http://127.0.0.1/tudestino/index.php/es/blog/2011/10/02/publicacion-2', 'Active'),
(7, 'http://127.0.0.1/tudestino/index.php/es/blog/2011/10/02/publicacion-3a', 'Active'),
(8, 'http://127.0.0.1/tudestino/index.php/es/blog/2011/10/02/publicacion-4', 'Active'),
(9, 'http://127.0.0.1/tudestino/index.php/es/blog/2011/10/02/otra-mas', 'Active'),
(10, 'http://127.0.0.1/tudestino/index.php/es/blog/2011/10/02/sdsadsadsad', 'Active'),
(11, 'http://127.0.0.1/tudestino/index.php/es/blog/2011/10/02/esta-noticia-tiene-un-titulo-bastante-largo-he-dicho-senores', 'Active'),
(12, 'http://127.0.0.1/tudestino/index.php/es/blog/2011/10/02/esta-noticia-tiene-un-titulo-bastante-largo-he-dicho-senores2', 'Active'),
(13, 'http://127.0.0.1/tudestino/index.php/es/blog/2011/10/02/esta-noticia-tiene-un-titulo-bastante-largo-he-dicho-senores3', 'Active'),
(14, 'http://127.0.0.1/tudestino/index.php/es/blog/2011/10/02/la-ultima-y-nos-vamos', 'Active'),
(15, 'http://127.0.0.1/tudestino/index.php/es/blog/2011/10/03/dsadasdasd', 'Active'),
(16, 'http://localhost/muucms/index.php/es/blog/2011/10/05/villa-panamericana-abre-sus-puertas-en-guadalajara', 'Active'),
(17, 'http://localhost/muucms/index.php/es/blog/2011/10/05/villa-panamericana-abre-sus-puertas-en-guadalajara', 'Active'),
(18, 'http://localhost/muucms/index.php/es/blog/2011/10/05/un-muerto-tras-choques-en-arizona-por-tormenta-de-arena', 'Active'),
(19, 'http://localhost/muucms/index.php/es/blog/2011/10/05/helicoptero-se-estrella-en-rio-este-de-nueva-york', 'Active'),
(20, 'http://localhost/muucms/index.php/es/blog/2011/10/05/europa-fuente-de-estres-financiero-bernanke', 'Active'),
(21, 'http://localhost/tudestino/index.php/es/blog/2011/10/15/nueva-entrada-de-prueba', 'Active'),
(22, 'http://localhost/tudestino/index.php/es/blog/2011/10/15/entrada-dos', 'Active'),
(23, 'http://localhost/tudestino/index.php/es/blog/2011/10/15/steve-jobs', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_users`
--

DROP TABLE IF EXISTS `muu_users`;
CREATE TABLE IF NOT EXISTS `muu_users` (
  `ID_User` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `Username` varchar(30) NOT NULL,
  `Pwd` varchar(40) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Website` varchar(100) DEFAULT NULL,
  `Avatar` varchar(200) DEFAULT NULL,
  `Rank` varchar(30) NOT NULL DEFAULT 'Member',
  `Sign` text,
  `Messages` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Recieve_Messages` tinyint(1) NOT NULL DEFAULT '1',
  `Topics` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Replies` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Visits` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Comments` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Subscribed` tinyint(1) NOT NULL DEFAULT '0',
  `Start_Date` int(11) NOT NULL,
  `Code` varchar(10) NOT NULL,
  `God` tinyint(1) NOT NULL DEFAULT '0',
  `Privilege` varchar(50) NOT NULL DEFAULT 'Member',
  `Type` varchar(30) NOT NULL DEFAULT 'Normal',
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_User`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `muu_users`
--

INSERT INTO `muu_users` (`ID_User`, `Username`, `Pwd`, `Email`, `Website`, `Avatar`, `Rank`, `Sign`, `Messages`, `Recieve_Messages`, `Topics`, `Replies`, `Visits`, `Comments`, `Subscribed`, `Start_Date`, `Code`, `God`, `Privilege`, `Type`, `Situation`) VALUES
(1, 'Carlos Santana', '99b94460aa941d668e60262be137c7187045ed45', 'carlos@milkzoft.com', 'www.facebook.com', 'lib/files/images/users/mini_6c2e9_tumblr_lhzl83rr8r1qho0hpo1_500.jpg', 'Administrator', '<p><em><strong>qweqleqwkeqwkneqwe</strong></em></p>\r\n<p><em><strong>qweqweqwe<br /></strong></em></p>', 0, 1, 9, 1, 92, 0, 0, 1304740493, '3628FB9CC0', 0, 'Super Admin', 'Normal', 'Active'),
(15, 'caarloshugo', '2b4f2eda0f53ea99ad419d155803f8ea15bc25aa', 'caarloshugo@gmail.com', NULL, NULL, 'Beginner', NULL, 0, 1, 0, 0, 0, 0, 0, 1319165127, 'D43F903963', 0, 'Member', 'Normal', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_users_information`
--

DROP TABLE IF EXISTS `muu_users_information`;
CREATE TABLE IF NOT EXISTS `muu_users_information` (
  `ID_User_Information` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_User` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Name` varchar(60) NOT NULL,
  `Phone` varchar(15) NOT NULL,
  `Company` varchar(50) NOT NULL,
  `Gender` varchar(20) NOT NULL,
  `Birthday` varchar(20) NOT NULL,
  `Country` varchar(50) NOT NULL,
  `District` varchar(50) NOT NULL,
  `Town` varchar(50) NOT NULL,
  `Facebook` varchar(100) NOT NULL,
  `Twitter` varchar(100) NOT NULL,
  `Linkedin` varchar(150) NOT NULL,
  `Google` varchar(150) NOT NULL,
  PRIMARY KEY (`ID_User_Information`),
  KEY `ID_User` (`ID_User`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `muu_users_information`
--

INSERT INTO `muu_users_information` (`ID_User_Information`, `ID_User`, `Name`, `Phone`, `Company`, `Gender`, `Birthday`, `Country`, `District`, `Town`, `Facebook`, `Twitter`, `Linkedin`, `Google`) VALUES
(1, 1, 'Carlos Santana Roldan', '', 'MilkZoft', 'Male', '11/09/1991', 'México', 'Colima', 'Colima', 'czantany', 'czantany', 'dasdadsa', '1241241241241241'),
(15, 15, '', '', '', '', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_users_online`
--

DROP TABLE IF EXISTS `muu_users_online`;
CREATE TABLE IF NOT EXISTS `muu_users_online` (
  `User` varchar(20) NOT NULL DEFAULT '',
  `Start_Date` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`User`),
  KEY `Date_Start` (`Start_Date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `muu_users_online`
--

INSERT INTO `muu_users_online` (`User`, `Start_Date`) VALUES
('Carlos Santana', 1314834244);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_users_online_anonymous`
--

DROP TABLE IF EXISTS `muu_users_online_anonymous`;
CREATE TABLE IF NOT EXISTS `muu_users_online_anonymous` (
  `IP` varchar(20) NOT NULL DEFAULT '',
  `Start_Date` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`IP`),
  KEY `Date_Start` (`Start_Date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_videos`
--

DROP TABLE IF EXISTS `muu_videos`;
CREATE TABLE IF NOT EXISTS `muu_videos` (
  `ID_Video` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_User` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ID_YouTube` varchar(20) NOT NULL,
  `Title` varchar(250) NOT NULL,
  `Slug` varchar(150) NOT NULL,
  `Description` text NOT NULL,
  `URL` varchar(250) NOT NULL,
  `Server` varchar(25) NOT NULL DEFAULT 'YouTube',
  `Duration` varchar(10) DEFAULT NULL,
  `Views` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Start_Date` int(11) NOT NULL,
  `Text_Date` varchar(40) NOT NULL,
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Video`),
  KEY `ID_User` (`ID_User`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Volcado de datos para la tabla `muu_videos`
--

INSERT INTO `muu_videos` (`ID_Video`, `ID_User`, `ID_YouTube`, `Title`, `Slug`, `Description`, `URL`, `Server`, `Duration`, `Views`, `Start_Date`, `Text_Date`, `Situation`) VALUES
(1, 1, 'N_1KfUDB1zU', 'Kan Mi Youn | Going Crazy (ft. MBLAQ''s Mir & Lee Joon)  [HD:MV] (ENG SUB)', 'kan-mi-youn-going-crazy-ft-mblaq-s-mir-lee-joon-hd-mv-eng-sub', 'Kan Mi Youn | Going Crazy (ft. MBLAQ''s Mir & Lee Joon)  [HD:MV] (ENG SUB)', 'http://www.youtube.com/watch?v=N_1KfUDB1zU', 'YouTube', NULL, 0, 1318226840, 'Lunes, 10 de Octubre de 2011', 'Active'),
(2, 1, 'ibvuhCoBkZo', 'Danny Don''t Know', 'danny-don-t-know', 'Danny Kass tried his hand at baseball, football, basketball and hockey in this Nike Snowboarding tribute to the iconic Nike Bo Know''s campaign. Snowboarder Magazine editor Pat Bridges makes a cameo and narrates as Danny fails to succeed at just about everything. Luckily, Danny Knows Snowboarding.', '', 'YouTube', NULL, 0, 1318227186, 'Lunes, 10 de Octubre de 2011', 'Active'),
(3, 1, 'BLGQbxwER9s', 'Nike Chosen: Week 3 Recap', 'nike-chosen-week-3-recap', 'Each week, we''ll show you the top crews from around the world that are bringing fresh and unexpected creativity to the Chosen crew video contest or creating buzz in Facebook.\r\n\r\nSee more and find out how your crew could be chosen to live like a pro at http://www.nike.com/chosen', '', 'YouTube', NULL, 0, 1318227186, 'Lunes, 10 de Octubre de 2011', 'Active'),
(4, 1, '3osb4IYOw2Q', 'Nike BetterWorld - History featuring Phil Knight', 'nike-betterworld-history-featuring-phil-knight', 'Learn about the history of Nike Better World from Nike Chairman and co-founder Phil Knight.', '', 'YouTube', NULL, 0, 1318227186, 'Lunes, 10 de Octubre de 2011', 'Active'),
(5, 1, 'KUmZp8pR1uc', 'Amy Winehouse - Rehab', 'amy-winehouse-rehab', 'Music video by Amy Winehouse performing Rehab. YouTube view counts pre-VEVO: 3,993,824. (C) 2006 Universal Island Records Ltd. A Universal Music Company.', '', 'YouTube', NULL, 0, 1318228680, 'Lunes, 10 de Octubre de 2011', 'Active'),
(6, 1, 'ibvuhCoBkZo', 'Danny Don''t Know', 'danny-don-t-know', 'Danny Kass tried his hand at baseball, football, basketball and hockey in this Nike Snowboarding tribute to the iconic Nike Bo Know''s campaign. Snowboarder Magazine editor Pat Bridges makes a cameo and narrates as Danny fails to succeed at just about everything. Luckily, Danny Knows Snowboarding.', '', 'YouTube', NULL, 0, 1318375906, 'Miércoles, 12 de Octubre de 2011', 'Active'),
(7, 1, 'KUmZp8pR1uc', 'Amy Winehouse - Rehab', 'amy-winehouse-rehab', 'Music video by Amy Winehouse performing Rehab. YouTube view counts pre-VEVO: 3,993,824. (C) 2006 Universal Island Records Ltd. A Universal Music Company.', '', 'YouTube', NULL, 0, 1318377296, 'Miércoles, 12 de Octubre de 2011', 'Active'),
(8, 1, '_OFMkCeP6ok', 'Tony Bennett & Amy Winehouse - Body And Soul', 'tony-bennett-amy-winehouse-body-and-soul', 'Music video by Tony Bennett & Amy Winehouse performing Body And Soul. (C) 2011 Sony Music Entertainment', '', 'YouTube', NULL, 0, 1318377296, 'Miércoles, 12 de Octubre de 2011', 'Active'),
(9, 1, 'euMu1SKi-ak', 'Ronaldooo', 'ronaldooo', 'Cristo', '', 'YouTube', NULL, 0, 1318379209, 'Miércoles, 12 de Octubre de 2011', 'Active'),
(10, 1, 'ibvuhCoBkZo', 'Danny Don''t Know', 'danny-don-t-know', 'Danny Kass tried his hand at baseball, football, basketball and hockey in this Nike Snowboarding tribute to the iconic Nike Bo Know''s campaign. Snowboarder Magazine editor Pat Bridges makes a cameo and narrates as Danny fails to succeed at just about everything. Luckily, Danny Knows Snowboarding.', '', 'YouTube', NULL, 0, 1318382055, 'Miércoles, 12 de Octubre de 2011', 'Active'),
(11, 1, 'mrncemuUbC8', 'The Nike MAG', 'the-nike-mag', 'Introducing the future of Nike Footwear. The 2011 Nike MAG shoes have arrived. 1500 of the famous, LED-electroluminescent shoes will be auctioned on eBay, Sept 8th - Sept 18th. All net proceeds from the auction sales will go directly to The Michael J. Fox Foundation for Parkinson''s Research.', '', 'YouTube', NULL, 0, 1318382161, 'Miércoles, 12 de Octubre de 2011', 'Active'),
(12, 1, '57IrhtYSi60', 'Nike Chosen Crew Contest Final Recap', 'nike-chosen-crew-contest-final-recap', 'Throughout the summer thousands of crews in the Nike Chosen crew video contest brought their creativity to the world stage. After Nike selected 9 crews from 12 countries to advance into Round 2, the worldwide community narrowed the field to three finalists during US Open, leaving it up to 28 top Nike athletes from surf, skate and BMX to choose the winning crew.  Congrats to Fus from Germany for being Chosen.  Let''s see how it all went down.', '', 'YouTube', NULL, 0, 1318382161, 'Miércoles, 12 de Octubre de 2011', 'Active'),
(13, 1, 's-_2Hrh_v-E', 'Nike CHOSEN crew contest: Round 1 Recap', 'nike-chosen-crew-contest-round-1-recap', 'During the past 8 weeks we''ve seen over 1,800 crews in 12 countries who submitted videos for the world to see.\r\n\r\nWe saw creativity and we saw style, we saw originality and we saw progression. Many thanks to all the crews who took the time to share their creative vision with us. Everyone obviously put blood, sweat and tears into their video, so without further delay let''s see who made it into round 2.\r\n\r\nRound 2 takes the CHOSEN to a whole new level. From now on it''s all about votes. To win crews will be hustling to get as many votes as they can from across the world. You have until 6pm PST on August 6th to cast your vote for the crew that catches your eye at http://www.nike.com/chosen.', '', 'YouTube', NULL, 0, 1318382381, 'Miércoles, 12 de Octubre de 2011', 'Active'),
(14, 1, '22unJBq5jIE', 'Nike CHOSEN: Noticed! episode 6 feat. a JUSTanDO ITinerÃƒÂ¡rio', 'nike-chosen-noticed-episode-6-feat-a-justando-itiner-rio', 'A Justando Itinerario has been Noticed! These guys have been catching the eyes of a lot of people throughout this entire campaign with their creative videos and unique crew personality. Check out what these Florianopolis, Brasil surfers have to say about their inspirations and how they''ve been successfully hustling their crew.\r\n\r\nFor more http://www.nike.com/chosen', '', 'YouTube', NULL, 0, 1318382381, 'Miércoles, 12 de Octubre de 2011', 'Active'),
(15, 1, 'tpNkNHy_6Bg', 'Fallen Kingdoms - Saison 01 - Jour 15', 'fallen-kingdoms-saison-01-jour-15', 'TÃƒÂ©lÃƒÂ©chargez la map sur le facebook : http://www.facebook.com/FallenKingdoms\r\n\r\nLe quinziÃƒÂ¨me  jour de l''aventure avec IndiaNatyu et Zelvac dans le monde de Fallen Kingdoms.\r\nPour connaÃƒÂ®tre les actions de nos ennemis Unsterblicher et Kigyar69  durant la mÃƒÂªme pÃƒÂ©riode rendez-vous ici: \r\nhttp://www.youtube.com/user/Unsterbliicher\r\n\r\nN''oubliez pas, vous pouvez retrouver les rÃƒÂ¨gles intÃƒÂ©grales ÃƒÂ  cette adresse: \r\nhttp://www.youtube.com/watch?v=Crb5KoCpYOo', '', 'YouTube', NULL, 0, 1318394262, 'Miércoles, 12 de Octubre de 2011', 'Active'),
(16, 1, 'lqSKVv6YO8g', 'The DL - Amy Winehouse ''Valerie'' Live', 'the-dl-amy-winehouse-valerie-live', 'For better sound and video quality, watch this on The DL: \r\ndl.aol.com', '', 'YouTube', NULL, 0, 1318394262, 'Miércoles, 12 de Octubre de 2011', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_works`
--

DROP TABLE IF EXISTS `muu_works`;
CREATE TABLE IF NOT EXISTS `muu_works` (
  `ID_Work` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(100) NOT NULL,
  `Slug` varchar(100) NOT NULL,
  `Preview1` varchar(200) NOT NULL,
  `Preview2` varchar(200) NOT NULL,
  `Image` varchar(200) NOT NULL,
  `URL` varchar(100) NOT NULL,
  `Description` text NOT NULL,
  `Situation` varchar(10) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Work`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_world`
--

DROP TABLE IF EXISTS `muu_world`;
CREATE TABLE IF NOT EXISTS `muu_world` (
  `Continent` varchar(20) NOT NULL,
  `Code` varchar(5) NOT NULL,
  `Country` varchar(100) NOT NULL,
  `District` varchar(100) NOT NULL,
  `Town` varchar(100) NOT NULL,
  KEY `District` (`District`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `muu_world`
--

INSERT INTO `muu_world` (`Continent`, `Code`, `Country`, `District`, `Town`) VALUES
('America', 'ARG', 'Argentina', 'Buenos Aires', ''),
('America', 'ARG', 'Argentina', 'Catamarca', ''),
('America', 'ARG', 'Argentina', 'Chaco', ''),
('America', 'ARG', 'Argentina', 'Chubut', ''),
('America', 'ARG', 'Argentina', 'C', ''),
('America', 'ARG', 'Argentina', 'Corrientes', ''),
('America', 'ARG', 'Argentina', 'Distrito Federal', ''),
('America', 'ARG', 'Argentina', 'Entre Rios', ''),
('America', 'ARG', 'Argentina', 'Formosa', ''),
('America', 'ARG', 'Argentina', 'Jujuy', ''),
('America', 'ARG', 'Argentina', 'La Rioja', ''),
('America', 'ARG', 'Argentina', 'Mendoza', ''),
('America', 'ARG', 'Argentina', 'Misiones', ''),
('America', 'ARG', 'Argentina', 'Neuqu', ''),
('America', 'ARG', 'Argentina', 'Salta', ''),
('America', 'ARG', 'Argentina', 'San Juan', ''),
('America', 'ARG', 'Argentina', 'San Luis', ''),
('America', 'ARG', 'Argentina', 'Santa F', ''),
('America', 'ARG', 'Argentina', 'Santiago del Estero', ''),
('America', 'ARG', 'Argentina', 'Tucum', ''),
('America', 'BLZ', 'Belize', 'Belize City', ''),
('America', 'BLZ', 'Belize', 'Cayo', ''),
('America', 'BOL', 'Bolivia', 'Chuquisaca', ''),
('America', 'BOL', 'Bolivia', 'Cochabamba', ''),
('America', 'BOL', 'Bolivia', 'La Paz', ''),
('America', 'BOL', 'Bolivia', 'Oruro', ''),
('America', 'BOL', 'Bolivia', 'Potos', ''),
('America', 'BOL', 'Bolivia', 'Santa Cruz', ''),
('America', 'BOL', 'Bolivia', 'Tarija', ''),
('America', 'BRA', 'Brazil', 'Acre', ''),
('America', 'BRA', 'Brazil', 'Alagoas', ''),
('America', 'BRA', 'Brazil', 'Amap', ''),
('America', 'BRA', 'Brazil', 'Amazonas', ''),
('America', 'BRA', 'Brazil', 'Bahia', ''),
('America', 'BRA', 'Brazil', 'Cear', ''),
('America', 'BRA', 'Brazil', 'Distrito Federal', ''),
('America', 'BRA', 'Brazil', 'Esp', ''),
('America', 'BRA', 'Brazil', 'Goi', ''),
('America', 'BRA', 'Brazil', 'Maranh', ''),
('America', 'BRA', 'Brazil', 'Mato Grosso', ''),
('America', 'BRA', 'Brazil', 'Mato Grosso do Sul', ''),
('America', 'BRA', 'Brazil', 'Minas Gerais', ''),
('America', 'BRA', 'Brazil', 'Par', ''),
('America', 'BRA', 'Brazil', 'Para', ''),
('America', 'BRA', 'Brazil', 'Paran', ''),
('America', 'BRA', 'Brazil', 'Pernambuco', ''),
('America', 'BRA', 'Brazil', 'Piau', ''),
('America', 'BRA', 'Brazil', 'Rio de Janeiro', ''),
('America', 'BRA', 'Brazil', 'Rio Grande do Norte', ''),
('America', 'BRA', 'Brazil', 'Rio Grande do Sul', ''),
('America', 'BRA', 'Brazil', 'Rond', ''),
('America', 'BRA', 'Brazil', 'Roraima', ''),
('America', 'BRA', 'Brazil', 'Santa Catarina', ''),
('America', 'BRA', 'Brazil', 'S', ''),
('America', 'BRA', 'Brazil', 'Sergipe', ''),
('America', 'BRA', 'Brazil', 'Tocantins', ''),
('America', 'CAN', 'Canada', 'Alberta', ''),
('America', 'CAN', 'Canada', 'British Colombia', ''),
('America', 'CAN', 'Canada', 'Manitoba', ''),
('America', 'CAN', 'Canada', 'Newfoundland', ''),
('America', 'CAN', 'Canada', 'Nova Scotia', ''),
('America', 'CAN', 'Canada', 'Ontario', ''),
('America', 'CAN', 'Canada', 'Qu', ''),
('America', 'CAN', 'Canada', 'Saskatchewan', ''),
('America', 'CHL', 'Chile', 'Antofagasta', ''),
('America', 'CHL', 'Chile', 'Atacama', ''),
('America', 'CHL', 'Chile', 'B', ''),
('America', 'CHL', 'Chile', 'Coquimbo', ''),
('America', 'CHL', 'Chile', 'La Araucan', ''),
('America', 'CHL', 'Chile', 'Los Lagos', ''),
('America', 'CHL', 'Chile', 'Magallanes', ''),
('America', 'CHL', 'Chile', 'Maule', ''),
('America', 'CHL', 'Chile', 'Santiago', ''),
('America', 'CHL', 'Chile', 'Tarapac', ''),
('America', 'CHL', 'Chile', 'Valpara', ''),
('America', 'COL', 'Colombia', 'Antioquia', ''),
('America', 'COL', 'Colombia', 'Atl', ''),
('America', 'COL', 'Colombia', 'Bol', ''),
('America', 'COL', 'Colombia', 'Boyac', ''),
('America', 'COL', 'Colombia', 'Caldas', ''),
('America', 'COL', 'Colombia', 'Caquet', ''),
('America', 'COL', 'Colombia', 'Cauca', ''),
('America', 'COL', 'Colombia', 'Cesar', ''),
('America', 'COL', 'Colombia', 'C', ''),
('America', 'COL', 'Colombia', 'Cundinamarca', ''),
('America', 'COL', 'Colombia', 'Huila', ''),
('America', 'COL', 'Colombia', 'La Guajira', ''),
('America', 'COL', 'Colombia', 'Magdalena', ''),
('America', 'COL', 'Colombia', 'Meta', ''),
('America', 'COL', 'Colombia', 'Norte de Santander', ''),
('America', 'COL', 'Colombia', 'Quind', ''),
('America', 'COL', 'Colombia', 'Risaralda', ''),
('America', 'COL', 'Colombia', 'Santaf', ''),
('America', 'COL', 'Colombia', 'Santander', ''),
('America', 'COL', 'Colombia', 'Sucre', ''),
('America', 'COL', 'Colombia', 'Tolima', ''),
('America', 'COL', 'Colombia', 'Valle', ''),
('America', 'CRI', 'Costa Rica', 'San Jos', ''),
('America', 'CUB', 'Cuba', 'Ciego de ', ''),
('America', 'CUB', 'Cuba', 'Cienfuegos', ''),
('America', 'CUB', 'Cuba', 'Granma', ''),
('America', 'CUB', 'Cuba', 'Guant', ''),
('America', 'CUB', 'Cuba', 'Holgu', ''),
('America', 'CUB', 'Cuba', 'La Habana', ''),
('America', 'CUB', 'Cuba', 'Las Tunas', ''),
('America', 'CUB', 'Cuba', 'Matanzas', ''),
('America', 'CUB', 'Cuba', 'Pinar del R', ''),
('America', 'CUB', 'Cuba', 'Santiago de Cuba', ''),
('America', 'CUB', 'Cuba', 'Villa Clara', ''),
('America', 'CYM', 'Cayman Islands', 'Grand Cayman', ''),
('America', 'DMA', 'Dominica', 'St George', ''),
('America', 'DOM', 'Dominican Republic', 'Distrito Nacional', ''),
('America', 'DOM', 'Dominican Republic', 'Duarte', ''),
('America', 'DOM', 'Dominican Republic', 'La Romana', ''),
('America', 'DOM', 'Dominican Republic', 'Puerto Plata', ''),
('America', 'DOM', 'Dominican Republic', 'San Pedro de Macor', ''),
('America', 'DOM', 'Dominican Republic', 'Santiago', ''),
('America', 'ECU', 'Ecuador', 'Azuay', ''),
('America', 'ECU', 'Ecuador', 'Chimborazo', ''),
('America', 'ECU', 'Ecuador', 'El Oro', ''),
('America', 'ECU', 'Ecuador', 'Esmeraldas', ''),
('America', 'ECU', 'Ecuador', 'Guayas', ''),
('America', 'ECU', 'Ecuador', 'Imbabura', ''),
('America', 'ECU', 'Ecuador', 'Loja', ''),
('America', 'ECU', 'Ecuador', 'Los R', ''),
('America', 'ECU', 'Ecuador', 'Manab', ''),
('America', 'ECU', 'Ecuador', 'Pichincha', ''),
('America', 'ECU', 'Ecuador', 'Tungurahua', ''),
('America', 'SLV', 'El Salvador', 'La Libertad', ''),
('America', 'SLV', 'El Salvador', 'San Miguel', ''),
('America', 'SLV', 'El Salvador', 'San Salvador', ''),
('America', 'SLV', 'El Salvador', 'Santa Ana', ''),
('America', 'GTM', 'Guatemala', 'Guatemala', ''),
('America', 'GTM', 'Guatemala', 'Quetzaltenango', ''),
('America', 'HND', 'Honduras', 'Atl', ''),
('America', 'HND', 'Honduras', 'Cort', ''),
('America', 'HND', 'Honduras', 'Distrito Central', ''),
('America', 'MEX', 'Mexico', 'Aguascalientes', ''),
('America', 'MEX', 'Mexico', 'Baja California', ''),
('America', 'MEX', 'Mexico', 'Baja California Sur', ''),
('America', 'MEX', 'Mexico', 'Campeche', ''),
('America', 'MEX', 'Mexico', 'Chiapas', ''),
('America', 'MEX', 'Mexico', 'Chihuahua', ''),
('America', 'MEX', 'Mexico', 'Coahuila de Zaragoza', ''),
('America', 'MEX', 'Mexico', 'Colima', ''),
('America', 'MEX', 'Mexico', 'Colima', 'Armer'),
('America', 'MEX', 'Mexico', 'Colima', 'Colima'),
('America', 'MEX', 'Mexico', 'Colima', 'Comala'),
('America', 'MEX', 'Mexico', 'Colima', 'Coquimatl'),
('America', 'MEX', 'Mexico', 'Colima', 'Cuauht'),
('America', 'MEX', 'Mexico', 'Colima', 'Ixtlahuac'),
('America', 'MEX', 'Mexico', 'Colima', 'Manzanillo'),
('America', 'MEX', 'Mexico', 'Colima', 'Minatitl'),
('America', 'MEX', 'Mexico', 'Colima', 'Tecom'),
('America', 'MEX', 'Mexico', 'Colima', 'Villa de '),
('America', 'MEX', 'Mexico', 'Distrito Federal', ''),
('America', 'MEX', 'Mexico', 'Durango', ''),
('America', 'MEX', 'Mexico', 'Guanajuato', ''),
('America', 'MEX', 'Mexico', 'Guerrero', ''),
('America', 'MEX', 'Mexico', 'Hidalgo', ''),
('America', 'MEX', 'Mexico', 'Jalisco', ''),
('America', 'MEX', 'Mexico', 'M', ''),
('America', 'MEX', 'Mexico', 'Michoac', ''),
('America', 'MEX', 'Mexico', 'Morelos', ''),
('America', 'MEX', 'Mexico', 'Nayarit', ''),
('America', 'MEX', 'Mexico', 'Nuevo Le', ''),
('America', 'MEX', 'Mexico', 'Oaxaca', ''),
('America', 'MEX', 'Mexico', 'Puebla', ''),
('America', 'MEX', 'Mexico', 'Quer', ''),
('America', 'MEX', 'Mexico', 'Quer', ''),
('America', 'MEX', 'Mexico', 'Quintana Roo', ''),
('America', 'MEX', 'Mexico', 'San Luis Potos', ''),
('America', 'MEX', 'Mexico', 'Sinaloa', ''),
('America', 'MEX', 'Mexico', 'Sonora', ''),
('America', 'MEX', 'Mexico', 'Tabasco', ''),
('America', 'MEX', 'Mexico', 'Tamaulipas', ''),
('America', 'MEX', 'Mexico', 'Veracruz', ''),
('America', 'MEX', 'Mexico', 'Yucat', ''),
('America', 'MEX', 'Mexico', 'Zacatecas', ''),
('America', 'NIC', 'Nicaragua', 'Chinandega', ''),
('America', 'NIC', 'Nicaragua', 'Le', ''),
('America', 'NIC', 'Nicaragua', 'Managua', ''),
('America', 'NIC', 'Nicaragua', 'Masaya', ''),
('America', 'PAN', 'Panama', 'Panam', ''),
('America', 'PAN', 'Panama', 'San Miguelito', ''),
('America', 'PER', 'Peru', 'Ancash', ''),
('America', 'PER', 'Peru', 'Arequipa', ''),
('America', 'PER', 'Peru', 'Ayacucho', ''),
('America', 'PER', 'Peru', 'Cajamarca', ''),
('America', 'PER', 'Peru', 'Callao', ''),
('America', 'PER', 'Peru', 'Cusco', ''),
('America', 'PER', 'Peru', 'Huanuco', ''),
('America', 'PER', 'Peru', 'Ica', ''),
('America', 'PER', 'Peru', 'Jun', ''),
('America', 'PER', 'Peru', 'La Libertad', ''),
('America', 'PER', 'Peru', 'Lambayeque', ''),
('America', 'PER', 'Peru', 'Lima', ''),
('America', 'PER', 'Peru', 'Loreto', ''),
('America', 'PER', 'Peru', 'Piura', ''),
('America', 'PER', 'Peru', 'Puno', ''),
('America', 'PER', 'Peru', 'Tacna', ''),
('America', 'PER', 'Peru', 'Ucayali', ''),
('America', 'PRI', 'Puerto Rico', 'Arecibo', ''),
('America', 'PRI', 'Puerto Rico', 'Bayam', ''),
('America', 'PRI', 'Puerto Rico', 'Caguas', ''),
('America', 'PRI', 'Puerto Rico', 'Carolina', ''),
('America', 'PRI', 'Puerto Rico', 'Guaynabo', ''),
('America', 'PRI', 'Puerto Rico', 'Ponce', ''),
('America', 'PRI', 'Puerto Rico', 'San Juan', ''),
('America', 'PRI', 'Puerto Rico', 'Toa Baja', ''),
('America', 'PRY', 'Paraguay', 'Alto Paran', ''),
('America', 'PRY', 'Paraguay', 'Asunci', ''),
('America', 'PRY', 'Paraguay', 'Central', ''),
('America', 'URY', 'Uruguay', 'Montevideo', ''),
('America', 'USA', 'United Situations', 'Alabama', ''),
('America', 'USA', 'United Situations', 'Alaska', ''),
('America', 'USA', 'United Situations', 'Arizona', ''),
('America', 'USA', 'United Situations', 'Arkansas', ''),
('America', 'USA', 'United Situations', 'California', ''),
('America', 'USA', 'United Situations', 'Colorado', ''),
('America', 'USA', 'United Situations', 'Connecticut', ''),
('America', 'USA', 'United Situations', 'District of Columbia', ''),
('America', 'USA', 'United Situations', 'Florida', ''),
('America', 'USA', 'United Situations', 'Georgia', ''),
('America', 'USA', 'United Situations', 'Hawaii', ''),
('America', 'USA', 'United Situations', 'Idaho', ''),
('America', 'USA', 'United Situations', 'Illinois', ''),
('America', 'USA', 'United Situations', 'Indiana', ''),
('America', 'USA', 'United Situations', 'Iowa', ''),
('America', 'USA', 'United Situations', 'Kansas', ''),
('America', 'USA', 'United Situations', 'Kentucky', ''),
('America', 'USA', 'United Situations', 'Louisiana', ''),
('America', 'USA', 'United Situations', 'Maryland', ''),
('America', 'USA', 'United Situations', 'Massachusetts', ''),
('America', 'USA', 'United Situations', 'Michigan', ''),
('America', 'USA', 'United Situations', 'Minnesota', ''),
('America', 'USA', 'United Situations', 'Mississippi', ''),
('America', 'USA', 'United Situations', 'Missouri', ''),
('America', 'USA', 'United Situations', 'Montana', ''),
('America', 'USA', 'United Situations', 'Nebraska', ''),
('America', 'USA', 'United Situations', 'Nevada', ''),
('America', 'USA', 'United Situations', 'New Hampshire', ''),
('America', 'USA', 'United Situations', 'New Jersey', ''),
('America', 'USA', 'United Situations', 'New Mexico', ''),
('America', 'USA', 'United Situations', 'New York', ''),
('America', 'USA', 'United Situations', 'North Carolina', ''),
('America', 'USA', 'United Situations', 'Ohio', ''),
('America', 'USA', 'United Situations', 'Oklahoma', ''),
('America', 'USA', 'United Situations', 'Oregon', ''),
('America', 'USA', 'United Situations', 'Pennsylvania', ''),
('America', 'USA', 'United Situations', 'Rhode Island', ''),
('America', 'USA', 'United Situations', 'South Carolina', ''),
('America', 'USA', 'United Situations', 'South Dakota', ''),
('America', 'USA', 'United Situations', 'Tennessee', ''),
('America', 'USA', 'United Situations', 'Texas', ''),
('America', 'USA', 'United Situations', 'Utah', ''),
('America', 'USA', 'United Situations', 'Virginia', ''),
('America', 'USA', 'United Situations', 'Washington', ''),
('America', 'USA', 'United Situations', 'Wisconsin', ''),
('America', 'VEN', 'Venezuela', 'Anzo', ''),
('America', 'VEN', 'Venezuela', 'Apure', ''),
('America', 'VEN', 'Venezuela', 'Aragua', ''),
('America', 'VEN', 'Venezuela', 'Barinas', ''),
('America', 'VEN', 'Venezuela', 'Bol', ''),
('America', 'VEN', 'Venezuela', 'Carabobo', ''),
('America', 'VEN', 'Venezuela', 'Distrito Federal', ''),
('America', 'VEN', 'Venezuela', 'Falc', ''),
('America', 'VEN', 'Venezuela', 'Gu', ''),
('America', 'VEN', 'Venezuela', 'Lara', ''),
('America', 'VEN', 'Venezuela', 'M', ''),
('America', 'VEN', 'Venezuela', 'Miranda', ''),
('America', 'VEN', 'Venezuela', 'Monagas', ''),
('America', 'VEN', 'Venezuela', 'Portuguesa', ''),
('America', 'VEN', 'Venezuela', 'Sucre', ''),
('America', 'VEN', 'Venezuela', 'T', ''),
('America', 'VEN', 'Venezuela', 'Trujillo', ''),
('America', 'VEN', 'Venezuela', 'Yaracuy', ''),
('America', 'VEN', 'Venezuela', 'Zulia', ''),
('Europe', 'BEL', 'Belgium', 'Antwerpen', ''),
('Europe', 'BEL', 'Belgium', 'Bryssel', ''),
('Europe', 'BEL', 'Belgium', 'East Flanderi', ''),
('Europe', 'BEL', 'Belgium', 'Hainaut', ''),
('Europe', 'BEL', 'Belgium', 'Namur', ''),
('Europe', 'BEL', 'Belgium', 'West Flanderi', ''),
('Europe', 'FRA', 'France', 'Alsace', ''),
('Europe', 'FRA', 'France', 'Aquitaine', ''),
('Europe', 'FRA', 'France', 'Auvergne', ''),
('Europe', 'FRA', 'France', 'Basse-Normandie', ''),
('Europe', 'FRA', 'France', 'Bourgogne', ''),
('Europe', 'FRA', 'France', 'Bretagne', ''),
('Europe', 'FRA', 'France', 'Centre', ''),
('Europe', 'FRA', 'France', 'Limousin', ''),
('Europe', 'FRA', 'France', 'Lorraine', ''),
('Europe', 'FRA', 'France', 'Pays de la Loire', ''),
('Europe', 'FRA', 'France', 'Picardie', ''),
('Europe', 'FRA', 'France', 'Rh', ''),
('Europe', 'DEU', 'Germany', 'Anhalt Sachsen', ''),
('Europe', 'DEU', 'Germany', 'Baijeri', ''),
('Europe', 'DEU', 'Germany', 'Berliini', ''),
('Europe', 'DEU', 'Germany', 'Brandenburg', ''),
('Europe', 'DEU', 'Germany', 'Bremen', ''),
('Europe', 'DEU', 'Germany', 'Hamburg', ''),
('Europe', 'DEU', 'Germany', 'Hessen', ''),
('Europe', 'DEU', 'Germany', 'Mecklenburg-Vorpomme', ''),
('Europe', 'DEU', 'Germany', 'Niedersachsen', ''),
('Europe', 'DEU', 'Germany', 'Nordrhein-Westfalen', ''),
('Europe', 'DEU', 'Germany', 'Rheinland-Pfalz', ''),
('Europe', 'DEU', 'Germany', 'Saarland', ''),
('Europe', 'DEU', 'Germany', 'Saksi', ''),
('Europe', 'DEU', 'Germany', 'Schleswig-Holstein', ''),
('Europe', 'ITA', 'Italy', 'Abruzzit', ''),
('Europe', 'ITA', 'Italy', 'Apulia', ''),
('Europe', 'ITA', 'Italy', 'Calabria', ''),
('Europe', 'ITA', 'Italy', 'Campania', ''),
('Europe', 'ITA', 'Italy', 'Emilia-Romagna', ''),
('Europe', 'ITA', 'Italy', 'Friuli-Venezia Giuli', ''),
('Europe', 'ITA', 'Italy', 'Latium', ''),
('Europe', 'ITA', 'Italy', 'Liguria', ''),
('Europe', 'ITA', 'Italy', 'Lombardia', ''),
('Europe', 'ITA', 'Italy', 'Marche', ''),
('Europe', 'ITA', 'Italy', 'Piemonte', ''),
('Europe', 'ITA', 'Italy', 'Sardinia', ''),
('Europe', 'ITA', 'Italy', 'Sisilia', ''),
('Europe', 'ITA', 'Italy', 'Toscana', ''),
('Europe', 'ITA', 'Italy', 'Umbria', ''),
('Europe', 'ITA', 'Italy', 'Veneto', ''),
('Europe', 'PRT', 'Portugal', 'Braga', ''),
('Europe', 'PRT', 'Portugal', 'Co', ''),
('Europe', 'PRT', 'Portugal', 'Lisboa', ''),
('Europe', 'PRT', 'Portugal', 'Porto', ''),
('Europe', 'ESP', 'Spain', 'Andalusia', ''),
('Europe', 'ESP', 'Spain', 'Aragonia', ''),
('Europe', 'ESP', 'Spain', 'Asturia', ''),
('Europe', 'ESP', 'Spain', 'Balears', ''),
('Europe', 'ESP', 'Spain', 'Baskimaa', ''),
('Europe', 'ESP', 'Spain', 'Canary Islands', ''),
('Europe', 'ESP', 'Spain', 'Cantabria', ''),
('Europe', 'ESP', 'Spain', 'Castilla and Le', ''),
('Europe', 'ESP', 'Spain', 'Extremadura', ''),
('Europe', 'ESP', 'Spain', 'Galicia', ''),
('Europe', 'ESP', 'Spain', 'Katalonia', ''),
('Europe', 'ESP', 'Spain', 'La Rioja', ''),
('Europe', 'ESP', 'Spain', 'Madrid', ''),
('Europe', 'ESP', 'Spain', 'Murcia', ''),
('Europe', 'ESP', 'Spain', 'Navarra', ''),
('Europe', 'ESP', 'Spain', 'Valencia', ''),
('Europe', 'CHE', 'Switzerland', 'Bern', ''),
('Europe', 'CHE', 'Switzerland', 'Geneve', ''),
('Europe', 'CHE', 'Switzerland', 'Vaud', ''),
('Europe', 'GBR', 'United Kingdom', 'England', ''),
('Europe', 'GBR', 'United Kingdom', 'Jersey', ''),
('Europe', 'GBR', 'United Kingdom', 'North Ireland', ''),
('Europe', 'GBR', 'United Kingdom', 'Scotland', ''),
('Europe', 'GBR', 'United Kingdom', 'Wales', ''),
('Oceania', 'AUS', 'Australia', 'Capital Region', ''),
('Oceania', 'AUS', 'Australia', 'New South Wales', ''),
('Oceania', 'AUS', 'Australia', 'Queensland', ''),
('Oceania', 'AUS', 'Australia', 'South Australia', ''),
('Oceania', 'AUS', 'Australia', 'Tasmania', ''),
('Oceania', 'AUS', 'Australia', 'Victoria', ''),
('Oceania', 'AUS', 'Australia', 'West Australia', ''),
('Oceania', 'NZL', 'New Zealand', 'Auckland', ''),
('Oceania', 'NZL', 'New Zealand', 'Canterbury', ''),
('Oceania', 'NZL', 'New Zealand', 'Dunedin', ''),
('Oceania', 'NZL', 'New Zealand', 'Hamilton', ''),
('Oceania', 'NZL', 'New Zealand', 'Wellington', '');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `muu_ads`
--
ALTER TABLE `muu_ads`
  ADD CONSTRAINT `muu_ads_ibfk_1` FOREIGN KEY (`ID_User`) REFERENCES `muu_users` (`ID_User`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_blog`
--
ALTER TABLE `muu_blog`
  ADD CONSTRAINT `muu_blog_ibfk_1` FOREIGN KEY (`ID_User`) REFERENCES `muu_users` (`ID_User`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `muu_blog_ibfk_2` FOREIGN KEY (`ID_URL`) REFERENCES `muu_url` (`ID_URL`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_forums_posts`
--
ALTER TABLE `muu_forums_posts`
  ADD CONSTRAINT `muu_forums_posts_ibfk_1` FOREIGN KEY (`ID_User`) REFERENCES `muu_users` (`ID_User`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_gallery`
--
ALTER TABLE `muu_gallery`
  ADD CONSTRAINT `muu_gallery_ibfk_1` FOREIGN KEY (`ID_User`) REFERENCES `muu_users` (`ID_User`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_hotels_contacts`
--
ALTER TABLE `muu_hotels_contacts`
  ADD CONSTRAINT `fk_muu_hotels_contacts_1` FOREIGN KEY (`ID_Hotel`) REFERENCES `muu_hotels` (`ID_Hotel`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_hotels_information`
--
ALTER TABLE `muu_hotels_information`
  ADD CONSTRAINT `fk_muu_hotels_information_1` FOREIGN KEY (`ID_Hotel`) REFERENCES `muu_hotels` (`ID_Hotel`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_hotels_policy`
--
ALTER TABLE `muu_hotels_policy`
  ADD CONSTRAINT `fk_muu_hotels_policy_1` FOREIGN KEY (`ID_Hotel`) REFERENCES `muu_hotels` (`ID_Hotel`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_links`
--
ALTER TABLE `muu_links`
  ADD CONSTRAINT `muu_links_ibfk_1` FOREIGN KEY (`ID_User`) REFERENCES `muu_users` (`ID_User`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_logs`
--
ALTER TABLE `muu_logs`
  ADD CONSTRAINT `muu_logs_ibfk_1` FOREIGN KEY (`ID_User`) REFERENCES `muu_users` (`ID_User`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_pages`
--
ALTER TABLE `muu_pages`
  ADD CONSTRAINT `muu_pages_ibfk_1` FOREIGN KEY (`ID_User`) REFERENCES `muu_users` (`ID_User`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_polls`
--
ALTER TABLE `muu_polls`
  ADD CONSTRAINT `muu_polls_ibfk_1` FOREIGN KEY (`ID_User`) REFERENCES `muu_users` (`ID_User`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_polls_answers`
--
ALTER TABLE `muu_polls_answers`
  ADD CONSTRAINT `muu_polls_answers_ibfk_1` FOREIGN KEY (`ID_Poll`) REFERENCES `muu_polls` (`ID_Poll`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_polls_ips`
--
ALTER TABLE `muu_polls_ips`
  ADD CONSTRAINT `muu_polls_ips_ibfk_1` FOREIGN KEY (`ID_Poll`) REFERENCES `muu_polls` (`ID_Poll`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_re_categories_records`
--
ALTER TABLE `muu_re_categories_records`
  ADD CONSTRAINT `muu_re_categories_records_ibfk_1` FOREIGN KEY (`ID_Category2Application`) REFERENCES `muu_re_categories_applications` (`ID_Category2Application`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_re_comments_records`
--
ALTER TABLE `muu_re_comments_records`
  ADD CONSTRAINT `muu_re_comments_records_ibfk_1` FOREIGN KEY (`ID_Comment2Application`) REFERENCES `muu_re_comments_applications` (`ID_Comment2Application`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_re_hotels_amenities`
--
ALTER TABLE `muu_re_hotels_amenities`
  ADD CONSTRAINT `fk_muu_re_hotels_amenities_1` FOREIGN KEY (`ID_Amenity`) REFERENCES `muu_hotels_amenities` (`ID_Amenity`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_muu_re_hotels_amenities_2` FOREIGN KEY (`ID_Hotel`) REFERENCES `muu_hotels` (`ID_Hotel`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_re_hotels_rates`
--
ALTER TABLE `muu_re_hotels_rates`
  ADD CONSTRAINT `fk_muu_re_hotels_rates_1` FOREIGN KEY (`ID_Rate`) REFERENCES `muu_hotels_rates` (`ID_Rate`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_muu_re_hotels_rates_2` FOREIGN KEY (`ID_Hotel`) REFERENCES `muu_hotels` (`ID_Hotel`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_re_hotels_rooms`
--
ALTER TABLE `muu_re_hotels_rooms`
  ADD CONSTRAINT `fk_muu_re_hotels_rooms_1` FOREIGN KEY (`ID_Room`) REFERENCES `muu_hotels_rooms` (`ID_Room`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_muu_re_hotels_rooms_2` FOREIGN KEY (`ID_Hotel`) REFERENCES `muu_hotels` (`ID_Hotel`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_re_permissions_privileges`
--
ALTER TABLE `muu_re_permissions_privileges`
  ADD CONSTRAINT `muu_re_permissions_privileges_ibfk_1` FOREIGN KEY (`ID_Privilege`) REFERENCES `muu_privileges` (`ID_Privilege`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `muu_re_permissions_privileges_ibfk_2` FOREIGN KEY (`ID_Application`) REFERENCES `muu_applications` (`ID_Application`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_re_privileges_users`
--
ALTER TABLE `muu_re_privileges_users`
  ADD CONSTRAINT `muu_re_privileges_users_ibfk_1` FOREIGN KEY (`ID_Privilege`) REFERENCES `muu_privileges` (`ID_Privilege`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `muu_re_privileges_users_ibfk_2` FOREIGN KEY (`ID_User`) REFERENCES `muu_users` (`ID_User`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_re_tags_applications`
--
ALTER TABLE `muu_re_tags_applications`
  ADD CONSTRAINT `muu_re_tags_applications_ibfk_2` FOREIGN KEY (`ID_Tag`) REFERENCES `muu_tags` (`ID_Tag`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_re_tags_records`
--
ALTER TABLE `muu_re_tags_records`
  ADD CONSTRAINT `muu_re_tags_records_ibfk_1` FOREIGN KEY (`ID_Tag2Application`) REFERENCES `muu_re_tags_applications` (`ID_Tag2Application`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_support`
--
ALTER TABLE `muu_support`
  ADD CONSTRAINT `muu_support_ibfk_1` FOREIGN KEY (`ID_User`) REFERENCES `muu_users` (`ID_User`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_tokens`
--
ALTER TABLE `muu_tokens`
  ADD CONSTRAINT `muu_tokens_ibfk_1` FOREIGN KEY (`ID_User`) REFERENCES `muu_users` (`ID_User`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_users_information`
--
ALTER TABLE `muu_users_information`
  ADD CONSTRAINT `muu_users_information_ibfk_1` FOREIGN KEY (`ID_User`) REFERENCES `muu_users` (`ID_User`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `muu_videos`
--
ALTER TABLE `muu_videos`
  ADD CONSTRAINT `muu_videos_ibfk_1` FOREIGN KEY (`ID_User`) REFERENCES `muu_users` (`ID_User`) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `getCategories`$$
CREATE PROCEDURE `getCategories`()
BEGIN

    SELECT muu_re_categories_applications.ID_Category, ID_Application, ID_Parent, Title, Slug, Language, Situation FROM muu_re_categories_applications 

    INNER JOIN muu_categories 

            ON muu_categories.ID_Category = muu_re_categories_applications.ID_Category;

END$$

DROP PROCEDURE IF EXISTS `getCategoriesByApplication`$$
CREATE PROCEDURE `getCategoriesByApplication`(_Application VARCHAR(150), _Language VARCHAR(15))
BEGIN

  DECLARE _ID_Application MEDIUMINT(8);

  

  IF(EXISTS(SELECT ID_Application FROM muu_applications WHERE Slug = _Application)) THEN

    SET _ID_Application = (SELECT ID_Application FROM muu_applications WHERE Slug = _Application);



    SELECT muu_re_categories_applications.ID_Category, Title, Slug, Language, Situation 

    FROM muu_re_categories_applications     

    INNER JOIN muu_categories ON muu_categories.ID_Category = muu_re_categories_applications.ID_Category

    WHERE muu_re_categories_applications.ID_Application = _ID_Application AND muu_categories.Language = _Language ORDER BY ID_Category DESC;

  END IF;

END$$

DROP PROCEDURE IF EXISTS `getCategoriesByRecord`$$
CREATE PROCEDURE `getCategoriesByRecord`(_ID_Application mediumint(8), _ID_Record mediumint(8))
BEGIN

    SELECT * FROM muu_categories WHERE muu_categories.ID_Category IN (

        SELECT muu_re_categories_applications.ID_Category FROM muu_re_categories_applications 

        WHERE muu_re_categories_applications.ID_Application = _ID_Application AND muu_re_categories_applications.ID_Category2Application IN (

            SELECT muu_re_categories_records.ID_Category2Application FROM muu_re_categories_records WHERE ID_Record = _ID_Record

        )

    );

END$$

DROP PROCEDURE IF EXISTS `getComments`$$
CREATE PROCEDURE `getComments`(_ID_Application mediumint(8), _ID_Record mediumint(8))
BEGIN

    IF (_ID_Record = 0) THEN

        SELECT * FROM muu_comments WHERE muu_comments.ID_Comment IN (

            SELECT muu_re_comments_applications.ID_Comment FROM muu_re_comments_applications 

            WHERE muu_re_comments_applications.ID_Application = _ID_Application 

        ) AND Situation = 'Inactive';

    ELSE    

        SELECT * FROM muu_comments WHERE muu_comments.ID_Comment IN (

            SELECT muu_re_comments_applications.ID_Comment FROM muu_re_comments_applications 

            WHERE muu_re_comments_applications.ID_Application = _ID_Application AND muu_re_comments_applications.ID_Comment2Application IN (

                SELECT muu_re_comments_records.ID_Comment2Application FROM muu_re_comments_records WHERE ID_Record = _ID_Record

            )

        );    

    END IF;

END$$

DROP PROCEDURE IF EXISTS `getFeedbackNotifications`$$
CREATE PROCEDURE `getFeedbackNotifications`()
BEGIN

    SELECT * FROM muu_feedback WHERE Situation != 'Read';

END$$

DROP PROCEDURE IF EXISTS `getImage`$$
CREATE PROCEDURE `getImage`(_ID_Image MEDIUMINT(8))
BEGIN
  DECLARE _ID_Cat2App MEDIUMINT(8);
  DECLARE _ID_Application MEDIUMINT(8);
  DECLARE _ID_Category MEDIUMINT(8);
  DECLARE _Album_Slug  VARCHAR(150);

  SET _ID_Application = (SELECT ID_Application FROM muu_applications WHERE Slug = "gallery");
  SET _Album_Slug = (SELECT Album_Slug FROM muu_gallery WHERE ID_Image = _ID_Image);

  IF(_Album_Slug != "none") THEN
    SELECT muu_gallery.* ,  muu_categories.ID_Category FROM muu_gallery
    INNER JOIN 
    muu_categories ON muu_categories.ID_Category = 
    (SELECT ID_Category FROM muu_re_categories_applications WHERE ID_Category2Application = 
    (SELECT ID_Category2Application FROM muu_re_categories_records WHERE ID_Record = _ID_Image) AND ID_Application = _ID_Application)
    WHERE ID_Image = _ID_Image;
  ELSE
    SELECT * FROM muu_gallery WHERE ID_Image = _ID_Image;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `getLink`$$
CREATE PROCEDURE `getLink`(_ID_Link MEDIUMINT(8))
BEGIN

  DECLARE _ID_Category2Application MEDIUMINT(8);

  DECLARE _ID_Application MEDIUMINT(8);

  DECLARE _ID_Category MEDIUMINT(8);



  SET _ID_Application = (SELECT ID_Application FROM muu_applications WHERE Slug = 'links');

  

  SELECT muu_links.*,  muu_categories.ID_Category FROM muu_links

  LEFT JOIN 

  muu_categories ON muu_categories.ID_Category = 

  (SELECT ID_Category FROM muu_re_categories_applications WHERE ID_Category2Application = 

  (SELECT ID_Category2Application FROM muu_re_categories_records WHERE ID_Record = _ID_Link) AND ID_Application = _ID_Application)

  WHERE ID_Link = _ID_Link;

END$$

DROP PROCEDURE IF EXISTS `getRepliesByTopic`$$
CREATE PROCEDURE `getRepliesByTopic`(
    _ID_Parent MEDIUMINT(8)
)
BEGIN
  SELECT * FROM muu_forums_posts
  INNER JOIN muu_users ON muu_users.ID_User = muu_forums_posts.ID_User
  INNER JOIN muu_users_information ON muu_users_information.ID_User = muu_users.ID_User
  WHERE ID_Parent = _ID_Parent;
END$$

DROP PROCEDURE IF EXISTS `getTags`$$
CREATE PROCEDURE `getTags`(_ID_Application mediumint(8), _ID_Record mediumint(8))
BEGIN

    SELECT * FROM muu_tags WHERE muu_tags.ID_Tag IN (

        SELECT muu_re_tags_applications.ID_Tag FROM muu_re_tags_applications 

        WHERE muu_re_tags_applications.ID_Application = _ID_Application AND muu_re_tags_applications.ID_Tag2Application IN (

            SELECT muu_re_tags_records.ID_Tag2Application FROM muu_re_tags_records WHERE ID_Record = _ID_Record

        )

    );

END$$

DROP PROCEDURE IF EXISTS `getTagsByRecord`$$
CREATE PROCEDURE `getTagsByRecord`(_ID_Application mediumint(8), _ID_Record mediumint(8))
BEGIN
    SELECT * FROM muu_tags WHERE muu_tags.ID_Tag IN (
        SELECT muu_re_tags_applications.ID_Tag FROM muu_re_tags_applications 
        WHERE muu_re_tags_applications.ID_Application = _ID_Application AND muu_re_tags_applications.ID_Tag2Application IN (
            SELECT muu_re_tags_records.ID_Tag2Application FROM muu_re_tags_records WHERE ID_Record = _ID_Record
        )
    );
END$$

DROP PROCEDURE IF EXISTS `getTopicForum`$$
CREATE PROCEDURE `getTopicForum`(_ID_Post MEDIUMINT(8))
BEGIN
  SELECT * FROM muu_forums_posts
  INNER JOIN muu_users ON muu_users.ID_User = muu_forums_posts.ID_User
  INNER JOIN muu_users_information ON muu_users_information.ID_User = muu_users.ID_User
  WHERE ID_Post = _ID_Post AND Situation = 'Active' AND ID_Parent = 0;
END$$

DROP PROCEDURE IF EXISTS `getUser`$$
CREATE PROCEDURE `getUser`(_ID_User mediumint(8))
BEGIN

  SELECT muu_users.*, muu_re_privileges_users.ID_Privilege FROM muu_users, muu_re_privileges_users WHERE muu_users.ID_User = _ID_User and muu_re_privileges_users.ID_User = _ID_User;

END$$

DROP PROCEDURE IF EXISTS `setCategory`$$
CREATE PROCEDURE `setCategory`(

_Title VARCHAR(90),

_Slug VARCHAR(90),

_Language VARCHAR(10),

_Situation VARCHAR(15)

)
BEGIN

  IF(NOT EXISTS(SELECT ID_Category FROM muu_categories WHERE Title = _Title AND Language = _Language)) THEN

    INSERT INTO muu_categories (Title, Slug, Language, Situation) VALUES (_Title, _Slug, _Language, _Situation);

    SELECT LAST_INSERT_ID() as ID_Category;

  ELSE

    SELECT ID_Category FROM muu_categories WHERE Title = _Title;

  END IF;

END$$

DROP PROCEDURE IF EXISTS `setForum`$$
CREATE PROCEDURE `setForum`(
  _Title VARCHAR(100),
  _Slug VARCHAR(100),
  _Description VARCHAR(250),
  _Language VARCHAR(20),
  _Situation VARCHAR(15)
)
BEGIN
  IF(EXISTS(SELECT ID_Forum FROM muu_forums WHERE Slug = _Slug AND Language = _Language)) THEN
    SELECT FALSE;
  ELSE
    INSERT INTO muu_forums (Title, Slug, Description, Language, Situation) VALUES (_Title, _Slug, _Description, _Language, _Situation);
    SELECT LAST_INSERT_ID();
  END IF;
END$$

DROP PROCEDURE IF EXISTS `setImage`$$
CREATE PROCEDURE `setImage`(

_ID_User MEDIUMINT(8),

_ID_Category MEDIUMINT(8),

_Title VARCHAR(100),

_Slug VARCHAR(100),

_Description VARCHAR(250),

_Small VARCHAR(255),

_Medium VARCHAR(255),

_Original VARCHAR(255),

_Start_Date INT(11),

_Text_Date VARCHAR(50),

_Situation VARCHAR(15)

)
BEGIN

  DECLARE _ID_Image MEDIUMINT(8);

  DECLARE _ID_Category2Application MEDIUMINT(8);

  DECLARE _ID_Application MEDIUMINT(8);

  DECLARE _Album VARCHAR(150);

  DECLARE _Album_Slug VARCHAR(150);

  

  INSERT INTO muu_gallery 

  (ID_User, Title, Slug, Description, Small, Medium, Original, Start_Date, Text_Date, Situation) 

  VALUES 

  (_ID_User, _Title, _Slug, _Description, _Small, _Medium, _Original, _Start_Date, _Text_Date, _Situation);

    

  SET _ID_Image = LAST_INSERT_ID();

  

  IF(EXISTS(SELECT ID_Category FROM muu_categories WHERE ID_Category = _ID_Category)) THEN

    SET _ID_Application = (SELECT ID_Application as _ID_Application FROM muu_applications WHERE Slug = 'gallery');

    IF(EXISTS(SELECT ID_Category FROM muu_re_categories_applications WHERE ID_Category = _ID_Category AND ID_Application = _ID_Application)) THEN

      SET _ID_Category2Application = (SELECT ID_Category2Application FROM muu_re_categories_applications WHERE ID_Category = _ID_Category AND ID_Application = _ID_Application);

    ELSE

      INSERT INTO muu_re_categories_applications (ID_Application, ID_Category) VALUES (_ID_Application, _ID_Category);

      SET _ID_Category2Application = LAST_INSERT_ID();

    END IF;

    

    INSERT INTO muu_re_categories_records (ID_Category2Application, ID_Record) VALUES (_ID_Category2Application, _ID_Image);



    SET _Album = (SELECT Title FROM muu_categories WHERE ID_Category = _ID_Category);
    SET _Album_Slug = (SELECT Slug FROM muu_categories WHERE ID_Category = _ID_Category);

    UPDATE muu_gallery SET Album = _Album, Album_Slug = _Album_Slug WHERE ID_Image = _ID_Image;

  END IF;

  

  SELECT _ID_Image as ID_Image;

END$$

DROP PROCEDURE IF EXISTS `setPage`$$
CREATE PROCEDURE `setPage`(

_ID_User MEDIUMINT(8),

_Title VARCHAR(100),

_Slug VARCHAR(100),

_Content TEXT,

_Language VARCHAR(20),

_Principal TINYINT(1),

_Start_Date INT(11),

_Text_Date VARCHAR(40),  

_Situation VARCHAR(15)

)
BEGIN

  IF(EXISTS(SELECT ID_Page FROM muu_pages WHERE Slug = _Slug AND Language = _Language)) THEN

    SELECT FALSE;

  ELSE

    IF(_Principal = 1) THEN

      UPDATE muu_pages SET Principal=0 WHERE Language = _Language;

    END IF;

    INSERT INTO muu_pages (ID_User, Title, Slug, Content, Language, Principal, Start_Date, Text_Date, Situation) VALUES (_ID_User, _Title, _Slug, _Content, _Language, _Principal, _Start_Date, _Text_Date, _Situation);

    

    SELECT LAST_INSERT_ID();

  END IF;

END$$

DROP PROCEDURE IF EXISTS `setReplyTopic`$$
CREATE PROCEDURE `setReplyTopic`(
_ID_Forum MEDIUMINT(8),
_ID_Post MEDIUMINT(8),
_ID_User MEDIUMINT(8),
_Title VARCHAR(150),
_Slug VARCHAR(150),
_Content TEXT,
_Author VARCHAR(50),
_Start_Date INT(11),
_Text_Date VARCHAR(50),
_Hour VARCHAR(15)
)
BEGIN
  DECLARE _Last_ID MEDIUMINT(8);

  INSERT INTO muu_forums_posts (ID_User, ID_Forum, ID_Parent, Title, Slug, Content, Author, Start_Date, Text_Date, Hour, Topic) VALUES (_ID_User, _ID_Forum, _ID_Post, _Title, _Slug, _Content, _Author, _Start_Date, _Text_Date, _Hour, 0);
  SET _Last_ID = (SELECT LAST_INSERT_ID());

  UPDATE muu_forums SET Replies = Replies + 1, Last_Reply = _Last_ID WHERE ID_Forum = _ID_Forum;

  SELECT _Last_ID as Last_ID;
END$$

DROP PROCEDURE IF EXISTS `setTopicForum`$$
CREATE PROCEDURE `setTopicForum`(
_ID_Forum MEDIUMINT(8),
_ID_User MEDIUMINT(8),
_Title VARCHAR(150),
_Slug VARCHAR(150),
_Content TEXT,
_Author VARCHAR(50),
_Start_Date INT(11),
_Text_Date VARCHAR(50),
_Hour VARCHAR(15)
)
BEGIN
  DECLARE _Last_ID MEDIUMINT(8);

  INSERT INTO muu_forums_posts (ID_User, ID_Forum, Title, Slug, Content, Author, Start_Date, Text_Date, Hour, Topic) VALUES (_ID_User, _ID_Forum, _Title, _Slug, _Content, _Author, _Start_Date, _Text_Date, _Hour, 1);
  SET _Last_ID = (SELECT LAST_INSERT_ID());

  UPDATE muu_forums SET Topics = Topics + 1 WHERE ID_Forum = _ID_Forum;

  SELECT _Last_ID as Last_ID;
END$$

DROP PROCEDURE IF EXISTS `setUser`$$
CREATE PROCEDURE `setUser`(

_Username VARCHAR(30),

_Pwd VARCHAR(40),

_Email VARCHAR(45),

_Start_Date INT(11),

_Code VARCHAR(10),

_Situation VARCHAR(15),

_ID_Privilege MEDIUMINT(8)

)
BEGIN

  DECLARE _Last_ID MEDIUMINT(8);



  IF(EXISTS(SELECT ID_User FROM muu_users WHERE Email = _Email)) THEN

    SELECT TRUE as Email_Exists;

  ELSEIF(EXISTS(SELECT ID_User FROM muu_users WHERE Username = _Username)) THEN

    SELECT TRUE as Username_Exists;

  ELSE

    INSERT INTO muu_users (Username, Pwd, Email, Start_Date, Code, Situation) VALUES (_Username, _Pwd, _Email, _Start_Date, _Code, _Situation);

    SET _LAST_ID = LAST_INSERT_ID();

    INSERT INTO muu_re_privileges_users (ID_Privilege, ID_User) VALUES (_ID_Privilege, _LAST_ID);

    INSERT INTO muu_users_information (ID_User) VALUES (_LAST_ID);

    SELECT _LAST_ID as ID_User;

  END IF;

END$$

DROP PROCEDURE IF EXISTS `updateForum`$$
CREATE PROCEDURE `updateForum`(

    _ID_Forum MEDIUMINT(8),

    _Title VARCHAR(100),

    _Slug VARCHAR(100),

    _Description VARCHAR(250), 

    _Situation VARCHAR(15)

)
BEGIN

    IF(EXISTS(SELECT ID_Forum FROM muu_forums WHERE ID_Forum = _ID_Forum)) THEN

        IF(NOT EXISTS(SELECT ID_Forum FROM muu_forums WHERE Slug = _Slug AND ID_Forum <> _ID_Forum)) THEN

            UPDATE muu_forums SET Title = _Title, Slug = _Slug, Description = _Description, Situation = _Situation WHERE ID_Forum = _ID_Forum;

            SELECT _ID_Forum;

        ELSE

            SELECT FALSE as Forum_Exists;

        END IF;

    ELSE

        SELECT FALSE;

    END IF;

END$$

DROP PROCEDURE IF EXISTS `updateImage`$$
CREATE PROCEDURE `updateImage`(
_ID_Image MEDIUMINT(8),
_ID_Category MEDIUMINT(8),
_Title VARCHAR(100),
_Slug VARCHAR(100),
_Description VARCHAR(250),
_Small VARCHAR(255),
_Medium VARCHAR(255),
_Original VARCHAR(255),
_Situation VARCHAR(15)
)
BEGIN
  DECLARE _ID_Application MEDIUMINT(8);
  DECLARE _ID_Category2   MEDIUMINT(8);
  DECLARE _ID_Cat2App     MEDIUMINT(8);
  DECLARE _Album_Slug     VARCHAR(150);
  DECLARE _Album      VARCHAR(50);

  SET _Album_Slug = (SELECT Album_Slug FROM muu_gallery WHERE ID_Image = _ID_Image);
  
  IF(EXISTS(SELECT ID_Image FROM muu_gallery WHERE ID_Image = _ID_Image)) THEN
    IF(_Small = "") THEN
      UPDATE muu_gallery SET Title = _Title, Slug = _Slug, Description = _Description, Situation = _Situation WHERE ID_Image = _ID_Image;
    ELSE
      UPDATE muu_gallery 
      SET Title = _Title, Slug = _Slug, Description = _Description, Small = _Small, Medium = _Medium, Original = _Original, Situation = _Situation 
      WHERE ID_Image = _ID_Image;
    END IF;

    IF(_Album_Slug = 'none' AND _ID_Category > 0) THEN
      IF(EXISTS(SELECT ID_Category FROM muu_categories WHERE ID_Category = _ID_Category)) THEN
        SET _ID_Application = (SELECT ID_Application as _ID_Application FROM muu_applications WHERE Slug = 'gallery');
        IF(EXISTS(SELECT ID_Category FROM muu_re_categories_applications WHERE ID_Category = _ID_Category AND ID_Application = _ID_Application)) THEN
          SET _ID_Cat2App = (SELECT ID_Cat2App FROM muu_re_categories_applications WHERE ID_Category = _ID_Category AND ID_Application = _ID_Application);
        ELSE
          INSERT INTO muu_re_categories_applications (ID_Application, ID_Category) VALUES (_ID_Application, _ID_Category);
          SET _ID_Cat2App = LAST_INSERT_ID();
        END IF;
        
        INSERT INTO muu_re_categories_records (ID_Cat2App, ID_Record) VALUES (_ID_Cat2App, _ID_Image);

        SET _Album = (SELECT Title FROM muu_categories WHERE ID_Category = _ID_Category);
        SET _Album_Slug = (SELECT Slug FROM muu_categories WHERE ID_Category = _ID_Category);
        UPDATE muu_gallery SET Album_Slug = _Album_Slug, Album = _Album WHERE ID_Image = _ID_Image;
      END IF;
    ELSE
      SET _ID_Application = (SELECT ID_Application FROM muu_applications WHERE Slug = 'gallery');
      SET _ID_Category2   = (SELECT ID_Category FROM muu_re_categories_applications WHERE ID_Cat2App = (SELECT ID_Cat2App FROM muu_re_categories_records WHERE ID_Record = _ID_Image) AND ID_Application = _ID_Application);
          
      IF(_ID_Category <> _ID_Category2) THEN
        DELETE FROM muu_re_categories_records WHERE ID_Record = _ID_Image AND ID_Cat2App = (SELECT ID_Cat2app FROM muu_re_categories_applications WHERE ID_Category = _ID_Category2  AND ID_Application = _ID_Application);
        
        IF(EXISTS(SELECT ID_Cat2App FROM muu_re_categories_applications WHERE ID_Application = _ID_Application AND ID_Category = _ID_Category)) THEN
          SET _ID_Cat2App = (SELECT ID_Cat2App FROM muu_re_categories_applications WHERE ID_Application = _ID_Application AND ID_Category = _ID_Category);
        ELSE
          INSERT INTO muu_re_categories_applications (ID_Application, ID_Category) VALUES (_ID_Application, _ID_Category);
          SET _ID_Cat2App = LAST_INSERT_ID();
        END IF;
        
        INSERT INTO muu_re_categories_records (ID_Cat2App, ID_Record) VALUES (_ID_Cat2App, _ID_Image);
        UPDATE muu_gallery SET Album = (SELECT Title FROM muu_categories WHERE ID_Category = _ID_Category), Album_Slug = (SELECT Slug FROM muu_categories WHERE ID_Category = _ID_Category) WHERE ID_Image = _ID_Image;
      END IF;
    END IF; 
    
    SELECT _ID_Image as ID_Image;
  ELSE
    SELECT FALSE as Image_Not_Exists;
  END IF;
END$$

DROP PROCEDURE IF EXISTS `updateLink`$$
CREATE PROCEDURE `updateLink`(

_ID_Link MEDIUMINT(8),

_ID_Category MEDIUMINT(8),

_Title VARCHAR(100),

_URL VARCHAR(100),

_Description VARCHAR(100),

_Follow TINYINT(1),

_Situation VARCHAR(15)

)
BEGIN

  DECLARE _ID_Application MEDIUMINT(8);

  DECLARE _ID_Category2   MEDIUMINT(8);

  DECLARE _ID_Category2Application   MEDIUMINT(8);

  

  IF(EXISTS(SELECT ID_Link FROM muu_links WHERE ID_Link = _ID_Link)) THEN

    UPDATE muu_links 

    SET Title = _Title, URL = _URL, Description = _Description, Follow = _Follow, Situation = _Situation 

    WHERE ID_Link = _ID_Link;

    

    SET _ID_Application = (SELECT ID_Application FROM muu_applications WHERE Slug = 'links');

    SET _ID_Category2   = (SELECT ID_Category FROM muu_re_categories_applications WHERE ID_Category2Application = (SELECT ID_Category2Application FROM muu_re_categories_records WHERE ID_Record = _ID_Link) AND ID_Application = _ID_Application);

    

    IF(_ID_Category <> _ID_Category2) THEN

      DELETE FROM muu_re_categories_records WHERE ID_Record = _ID_Link AND ID_Category2Application = (SELECT ID_Category2Application FROM muu_re_categories_applications WHERE ID_Category = _ID_Category2  AND ID_Application = _ID_Application);

      

      IF(EXISTS(SELECT ID_Category2Application FROM muu_re_categories_applications WHERE ID_Application = _ID_Application AND ID_Category = _ID_Category)) THEN

        SET _ID_Category2Application = (SELECT ID_Category2Application FROM muu_re_categories_applications WHERE ID_Application = _ID_Application AND ID_Category = _ID_Category);

      ELSE

        INSERT INTO muu_re_categories_applications (ID_Application, ID_Category) VALUES (_ID_Application, _ID_Category);

        SET _ID_Category2Application = LAST_INSERT_ID();

      END IF;

      

      INSERT INTO muu_re_categories_records (ID_Category2Application, ID_Record) VALUES (_ID_Category2Application, _ID_Link);

      UPDATE muu_links SET Category = (SELECT Title FROM muu_categories WHERE ID_Category = _ID_Category) WHERE ID_Link = _ID_Link;

    END IF;

    

    SELECT _ID_Link as ID_Link;

  ELSE

    SELECT FALSE as Link_Not_Exists;

  END IF;

END$$

DROP PROCEDURE IF EXISTS `updatePage`$$
CREATE PROCEDURE `updatePage`(

_ID_Page MEDIUMINT(8),

_ID_User MEDIUMINT(8),

_Title VARCHAR(100),

_Slug VARCHAR(100),

_Content TEXT,

_Language VARCHAR(20),

_Principal TINYINT(1),  

_Situation VARCHAR(15)

)
BEGIN

  IF(EXISTS(SELECT ID_Page FROM muu_pages WHERE ID_Page = _ID_Page)) THEN

    IF(NOT EXISTS(SELECT ID_Page FROM muu_pages WHERE Slug = _Slug AND ID_Page <> _ID_Page)) THEN

      IF(_Principal = 1) THEN

        UPDATE muu_pages SET Principal=0 WHERE Language = _Language;

      END IF;



      UPDATE muu_pages SET Title = _Title, Slug = _Slug, Content = _Content, Language = _Language, Principal = _Principal, Situation = _Situation WHERE ID_Page = _ID_Page;

      

      SELECT _ID_Page;

    ELSE

      SELECT FALSE as Page_Exists;

    END IF;

  ELSE

    SELECT FALSE;

  END IF;

END$$

DROP PROCEDURE IF EXISTS `updateReplyTopic`$$
CREATE PROCEDURE `updateReplyTopic`(
_ID_Post MEDIUMINT(8),
_Title VARCHAR(150),
_Slug VARCHAR(150),
_Content TEXT,
_Start_Date INT(11),
_Text_Date VARCHAR(50),
_Hour VARCHAR(15)
)
BEGIN
  UPDATE muu_forums_posts SET Title = _Title, Slug = _Slug, Content = _Content, Start_Date = _Start_Date, Text_Date = _Text_Date, Hour = _Hour WHERE ID_Post = _ID_Post;
  
  SELECT ID_Post, ID_Parent FROM muu_forums_posts WHERE ID_Post = _ID_Post;
END$$

DROP PROCEDURE IF EXISTS `updateTopicForum`$$
CREATE PROCEDURE `updateTopicForum`(
_ID_Post MEDIUMINT(8),
_Title VARCHAR(150),
_Slug VARCHAR(150),
_Content TEXT,
_Start_Date INT(11),
_Text_Date VARCHAR(50),
_Hour VARCHAR(15)
)
BEGIN
  UPDATE muu_forums_posts SET Title = _Title, Slug = _Slug, Content = _Content, Start_Date = _Start_Date, Text_Date = _Text_Date, Hour = _Hour WHERE ID_Post = _ID_Post;
  
  SELECT ID_Post FROM muu_forums_posts WHERE ID_Post = _ID_Post;
END$$

DROP PROCEDURE IF EXISTS `updateUser`$$
CREATE PROCEDURE `updateUser`(

_ID_User MEDIUMINT(8),

_Username VARCHAR(30),

_Pwd  VARCHAR(40),

_Email VARCHAR(45),

_Situation VARCHAR(15),

_ID_Privilege MEDIUMINT(8)

)
BEGIN

  IF(EXISTS(SELECT ID_User FROM muu_users WHERE ID_User = _ID_User)) THEN

    IF(NOT EXISTS(SELECT ID_User FROM muu_users WHERE Username = _Username AND ID_User <> _ID_User)) THEN

      IF(NOT EXISTS(SELECT ID_User FROM muu_users WHERE Email = _Email AND ID_User <> _ID_User)) THEN

        IF(_Pwd <> "") THEN

          UPDATE muu_users SET Username = _Username, Pwd = _Pwd, Email = _Email, Situation = _Situation WHERE ID_User = _ID_User;

        ELSE

          UPDATE muu_users SET Username = _Username, Email = _Email, Situation = _Situation WHERE ID_User = _ID_User;

        END IF;



        UPDATE muu_re_privileges_users SET ID_Privilege = _ID_Privilege WHERE ID_User = _ID_User;

        SELECT _ID_User as ID_User;

      ELSE

        SELECT TRUE as Email_Exists;

      END IF;

    ELSE

      SELECT TRUE as Username_Exists;

    END IF;

  ELSE

    SELECT TRUE as User_Not_Exists;

  END IF;

END$$

DELIMITER ;