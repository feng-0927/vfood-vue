<?php 
//订单管理
include_once "../includes/init.php";
include_once "./common.php";

$id = isset($_GET['id']) ? $_GET['id'] : false;
if($id) {
  //已支付 => 就餐中
  $res = $db -> save("order", array('status' => 3), "id = $id");
}

//每页数量
$limit = 5;

//总数量
$res = $db -> select("count(*) as len") -> from("order") -> find();
$count = $res['len'];

//设置当前页和每页限制数
$currentPage = isset($_GET['page']) ? $_GET['page'] : 1;

if(!$res) {
    die("SQL语句执行错误");
}


//设置值
$offset = ($currentPage-1) * $limit;

//分页
$page = page($currentPage, $count, $limit, 5, 'yellow');

//查询用户
$user = $db -> select("id,username") -> from("user") -> all();

//订单表
$order = $db -> select() -> from("order") -> limit($offset, $limit) -> all(); 

//订单食物表
$sql = "SELECT o.id,o.userid,order_food.foodnum,food.name FROM pre_order AS o LEFT JOIN pre_order_food AS order_food ON order_food.orderid = o.id LEFT JOIN pre_food AS food ON food.id = order_food.foodid";
$food = $db -> query($sql, true);

foreach ($order as $key => $value) {
  $status = $value['status'];

  switch($status) {
    case "0":
      $order[$key]['status'] = "未支付";
      break;
    case "1":
      $order[$key]['status'] = "已支付";
      break;
    case "2":
      $order[$key]['status'] = "已取消";
      break;
    case "3":
      $order[$key]['status'] = "就餐中";
      break;
    case "4":
      $order[$key]['status'] = "评价";
      break;
    case "5":
      $order[$key]['status'] = "已完成";
      break;
  }

  //菜品1 × 菜品2 × 菜品3 
  $order[$key]['foodname'] = '';
  foreach ($food as $f) {
    if($value['id'] == $f['id']) {
      $order[$key]['foodname'] .= $f['name'] . '×';
    }
  }

  $order[$key]['foodname'] = trim($order[$key]['foodname'], '×');

  //所属用户
  $order[$key]['username'] = '';
  foreach ($user as $u) {
    if($value['userid'] == $u['id']) {
      $order[$key]['username'] = $u['username'];
    }
  }
}

?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <?php include_once "./meta.php"; ?>
  </head>
  <body> 
    <?php include_once "header.php"; ?>
    <?php include_once "menu.php"; ?>
    <div class="content">
        <div class="header">
            <h1 class="page-title">订单列表</h1>
        </div>
        <ul class="breadcrumb">
            <li><a href="index.php">首页</a> <span class="divider">/</span></li>
            <li><a href="userList.php">用户管理</a><span class="divider">/</span></li>
            <li class="active">订单记录</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">
                <div class="btn-toolbar"></div>
                <div class="well">
                    <table class="table">
                      <thead>
                        <tr>
                          <th>用户</th>
                          <th>订单号</th>
                          <th>创建时间</th>
                          <th>状态</th>
                          <th>菜品名称</th>
                          <th>价格</th>
                          <th>订单评价</th>
                          <th>操作</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach ($order as $key => $item) { ?>
                        <tr>
                          <td><?php echo $item['username']; ?></td>
                          <td><?php echo $item['ordersn']; ?></td>
                          <td><?php echo date('Y-m-d', $item['createtime']); ?></td>
                          <td><?php echo $item['status']; ?></td>
                          <td><?php echo $item['foodname'] ?></td>
                          <td><?php echo $item['price'] ?></td>
                          <td><?php echo empty($item['content']) ? '该用户没有评价,默认好评' : $item['content']; ?></td>
                          <?php if($item['status'] == '已支付') {?>
                            <td><a href="?id=<?php echo $item['id']; ?>&page=<?php echo $currentPage; ?>">去配菜</a></td>
                          <?php } ?>
                        </tr>
                        <?php } ?>
                      </tbody>
                    </table>
                </div>
                <div class="pagination">
                    <ul>
                        <?php echo $page; ?>
                    </ul>
                </div>

                <footer>
                    <hr>
                    <p>&copy; 2017 <a href="#" target="_blank">copyright</a></p>
                </footer> 
            </div>
        </div>
    </div>
    
    <?php include_once "footer.php"; ?>
    
  </body>
</html>


