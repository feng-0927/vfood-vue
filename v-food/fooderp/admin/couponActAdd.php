<?php 
include_once "../includes/init.php";
include_once "./common.php";

$id = isset($_GET['id']) ? trim($_GET['id']) : false;
$name = ""; //优惠卷名称
$num = ""; //数量
$price = ""; //价格

//POST请求
if($_POST) {
  $data = array();
  foreach ($_POST as $key => $value) {
    if($key != 'id') {
      $data[$key] = $value;
    }
  }

  //优惠卷冲突
  if(!$id) {
    $res = $db -> select("name") -> from("coupon") -> where("name = '" . $data['name'] . "'") -> find();
    if($res) {
      show("该优惠卷已存在", "couponAdd.php"); die;
    }
  }
  
  if($id) {
    //更新
    if($db -> save("coupon", $data, "id='{$id}'")) {
      show("更新成功", "couponActList.php"); die;
    }
    show("更新失败", "couponActList.php"); die;
  }
  
  //开启事务
  $db -> query("start transaction");

  //插入优惠卷同时要插入优惠卷使用记录表
  $res = $db -> save("coupon", $data);
  if(!$res) {
    $db -> query("ROLLBACK");
    show("插入失败", "couponActAdd.php"); die;
  }

  $dataAll = array();
  for($i = 0; $i < intval($data['num']); $i++) {
    $dataAll[] = array(
      'password' => $strings -> randomStr(15, false),
      'cid' => $res,
      'status' => 0,
      'createtime' => time() + 86400 * 3
    );
  }

  $res = $db -> addAll("coupon_record", $dataAll);

  if(!$res) {
    $db -> query("ROLLBACK");
    show("插入失败", "couponActAdd.php"); die;
  }

  $db -> query("COMMIT");
  show("插入成功", "couponActList.php"); die;
}

if($id) {
  //编辑页面
  $where = array(
    'id' => $id
  );
  $data = $db -> select() -> from("coupon") -> where($where) -> find();
  
  $name = $data['name'];
  $num = $data['num'];
  $price = $data['price'];
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
            <h1 class="page-title">优惠卷修改</h1>
        </div>
        <ul class="breadcrumb">
            <li><a href="couponActList.php">优惠卷列表</a> <span class="divider">/</span></li>
            <li class="active">优惠卷修改</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">
                <div class="well">
                    <div id="myTabContent" class="tab-content">
                      <div class="tab-pane active in" id="home">
                        <form method="POST" enctype="multipart/form-data">
                            <label>优惠卷名称</label>
                            <input required name="name" type="text" value="<?php echo $name; ?>" class="input-xxlarge"> 
                                  
                            <label>价格</label>
                            <input required name="price" type="text" value="<?php echo $price; ?>" class="input-xxlarge">  

                            <label>数量</label>
                            <input required name="num" type="number" value="<?php echo $num; ?>" class="input-xxlarge">    

                            <label></label>
                            <input class="btn btn-primary" type="submit" value="提交" />
                        </form>
                      </div>
                  </div>
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


