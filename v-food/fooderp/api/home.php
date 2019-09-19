<?php
include_once("../includes/init.php");

$action = isset($_GET['action']) ? $_GET['action'] : "";

$json = array("msg"=>null,"result"=>false,"data"=>null);

if($action == "banner")  //banner
{
  $banner = $db->select()->from("food")->where(["flag"=>"top"])->limit(0,8)->all();

  $json['data'] = $banner;
  $json['result'] = true;

  return json($json);
}else if($action == 'hotfood') //热销产品
{ 
  $userid = isset($_POST['userid']) ? $_POST['userid'] : 0;
  
  if($userid)
  {
    $hotfood = $db->select()->from("food")->where(["flag"=>"hot"])->limit(0,20)->all();

    $cart = $db->select()->from("cart")->where(["userid"=>$userid])->all();

    $foodid = array_column($cart, 'foodid');

    foreach($hotfood as $key=>$item)
    {
      if($index = array_search($item['id'],$foodid))
      {
        $foodnum = $cart[$index]['foodnum'];
        $hotfood[$key]['num'] = $foodnum;
      }else{
        $hotfood[$key]['num'] = 0;
      }
    }

  }else{
    $hotfood = $db->select()->from("food")->where(["flag"=>"hot"])->limit(0,20)->all();

    foreach($hotfood as $key=>$item)
    {
      $hotfood[$key]['num'] = 0;
    }
  }
  

  $json['data'] = $hotfood;
  $json['result'] = true;

  return json($json);
}else if($action == 'foodcate') //食品分类
{ 
  $userid = isset($_POST['userid']) ? $_POST['userid'] : 0;
  $foodcate = $db->select()->from("foodcate")->limit(0,8)->all();

  if(count($foodcate) > 0)
  {
    $cateid = isset(current($foodcate)['id']) ? current($foodcate)['id'] : 0;
    $foodlist = $db->select()->from("food")->where(['cateid'=>$cateid])->all();

    if($userid)
    {
      $cart = $db->select()->from("cart")->where(["userid"=>$userid])->all();

      $foodid = array_column($cart, 'foodid');

      foreach($foodlist as $key=>$item)
      {
        if($index = array_search($item['id'],$foodid))
        {
          $foodnum = $cart[$index]['foodnum'];
          $foodlist[$key]['num'] = $foodnum;
        }else{
          $foodlist[$key]['num'] = 0;
        }
      }
    }else{
      foreach($foodlist as $key=>$item)
      {
        $foodlist[$key]['num'] = 0;
      }
    }

    
  }

  $json['data'] = ['foodcate'=>$foodcate,"foodlist"=>$foodlist];
  $json['result'] = true;

  return json($json);
}else if($action == 'foodlist') //查询指定分类
{ 
  $cateid = isset($_POST['cateid']) ? $_POST['cateid'] : 0;
  $foodlist = $db->select()->from("food")->where(["cateid"=>$cateid])->all();

  $userid = isset($_POST['userid']) ? $_POST['userid'] : 0;

  if($userid)
  {
    $cart = $db->select()->from("cart")->where(["userid"=>$userid])->all();

      $foodid = array_column($cart, 'foodid');

      foreach($foodlist as $key=>$item)
      {
        if($index = array_search($item['id'],$foodid))
        {
          $foodnum = $cart[$index]['foodnum'];
          $foodlist[$key]['num'] = $foodnum;
        }else{
          $foodlist[$key]['num'] = 0;
        }
      }
  }else{
    foreach($foodlist as $key=>$item)
    {
      $foodlist[$key]['num'] = 0;
    }
  }

  $json['data'] = $foodlist;
  $json['result'] = true;

  return json($json);
}else if($action == "addcart")
{
  if($_POST)
  {
    $foodid = isset($_POST['foodid']) ? trim($_POST['foodid']) : 0;
    $userid = isset($_POST['userid']) ? trim($_POST['userid']) : 0;
    $foodnum = isset($_POST['foodnum']) ? trim($_POST['foodnum']) : 1;

    $cart = $db->select()->from("cart")->where(["foodid"=>$foodid,"userid"=>$userid])->find();

    $data = array(
      "userid"=>$userid,
      "foodid"=>$foodid,
      "foodnum"=>$foodnum
    );

    if($cart) {
      //有记录
      $res = $db->save("cart", $data, "id = ".$cart['id']);
    }else{
      //无记录
      $res = $db->save("cart",$data);
    }

    if($res)
    {
      $json['result'] = true;
      $json['msg'] = '添加购物车成功';
    }

    return json($json);
  }
}else if($action == "countcart")
{
  if($_POST)
  {
    $userid = isset($_POST['userid']) ? trim($_POST['userid']) : 0;

    $cart = $db->select("cart.*,food.price")->from("cart")->join("food","cart.foodid = food.id")->where("cart.userid = $userid")->all();

    $cartBack = array(
      "count"=>0,  //数量
      "price"=>0,  //价格
    );

    if(!$cart) {
      $json['data'] = $cartBack;
    }else{
      //有数据
      foreach($cart as $item)
      {
        $cartBack['count'] += $item['foodnum'];
        $cartBack['price'] += ($item['price']*$item['foodnum']);
      }
      $json['data'] = $cartBack;
    }

    $json['msg'] = '获取购物车数据成功';
    $json['result'] = true;

    return json($json);
  }
}else if($action == 'delcart') {
  //删除购物车为0的餐品
  if($_POST) {
    $id = isset($_POST['foodid']) ? $_POST['foodid'] : 0;
    $userid = isset($_POST['userid']) ? $_POST['userid'] : 0;

    if($db -> delete("cart", array('userid'=>$userid, 'foodid'=>$id))) {
      $json['msg'] = '删除成功';
      $json['result'] = true;

      return json($json);
    } 

    $json['msg'] = '删除失败';
    $json['result'] = false;
    return json($json);
  }
}





?>