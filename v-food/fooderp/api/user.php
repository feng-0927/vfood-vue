<?php
include_once("../includes/init.php");

$action = isset($_GET['action']) ? $_GET['action'] : "";

$json = array("msg"=>null,"result"=>false,"data"=>null);

if($action == "register")  //注册
{
  if($_POST)
  {
    $username = isset($_POST['username']) ? trim($_POST['username']) : "";

    $user = $db->select()->from("user")->where(["username"=>$username])->find();

    if($user)
    {
      $json['msg'] = '该用户已经注册了';
      return json($json);
    }
    
    $salt = $strings->randomStr(15, false);

    $password = isset($_POST['password']) ? trim($_POST['password']) : "";

    $data = [
      "username"=>$username,
      "password"=>md5($password.$salt),
      "salt"=>$salt,
      "createtime"=>time(),
      "status"=>0,
      "avatar"=>'',
      'sex'=>1,
      'email'=>'',
      'money'=>''
    ];

    $result = $db->save("user", $data);

    if($result)
    {
      $json['result'] = true;
      $json['msg'] = '注册成功，跳转登录';
    }else{
      $json['result'] = false;
      $json['msg'] = '注册失败';
    }

    return json($json);
  }
}else if($action == "login")  //登录
{
  if($_POST)
  {
    $username = isset($_POST['username']) ? trim($_POST['username']) : "";

    //先判断用户是否存在
    $user = $db->select()->from("user")->where(['username'=>$username])->find();

    if(!$user)
    {
      $json['msg'] = "用户不存在";
      return json($json);
    }

    //判断密码是否正确
    $password = isset($_POST['password']) ? trim($_POST['password']) : "";
    $repass = $user['password'];
    $salt = $user['salt'];

    if(md5($password.$salt) != $repass)
    {
      $json['msg'] = '密码不正确';
      return json($json);
    }else{
      $json['msg'] = '登录成功';
      $json['data'] = $user;
      $json['result'] = true;
      return json($json);
    }

  }
}else if($action == 'recharge') 
{
  //充值金额 => 用户充值记录表 => 用户金额 增加
  if($_POST) 
  {
    $money = isset($_POST['money']) ? trim($_POST['money']) : "";
    $userid = isset($_POST['userid']) ? trim($_POST['userid']) : "";

    //先判断用户是否存在
    $user = $db->select()->from("user")->where(['id'=>$userid])->find();

    if(empty($money) || empty($userid)) {
      $json['msg'] = "参数不存在";
      $json['result'] = false;
      return json($json);
    }else if(!$user) {
      $json['msg'] = "用户不存在";
      $json['result'] = false;
      return json($json);
    }

    //充值记录表
    $data = array(
      'money' => $money,
      'userid' => $userid,
      'status' => 0,
      'createtime' => time()
    );
    $res = $db -> save("recharge_record", $data);

    if(!$res) {
      $json['msg'] = "充值失败，请稍后再试";
      $json['result'] = false;
      return json($json);
    }
    
    $json['msg'] = "充值成功,请等待审核";
    $json['result'] = true;
    return json($json);
  }
}else if($action == 'sendEmailCheck') {
  //发送邮箱
  if($_POST) {
    $email = isset($_POST['email']) ? $_POST['email'] : '';
    $id = isset($_POST['id']) ? $_POST['id'] : 0;

    //使用163邮箱服务器
    $smtpserver = "smtp.163.com";
    //163邮箱服务器端口 
    $smtpserverport = 25;
    //你的163服务器邮箱账号
    $smtpusermail = "qq790891601@163.com";
    //收件人邮箱
    $smtpemailto = $email;

    //你的邮箱账号(去掉@163.com)
    $smtpuser = "qq790891601";//你的163邮箱去掉后面的163.com
    //你的邮箱密码
    $smtppass = "h1902123"; //你的163邮箱SMTP的授权码，千万不要填密码！！！

    $mailbody = "<a href='http://localhost:8080/api/user.php?action=emailCheck&id=" . $id ."'>点击验证邮箱</a>";  //邮件内容
    $mailtype = "HTML";    //邮件格式（HTML/TXT）,TXT为文本邮件
    //邮件主题 
    $mailsubject = "邮箱认证";
    //这里面的一个true是表示使用身份验证,否则不使用身份验证. 
    $smtp = new smtp($smtpserver, $smtpserverport, true, $smtpuser, $smtppass);
    //是否显示发送的调试信息 
    $smtp->debug = TRUE;
    //发送邮件
    $smtp->sendmail($smtpemailto, $smtpusermail, $mailsubject, $mailbody, $mailtype); 
  }
}else if($action == 'emailCheck') {
  //邮箱认证
  $id = isset($_GET['id']) ? $_GET['id'] : 0;

  //邮箱认证成功
  $res = $db -> save("user", array('status' => 1), "id = $id");
  if(!$res) {
    echo "<script>alert('邮箱认证失败');</script>";
    return header("location:http://localhost:8080/#/other");
  }
  
  echo "<script>alert('邮箱验证成功');</script>";
  return header("location:http://localhost:8080/#/other");
}else if($action == 'info') {
  //个人资料
  if($_POST) {
    $id = isset($_POST['id']) ? $_POST['id'] : 0;
    $sex = isset($_POST['sex']) ? $_POST['sex'] : 0;
    $username = isset($_POST['username']) ? $_POST['username'] : '';
    $email = isset($_POST['email']) ? $_POST['email'] : '';

    $data = array(
      'username' => $username,
      'email' => $email,
      'sex' => $sex
    );

    if($db -> save("user", $data, "id = $id")) {
      $json['msg'] = '提交个人资料成功';
      $json['result'] = true;
      return json($json);
    }

    $json['msg'] = "提交个人资料失败";
    $json['result'] = false;
    return json($json);
  }

  $id = isset($_GET['id']) ? $_GET['id'] : 0;

  $data = $db -> select() -> from("user") -> where("id = $id") -> find();

  if(!$data) {
    $json['msg'] = "获取个人信息失败";
    return json($json);
  }

  $json['msg'] = "获取个人信息成功";
  $json['data'] = $data;
  $json['result'] = true;
  return json($json);
}else if($action == 'coupon') {
  //优惠卷列表
  $id = isset($_GET['id']) ? $_GET['id'] : 0;
  $res = $db -> select("coupon_record.*,coupon.price,coupon.name") -> from("coupon_record") -> join("coupon", "coupon.id = coupon_record.cid") -> where("userid = $id") -> orderBy("coupon.price", "desc") -> all();

  if(!$res) {
    $json['msg'] = "获取优惠卷失败";
    return json($json);
  }

  $json['msg'] = "获取优惠卷成功";
  $json['result'] = true;
  $json['data'] = $res;
  return json($json);
}else if($action == 'couponadd') {
  //输入口令 => 添加优惠卷
  $password = isset($_POST['password']) ? $_POST['password'] : 0;
  $id = isset($_POST['id']) ? $_POST['id'] : 0;

  //查看是否有该口令
  $res = $db -> select() -> from("coupon_record") -> where("password = '$password'") -> find();
  if(!$res) {
    $json['msg'] = "该口令不存在";
    return json($json);
  }

  //该口令已被领取
  if($res['userid'] == $id) {
    $json['msg'] = "该口令已被领取";
    return json($json);
  }

  //更新记录表
  $data = array(
    'status' => 1,
    'userid' => $id
  );
  $res = $db -> save("coupon_record", $data, "password = '$password'");

  if(!$res) {
    $json['msg'] = "领取失败";
    return json($json);
  }

  $json['msg'] = "领取成功";
  $json['result'] = true;
  return json($json);
}else if($action == 'uploadAvatar') {
  $file = isset($_FILES['file']) ? $_FILES['file'] : false;
  $id = isset($_POST['id']) ? $_POST['id'] : 0;

  if($file) {
    if($homeUploadFile -> upload_file($file)) {
      
      $res = $db -> save("user", array('avatar' => "/static/upload/" . $homeUploadFile -> get_file_name()), "id = $id");
      $json['msg'] = "上传成功";
      $json['result'] = true;
      return json($json);
    }
    $json['msg'] = "上传失败";
    $json['result'] = false;
    return json($json);
  }
}else if($action == 'userinfo') {
  //重新请求用户信息
  $id = isset($_GET['id']) ? $_GET['id'] : 0;
  $res = $db -> select() -> from("user") -> where("id = $id") -> find();

  if(!$res) {
    $json['msg'] = "请求用户信息失败";
    return json($json);
  }

  $json['msg'] = "请求用户信息成功";
  $json['data'] = $res;
  $json['result'] = true;
  return json($json);
}

?>