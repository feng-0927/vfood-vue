<?php 
include_once "../includes/init.php";
include_once "./common.php";

$id = isset($_GET['id']) ? trim($_GET['id']) : false;
$name = "";

//POST请求
if($_POST) {
  $data = array();
  foreach ($_POST as $key => $value) {
    if($key != 'id') {
      $data[$key] = $value;
    }
  }

  //分类名冲突
  if(!$id) {
    $res = $db -> select("name") -> from("foodcate") -> where("name = '" . $data['name'] . "'") -> find();
    if($res) {
      show("食品分类名已存在", "foodCateAdd.php"); die;
    }
  }

  if($id) {
    //更新
    if($db -> save("foodcate", $data, "id='{$id}'")) {
      show("更新成功", "foodCateList.php"); die;
    }
    show("更新失败", "foodCateList.php"); die;
  }
  
  if($db -> save("foodcate", $data)) {
    show("插入成功", "foodCateList.php"); die;
  }
}

if($id) {
  //编辑页面
  $where = array(
    'id' => $id
  );
  $data = $db -> select() -> from("foodcate") -> where($where) -> find();
  
  $name = $data['name'];
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
            <h1 class="page-title">编辑食品分类</h1>
        </div>
        <ul class="breadcrumb">
            <li><a href="foodCateList.php">食品分类列表</a> <span class="divider">/</span></li>
            <li class="active">编辑食品分类</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">

                <div class="well">
                    <div id="myTabContent" class="tab-content">
                      <div class="tab-pane active in" id="home">
                        <form method="POST">
                            <label>食品分类</label>
                            <input required name="name" type="text" value="<?php echo $name; ?>" class="input-xxlarge">
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


