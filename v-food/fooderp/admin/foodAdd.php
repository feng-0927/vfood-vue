<?php 
include_once "../includes/init.php";
include_once "./common.php";

$id = isset($_GET['id']) ? trim($_GET['id']) : false;
$name = ""; //食品名称
$price = ""; //价格
$thumb = ""; //食品样图
$flag = ""; //食品标签
$content = "";

//POST请求
if($_POST) {
  $data = array();
  foreach ($_POST as $key => $value) {
    if($key != 'id') {
      $data[$key] = $value;
    }
  }

  //食品冲突
  if(!$id) {
    $res = $db -> select("name") -> from("food") -> where("name = '" . $data['name'] . "'") -> find();
    if($res) {
      show("食品名称已存在", "foodAdd.php"); die;
    }
  }
  
  //上传头像
  if($_FILES['thumb']) {
    if($uploadFile -> upload_file($_FILES['thumb'])) {
      $data['thumb'] = $uploadFile -> get_file_name();
    }
  }
  
  if($id) {
    //查询图片路径
    $res = $db -> select('thumb') -> from("food") -> where("id = '$id'") -> find();
    
    //存放图片路径
    $filename = $uploadsDir . $res["thumb"];

    //查找图片存在不，存在就删除，不存在就直接更新
    if(is_file($filename)) {
      $res = unlink($filename);
    }

    //更新
    if($db -> save("food", $data, "id='{$id}'")) {
      show("更新成功", "foodList.php"); die;
    }
    show("更新失败", "foodList.php"); die;
  }
  
  if($db -> save("food", $data)) {
    show("插入成功", "foodList.php");
  }
}

if($id) {
  //编辑页面
  $where = array(
    'id' => $id
  );
  $data = $db -> select() -> from("food") -> where($where) -> find();
  
  $name = $data['name'];
  $price = $data['price'];
  $thumb =  "../assets/uploads/" . $data['thumb'];
  $flag = $data['flag'];
  $content = $data['content'];
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
            <h1 class="page-title">食品修改</h1>
        </div>
        <ul class="breadcrumb">
            <li><a href="foodList.php">食品列表</a> <span class="divider">/</span></li>
            <li class="active">食品修改</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">
                <div class="well">
                    <div id="myTabContent" class="tab-content">
                      <div class="tab-pane active in" id="home">
                        <form method="POST" enctype="multipart/form-data">
                            <label>食品名称</label>
                            <input required name="name" type="text" value="<?php echo $name; ?>" class="input-xxlarge">                            
                            <label>食品样图</label>
                            <?php if(!empty($thumb)) { ?>
                              <img class="img-responsive book_thumb" src="<?php echo $thumb; ?>" />
                            <?php } ?>
                            <input name="thumb" type="file" value="" class="input-xxlarge"> 
                                  
                            <label>价格</label>
                            <input required name="price" type="text" value="<?php echo $price; ?>" class="input-xxlarge">   

                            <label>标签</label>
                            <select required name="flag" value="<?php echo $flag; ?>">
                              <option>请选择</option>
                              <option>hot</option>
                              <option>new</option>
                              <option>top</option>
                            </select>

                            <label>描述</label>
                            <textarea name="content"><?php echo $content; ?></textarea>

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


