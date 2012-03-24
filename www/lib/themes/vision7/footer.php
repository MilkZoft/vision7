<?php
	if(segments() === 0) {
	?>
		<div id="extra">
			<p class="center">Columas Pol&iacute;ticas</p>
			
			<div id="blog-column">
				<?php print $this->execute("Blog_Controller", "getLastPostByCategory", array("la-grilla")); ?>
			</div>

			<div id="polls">
				<?php print $this->execute("Polls_Controller", "last"); ?>
			</div>

			<div id="blog-archive">
				<?php print $this->execute("Blog_Controller", "archive"); ?>
			</div>

			<div class="clear"></div>
		</div>
	<?php
	}
?>
		
	<div id="footer">
		<span class="map">Accede a las noticias por municipio:</span>
		<div id="colima"></div>
		
		<div id="country">
			<ul>
				<li><a id="mnz"    class="on-out" href="<?php print _webBase . _sh .  _webLang . _sh . _blog . _sh . _category . _sh . "manzanillo";?>">Manzanillo</a></li>
				<li><a id="coli"   class="on-out" href="<?php print _webBase . _sh .  _webLang . _sh . _blog . _sh . _category . _sh . "colima";?>">Colima</a></li>
				<li><a id="tec"    class="on-out" href="<?php print _webBase . _sh .  _webLang . _sh . _blog . _sh . _category . _sh . "tecoman";?>">Tecom&aacute;n</a></li>
				<li><a id="villa"  class="on-out" href="<?php print _webBase . _sh .  _webLang . _sh . _blog . _sh . _category . _sh . "villa-de-alvarez";?>">Villa de &Aacute;lvarez</a></li>
				<li><a id="arm"    class="on-out" href="<?php print _webBase . _sh .  _webLang . _sh . _blog . _sh . _category . _sh . "armeria";?>">Armer&iacute;a</a></li>
				<li><a id="comala" class="on-out" href="<?php print _webBase . _sh .  _webLang . _sh . _blog . _sh . _category . _sh . "comala";?>">Comala</a></li>
				<li><a id="coqui"  class="on-out" href="<?php print _webBase . _sh .  _webLang . _sh . _blog . _sh . _category . _sh . "coquimatlan";?>">Coquimatlan</a></li>
				<li><a id="cua"    class="on-out" href="<?php print _webBase . _sh .  _webLang . _sh . _blog . _sh . _category . _sh . "cuahtecom";?>">Cuaht&eacute;moc</a></li>
				<li><a id="mina"   class="on-out" href="<?php print _webBase . _sh .  _webLang . _sh . _blog . _sh . _category . _sh . "minatitlan";?>">Minatitl&aacute;n</a></li>
				<li><a id="ixt"    class="on-out" href="<?php print _webBase . _sh .  _webLang . _sh . _blog . _sh . _category . _sh . "ixtlahuacan";?>">Ixtlahuac&aacute;n</a></li>
			</ul>
		</div>
		
		<div class="clear"></div>
		
		<div id="copy">
			<p>
				&copy; Todos lo derechos reservados <a href="http://www.visio7.mx" title="Noticias">Vision7.mx</a> | <a href="<?php print _webBase . _sh .  _webLang . _sh . _pages . _sh . "politica-de-privacidad";?>" title="Politica de privacidad">Politica de privacidad</a> | Desarrollado por <a href="http://www.milkzoft.com" title="Desarrollo de Software">MilkZoft</a>
			</p>
		</div>
		
		<input type="hidden" id="webUrl" name="webUrl" value="<?php print _webBase; ?>" />
	</div>
</div>


<script type="text/javascript" src="<?php print $this->themePath . "/js/raphael.js"; ?>"></script>
<script type="text/javascript" src="<?php print $this->themePath . "/js/load.js"; ?>"></script>		
<script type="text/javascript" src="<?php print $this->themePath . "/js/map.js"; ?>"></script>		
<script type="text/javascript" src="<?php print $this->themePath . "/js/divs.js"; ?>"></script>	

<?php 
	$this->js("www/lib/scripts/js/slides.js");
	$this->js("www/lib/scripts/js/ad.js"); 	
	$this->js("www/lib/scripts/js/add.js"); 
	$this->js("js/pretty-photo", "videos"); 
	
	print $this->getJs(); 
?>

</body>
</html>