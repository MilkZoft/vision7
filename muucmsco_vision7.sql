-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 24-03-2012 a las 20:02:04
-- Versión del servidor: 5.1.52
-- Versión de PHP: 5.2.9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `muucmsco_vision7`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `getCategories`()
BEGIN

    SELECT muu_re_categories_applications.ID_Category, ID_Application, ID_Parent, Title, Slug, Language, Situation FROM muu_re_categories_applications 

    INNER JOIN muu_categories 

            ON muu_categories.ID_Category = muu_re_categories_applications.ID_Category;

END$$

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `getCategoriesByApplication`(_Application VARCHAR(150), _Language VARCHAR(15))
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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `getCategoriesByRecord`(_ID_Application mediumint(8), _ID_Record mediumint(8))
BEGIN

    SELECT * FROM muu_categories WHERE muu_categories.ID_Category IN (

        SELECT muu_re_categories_applications.ID_Category FROM muu_re_categories_applications 

        WHERE muu_re_categories_applications.ID_Application = _ID_Application AND muu_re_categories_applications.ID_Category2Application IN (

            SELECT muu_re_categories_records.ID_Category2Application FROM muu_re_categories_records WHERE ID_Record = _ID_Record

        )

    );

END$$

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `getComments`(_ID_Application mediumint(8), _ID_Record mediumint(8))
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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `getFeedbackNotifications`()
BEGIN

    SELECT * FROM muu_feedback WHERE Situation != 'Read';

END$$

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `getImage`(_ID_Image MEDIUMINT(8))
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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `getLink`(_ID_Link MEDIUMINT(8))
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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `getRepliesByTopic`(
    _ID_Parent MEDIUMINT(8)
)
BEGIN
  SELECT * FROM muu_forums_posts
  INNER JOIN muu_users ON muu_users.ID_User = muu_forums_posts.ID_User
  INNER JOIN muu_users_information ON muu_users_information.ID_User = muu_users.ID_User
  WHERE ID_Parent = _ID_Parent;
END$$

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `getTags`(_ID_Application mediumint(8), _ID_Record mediumint(8))
BEGIN

    SELECT * FROM muu_tags WHERE muu_tags.ID_Tag IN (

        SELECT muu_re_tags_applications.ID_Tag FROM muu_re_tags_applications 

        WHERE muu_re_tags_applications.ID_Application = _ID_Application AND muu_re_tags_applications.ID_Tag2Application IN (

            SELECT muu_re_tags_records.ID_Tag2Application FROM muu_re_tags_records WHERE ID_Record = _ID_Record

        )

    );

END$$

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `getTagsByRecord`(_ID_Application mediumint(8), _ID_Record mediumint(8))
BEGIN
    SELECT * FROM muu_tags WHERE muu_tags.ID_Tag IN (
        SELECT muu_re_tags_applications.ID_Tag FROM muu_re_tags_applications 
        WHERE muu_re_tags_applications.ID_Application = _ID_Application AND muu_re_tags_applications.ID_Tag2Application IN (
            SELECT muu_re_tags_records.ID_Tag2Application FROM muu_re_tags_records WHERE ID_Record = _ID_Record
        )
    );
END$$

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `getTopicForum`(_ID_Post MEDIUMINT(8))
BEGIN
  SELECT * FROM muu_forums_posts
  INNER JOIN muu_users ON muu_users.ID_User = muu_forums_posts.ID_User
  INNER JOIN muu_users_information ON muu_users_information.ID_User = muu_users.ID_User
  WHERE ID_Post = _ID_Post AND Situation = 'Active' AND ID_Parent = 0;
END$$

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `getUser`(_ID_User mediumint(8))
BEGIN

  SELECT muu_users.*, muu_re_privileges_users.ID_Privilege FROM muu_users, muu_re_privileges_users WHERE muu_users.ID_User = _ID_User and muu_re_privileges_users.ID_User = _ID_User;

END$$

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `setCategory`(

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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `setForum`(
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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `setImage`(

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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `setPage`(

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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `setReplyTopic`(
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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `setTopicForum`(
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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `setUser`(

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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `updateForum`(

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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `updateImage`(
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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `updateLink`(

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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `updatePage`(

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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `updateReplyTopic`(
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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `updateTopicForum`(
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

CREATE DEFINER=`muucmsco`@`localhost` PROCEDURE `updateUser`(

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_ads`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_applications`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=26 ;

--
-- Volcado de datos para la tabla `muu_blog`
--

INSERT INTO `muu_blog` (`ID_Post`, `ID_User`, `ID_URL`, `Title`, `Slug`, `Content`, `Author`, `Start_Date`, `Text_Date`, `Year`, `Month`, `Day`, `Views`, `Image_Small`, `Image_Medium`, `Comments`, `Enable_Comments`, `Language`, `Pwd`, `Situation`) VALUES
(11, 2, 1, '5 años de cárcel para dos ladrones de ganado en Tecoman.', '5-anos-de-carcel-para-dos-ladrones-de-ganado-en-tecoman', '<p>Sacrificaron y destazaron una becerra para vender su carne.</p>\r\n<p><!-- pagebreak --></p>\r\n<p>En Tecom&aacute;n el juez segundo de lo penal dict&oacute; sentencia de cinco a&ntilde;os de prisi&oacute;n a Jos&eacute; Isidro Maldonado Montoy (a) <em>El Chiro</em> y Gabriel Mayo Mar&iacute;n (a) <em>Sol&iacute;n</em>, por ser responsable del delito de robo de ganado en t&eacute;rminos de autor&iacute;a y participaci&oacute;n en agravio de Jos&eacute; Luis &Aacute;lvarez Silva, por hechos ocurridos en febrero del a&ntilde;o pasado en una parcela que se ubica a un castado de la carretera Tecom&aacute;n-El Real.</p>\r\n<p>De acuerdo a la indagatoria, el d&iacute;a 10 de febrero del a&ntilde;o 2011 los hoy sentenciados robaron, sacrificaron y destazaron una becerra propiedad del ofendido, con el fin de vender la carne y obtener dinero, sin embargo fueron detenidos por las autoridades policiacas y puestos a disposici&oacute;n del ministerio p&uacute;blico para llevar a cabo los tr&aacute;mites correspondientes y continuar el proceso que la ley establece.&nbsp;</p>\r\n<p>Se hace un llamado a la poblaci&oacute;n en general para que denuncie de manera an&oacute;nima hechos delictivos a la PGJ a los tel&eacute;fonos gratuitos 01 800 581 1770, 01 800 506 8360, as&iacute; como al 01 800 8306415, afin de coadyuvar con las autoridades en las acciones que sigan garantizando el Colima Seguro que la poblaci&oacute;n exige.</p>', 'vision7', 1329768874, 'Lunes, 20 de Febrero de 2012', '2012', '02', '20', 5, 'www/lib/files/images/blog/small_a478e_7-anos-por-robar-ganado.jpg', 'www/lib/files/images/blog/medium_a478e_7-anos-por-robar-ganado.jpg', 0, 1, 'Spanish', '', 'Active'),
(12, 2, 1, 'PRI presenta lista de Aspirantes Locales ', 'pri-presenta-lista-de-aspirantes-locales', '<p>&nbsp;</p>\r\n<ul>\r\n<li><strong>Tambi&eacute;n fue dada a conocer las convocatorias PRI para la selecci&oacute;n de candidatos a Diputados Locales y Presidentes Municipales</strong></li>\r\n</ul>\r\n<p><strong><span><span style="font-family: Calibri;"><!-- pagebreak --></span></span></strong></p>\r\n<p class="yiv1968587137MsoNormal">&nbsp;</p>\r\n<p>En la rueda de prensa en que se dieron a conocer las convocatorias para la selecci&oacute;n de candidatos a alcaldes y diputados locales, el dirigente estatal del PRI Mart&iacute;n Flores Casta&ntilde;eda, difundi&oacute; la lista de aspirantes que el Partido contempla en la recta final rumbo a la definici&oacute;n de las candidaturas locales.</p>\r\n<p class="yiv1968587137MsoNormal">&nbsp;</p>\r\n<p>&nbsp;Para la presidencia municipal de Armer&iacute;a participan Patricia Mac&iacute;as G&oacute;mez, Gonzalo Isordia Heredia y Mart&iacute;n Alcaraz Parra, mientras que para la diputaci&oacute;n local est&aacute;n contemplados Esperanza Alcaraz Alcaraz y Ramiro Pamplona Rosales.</p>\r\n<p class="yiv1968587137MsoNormal">&nbsp;</p>\r\n<p>&nbsp;En el proceso de selecci&oacute;n para la presidencia municipal de Colima est&aacute; contemplado en la etapa conclusiva Federico Rangel Lozano.</p>\r\n<p class="yiv1968587137MsoNormal">&nbsp;</p>\r\n<p>Para las diputaciones locales en este municipio figuran para el distrito I Miguel de la Madrid Andrade, Pastora Ferraez Lepe, Hugo V&aacute;zquez Montes y Francisco Barrag&aacute;n Preciado.</p>\r\n<p class="yiv1968587137MsoNormal">&nbsp;</p>\r\n<p>En lo referente al segundo distrito se encuentran en la recta final de las evaluaciones Oscar Gait&aacute;n Mart&iacute;nez, Jos&eacute; Antonio Orozco Sandoval y Ernesto Pasar&iacute;n Tapia, mientras que para el distrito tres del municipio de Colima el PRI eval&uacute;a a Oscar Valdovinos Anguiano y Jos&eacute; Verduzco Moreno.</p>\r\n<p class="yiv1968587137MsoNormal">&nbsp;</p>\r\n<p>En lo que corresponde al municipio de Comala, para la alcald&iacute;a est&aacute;n siendo evaluados en la etapa final Jos&eacute; Ferm&iacute;n Santana, C&eacute;sar Rodr&iacute;guez Rinc&oacute;n, Salom&oacute;n Salazar Barrag&aacute;n y Francisco Montes Fuentes, mientras que para la diputaci&oacute;n local solamente participa Agust&iacute;n Morales Anguiano.</p>\r\n<p class="yiv1968587137MsoNormal">&nbsp;</p>\r\n<p>Para la alcald&iacute;a del municipio de Coquimatl&aacute;n est&aacute; siendo considerado David Ballesteros Peralta, pero a&uacute;n est&aacute; por definirse quienes m&aacute;s participan. En lo que corresponde ala diputaci&oacute;n local est&aacute; siendo evaluado Jos&eacute; Juan Michel Ram&iacute;rez.</p>\r\n<p class="yiv1968587137MsoNormal">&nbsp;</p>\r\n<p>Por lo que corresponde a la presidencia municipal de Cuauht&eacute;moc est&aacute; siendo evaluada Mely Romero Celis, mientras que para la diputaci&oacute;n local el partido eval&uacute;a en esta recta final a Dinorah Serratos de Plascencia, Cesar Ceballos G&oacute;mez y Octavio Tintos Trujillo.</p>\r\n<p class="yiv1968587137MsoNormal">&nbsp;</p>\r\n<p>En lo referente a la alcald&iacute;a de Ixtlahuac&aacute;n el partido est&aacute; evaluando a Carlos Carrasco Ch&aacute;vez, Mart&iacute;n Guadalupe Rivera, Severo Bautista Mac&iacute;as y Jos&eacute; Cort&eacute;s Navarro, mientras que para la diputaci&oacute;n local est&aacute;n contemplados Jorge Audel Mendoza Virgen, Concepci&oacute;n V&aacute;zquez Flores y Crisp&iacute;n Guti&eacute;rrez Moreno.</p>\r\n<p class="yiv1968587137MsoNormal">&nbsp;</p>\r\n<p>El dirigente priista dijo tambi&eacute;n que para la presidencia municipal de Manzanillo participan en esta etapa de evaluaci&oacute;n Rogelio Rueda S&aacute;nchez y Armida N&uacute;&ntilde;ez Garc&iacute;a, para la diputaci&oacute;n por el distrito XI Mart&iacute;n S&aacute;nchez Valdivia, para el XII Guillermo Topete Palomera, Francisco Santana Ochoa y Alberto Medina Urgell, mientras que para la diputaci&oacute;n local por el distrito XIII se eval&uacute;a a Miguel Salazar Abaroa, Celsa D&iacute;az Zamorano y Heriberto Leal Valencia.</p>\r\n<p>En Minatitl&aacute;n es evaluado para la alcald&iacute;a Alejandro Mancilla Gonz&aacute;lez, mientras que para la diputaci&oacute;n local Manuel Palacios Rodr&iacute;guez y Lilia Figueroa Larios.</p>\r\n<p class="yiv1968587137MsoNormal">&nbsp;</p>\r\n<p>En Tecom&aacute;n para la presidencia municipal participan H&eacute;ctor Ra&uacute;l V&aacute;zquez Montes, Arturo Garc&iacute;a Arias y Jos&eacute; Guadalupe Garc&iacute;a Negrete, para la diputaci&oacute;n del distrito XV Juan Carlos Pinto Rodr&iacute;guez, Arturo Garc&iacute;a Arias, Mayra Cavazos Ceballos y Julio Anguiano Urbina.</p>\r\n<p class="yiv1968587137MsoNormal">&nbsp;</p>\r\n<p>Tambi&eacute;n en Tecom&aacute;n para la diputaci&oacute;n local por el distrito XVI se eval&uacute;a a No&eacute; Pinto de los Santos y Flavio Castillo Palomino.</p>\r\n<p class="yiv1968587137MsoNormal">&nbsp;</p>\r\n<p>Finalmente, para la alcald&iacute;a del municipio de Villa de &Aacute;lvarez est&aacute;n considerados Enrique Rojas Orozco, Petronilo V&aacute;zquez Vuelvas y Adrian L&oacute;pez Virgen, mientras que para la diputaci&oacute;n local por el distrito VII se eval&uacute;a a Cuauht&eacute;moc Gait&aacute;n Cabrera, Fernando Mancilla Gonz&aacute;lez, Jes&uacute;s Villanueva Guti&eacute;rrez y Luis &Aacute;vila Aguilar, mientras que para el distrito est&aacute;n considerados VIII Mar&iacute;a Esther Guti&eacute;rrez, Hermelinda Carrillo Gamboa, Luis Ernesto Calvario Venegas y Sergio Michel Casta&ntilde;eda.</p>\r\n<p class="yiv1968587137MsoNormal">&nbsp;</p>\r\n<p>Por su parte, Miguel Ch&aacute;vez Michel, presidente de la Comisi&oacute;n Estatal de Procesos Internos, dio a conocer que para la elecci&oacute;n de candidatos a Diputados Locales, a partir del 28 de febrero ser&aacute; la entrega de formatos para registros, el registro de precandidatos tendr&aacute; lugar el jueves 1 de marzo, las precampa&ntilde;as se realizar&aacute;n invariablemente entre el 3 y 5 de marzo, mientras que las convenciones de delegados se efectuar&aacute;n entre el jueves 8 y el s&aacute;bado 10 de marzo.</p>\r\n<p class="yiv1968587137MsoNormal">&nbsp;</p>\r\n<p>En lo que cabe al proceso para seleccionar candidatos a Presidentes Municipales, a partir del mi&eacute;rcoles 29 se estar&aacute;n entregando los formatos para los registros, el viernes 2 ser&aacute; el registro de aspirantes, el proceso interno de precampa&ntilde;a ser&aacute; tambi&eacute;n entre el 3 y el 5 de marzo, mientras que entre el lunes 12 y el mi&eacute;rcoles 14 de marzo tendr&aacute;n lugar las convenciones de delegados.</p>\r\n<p class="yiv1968587137MsoNormal"><span style="font-family: Calibri;"><br /></span></p>\r\n<p class="yiv1968587137MsoNormal">&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', 'vision7', 1329770922, 'Lunes, 20 de Febrero de 2012', '2012', '02', '20', 7, 'www/lib/files/images/blog/small_28296_lista-negra.jpg', 'www/lib/files/images/blog/medium_28296_lista-negra.jpg', 0, 1, 'Spanish', '', 'Active'),
(13, 2, 1, 'Rehabilitaran el balneario ojo de agua en Zacualpan y crearan un hostal.', 'rehabilitaran-el-balneario-ojo-de-agua-en-zacualpan-y-crearan-un-hostal', '<p><strong>Como parte de la recuperaci&oacute;n de zonas da&ntilde;adas por el paso del hurac&aacute;n Jova en Comala.</strong></p>\r\n<p><strong><!-- pagebreak --></strong></p>\r\n<p>Se busca obtener recursos para la rehabilitaci&oacute;n del ojo de agua &ldquo;El Cobano&rdquo; de la comunidad de Zacualpan donde se benefician cerca de 308 familias del lugar, indicaron el Ing. Sergio Agust&iacute;n Morales Anguiano y el Regidor de la comunidad Ing. Melesio Guzm&aacute;n Santos.</p>\r\n<p>Dieron a conocer que se present&oacute; un proyecto ante la Comisi&oacute;n Nacional para el Desarrollo de los Pueblos Ind&iacute;genas, el cual tiene como objetivo rehabilitar las zonas da&ntilde;adas por el hurac&aacute;n, a&ntilde;adieron que gracias al apoyo del Gobernador del Estado Lic. Mario Anguiano Moreno ya se han recibido algunos apoyos como mueble y limpieza, as&iacute; como del Gobierno Municipal, lo que permiti&oacute; la reactivaci&oacute;n del balneario, sin embargo es necesario tambi&eacute;n el apoyo de la comisi&oacute;n, por lo que se present&oacute; un proyecto de rehabilitaci&oacute;n integral por 1 mill&oacute;n 500 mil pesos.</p>\r\n<p>Invit&oacute; el alcalde a visitar este hermoso balneario donde se ofrece servicio de restaurante con comidas t&iacute;picas de la regi&oacute;n, caminata hacia un mirador, observaci&oacute;n de flora y fauna, venta de artesan&iacute;as, paquetes tur&iacute;sticos que incluyen visitas a eventos culturales a la comunidad, paquetes especiales a escuelas, discapacitados e instituciones que as&iacute; lo soliciten.</p>\r\n<p>Por otra parte se presentar&aacute; tambi&eacute;n ante esta comisi&oacute;n un proyecto para la habilitaci&oacute;n de un hostal buscando reactivar la zona que se conoce como el vivero ubicado dentro de la zona urbana de la misma comunidad y que ser&aacute; administrado por un grupo de mujeres de la Unidad Agr&iacute;cola e Industrial de la Mujer, solicitando recursos por 350 mil pesos para realizar los estudios necesarios para determinar la factibilidad del proyecto, finaliz&oacute;<strong><br /></strong></p>', 'vision7', 1329772250, 'Lunes, 20 de Febrero de 2012', '2012', '02', '20', 8, 'www/lib/files/images/blog/small_a7dce_laguna-de-zacualpan.png', 'www/lib/files/images/blog/medium_a7dce_laguna-de-zacualpan.png', 0, 1, 'Spanish', '', 'Active'),
(14, 2, 1, 'Presentan las candidatas a reina de la Facultad de Contabilidad y Administración', 'presentan-las-candidatas-a-reina-de-la-facultad-de-contabilidad-y-administracion', '<div class="SCX251780891">\r\n<ul class="BulletListStyle1 SCX251780891">\r\n<li class="OutlineElement Ltr SCX251780891" style="font-style: normal; text-indent: 0px; font-family: Verdana; margin-left: 48px; font-size: 12pt; vertical-align: baseline; font-weight: normal;">\r\n<p class="Paragraph SCX251780891" style="background-color: transparent; font-style: normal; text-indent: 0px; width: auto; font-family: ''Segoe UI'',Tahoma,Verdana,''Sans-Serif''; height: auto; color: windowtext; font-size: 8pt; vertical-align: baseline; font-weight: normal; margin-right: 21px;"><span class="TextRun SCX251780891" style="font-style: italic; font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">La reina participar&aacute; en actividades del 50 aniversario de la escuela</span></p>\r\n</li>\r\n<li class="OutlineElement Ltr SCX251780891" style="font-style: normal; text-indent: 0px; font-family: Verdana; margin-left: 48px; font-size: 12pt; vertical-align: baseline; font-weight: normal;">\r\n<p class="Paragraph SCX251780891" style="background-color: transparent; font-style: normal; text-indent: 0px; font-family: ''Segoe UI'',Tahoma,Verdana,''Sans-Serif''; color: windowtext; font-size: 8pt; vertical-align: baseline; font-weight: normal;"><span class="TextRun SCX251780891" style="font-style: italic; font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">Las concursantes llevar&aacute;n a cabo actividades de labor social</span></p>\r\n</li>\r\n</ul>\r\n</div>\r\n<p class="Paragraph SCX251780891" style="background-color: transparent; font-style: normal; text-indent: 0px; font-family: ''Segoe UI'',Tahoma,Verdana,''Sans-Serif''; color: windowtext; margin-left: 48px; font-size: 8pt; vertical-align: baseline; font-weight: normal;"><span class="TextRun SCX251780891" style="font-style: italic; font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX"><!-- pagebreak --></span></p>\r\n<p class="Paragraph SCX251780891" style="background-color: transparent; font-style: normal; text-indent: 0px; font-family: ''Segoe UI'',Tahoma,Verdana,''Sans-Serif''; color: windowtext; font-size: 8pt; vertical-align: baseline; font-weight: normal;" xml:lang="ES-ES">&nbsp;</p>\r\n<div class="OutlineElement Ltr SCX251780891" style="text-indent: 0px; margin-left: 0px;">\r\n<p class="Paragraph SCX251780891" style="background-color: transparent; font-style: normal; text-indent: 0px; font-family: ''Segoe UI'',Tahoma,Verdana,''Sans-Serif''; color: windowtext; font-size: 8pt; vertical-align: baseline; font-weight: normal;"><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">La Facultad de Contabilidad y Administraci&oacute;n de la Universidad de Colima present&oacute; a las candidatas a reina que participar&aacute;n este a&ntilde;o en el certamen Miss FCA 2012, el cual pretende ser una propuesta novedosa en la que las contendientes desarrollar&aacute;n actividades de labor social.</span></p>\r\n<p class="Paragraph SCX251780891" style="background-color: transparent; font-style: normal; text-indent: 0px; font-family: ''Segoe UI'',Tahoma,Verdana,''Sans-Serif''; color: windowtext; font-size: 8pt; vertical-align: baseline; font-weight: normal;">&nbsp;</p>\r\n<div class="OutlineElement Ltr SCX251780891" style="text-indent: 0px; margin-left: 0px;">\r\n<p class="Paragraph SCX251780891" style="background-color: transparent; font-style: normal; text-indent: 0px; font-family: ''Segoe UI'',Tahoma,Verdana,''Sans-Serif''; color: windowtext; font-size: 8pt; vertical-align: baseline; font-weight: normal;"><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">Las participantes son: </span><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">Ye</span><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">ssica</span><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX"> Feliz Salas de 6&ordm; C, Mariana Elizabeth Flores Villalvazo de 6&ordm; A, </span><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">Janice</span><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX"> Jacqueline Ramos D&iacute;az 2&ordm; B, Estefan&iacute;a M&aacute;rquez Luna de </span><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">6&ordm; D, </span><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">Ericka</span><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX"> Gonz&aacute;lez Zendejas 8&ordm; C, Alma Rosa P&eacute;rez Orozco 4&ordm; B, </span><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">Silem</span><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX"> Alejandra C&aacute;rdenas Mendoza de 4&ordm; A, </span><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">Ailim</span><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">del Toro Uribe de 4&ordm; B y Lilia Nohem&iacute; &Aacute;guila Amezcua de 4&ordm; C, y la reina saliente es Laura Castell Garc&iacute;a.</span></p>\r\n</div>\r\n<div class="OutlineElement Ltr SCX251780891" style="text-indent: 0px; margin-left: 0px;">\r\n<p class="Paragraph SCX251780891" style="background-color: transparent; font-style: normal; text-indent: 0px; font-family: ''Segoe UI'',Tahoma,Verdana,''Sans-Serif''; color: windowtext; font-size: 8pt; vertical-align: baseline; font-weight: normal;"><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">El presidente de la Sociedad de Alumnos de esta facultad, Alejandra Jim&eacute;nez Valdovinos, dio a conocer un magno evento que planea presentar a sus candidatas mediante un concepto diferente.</span></p>\r\n</div>\r\n</div>\r\n<div class="OutlineElement Ltr SCX251780891" style="text-indent: 0px; margin-left: 0px;">\r\n<p class="Paragraph SCX251780891" style="background-color: transparent; font-style: normal; text-indent: 0px; font-family: ''Segoe UI'',Tahoma,Verdana,''Sans-Serif''; color: windowtext; font-size: 8pt; vertical-align: baseline; font-weight: normal;"><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">Detall&oacute; que la deliberaci&oacute;n se har&aacute; mediante el voto de un jurado conformado por jueces de otros estados, esto con el fin de que exista transparencia en el proceso y todas las participantes cuenten con las mismas oportunidades.</span></p>\r\n</div>\r\n<div class="OutlineElement Ltr SCX251780891" style="text-indent: 0px; margin-left: 0px;">\r\n<p class="Paragraph SCX251780891" style="background-color: transparent; font-style: normal; text-indent: 0px; font-family: ''Segoe UI'',Tahoma,Verdana,''Sans-Serif''; color: windowtext; font-size: 8pt; vertical-align: baseline; font-weight: normal;"><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">As&iacute; mismo, Alejandra Jim&eacute;nez Valdovinos se&ntilde;al&oacute; que una de las metas de este evento es mostrar, adem&aacute;s de las cualidades f&iacute;sicas de las candidatas y su proyecci&oacute;n esc&eacute;nica, la actividad de impacto social que realicen en lugares como casas hogares, asilos para personas de la tercera edad, entre otros. </span></p>\r\n</div>\r\n<div class="OutlineElement Ltr SCX251780891" style="text-indent: 0px; margin-left: 0px;">\r\n<p class="Paragraph SCX251780891" style="background-color: transparent; font-style: normal; text-indent: 0px; font-family: ''Segoe UI'',Tahoma,Verdana,''Sans-Serif''; color: windowtext; font-size: 8pt; vertical-align: baseline; font-weight: normal;"><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">Anunci&oacute; que la concursante que resulte ganadora de este certamen recibir&aacute; un premio de 8 mil pesos en efectivo y tendr&aacute; el compromiso de participar en distintas actividades acad&eacute;micas, culturales y recreativas de la Facultad de Contabilidad y Administraci&oacute;n, representando a los estudiantes de &eacute;sta.</span></p>\r\n</div>\r\n<div class="OutlineElement Ltr SCX251780891" style="text-indent: 0px; margin-left: 0px;">\r\n<p class="Paragraph SCX251780891" style="background-color: transparent; font-style: normal; text-indent: 0px; font-family: ''Segoe UI'',Tahoma,Verdana,''Sans-Serif''; color: windowtext; font-size: 8pt; vertical-align: baseline; font-weight: normal;"><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">Por su parte, la secretaria de Cultura de la Sociedad de Alumnos de la FCA, Yaret Anguiano Arreola, resalt&oacute; que este certamen es importante para la facultad, ya que de ah&iacute; saldr&aacute; la persona que representar&aacute; de manera digna a los estudiantes de esta instituci&oacute;n que pr&oacute;ximamente llegar&aacute; a su 50 Aniversario.</span></p>\r\n</div>\r\n<div class="OutlineElement Ltr SCX251780891" style="text-indent: 0px; margin-left: 0px;">\r\n<p class="Paragraph SCX251780891" style="background-color: transparent; font-style: normal; text-indent: 0px; font-family: ''Segoe UI'',Tahoma,Verdana,''Sans-Serif''; color: windowtext; font-size: 8pt; vertical-align: baseline; font-weight: normal;"><span class="TextRun SCX251780891" style="font-family: Tahoma,Sans-Serif; font-size: 12pt;" xml:lang="ES-MX">Finalmente, Yaret Anguiano inform&oacute; que entre los eventos se encuentran la presentaci&oacute;n formal de las candidatas el 9 de marzo, la callejoneada el 16 de marzo y el c&oacute;mputo final el 17 de marzo. Cabe mencionar que la reina de la FCA 2012 intervendr&aacute; de forma activa en las tareas que realiza la sociedad de alumnos de esta facultad.</span></p>\r\n</div>\r\n<div class="OutlineElement Ltr SCX251780891" style="text-indent: 0px; margin-left: 0px;">\r\n<p class="Paragraph SCX251780891" style="background-color: transparent; font-style: normal; text-indent: 0px; font-family: ''Segoe UI'',Tahoma,Verdana,''Sans-Serif''; color: windowtext; font-size: 8pt; vertical-align: baseline; font-weight: normal;">&nbsp;</p>\r\n</div>\r\n<div class="OutlineElement Ltr SCX251780891" style="text-indent: 0px; margin-left: 0px;">\r\n<p class="Paragraph SCX251780891" style="text-align: left; background-color: transparent; font-style: normal; text-indent: 0px; font-family: ''Segoe UI'',Tahoma,Verdana,''Sans-Serif''; color: windowtext; font-size: 8pt; vertical-align: baseline; font-weight: normal;">&nbsp;</p>\r\n</div>', 'vision7', 1329775685, 'Lunes, 20 de Febrero de 2012', '2012', '02', '20', 26, 'www/lib/files/images/blog/small_5e3cf_candidatas-fca.jpg', 'www/lib/files/images/blog/medium_5e3cf_candidatas-fca.jpg', 0, 1, 'Spanish', '', 'Active'),
(16, 2, 1, 'La Presidenta de Colima fomenta el hábito de la lectura', 'la-presidenta-de-colima-fomenta-el-habito-de-la-lectura', '<p>Mar&iacute;a Guadalupe Vuelvas Cisneros, exhort&oacute; a los alumnos a fomentar el h&aacute;bito de la lectura.</p>\r\n<p><!-- pagebreak --></p>\r\n<p>&ldquo;El ni&ntilde;o que lee mejora su vocabulario, facilita sus habilidades y aprende m&aacute;s r&aacute;pido&rdquo;, asegur&oacute; la alcaldesa al dirigir un mensaje al encabezar la ceremonia c&iacute;vica en la escuela primaria &ldquo;Gregorio Torres Quintero&rdquo; de la colonia El Diezmo, donde fue directora por m&aacute;s de 8 a&ntilde;os</p>\r\n<p>Mencion&oacute; que es necesario que los padres de familia apoyen a sus hijos para que desde peque&ntilde;os desarrollen el gusto por la leer, &ldquo;qu&eacute; mejor que sea en el seno familiar donde se inicie este excelente h&aacute;bito&rdquo;.</p>\r\n<p>&ldquo;Mucho se ha dicho que los libros son nuestros mejores amigos, porque nos ayudan no s&oacute;lo al desarrollo, sino tambi&eacute;n a madurar y tomar decisiones acertadas&rdquo;, expuso la presidenta municipal de Colima.</p>\r\n<p>Por otra parte, felicit&oacute; a los alumnos, padres de familia y directivos por formar un solo equipo e ir transformando las instalaciones, adecu&aacute;ndolas a las nuevas necesidades que se tienen, tomando en cuenta que se trata de una escuela de tiempo completo.</p>\r\n<p>&ldquo;Solamente as&iacute;, trabajando unidos es como se logran las cosas, por eso nuestro reconocimiento y felicitaci&oacute;n por trabajar en una sola direcci&oacute;n&rdquo;, agreg&oacute; la mandataria municipal.</p>\r\n<p>En su oportunidad, el director del plantel, Jos&eacute; Luis Oliva G&oacute;mez agradeci&oacute; a la alcaldesa que los haya visitado y sobre todo que haya regresado a una escuela donde se le recuerda y aprecia.<strong></strong></p>\r\n<p>Cabe destacar que esta ceremonia estuvo a cargo de los alumnos del 6&ordm; B, a cargo de la profesora Itzel Morent&iacute;n Valladares<strong>.</strong></p>\r\n<p>Por la tarde, la alcaldesa visit&oacute; la escuela primaria Heliodoro Silva Palacios, que est&aacute; ubicada en la calle Francisco Hern&aacute;ndez Espinoza, en la colonia Fovissste, en donde dirigi&oacute; un mensaje a los alumnos sobre la importancia de su formaci&oacute;n educativa.</p>', 'vision7', 1329776633, 'Lunes, 20 de Febrero de 2012', '2012', '02', '20', 6, 'www/lib/files/images/blog/small_4ee94_presentacion1.jpg', 'www/lib/files/images/blog/medium_4ee94_presentacion1.jpg', 0, 1, 'Spanish', '', 'Active'),
(18, 2, 1, 'El Congreso del Colima pide disminuir los fraudes electrónicos.', 'el-congreso-del-colima-pide-disminuir-los-fraudes-electronicos', '<p>Para disminuir los fraudes electr&oacute;nicos y los que se hacen v&iacute;a llamada telef&oacute;nica, el Congreso del Estado exhort&oacute; a la Comisi&oacute;n Nacional Bancaria y de Valores (CNByV) a que conmine a las instituciones financieras, a que implementen m&eacute;todos de contrataci&oacute;n electr&oacute;nica de bienes m&aacute;s efectivos y seguros.</p>\r\n<p><!-- pagebreak --></p>\r\n<p>El exhorto a la CNByV, realizado a trav&eacute;s de punto de acuerdo presentado por el Grupo Parlamentario del PRI, se&ntilde;ala que el comercio electr&oacute;nico tiene como forma de pago m&aacute;s popular la tarjeta de cr&eacute;dito, encontr&aacute;ndose instituciones que aceptan pagos con tarjeta sin proveer de seguridad extra la transacci&oacute;n.</p>\r\n<p>El punto de acuerdo se&ntilde;ala que esa situaci&oacute;n est&aacute; provocando que los sitios que aceptan informaci&oacute;n de tarjetas de cr&eacute;dito sin seguridad extra, est&aacute;n tomando el riesgo de posibles fraudes, incluyendo cargos considerables cuando no fueron debidamente autorizados.</p>\r\n<p>Asimismo, el Congreso del Estado destac&oacute; el crecimiento del n&uacute;mero de llamadas telef&oacute;nicas de ofertas por parte de las instituciones bancarias para ofrecer diversos servicios, en las que se corre el riesgo de no tener la certeza por parte de la ofertante que quien acepta sea realmente la persona que dice ser.</p>\r\n<p>Se&ntilde;alaron que esa situaci&oacute;n puede prestarse a obligar a personas que nunca dieron su aprobaci&oacute;n, a contratar servicios con un supuesto banco o instituci&oacute;n de cr&eacute;dito que al final pueden resultar un fraude, dado que realiz&oacute; operaciones comerciales con una persona que usurp&oacute; la identidad de alguna empresa o un ciudadano.</p>\r\n<p>Ante estas circunstancias, los diputados estimaron oportuno exhortar a la CNByV, para que conmine a las instituciones adscritas al sistema financiero nacional, a implementar m&eacute;todos de contrataci&oacute;n electr&oacute;nica de bienes y/o servicios m&aacute;s efectivos y seguros.</p>\r\n<p>Tambi&eacute;n se exhort&oacute; a la Comisi&oacute;n Nacional parala Protecci&oacute;ny Defensa de los Usuarios de Servicios Financieros, para que difunda en la poblaci&oacute;n informaci&oacute;n relativa al uso adecuado y responsable de los servicios financieros y en la medida de lo posible, disminuir la comisi&oacute;n de delitos de fraude o abuso de confianza, que en ocasiones son objeto los usuarios de los servicios bancarios.</p>', 'vision7', 1329779996, 'Lunes, 20 de Febrero de 2012', '2012', '02', '20', 5, 'www/lib/files/images/blog/small_4db0f_800px-congreso-de-colima.jpg', 'www/lib/files/images/blog/medium_4db0f_800px-congreso-de-colima.jpg', 0, 1, 'Spanish', '', 'Active'),
(19, 2, 1, 'Captura la Policía Estatal  a persona armada.', 'captura-la-policia-estatal-a-persona-armada', '<p><em>Portaba pistola calibre 38 s&uacute;per fue a</em><em>segurado en la comunidad de Acatit&aacute;n</em></p>\r\n<p>&nbsp;<!-- pagebreak --></p>\r\n<p>&nbsp;Elementos de la Polic&iacute;a Estatal detuvieron la noche de este domingo a quien dijo llamarse Juan Gabriel Medrano de la Cruz de 32 a&ntilde;os de edad, con domicilio en la comunidad de Piscila, municipio de Colima, por su probable responsabilidad en la comisi&oacute;n del delito de portaci&oacute;n de arma de fuego sin licencia y dem&aacute;s que resulte.</p>\r\n<p>Por indicaciones de la central de emergencias 066, elementos de la Polic&iacute;a Estatal se trasladaron a la localidad de Acatit&aacute;n, Colima, ya que se reportaba una persona que portaba un armada de fuego.</p>\r\n<p>Al arribar al jard&iacute;n de dicho comunidad, a los elementos policiales les fueron&nbsp; proporcionadas las caracter&iacute;sticas y se&ntilde;as particulares del presunto delincuente armado, motivo por el cual los agentes de la Polic&iacute;a Estatal Preventiva (PEP) y Polic&iacute;a Estatal Acreditable (PEA) implementaron un operativo de b&uacute;squeda y detecci&oacute;n en busca del presunto infractor, logrando ubicar una persona que coincid&iacute;a con las caracter&iacute;sticas proporcionadas por los denunciantes, mismo que al ver la presencia policial intent&oacute; darse a la fuga.</p>\r\n<p>Motivo por el cual los elementos de la SSP iniciaron la persecuci&oacute;n y posterior aseguramiento del presunto infractor, mismo que portaba una pistola marca Colt, calibre 38 s&uacute;per, autom&aacute;tica, con su respectivo cargador abastecido con 8 cartuchos &uacute;tiles.</p>\r\n<p>Ante tales hechos y las evidencias encontradas los elementos de la Polic&iacute;a Estatal procedieron al aseguramiento y traslado del presunto delincuente, a la Direcci&oacute;n General de la Polic&iacute;a Estatal Preventiva para realizar los tr&aacute;mites legales correspondientes.</p>\r\n<p>Una vez concluidos en la dependencia policial, el probable responsable junto con el arma y los cartuchos asegurados fueron puestos a disposici&oacute;n del Ministerio P&uacute;blico correspondiente.</p>\r\n<p>&nbsp;</p>', 'vision7', 1329781994, 'Lunes, 20 de Febrero de 2012', '2012', '02', '20', 6, 'www/lib/files/images/blog/small_123d6_detenido.png', 'www/lib/files/images/blog/medium_123d6_detenido.png', 0, 1, 'Spanish', '', 'Active'),
(21, 2, 1, 'Declina Alfredo Hernández  a favor de Enrique Rojas por la presidencia de Villa de Alvarez.', 'declina-alfredo-hernandez-a-favor-de-enrique-rojas-por-la-presidencia-de-villa-de-alvarez', '<p class="ecxMsoNoSpacing"><span>En relacion a su aspiraci&oacute;n a ser candidato a la Presidencia Municipal de Villa de &Aacute;lvarez,&nbsp;el coordinador de los diputados locales del PANAL, Alfredo Hern&aacute;ndez Ramos, dijo &nbsp;declinar a favor de Enrique Rojas Orozco.&nbsp;</span></p>\r\n<p class="ecxMsoNoSpacing">Hern&aacute;ndez Ramos explic&oacute; que los acuerdos de su Partido y el PRI indican que s&iacute; habr&aacute; una alianza electoral para enfrentar los comicios locales, en la cual la candidatura a la alcald&iacute;a de Villa de &Aacute;lvarez corresponder&aacute; a un militante del Revolucionario Institucional.</p>\r\n<p class="ecxMsoNoSpacing">&ldquo;En virtud de esos acuerdos, yo declino a mi leg&iacute;tima aspiraci&oacute;n de ser candidato a la Presidencia Municipal de la Villa, y lo hago a favor de quien considero es el priista que m&aacute;s aceptaci&oacute;n tiene entre los villalvarenses, en este caso el diputado Enrique Rojas Orozco&rdquo;, se&ntilde;al&oacute; el legislador del Partido Nueva Alianza.</p>\r\n<p class="ecxMsoNoSpacing">En ese sentido, se congratul&oacute; porque el diputado Enrique Rojas es considerado por la dirigencia estatal del Revolucionario Institucional como posible candidato a alcalde de Villa de &Aacute;lvarez, pues se trata de un pol&iacute;tico joven con mucha aceptaci&oacute;n en todo el municipio.</p>\r\n<p class="ecxMsoNoSpacing">El legislador de Nueva Alianza mencion&oacute; que en los recorridos que &eacute;l realiza por las colonias y localidades del octavo distrito electoral local, ha percibido la aceptaci&oacute;n ciudadana de la que goza Rojas Orozco, por ello &ldquo;no tengo ninguna duda de que con<span class="ecxapple-converted-space">&nbsp;</span><em>Kike</em><span class="ecxapple-converted-space">&nbsp;</span>Rojas como candidato del PRI, en una sociedad electoral con el Partido Nueva Alianza, &eacute;l ser&iacute;a el ganador de la contienda constitucional&rdquo;.</p>\r\n<p class="ecxMsoNoSpacing"><span>&nbsp;</span></p>\r\n<p class="ecxMsoNoSpacing"><span>Alfredo Hern&aacute;ndez dijo que como ciudadano dedicado a la actividad pol&iacute;tica aspiraba leg&iacute;timamente a contender por la alcald&iacute;a de Villa de &Aacute;lvarez; sin embargo, &ldquo;admito que en este momento el priista favorecido con la simpat&iacute;a de los villalvarenses es Enrique Rojas, por lo que estoy en la mejor disposici&oacute;n de hacerme a un lado y apoyar a</span><span class="ecxapple-converted-space"><span>&nbsp;</span></span><em><span>Kike</span></em><span class="ecxapple-converted-space"><span>&rdquo;</span></span><span>.</span></p>\r\n<p class="ecxMsoNoSpacing"><span>&nbsp;</span></p>\r\n<p><span>Agreg&oacute;: &ldquo;Claro que me gustar&iacute;a ser candidato a la Presidencia Municipal de Villa de &Aacute;lvarez y por supuesto que me gustar&iacute;a ser el alcalde de mi municipio, pero no soy una persona de obsesiones, no soy una persona que siembre discordias ni divisiones; al contrario, siempre he procurado ser factor de unidad y as&iacute; pienso seguir siendo&rdquo;.</span></p>', 'vision7', 1329797213, 'Lunes, 20 de Febrero de 2012', '2012', '02', '20', 5, 'www/lib/files/images/blog/small_fdada_villa.png', 'www/lib/files/images/blog/medium_fdada_villa.png', 0, 1, 'Spanish', '', 'Active'),
(22, 2, 1, 'Detiene en Colima a cuatro  personas con ice', 'detiene-en-colima-a-cuatro-personas-con-ice', '<p>De acuerdo al reporte, la detenci&oacute;n se llev&oacute; a cabo cuando agentes de la polic&iacute;a de procuraci&oacute;n de justicia se encontraban realizando un recorrido por el lugar en menci&oacute;n, cuando observaron a los probables responsables quienes al notar la presencia policiaca trataron de retirarse a toda prisa, por ello se procedi&oacute; a marcarles el alto y realizarles una revisi&oacute;n corporal.</p>\r\n<p><!-- pagebreak --></p>\r\n<p>Ignacio Maga&ntilde;a Corona, (a) <em>El Silvano</em>,&nbsp; de 53 a&ntilde;os de edad; Mart&iacute;n Mart&iacute;nez S&aacute;nchez, de 44, Jos&eacute; Juan Hern&aacute;ndez Santiago, de 43 a&ntilde;os, y Susana Burgos Urrea, de 42, quedaron a disposici&oacute;n del ministerio p&uacute;blico por su probable responsabilidad en la comisi&oacute;n de los delitos contra la salud en su modalidad de narcomenudeo, tras haber sido detenidos en posesi&oacute;n de diversos envoltorios con <em>ice</em>, cuando se encontraban en el cruce de las calles Mexicali y Baja California en la colonia San Rafael de esta ciudad capital.</p>\r\n<p>A Mart&iacute;nez S&aacute;nchez &nbsp;y a Hern&aacute;ndez Santiago, se les encontr&oacute; un peque&ntilde;o envoltorio a cada uno con la droga se&ntilde;alada, mientras que a la mujer se le aseguraron trece envoltorios con la misma sustancia, y finalmente a <em>El Silvano</em> se le asegur&oacute; la cantidad de 200 pesos en efectivo, que a decir del detenido son producto de la venta de la droga, la cual realiza en las colonias Oriental y La Virgencita.</p>\r\n<p>Por todo lo anterior estas personas junto con la droga y &nbsp;el dinero en efectivo quedaron a disposici&oacute;n del representante social, a fin de llevar a cabo la investigaci&oacute;n que corresponde y continuar el proceso que la ley establece.</p>\r\n<p>Se hace un llamado a la poblaci&oacute;n en general para que denuncie de manera an&oacute;nima hechos delictivos a la PGJ a los tel&eacute;fonos gratuitos 01 800 581 1770, 01 800 506 8360, as&iacute; como al 01 800 8306415, afin de coadyuvar con las autoridades en las acciones que sigan garantizando el Colima Seguro que la poblaci&oacute;n exige.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', 'vision7', 1329802932, 'Martes, 21 de Febrero de 2012', '2012', '02', '21', 6, 'www/lib/files/images/blog/small_99571_detenidos-con-ice.png', 'www/lib/files/images/blog/medium_99571_detenidos-con-ice.png', 0, 1, 'Spanish', '', 'Active'),
(23, 2, 1, 'Da inicio el Futbolito Bimbo 2012', 'da-inicio-el-futbolito-bimbo-2012', '<p class="Sinespaciado">Este jueves se completa primera jornada y el viernes se juega la segunda en la modalidad de futbol 7, en su etapa local, cuando se jugaron ocho partidos y tres m&aacute;s quedaron&nbsp; pendientes para jugarse este jueves desde temprana hora en la cancha de la Francisco I. Madero, dijo Mario Carrillo Lezama &nbsp;coordinador de la justa escolar en Colima.</p>\r\n<p class="Sinespaciado">Las acciones comenzaron previo a la inauguraci&oacute;n del evento que se realiz&oacute; el s&aacute;bado anterior en la cancha de la colonia Francisco I. Madero de esta ciudad capital, en medio de un gran ambiente de los participantes.</p>\r\n<p class="Sinespaciado">Los primeros resultados en la Plaza Colima, cancha Francisco I. Madero, se tuvo como partido m&aacute;s emocionante el de la primaria Gregorio Macedo L&oacute;pez TM y el Colegio Campoverde, donde sali&oacute; con banderas desplegadas el primer equipo por 6 goles a 4.</p>\r\n<p class="Sinespaciado">Y tambi&eacute;n se impusieron: Fray Pedro de Gante 6-1 sobre la Severiano Guzm&aacute;n Moya, Instituto Cultura de Colima por 10-6 ante la Miguel &Aacute;lvarez Garc&iacute;a TM y De los Trabajadores TM 12-0 sobre la Miguel &Aacute;lvarez Garc&iacute;a.</p>\r\n<p class="Sinespaciado">Mientras que en la plaza Villa de &Aacute;lvarez, hubo partidos m&aacute;s emotivos y as&iacute; los equipos de las escuelas Ni&ntilde;os H&eacute;roes TM y Lorenzo Villa Rivera TM empataron a un gol; la Francisco Palacios Jim&eacute;nez TM super&oacute; 4-2 ala J. Jes&uacute;s Ventura Valdovinos TM; la Ford no. 163 TM 8-2 ala 1&ordm; de Septiembre TM y la Emiliano Zapata 7-0 ala Jos&eacute; Vasconcelos.</p>\r\n<p class="Sinespaciado">El equipo de la Juan Jos&eacute; R&iacute;os TV tiene pendientes sus partidos ante la Ford 163 y la J. Concepci&oacute;n Rivera Mancilla.</p>\r\n<p class="Sinespaciado">Para este jueves 8, se realizar&aacute;n algunos juegos que se pospusieron en la primera jornada, en la plaza Colima, as&iacute; el escuadr&oacute;n de la primaria Melchor Urz&uacute;a Quiroz TM jugar&aacute; a las 9 de la ma&ntilde;ana contra el de la Francisco I. Madero TV; mientras que a las 9:50 el de la Juan Oseguera Vel&aacute;zquez TM ir&aacute; contra Colegio Villanova TM y a las 10:40, el Colegio Ingl&eacute;s se enfrentar&aacute; al equipo de la Adolfo L&oacute;pez Mateos. Todos los partidos en la cancha Francisco I. Madera.</p>\r\n<p class="Sinespaciado">Para el viernes se juega la segunda jornada y los partidos que se jugar&aacute;n en la Francisco I. Madero, son:</p>\r\n<p class="Sinespaciado">&nbsp;</p>\r\n<p class="Sinespaciado">Hora&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Equipo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Equipo</p>\r\n<p class="Sinespaciado">08:30&nbsp; Francisco I. Madero TM vs Miguel &Aacute;lvarez Garc&iacute;a TM</p>\r\n<p class="Sinespaciado">09.20&nbsp; 16 de Septiembre TM vs Colegio Campoverde</p>\r\n<p class="Sinespaciado">10:10&nbsp; Eduardo Zarza Ocampo TM vs Fray Pedro de Gante</p>\r\n<p class="Sinespaciado">11:00&nbsp; Gregorio Macedo L&oacute;pez TM vs Colegio Ingl&eacute;s</p>\r\n<p class="Sinespaciado">11:50&nbsp; Francisco I. Madero TM vs Instituto Cultural de Colima</p>\r\n<p class="Sinespaciado">12:40&nbsp; De los Trabajadores TM vs Miguel Hidalgo TM</p>\r\n<p class="Sinespaciado">16:00&nbsp; Colegio Marcela Domene vs Melchor Urz&uacute;a Quiroz TM</p>\r\n<p class="Sinespaciado">16:50&nbsp; 16 de Septiembre TM vs Juan Oseguera Vel&aacute;zquez TM</p>\r\n<p class="Sinespaciado">&nbsp;</p>\r\n<p class="Sinespaciado">Y en la plaza Villa de &Aacute;lvarez, cancha de la Unidad&nbsp; Deportiva &ldquo;Gil Cabrera Gudi&ntilde;o&rdquo;:</p>\r\n<p class="Sinespaciado">&nbsp;</p>\r\n<p class="Sinespaciado">08:30&nbsp; Ford No. 163 TM vs Ni&ntilde;os H&eacute;roes TM</p>\r\n<p class="Sinespaciado">09:20 Cendi Tierra y Libertad TM vs J. Jes&uacute;s Ventura Valdovinos TM</p>\r\n<p class="Sinespaciado">10:10 J. Silverio Cavazos Ceballos vs 1&ordm; de Septiembre</p>\r\n<p class="Sinespaciado">11:00 Ni&ntilde;os H&eacute;roes TM vs Jos&eacute; Vasconcelos TM</p>\r\n<p class="Sinespaciado">&nbsp;</p>\r\n<p class="Sinespaciado">Quedar&aacute;n pendientes los partidos de la primaria Lorenzo Villa TM contra la Juan Jos&eacute; R&iacute;os TV y la J. Concepci&oacute;n Rivera M. TM.</p>\r\n<p class="Sinespaciado">&nbsp;</p>', 'vision7', 1331098832, 'Miércoles, 07 de Marzo de 2012', '2012', '03', '07', 3, 'www/lib/files/images/blog/small_ad4f6_futbolito-bimbo-2012.jpg', 'www/lib/files/images/blog/medium_ad4f6_futbolito-bimbo-2012.jpg', 0, 1, 'Spanish', '', 'Active'),
(25, 2, 1, 'Acuerdan SSP y Policías de los Municipios colaborar para la tranquilidad de los colimenses ', 'acuerdan-ssp-y-policias-de-los-municipios-colaborar-para-la-tranquilidad-de-los-colimenses', '<p>Con el fin de establecer acuerdos de coordinaci&oacute;n y colaboraci&oacute;n con los municipios, el Secretario de Seguridad P&uacute;blica del Estado, Ra&uacute;l Pinedo D&aacute;vila, se reuni&oacute;n con los directores municipales de Seguridad P&uacute;blica, Tr&aacute;nsito y Vialidad de la entidad; con quienes evalu&oacute; la situaci&oacute;n que impera en cada una de sus demarcaciones; con la finalidad de hacer un frente com&uacute;n en contra de la delincuencia, pero sobretodo, reforzar las estrategias de seguridad que permitan salvaguardar la paz y la tranquilidad de las familias colimenses.</p>\r\n<p><!-- pagebreak --></p>\r\n<p>En reuni&oacute;n celebrada en las instalaciones de la Secretaria de Seguridad P&uacute;blica, los encargados de Seguridad P&uacute;blica en los municipios, &nbsp;establecieron junto con el titular de la SSP nuevas estrategias de colaboraci&oacute;n y cooperaci&oacute;n, con el prop&oacute;sito de brindar mayor seguridad a la poblaci&oacute;n, a trav&eacute;s del reforzamiento de operativos, puestos de revisi&oacute;n, as&iacute; como patrullajes que realizan conjuntamente y de manera individual la polic&iacute;a estatal y polic&iacute;as municipales.</p>\r\n<p>Como parte de las estrategias de seguridad acordadas en dicha reuni&oacute;n, se destaca que se establecer&aacute;n nuevos mecanismos de intercambio de informaci&oacute;n que coadyuven a prevenir e inhibir la comisi&oacute;n de delitos, as&iacute; como al esclarecimiento de hechos delictivos.</p>\r\n<p>Por su parte el titular de la SSP, acord&oacute; redoblar la vigilancia en los municipios a trav&eacute;s de un mayor patrullaje y rondines por parte de la Polic&iacute;a Estatal Preventiva y la Polic&iacute;a Estatal Acreditable (PEA), en las zonas urbanas, como en zonas rurales,&nbsp; as&iacute; como en los ingresos y salidas de cada localidad.</p>\r\n<p>Pinedo D&aacute;vila, agradeci&oacute; a los directores del Seguridad P&uacute;blica, Tr&aacute;nsito y Vialidad de la entidad, su disposici&oacute;n para trabajar coordinadamente con la dependencia que &eacute;l encabeza en beneficio de la ciudadan&iacute;a colimense; invit&oacute; hacer extensiva y a reproducir entre su personal y habitantes de su municipio las medidas necesarias de prevenci&oacute;n del delito, &nbsp;para que en la medida de sus posibilidades puedan evitar ser v&iacute;ctimas de la delincuencia, finalizo diciendo. &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p>', 'vision7', 1331267115, 'Jueves, 08 de Marzo de 2012', '2012', '03', '08', 2, 'www/lib/files/images/blog/small_38a6a_policias.jpg', 'www/lib/files/images/blog/medium_38a6a_policias.jpg', 0, 1, 'Spanish', '', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_categories`
--

CREATE TABLE IF NOT EXISTS `muu_categories` (
  `ID_Category` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Parent` tinyint(4) DEFAULT '0',
  `Title` varchar(90) DEFAULT NULL,
  `Slug` varchar(90) DEFAULT NULL,
  `Language` varchar(10) DEFAULT NULL,
  `Situation` varchar(15) DEFAULT 'Active',
  PRIMARY KEY (`ID_Category`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

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
(23, 0, 'Playas', 'playas', 'Spanish', 'Active'),
(24, 0, 'Policiacas', 'policiacas', 'Spanish', 'Active'),
(25, 0, 'La Grilla', 'la-grilla', 'Spanish', 'Active'),
(26, 0, 'Enfoque Político', 'enfoque-politico', 'Spanish', 'Active'),
(27, 0, 'Tarea Política', 'tarea-politica', 'Spanish', 'Active'),
(28, 0, 'Deportes', 'deportes', 'Spanish', 'Active'),
(29, 0, 'Comala', 'comala', 'Spanish', 'Active'),
(30, 0, 'Colima', 'colima', 'Spanish', 'Active'),
(31, 0, 'Congredo del Estado de Colima', 'congredo-del-estado-de-colima', 'Spanish', 'Active'),
(32, 0, 'Congreso de Colima', 'congreso-de-colima', 'Spanish', 'Active'),
(33, 0, 'Villa de Alvarez', 'villa-de-alvarez', 'Spanish', 'Active'),
(34, 0, ' EDUCACIÓN ', 'educacion', 'Spanish', 'Active'),
(35, 0, 'ELECCIONES 2012', 'elecciones-2012', 'Spanish', 'Active'),
(36, 0, 'Elecciones del 2012', 'elecciones-del-2012', 'Spanish', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_comments`
--

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
(1, 'Visión 7', 'Vision 7', 'Vision 7', 'Vision 7', 'Vision 7', 'http://www.vision7.mx', 'es', 'Spanish', 'vision7', '1', 'Inactive', 'blog', '<p>Ups! sorry return later XD</p>', 'Admin', 'caarloshugo@gmail.com', 'webmaster@milkzoft.com', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_feedback`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_forums_posts`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_gallery`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_logs`
--

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

CREATE TABLE IF NOT EXISTS `muu_mural` (
  `ID_Mural` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Post` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Title` varchar(200) NOT NULL,
  `URL` varchar(250) NOT NULL,
  `Image` varchar(250) NOT NULL,
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_Mural`),
  KEY `ID_Post` (`ID_Post`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `muu_mural`
--

INSERT INTO `muu_mural` (`ID_Mural`, `ID_Post`, `Title`, `URL`, `Image`, `Situation`) VALUES
(1, 2, 'Más de 14 mdp en remesas, generó en 2010 Programa de Trabajadores Agrícolas México-Canadá', 'http://www.vision7.mx/es/blog/2011/11/11/mas-de-14-mdp-en-remesas-genero-en-2010-programa-de-trabajadores-agricolas-mexico-canada', 'www/lib/files/images/mural/835b0_mural.png', 'Active'),
(2, 0, 'Atardecer en Manzanillo, Colima. ', 'http://www.vision7.mx/es/blog/2011/11/29/atardecer-en-manzanillo-colima', 'www/lib/files/images/mural/a0618_dssad.jpg', 'Active'),
(3, 0, 'Manzanillo, Colima, México.', 'http://www.vision7.mx/es/blog/2011/11/29/manzanillo-colima-mexico', 'www/lib/files/images/mural/734a1_untitled-1-copy.png', 'Active'),
(4, 0, 'Manzanillo es un municipio mexicano del estado de Colima, limita al norte con Minatitlán, al este con Coquimatlán y Armería; al sur, está el Océano Pacífico; y al oeste y noroeste limita con el estado', 'http://www.vision7.mx/es/blog/2011/11/29/manzanillo-es-un-municipio-mexicano-del-estado-de-colima-limita-al-norte-con-minatitlan-al-este-con-coquimatlan-y-armeria-al-sur-esta-el-oceano-pacifico-y-al-oeste-y-noroeste-limita-con-el-estado-de-jalisco-se', 'www/lib/files/images/mural/c126b_untitled-1-copy.png', 'Active'),
(5, 0, 'REY COLIMAN ', 'http://www.vision7.mx/es/blog/2012/02/21/rey-coliman', 'www/lib/files/images/mural/cfbfb_rey-de-colima.jpg', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_pages`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_polls`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `muu_polls`
--

INSERT INTO `muu_polls` (`ID_Poll`, `ID_User`, `Title`, `Type`, `Start_Date`, `Text_Date`, `Situation`) VALUES
(2, 2, '¿Quién ganará las elecciones en el 2012?', 'Simple', 1322623508, 'Martes, 29 de Noviembre de 2011', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_polls_answers`
--

CREATE TABLE IF NOT EXISTS `muu_polls_answers` (
  `ID_Answer` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Poll` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Answer` varchar(100) NOT NULL,
  `Votes` mediumint(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID_Answer`),
  KEY `ID_Poll` (`ID_Poll`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `muu_polls_answers`
--

INSERT INTO `muu_polls_answers` (`ID_Answer`, `ID_Poll`, `Answer`, `Votes`) VALUES
(4, 2, 'PRD', 1),
(5, 2, 'PRI', 1),
(6, 2, 'PAN', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_polls_ips`
--

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

CREATE TABLE IF NOT EXISTS `muu_re_categories_applications` (
  `ID_Category2Application` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Application` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ID_Category` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID_Category2Application`),
  KEY `ID_Application` (`ID_Application`),
  KEY `ID_Category` (`ID_Category`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

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
(23, 3, 23),
(24, 3, 24),
(25, 3, 25),
(26, 3, 26),
(27, 3, 27),
(28, 3, 28),
(29, 3, 29),
(30, 3, 30),
(31, 3, 31),
(32, 3, 32),
(33, 3, 33),
(34, 3, 34),
(35, 3, 35),
(36, 3, 36);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_re_categories_records`
--

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
(24, 1),
(3, 2),
(28, 0),
(28, 0),
(23, 0),
(3, 1),
(3, 2),
(3, 4),
(28, 5),
(28, 6),
(4, 7),
(28, 8),
(24, 9),
(24, 0),
(24, 10),
(24, 11),
(3, 12),
(29, 13),
(13, 14),
(30, 16),
(31, 17),
(32, 18),
(24, 19),
(33, 20),
(33, 21),
(24, 22),
(28, 23),
(24, 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_re_comments_applications`
--

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

CREATE TABLE IF NOT EXISTS `muu_re_comments_records` (
  `ID_Comment2Application` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ID_Record` mediumint(8) unsigned NOT NULL DEFAULT '0',
  KEY `ID_Comment2Application` (`ID_Comment2Application`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_re_hotels_amenities`
--

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
(1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_re_tags_applications`
--

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

CREATE TABLE IF NOT EXISTS `muu_re_tags_records` (
  `ID_Tag2Application` mediumint(8) unsigned NOT NULL,
  `ID_Record` mediumint(8) unsigned NOT NULL,
  KEY `ID_Tag2Application` (`ID_Tag2Application`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_support`
--

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

CREATE TABLE IF NOT EXISTS `muu_url` (
  `ID_URL` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `URL` varchar(255) NOT NULL,
  `Situation` varchar(15) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ID_URL`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=68 ;

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
(23, 'http://localhost/tudestino/index.php/es/blog/2011/10/15/steve-jobs', 'Active'),
(24, 'http://www.vision7.mx/es/blog/2011/11/11/el-leches-fue-turnado-al-cereso-por-robo-calificado', 'Active'),
(25, 'http://www.vision7.mx/es/blog/2011/11/11/mas-de-14-mdp-en-remesas-genero-en-2010-programa-de-trabajadores-agricolas-mexico-canada', 'Active'),
(26, 'http://www.vision7.mx/es/blog/2011/11/14/en-manzanilo-se-realizo-la-primera-marcha-de-carros-antiguos', 'Active'),
(27, 'http://www.vision7.mx/es/blog/2011/11/14/en-manzanilo-se-realizo-la-primera-marcha-de-carros-antiguos', 'Active'),
(28, 'http://www.vision7.mx/es/blog/2011/11/18/los-loros-de-la-universidad-de-colima-vs-union-de-curtidores', 'Active'),
(29, 'http://www.vision7.mx/es/blog/2011/11/18/los-loros-de-la-universidad-de-colima-vs-union-de-curtidores', 'Active'),
(30, 'http://www.vision7.mx/es/blog/2011/11/18/los-loros-de-la-universidad-de-colima-vs-union-de-curtidores', 'Active'),
(31, 'http://www.vision7.mx/es/blog/2011/11/28/playas-de-manzanillo', 'Active'),
(32, 'http://www.vision7.mx/es/blog/2011/11/29/financiamientos-para-agro-productores-afectados-por-jova', 'Active'),
(33, 'http://www.vision7.mx/es/blog/2011/11/29/financiamientos-para-agro-productores-afectados-por-el-huracan-jova', 'Active'),
(34, 'http://www.vision7.mx/es/blog/2011/11/29/financiamientos-para-afectados-por-el-huracan-jova', 'Active'),
(35, 'http://www.vision7.mx/es/blog/2011/11/29/financiamientos-para-afectados-por-el-huracan-jova', 'Active'),
(36, 'http://www.vision7.mx/es/blog/2011/11/29/atardecer-en-manzanillo-colima', 'Active'),
(37, 'http://www.vision7.mx/es/blog/2011/11/29/manzanillo-colima-mexico', 'Active'),
(38, 'http://www.vision7.mx/es/blog/2011/11/29/realizan-la-segunda-paralimpiada-estatal', 'Active'),
(39, 'http://www.vision7.mx/es/blog/2011/11/29/realizan-la-segunda-paralimpiada-estatal', 'Active'),
(40, 'http://www.vision7.mx/es/blog/2011/11/29/manzanillo-esta-listo-para-recibir-a-los-turistas-nabor-ochoa-lopez', 'Active'),
(41, 'http://www.vision7.mx/es/blog/2011/11/29/manzanillo-es-un-municipio-mexicano-del-estado-de-colima-limita-al-norte-con-minatitlan-al-este-con-coquimatlan-y-armeria-al-sur-esta-el-oceano-pacifico-y-al-oeste-y-noroeste-limita-con-el-estado-de-jalisco-se-loca', 'Active'),
(42, 'http://www.vision7.mx/es/blog/2012/01/22/pierde-loros-en-su-visita-a-chivas-rayadas', 'Active'),
(43, 'http://www.vision7.mx/es/blog/2012/01/25/un-muerto-dos-detenidos-y-un-agente-lesionado-en-enfrentamiento', 'Active'),
(44, 'http://www.vision7.mx/es/blog/2012/02/20/7-anos-de-carcel-por-robarse-un-taxi-en-villa-de-alvarez', 'Active'),
(45, 'http://www.vision7.mx/es/blog/2012/02/20/7-anos-de-carcel-por-robarse-un-taxi-en-villa-de-alvarez', 'Active'),
(46, 'http://www.vision7.mx/es/blog/2012/02/20/5-anos-de-carcel-para-dos-ladrones-de-ganado-en-tecoman', 'Active'),
(47, 'http://www.vision7.mx/es/blog/2012/02/20/7-anos-por-robarle-su-automovil-a-un-taxista', 'Active'),
(48, 'http://www.vision7.mx/es/blog/2012/02/20/pri-presenta-lista-de-aspirantes-locales', 'Active'),
(49, 'http://www.vision7.mx/es/blog/2012/02/20/rehabilitaran-el-balneario-ojo-de-agua-en-zacualpan-y-crearan-un-hostal', 'Active'),
(50, 'http://www.vision7.mx/es/blog/2012/02/20/presentan-las-candidatas-a-reina-de-la-facultad-de-contabilidad-y-administracion', 'Active'),
(51, 'http://www.vision7.mx/es/blog/2012/02/20/presidenta-de-colima-fomenta-el-habito-de-la-lectura', 'Active'),
(52, 'http://www.vision7.mx/es/blog/2012/02/20/la-presidenta-de-colima-fomenta-el-habito-de-la-lectura', 'Active'),
(53, 'http://www.vision7.mx/es/blog/2012/02/20/el-congreso-del-estado-exhorto-a-la-comision-nacional-bancaria-y-de-valores-para-disminuir-los-fraudes-electronicos', 'Active'),
(54, 'http://www.vision7.mx/es/blog/2012/02/20/el-congreso-del-colima-pide-disminuir-los-fraudes-electronicos', 'Active'),
(55, 'http://www.vision7.mx/es/blog/2012/02/20/captura-la-policia-estatal-a-persona-armada', 'Active'),
(56, 'http://www.vision7.mx/es/blog/2012/02/20/declina-alfredo-hernandez-a-favor-de-enrique-rojas-por-la-presidencia-de-villa-de-alvarez', 'Active'),
(57, 'http://www.vision7.mx/es/blog/2012/02/20/declina-alfredo-hernandez-a-favor-de-enrique-rojas-por-la-presidencia-de-villa-de-alvarez', 'Active'),
(58, 'http://www.vision7.mx/es/blog/2012/02/21/detiene-en-colima-a-cuatro-personas-con-ice', 'Active'),
(59, 'http://www.vision7.mx/es/blog/2012/02/21/rey-coliman', 'Active'),
(60, 'http://www.vision7.mx/es/blog/2012/03/07/da-inicio-el-futbolito-bimbo-2012', 'Active'),
(61, 'http://www.vision7.mx/es/blog/2012/03/08/iee-en-la-intercampana-los-precandidatos-no-deberan-promoverse', 'Active'),
(62, 'http://www.vision7.mx/es/blog/2012/03/08/iee-en-la-intercampana-los-precandidatos-no-deberan-promoverse', 'Active'),
(63, 'http://www.vision7.mx/es/blog/2012/03/08/iee-en-la-intercampana-los-precandidatos-no-deberan-promoverse', 'Active'),
(64, 'http://www.vision7.mx/es/blog/2012/03/08/acuerdan-ssp-y-policias-de-los-municipios-colaborar-para-la-tranquilidad-de-los-colimenses', 'Active'),
(65, 'http://www.vision7.mx/es/blog/2012/03/08/dan-libros-sobre-equidad-de-genero-y-prevencion-de-violencia-en-la-primaria', 'Active'),
(66, 'http://www.vision7.mx/es/blog/2012/03/08/entregan-libro-sobre-equidad-de-genero-y-prevencion-de-violencia-en-la-primaria', 'Active'),
(67, 'http://www.vision7.mx/es/blog/2012/03/14/participaran-375-alumnos-en-universiada-regional-2012', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_users`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `muu_users`
--

INSERT INTO `muu_users` (`ID_User`, `Username`, `Pwd`, `Email`, `Website`, `Avatar`, `Rank`, `Sign`, `Messages`, `Recieve_Messages`, `Topics`, `Replies`, `Visits`, `Comments`, `Subscribed`, `Start_Date`, `Code`, `God`, `Privilege`, `Type`, `Situation`) VALUES
(1, 'Carlos Santana', '99b94460aa941d668e60262be137c7187045ed45', 'azapedia@gmail.com', NULL, NULL, 'Member', NULL, 0, 1, 0, 0, 0, 0, 0, 0, '', 1, 'Super Admin', 'Normal', 'Active'),
(2, 'vision7', '86e836875588c8c993c9ae9f1aa29ea3379ec2ff', 'pedro_8777@hotmail.com', NULL, NULL, 'Member', NULL, 0, 1, 0, 0, 0, 0, 0, 1317430063, '', 1, 'Super Admin', 'Normal', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_users_information`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `muu_users_information`
--

INSERT INTO `muu_users_information` (`ID_User_Information`, `ID_User`, `Name`, `Phone`, `Company`, `Gender`, `Birthday`, `Country`, `District`, `Town`, `Facebook`, `Twitter`, `Linkedin`, `Google`) VALUES
(1, 1, 'Carlos', '', '', '', '', '', '', '', '', '', '', ''),
(2, 2, 'Pedro', '', '', '', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_users_online`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muu_works`
--

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
