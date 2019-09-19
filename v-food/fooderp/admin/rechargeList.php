<?php 
//充值记录页面
include_once "../includes/init.php";
include_once "./common.php";

$id = isset($_GET['id']) ? $_GET['id'] : 0;
//设置当前页和每页限制数
$currentPage = isset($_GET['page']) ? $_GET['page'] : 1;

//每页数量
$limit = 5;

//总数量
$res = $db -> select("count(*) as len") -> from("recharge_record") -> where("userid = $id") -> find();
$count = $res['len'];

//设置值
$offset = ($currentPage-1) * $limit;

//分页
$page = page($currentPage, $count, $limit, 5, 'yellow');

$user = $db -> select("username") -> from("user") -> where("id = $id") -> find();

$data = $db -> select() -> from("recharge_record") -> where("userid = $id AND status = 1") -> limit($offset, $limit) -> all();
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
            <h1 class="page-title">充值记录列表</h1>
        </div>
        <ul class="breadcrumb">
            <li><a href="index.php">首页</a> <span class="divider">/</span></li>
            <li><a href="userList.php">用户列表</a> <span class="divider">/</span></li>
            <li class="active">查看<?php echo $user['username']; ?>充值记录</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">
                <div class="btn-toolbar"></div>
                <div class="well">
                    <table class="table">
                      <thead>
                        <tr>
                          <th>充值金额</th>
                          <th>充值时间</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach ($data as $key => $item) { ?>
                        <tr>
                          <td><?php echo $item['money']; ?></td>
                          <td><?php echo date('Y-m-d', $item['createtime']); ?></td>
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

                <div class="modal small hide fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h3 id="myModalLabel">Delete Confirmation</h3>
                    </div>
                    <div class="modal-body">
                        <p class="error-text"><i class="icon-warning-sign modal-icon"></i>Are you sure you want to delete the user?</p>
                    </div>
                    <div class="modal-footer">
                        <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
                        <button class="btn btn-danger" data-dismiss="modal">Delete</button>
                    </div>
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


