<?php
include_once("../includes/init.php");

$action = isset($_GET['action']) ? $_GET['action'] : "";

$json = array("msg"=>null,"result"=>false,"data"=>null);

if($action == 'tableware') {
	//要餐具
	if($_POST) {
		$prettys = isset($_POST['prettys']) ? $_POST['prettys'] : 0;
		$seatnum = isset($_POST['seatnum']) ? $_POST['seatnum'] : 0;
		$userid = isset($_POST['userid']) ? $_POST['userid'] : 0;

		$res = $db -> select() -> from("socket") -> where("userid = $userid AND seat = $seatnum") -> find();

		if($res) {
			$json['msg'] = "请不要重复要餐具，请等待服务员";
			return json($json);
		}

		$data = array(
			'seat' => $seatnum,
			'content' => $prettys,
			'userid' => $userid,
			'createtime' => time(),
			'status' => 0  
		);

		$res = $db -> save("socket", $data);
		if(!$res) {
			$json['msg'] = "餐具请求失败，请稍后再试";
			return json($json);
		} 

		$json['msg'] = "要餐具成功，请等待服务员";
		$json['result'] = true;
		return json($json);
	}
}else if($action == 'invoice') {
	//要餐具
	if($_POST) {
		$seatnum = isset($_POST['seatnum']) ? $_POST['seatnum'] : 0;
		$userid = isset($_POST['userid']) ? $_POST['userid'] : 0;

		$res = $db -> select() -> from("socket") -> where("userid = $userid AND seat = $seatnum") -> find();

		if($res) {
			$json['msg'] = "请不要重复开发票，请等待服务员";
			return json($json);
		}

		$data = array(
			'seat' => $seatnum,
			'userid' => $userid,
			'createtime' => time(),
			'status' => 0  
		);

		$res = $db -> save("socket", $data);
		if(!$res) {
			$json['msg'] = "发票请求失败，请稍后再试";
			return json($json);
		} 

		$json['msg'] = "开发票成功，请等待服务员";
		$json['result'] = true;
		return json($json);
	}
}else if($action == 'show') {
	$res = $db -> select() -> from("socket") -> where("status = 0") -> all();

	if(!$res) {
		$json['msg'] = "请求数据为空";
		return json($json);
	}

	//处理type
	foreach ($res as $key => $value) {
		switch($value['type']) {
			case "0":
				$res[$key]['type'] = "餐具";
				break;
			case "1":
				$res[$key]['type'] = "发票";
				break;
		}
		
		$db -> save("socket", array('status' => 1), "id = " . $value['id']);
	}

	$json['msg'] = "请求数据成功";
	$json['result'] = true;
	$json['data'] = $res;
	return json($json);
}