<?php 
// 查看优惠券(列表)
include_once "../includes/init.php";
include_once "./common.php";

//每页数量
$limit = 5;

//总数量
$res = $db -> select("count(*) as len") -> from("coupon_record") -> find();
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

$data = $db -> select("coupon.name,coupon.price,coupon_record.*") -> from("coupon_record") -> join("coupon", "coupon.id = coupon_record.cid") -> limit($offset, $limit) -> all();

foreach ($data as $key => $value) {
  switch ($value['status']) {
    case 0:
      $data[$key]['status'] = '未领取';
      break;
    case 1:
      $data[$key]['status'] = '已领取';
      break;
    case 2:
      $data[$key]['status'] = '已使用';
      break;
    case 3:
      $data[$key]['status'] = '已过期';
      break;
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
            <h1 class="page-title">查看优惠卷列表</h1>
        </div>
        <ul class="breadcrumb">
            <li><a href="index.php">首页</a> <span class="divider">/</span></li>
            <li class="active">查看优惠卷列表</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">
                <div class="btn-toolbar"></div>
                <div class="well">
                    <table class="table">
                      <thead>
                        <tr>
                          <th>名称</th>
                          <th>口令</th>
                          <th>金额</th>
                          <th>状态</th>
                          <th>创建时间</th>
                          <th style="width: 26px;"></th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach ($data as $key => $item) { ?>
                        <tr>
                          <td><?php echo $item['name']; ?></td>
                          <td><?php echo $item['password']; ?></td>
                          <td><?php echo $item['price']; ?></td>
                          <td><?php echo $item['status']; ?></td>
                          <td><?php echo date("Y-m-d", $item['createtime']); ?></td>
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


