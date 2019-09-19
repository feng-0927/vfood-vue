<?php
ini_set('max_execution_time','100');
ini_set('date.timezone','Asia/Shanghai');
header("Content-type: text/html; charset=UTF-8");
session_start();

$app_path  = dirname(__DIR__);
$admin_path = "../assets/admin";
$home_path = "./assets/home";
$home_assets_path = "./assets";
$admin_assets_path = "../assets";
$uploads_path = dirname($app_path) . "/food/static/upload";
$plugins_path = $app_path . '/assets/plugins';


define('APP_PATH', $app_path);
define('ADMIN_PATH', $admin_path);
define('HOME_PATH', $home_path);
define('HOME_ASSETS_PATH', $home_assets_path);
define('ADMIN_ASSETS_PATH', $admin_assets_path);
define('UPLOAD_PATH', $uploads_path);
define('PLUGINS_PATH', $plugins_path);

function __autoload($classname) {
	include_once "extends/{$classname}.class.php";
}

$config = array(
	'password' => 'root',
	'dbname' => 'food'
);

$db = new DB($config);
$strings = new Strings();


$allow_type = array("jpeg", "jpg", "png", "gif");
//存放上传图片路径
$uploadsDir = APP_PATH ."/assets/uploads/";
$uploadFile = new UploadFile(true, $uploadsDir, $allow_type);

$uploadsDir = UPLOAD_PATH ."/";
$homeUploadFile = new UploadFile(true, $uploadsDir, $allow_type);


include_once "helpers.php";