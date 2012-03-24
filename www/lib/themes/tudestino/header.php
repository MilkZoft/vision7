<?php if(!defined("_access")) { die("Error: You don't have permission to access here..."); } ?>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	
    <title><?php print $this->getTitle(); ?></title>
	
    <link rel="stylesheet" href="<?php print $this->themePath; ?>/css/style.css" type="text/css">
	
	<?php print $this->getCSS(); ?>
    
	<?php //print $this->js("jquery"); ?>
</head>

<body>
	<div id="container">
		<div id="header">
                <div id="logo">
                    <h1>TuDestino.MX</h1>
                </div>
                
                <div id="phones">
                	<p>
                        <strong>MEX</strong> 0180 8367570 <br />
                        <strong>USA</strong> 1877 4371714 <br />
                        <strong>CAD</strong> 1877 3340528 <br />
                        <strong>Resto del mundo</strong> 314 33 55951
                    </p>
                </div>
                
                <div class="clear"></div>
                
                <div id="top-menu">
                    <ul>
                        <li><a href="<?php print _webBase; ?>" title="Inicio">Inicio</a></li>
                        <li><a href="<?php print _webBase; ?>/es/pages/promociones" title="Promociones">Promociones</a></li>
                        <li><a href="<?php print _webBase; ?>/es/hotels" title="Hoteles">Hoteles</a></li>
                        <li><a href="<?php print _webBase; ?>/es/pages/guia-turistica" title="Gu&iacute;a Tur&iacute;stica">Gu&iacute;a Tur&iacute;stica</a></li>
                        <li><a href="<?php print _webBase; ?>/es/pages/acerca-de-nosotros" title="Acerca de nosotros">Acerca de nosotros</a></li>
                        <li><a href="<?php print _webBase; ?>/es/pages/preguntas-frecuentes" title="Acerca de nosotros">Preguntas frecuentes</a></li>
                        <li><a href="<?php print _webBase;?>/es/feedback" title="Cont&aacute;ctanos">Cont&aacute;ctanos</a></li>
                    </ul>
                </div>
		</div>

            <div id="mural">
            	<img src="<?php print $this->themePath; ?>/images/mural/photo01.png" alt="Mural" />
            </div>
            
            <div id="degrado"></div>
