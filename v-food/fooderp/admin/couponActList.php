<?php 
// 优惠活动(列表)
include_once "../includes/init.php";
include_once "./common.php";

//删除一条 
$id = isset($_GET['id']) ? $_GET['id'] : false;
if($id) {
    if($db -> del("coupon", $id)) {
      show("删除成功", "couponActList.php");
    }else {
      show("删除失败", "couponActList.php");
    }
}

//每页数量
$limit = 5;

//总数量
$res = $db -> select("count(*) as len") -> from("coupon") -> find();
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

$data = $db -> select() -> from("coupon") -> limit($offset, $limit) -> all();

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
            <h1 class="page-title">优惠卷活动列表</h1>
        </div>
        <ul class="breadcrumb">
            <li><a href="index.php">首页</a> <span class="divider">/</span></li>
            <li class="active">优惠卷活动管理</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">
                <div class="btn-toolbar">
                    <button class="btn btn-primary" onClick="location='couponActAdd.php'"><i class="icon-plus"></i>增加优惠卷</button>
                    <button class="btn" id="allDelBtn"><i class="icon-plus"></i>批量删除</button>
                </div>
                <div class="well">
                    <table class="table">
                      <thead>
                        <tr>
                          <th><input type="checkbox" id="allcheckbox" /></th>
                          <th>优惠卷名称</th>
                          <th>数量</th>
                          <th>金额</th>
                          <th style="width: 26px;"></th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach ($data as $key => $item) { ?>
                        <tr>
                          <td><input type="checkbox" name="items[]" class="item" value="<?php echo $item['id']; ?>" /></td>
                          <td><?php echo $item['name']; ?></td>
                          <td><?php echo $item['num']; ?></td>
                          <td><?php echo $item['price']; ?></td>
                          <td>
                              <a href="couponActAdd.php?id=<?php echo $item['id']; ?>"><i class="icon-pencil"></i></a>
                              <a href="javascript:;" onclick="location.href='couponActList.php?id=<?php echo $item['id']; ?>'" role="button" data-toggle="modal"><i class="icon-remove"></i></a>
                          </td>
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


