<?php if(!defined("_access")) die("Error: You don't have permission to access here..."); ?>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title><?php print $this->getTitle(); ?></title>
	<link rel="stylesheet" href="<?php print $this->themePath; ?>/css/style.css" type="text/css">
	<?php $this->CSS("polls", "polls"); ?>
	<?php print $this->getCSS(); ?>
	
	<?php print $this->js("www/lib/scripts/js/jquery.js", NULL, NULL, TRUE); ?>
</head>

<body>
	<div id="container">
		<div id="top-ads" class="div-ads">
			<?php print $this->execute("Ads_Controller", "ads", array("Top")); ?>
		</div>

		<div id="header">					
			<div id="logo">
				<img src="<?php print $this->themePath . "/images/Logo2.png"; ?>" /><br />
				<div id="time">
					<?php print encode(now(2)); ?> | <span class="hour"><?php print now(NULL, TRUE); ?></span>
				</div>
			</div>
			
			<div id="center-ads" class="div-ads">
				<?php print $this->execute("Ads_Controller", "ads", array("Center")); ?>
			</div>
			
			<div class="clear"></div>
			
			<div id="bar">
                <ul id="menu">
                    <li><a class="selected" href="http://www.vision7.mx">Inicio</a></li>
                    <li><a href="http://www.vision7.mx/es/blog/">Noticias</a>
                        <ul>
                            <li><a href="http://www.vision7.mx/es/blog/category/noticias-internacionales">Internacionales</a></li>
                            <li><a href="http://www.vision7.mx/es/blog/category/noticias-nacionales">Nacionales</a></li>
                            <li><a href="http://www.vision7.mx/es/blog/category/noticias-estatales">Estatales</a></li>
                            <li><a href="http://www.vision7.mx/es/blog/category/noticias-locales">Locales</a></li>
                        </ul>
                    </li>
                    <li><a href="http://www.vision7.mx/es/gallery">Sociales</a>
                        <ul>
                            <li><a href="http://www.vision7.mx/es/gallery/album/seccion-visual-ellas">Sección Visual - Ellas</a></li>
                            <li><a href="http://www.vision7.mx/es/gallery/album/seccion-visual-ellos">Sección Visual - Ellos</a></li>
                            <li><a href="http://www.vision7.mx/es/gallery/album/antros">Antros</a></li>
                            <li><a href="http://www.vision7.mx/es/gallery/album/cumpleanos">Cumpleaños</a></li>
                            <li><a href="http://www.vision7.mx/es/gallery/album/bautizos">Bautizos</a></li>
                            <li><a href="http://www.vision7.mx/es/gallery/album/xv-anos">XV A&ntilde;os</a></li>
                            <li><a href="http://www.vision7.mx/es/gallery/album/bodas">Bodas</a></li>
                            <li><a href="http://www.vision7.mx/es/gallery/album/infantil">Infantil</a></li>
                            <li><a href="http://www.vision7.mx/es/gallery/album/cupido">Cupido</a></li>
                            <li><a href="http://www.vision7.mx/es/gallery/album/playas">Playas</a></li>
                        </ul>
                    </li>
                    <li><a href="http://www.vision7.mx/es/blog/category/deportes">Deportes</a>
                        <ul>
                            <li><a href="http://www.vision7.mx/es/blog/category/deportes-extremos">Deportes Extremos</a></li>
                            <li><a href="http://www.vision7.mx/es/blog/category/baloncesto">Baloncesto</a></li>
                            <li><a href="http://www.vision7.mx/es/blog/category/box">Box</a></li>
                            <li><a href="http://www.vision7.mx/es/blog/category/lucha-libre">Lucha Libre</a></li>
                            <li><a href="http://www.vision7.mx/es/blog/category/futbol">F&uacute;tbol</a></li>
                            <li><a href="http://www.vision7.mx/es/blog/category/muay-thai">Muay Thai</a></li>
                            <li><a href="http://www.vision7.mx/es/blog/category/surfing">Surfing</a></li>
                            <li><a href="http://www.vision7.mx/es/blog/category/voleyball">Voleyball</a></li>
                            <li><a href="http://www.vision7.mx/es/blog/category/otros">Otros</a></li>
                        </ul>
                    </li>      
                    <li><a href="http://www.vision7.mx/es/blog/category/espectaculos">Espectaculos</a></li>
                    <li><a href="#">Facebook</a></li>
                    <li><a href="#">Twitter</a></li>
                </ul>
			</div>
        </div>
		
        <div id="mural">
            <?php print $this->execute("Blog_Controller", "mural"); ?>
        </div>
