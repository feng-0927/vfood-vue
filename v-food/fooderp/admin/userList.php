<?php 
include_once "../includes/init.php";
include_once "./common.php";

//每页数量
$limit = 5;

//总数量
$res = $db -> select("count(*) as len") -> from("user") -> find();
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

$data = $db -> select() -> from("user") -> limit($offset, $limit) -> all();
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
            <h1 class="page-title">用户列表</h1>
        </div>
        <ul class="breadcrumb">
            <li><a href="index.php">首页</a> <span class="divider">/</span></li>
            <li class="active">用户管理</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">
                <div class="btn-toolbar"></div>
                <div class="well">
                    <table class="table">
                      <thead>
                        <tr>
                          <th>用户名</th>
                          <th>头像</th>
                          <th>邮箱</th>
                          <th>创建时间</th>
                          <th></th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach ($data as $key => $item) { ?>
                        <tr>
                          <td><?php echo $item['username']; ?></td>
                          <td>
                            <?php if(empty($item['avatar'])) { ?>
                              <img class="img-responsive book_thumb" src="<?php echo ADMIN_PATH . '/images/cover.png'; ?>" />
                            <?php }else{ ?>
                              <img class="img-responsive book_thumb" src="<?php echo '../../food' . $item['avatar']; ?>" />
                            <?php } ?>
                          </td>
                          <td><?php echo empty($item['email']) ? '暂无邮箱' : $item['email']; ?></td>
                          <td><?php echo date('Y-m-d', $item['createtime']); ?></td>
                          <td>
                              <a href="orderList.php?id=<?php echo $item['id']; ?>">查看订单</a>
                              <a href="rechargeList.php?id=<?php echo $item['id']; ?>">
                                查看充值记录
                              </a>
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


