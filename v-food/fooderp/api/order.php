<?php
include_once("../includes/init.php");

$action = isset($_GET['action']) ? $_GET['action'] : "";

$json = array("msg"=>null,"result"=>false,"data"=>null);

if($action == "ordercart")
{
  if($_POST)
  {
    $userid = isset($_POST['userid']) ? trim($_POST['userid']) : 0;

    $cart = $db->select("cart.*,food.name,food.price")->from("cart")->join("food","cart.foodid = food.id")->where("cart.userid = $userid")->all();

    $cartBack = [
      "count"=>0,  //数量
      "price"=>0,  //价格
    ];

    //有数据
    foreach($cart as $item)
    {
      $cartBack['count'] += $item['foodnum'];
      $cartBack['price'] += ($item['price']*$item['foodnum']);
    }

    $result = [
      "cart"=>$cart,
      "cartBack"=>$cartBack
    ];

    $json['result'] = true;
    $json['data'] = $result;
    $json['msg'] = '返回购物车数据成功';

    return json($json);
  }
}else if($action == "orderadd")
{
  if($_POST)
  {
    //判断余额是否充足 更新用户表 订单表 订单产品 清空购物车
    $order = isset($_POST['order']) ? $_POST['order'] : false;
    $cart = isset($_POST['cart']) ? $_POST['cart'] : false;
    $userid = isset($_POST['userid']) ? $_POST['userid'] : 0;
    $coupon = isset($_POST['coupon']) ? $_POST['coupon'] : 0;

    //判断用户是否存在
    $user = $db->select()->from("user")->where(["id"=>$userid])->find();

    //查询优惠券是否过期
    if($coupon) {
      $couponRes = $db -> select("coupon_record.createtime,coupon.price") -> from("coupon_record") -> join("coupon", "coupon.id = coupon_record.cid") -> where("coupon_record.id = $coupon") -> find();
      if($couponRes['createtime'] < time()) {
        //已过期
        $db -> save("coupon_record", array('status' => 3), "id = $coupon");
        $coupon = 0;  //已过期没必要继续使用优惠券了
        $order['price'] = $order['price'] + $couponRes['price']; //加上原来的价格
      }
    }

    if(!$user) {
      $json['msg'] = '该用户不存在';
      return json($json);
    }

    if(!$order) {
      $json['msg'] = '无订单数据';
      return json($json);
    }

    if(!$cart) {
      $json['msg'] = '无食品数据';
      return json($json);
    }

    //判断余额是否充足
    $money = $user['money'];
    $price = $order['price'];
    $updateMoney = $money - $price;
    if($updateMoney < 0) {
      $json['msg'] = '余额不足，请先充值';
      return json($json);
    }

    //更新用户表
    $userData = array(
      "money"=> $updateMoney
    );

    //开启事务
    $db -> query("start transaction");

    $userRes = $db->save("user", $userData, "id = $userid");

    if(!$userRes) {
      $json['msg'] = '更新用户余额失败';
      return json($json);
    }

    //查询优惠券是否过期  => 是否有该优惠券 => 使用优惠券
    if($coupon) {
      $couponRes = $db -> save("coupon_record", array('status' => 2), "id = $coupon");
      if(!$couponRes) {
        $db -> query("ROLLBACK");
        $json['msg'] = "优惠券使用失败";
        return json($json);
      }
    }

    //订单表
    $orderData = array(
      "ordersn"=> $strings -> randomStr(20,false),
      "createtime"=> time(),
      "ordertype"=> $order['ordertype'],
      "price"=> $order['price'],
      "status"=> 1,
      "content"=> $order["content"],
      "userid"=> $userid
    );

    //预约
    if($order['ordertype'] == 1) {
      $orderData['ordertime'] = empty($order['ordertime']) ? 0 : strtotime($order['ordertime']);
    }else{
      $orderData['ordertime'] = time();
    }

    $orderRes = $db -> save("order", $orderData);

    if(!$orderRes) {
      $db -> query("ROLLBACK");
      $json['msg'] = '添加订单失败';
      return json($json);
    }

    $orderFood = [];
    foreach($cart as $item) { 
      $food = array(
        "orderid"=> $orderRes,
        "foodid"=> $item['foodid'],
        "foodnum"=> $item['foodnum']
      );
      $orderFood[] = $food;
    }

    $foodRes = $db-> addAll("order_food", $orderFood);

    if(!$foodRes) {
      $db->query("ROLLBACK");
      $json['msg'] = '添加订单产品失败';
      return json($json);
    }

    //清空购物车
    $cartRes = $db-> delete("cart",['userid'=> $userid]);

    if(!$cartRes) {
      $db->query("ROLLBACK");
      $json['msg'] = '清空购物车失败';
      return json($json);
    }

    //提交事务
    if($userRes && $orderRes && $foodRes && $cartRes) {
      $db->query("COMMIT"); //提交事务
      $json['msg'] = '下单成功';
      $json['result'] = true;
      return json($json);
    }
  }
}else if($action == 'orderlist') {
  //0 未支付 1 已支付 2 已取消 3 就餐 4 评价 5 已完成
  $status = isset($_GET['status']) ? $_GET['status'] : 0; 
  $userid = isset($_GET['userid']) ? $_GET['userid'] : 0;

  //订单数据
  $sql = "SELECT * FROM pre_order WHERE userid = $userid";

  $order = $db -> query($sql, true);


  //订单商品数据： 订单表 + 订单食物表 + 食物表
  $sql = "SELECT o.id,orderfood.foodid,orderfood.foodnum,food.name FROM pre_order AS o LEFT JOIN pre_order_food AS orderfood ON o.id = orderfood.orderid LEFT JOIN pre_food AS food ON food.id = orderfood.foodid WHERE o.status = $status AND o.userid = $userid";
  $order_food = $db -> query($sql, true);


  if(!$order_food || !$order) {
    $json['msg'] = "获取订单数据失败";
    $json['result'] = false;
    return json($json);
  }

  $json['msg'] = "获取订单数据成功";
  $json['data'] = array('orderfood' => $order_food, 'order' => $order);
  $json['result'] = true;
  return json($json);
}else if($action == 'changestatus') {
  //0 未支付 1 已支付 2 已取消 3 就餐 4 评价 5 已完成
  $status = isset($_POST['status']) ? $_POST['status'] : 0; 
  $orderid = isset($_POST['orderid']) ? $_POST['orderid'] : 0;
  $content = isset($_POST['content']) ? $_POST['content'] : '';

  $data = array(
    'status' => $status,
    'content' => $content
  );

  $res = $db -> save("order", $data, "id = $orderid");

  if(!$res) {
    $json['msg'] = "修改订单数据失败";
    $json['result'] = false;
    return json($json);
  }

  $json['msg'] = "修改订单数据成功";
  $json['result'] = true;
  return json($json);
}else if($action == 'ordersave') {
  $status = isset($_POST['status']) ? $_POST['status'] : 0; 
  $orderid = isset($_POST['orderid']) ? $_POST['orderid'] : 0;
  $userid = isset($_POST['userid']) ? $_POST['userid'] : 0;

  //判断用户是否存在
  $user = $db->select()->from("user")->where("id = $userid")->find();

  //判断订单是否存在
  $order = $db -> select("price") -> from("order") -> where("id = $orderid") -> find();

  if(!$user) {
    $json['msg'] = '该用户不存在';
    return json($json);
  }

  if(!$order) {
    $json['msg'] = "该订单不存在";
    return json($json);
  }

  if(!$status) {
    $json['msg'] = "该状态不存在";
    return json($json);
  }

  //查询用户余额 => 支付金额 => 支付成功 => 修改状态
  $money = $user['money'];
  $price = $order['price'];
  $money = $money - $price;
  if($money < 0) {
    //支付失败
    $json['msg'] = "支付失败,余额不足";
    return json($json);
  }

  //开启事务
  $db -> query("start transaction");

  //更新金额
  if(!$db -> save("user", array('money' => $money), "id = $userid")) {
    $json['msg'] = "更新金额失败,请稍后再试";
    return json($json);
  }

  //修改状态
  if(!$db -> save("order", array('status' => $status), "id = $orderid")) {
    $json['msg'] = "更新状态失败,请稍后再试";
    $db -> query("ROLLBACK");

    return json($json);
  }

  //提交事务
  $db -> query("COMMIT");
  $json['msg'] = "更新订单成功,请注意查看";
  $json['result'] = true;
  return json($json);
}else if($action == 'orderout') {
  //退款
  $orderid = isset($_POST['orderid']) ? $_POST['orderid'] : 0;
  $userid = isset($_POST['userid']) ? $_POST['userid'] : 0;

  $res = $db -> select() -> from("order") -> where("id = $orderid AND userid = $userid") -> find();
  if(!$res) {
    $json['result'] = false;
    $json['msg'] = "退款失败";
    return json($json);
  }

  $sql = "update pre_user set money = money + " . $res['price'] . " where id = $userid";
  $res = $db -> query($sql);

  if(!$res) {
    $json['result'] = false;
    $json['msg'] = "退款失败";
    return json($json);
  }

  $json['result'] = true;
  $json['msg'] = "退款成功";
  return json($json);
}

?>