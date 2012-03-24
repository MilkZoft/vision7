<?php 
/**
 * Access from index.php:
 */
if(!defined("_access")) {
	die("Error: You don't have permission to access here...");
}

ob_start(); 
session_start(); 

define("_dir", dirname(__FILE__));

if(file_exists(_dir . "/config/config.basics.php") and file_exists(_dir . "/config/config.core.php")) { 
	include "config/config.basics.php";
	include "config/config.core.php";
} else { 
	die("Error: config.basics.php or config.core.php doesn't exists");
}

include _corePath . "/classes/class.load.php";
include _corePath . "/classes/class.controller.php";
include _corePath . "/classes/class.model.php";

$Load = new ZP_Load(); 

$helpers = array("debugging", "i18n", "router", "benchmark", "string", "sessions", "security");

$Load->helper($helpers);

$Configuration_Model = $Load->model("Configuration_Model");

$config = $Configuration_Model->getConfig();

if(is_array($config)) {
	define("_webLanguage", 	   $config[0]["Language"]);
	define("_webLang", 		   $config[0]["Lang"]);
	define("_webName", 		   $config[0]["Name"]);
	define("_webSlogan", 	   $config[0]["Slogan_". _webLanguage]);
	define("_webURL", 		   $config[0]["URL"]);
	define("_webTheme", 	   $config[0]["Theme"]);
	define("_webGallery", 	   $config[0]["Gallery"]);
	define("_webValidation",   $config[0]["Validation"]);
	define("_webApplication",  $config[0]["Application"]);
	define("_webMessage",      $config[0]["Message"]);
	define("_webActivation",   $config[0]["Activation"]);
	define("_webEmailRecieve", $config[0]["Email_Recieve"]);
	define("_webEmailSend",    $config[0]["Email_Send"]);
	define("_webSituation",    $config[0]["Situation"]);

	if(!_modRewrite) {
		define("_webBase", _webURL . _sh . _index);
	} else {
		define("_webBase", _webURL);
	}
} else {
	define("_webURL", 		 _wURL);
	define("_webName", 		 _wName);
	define("_webTheme", 	 _wTheme);
	define("_webSituation",  _wSituation);
	define("_webLanguage",   _wLanguage);
	define("_webLang", 		 _wLang);
	define("_webApplicaion", _defaultApplication);
	define("_webEmailSend",  _wEmailSend);
	
	if(!_modRewrite) {
		define("_webBase", _wURL . _sh . _index);
	} else {
		define("_webBase", _wURL);
	}
}

define("_webPath", _webBase . _sh . _webLang . _sh);

if(_translation === "gettext") {
	$Load->library("class.gettext", "gettext");
	$Load->library("class.streams", "gettext");
	$Load->config("languages");
	
	$languageFile = _dir . _sh . _lib . _sh . _languages . _sh . _gettext . _sh . _sh . _language . _dot . strtolower(whichLanguage()) . _dot . _mo;

	if(file_exists($languageFile)) {
		$Gettext_Reader = new Gettext_Reader($languageFile);
		
		$Gettext_Reader->load_tables();
	}
}

benchMarkStart();

header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); 
header("Content-type: text/html; charset=utf-8");

error_reporting(E_ALL);

if(!version_compare(PHP_VERSION, "5.1.0", ">=")) {
	die("ZanPHP needs PHP 5.1.X or higher to run.");
}

execute();

#print benchMarkEnd();
