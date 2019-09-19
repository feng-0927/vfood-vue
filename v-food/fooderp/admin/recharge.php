<?php 
//充值记录页面
include_once "../includes/init.php";
include_once "./common.php";

//通过审核
$rechargeid = isset($_GET['rechargeid']) ? $_GET['rechargeid'] : 0;
if($rechargeid != 0) {
  //查询充值金额
  $info = $db -> select("userid,money") -> from("recharge_record") -> where("id = $rechargeid") -> find();


  //开启事务
  $db -> query("start transaction");

  //更新状态
  $data = array(
    'status' => 1
  );
  $res = $db -> save("recharge_record", $data, "id = $rechargeid");

  if(!$res) {
    show("审核失败", "recharge.php"); die;
  }

  //充值到用户
  $sql = "update pre_user set money = money + " . $info['money'] . " where id = " . $info['userid'];

  $res = $db -> query($sql);

  if(!$res) {
    $db -> query("ROLLBACK");
    show("审核失败", "recharge.php"); die;
  }

  $db -> query("COMMIT");
  show("审核通过", "recharge.php");
}


//设置当前页和每页限制数
$currentPage = isset($_GET['page']) ? $_GET['page'] : 1;

//每页数量
$limit = 5;

//总数量
$res = $db -> select("count(*) as len") -> from("recharge_record") -> find();
$count = $res['len'];

//设置值
$offset = ($currentPage-1) * $limit;

//分页
$page = page($currentPage, $count, $limit, 5, 'yellow');

$data = $db -> select() -> from("recharge_record") -> where("status = 0") -> limit($offset, $limit) -> all();
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
            <h1 class="page-title">充值列表</h1>
        </div>
        <ul class="breadcrumb">
            <li><a href="index.php">首页</a> <span class="divider">/</span></li>
            <li class="active">充值列表</li>
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
                          <th>操作</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach ($data as $key => $item) { ?>
                        <tr>
                          <td><?php echo $item['money']; ?></td>
                          <td><?php echo date('Y-m-d', $item['createtime']); ?></td>
                          <td>
                              <a href="recharge.php?rechargeid=<?php echo $item['id']; ?>&page=<?php echo $currentPage; ?>">审核通过</a>
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


