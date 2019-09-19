<?php 
include_once "../includes/init.php";
include_once "./common.php";

//删除一条 
$id = isset($_GET['id']) ? $_GET['id'] : false;
if($id) {
    if($db -> del("food", $id)) {
      //删除
      $res = $db -> select('thumb') -> from("food") -> where("id = '$id'") -> find();
      $filename = $uploadsDir . $res["thumb"];

      if(is_file($filename)) {
        $res = unlink($filename);
      }

      show("删除成功", "foodList.php");
    }else {
      show("删除失败", "foodList.php");
    }
}

//每页数量
$limit = 5;

//总数量
$res = $db -> select("count(*) as len") -> from("food") -> find();
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

$data = $db -> select() -> from("food") -> limit($offset, $limit) -> all();

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
            <h1 class="page-title">食品列表</h1>
        </div>
        <ul class="breadcrumb">
            <li><a href="index.php">首页</a> <span class="divider">/</span></li>
            <li class="active">食品管理</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">
                <div class="btn-toolbar">
                    <button class="btn btn-primary" onClick="location='foodAdd.php'"><i class="icon-plus"></i>增加食品</button>
                    <button class="btn" id="allDelBtn"><i class="icon-plus"></i>批量删除</button>
                </div>
                <div class="well">
                    <table class="table">
                      <thead>
                        <tr>
                          <th><input type="checkbox" id="allcheckbox" /></th>
                          <th>食品名称</th>
                          <th>食品样图</th>
                          <th>价格</th>
                          <th>标签</th>
                          <th>食品描述</th>
                          <th style="width: 26px;"></th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach ($data as $key => $item) { ?>
                        <tr>
                          <td><input type="checkbox" name="items[]" class="item" value="<?php echo $item['id']; ?>" /></td>
                          <td><?php echo $item['name']; ?></td>
                          <td>
                            <?php if(empty($item['thumb'])) { ?>
                              <img class="img-responsive book_thumb" src="<?php echo ADMIN_PATH . '/images/cover.png'; ?>" />
                            <?php }else{ ?>
                              <img class="img-responsive book_thumb" src="<?php echo ADMIN_ASSETS_PATH . '/uploads/' . $item['thumb']; ?>" />
                            <?php } ?>
                          </td>
                          <td><?php echo $item['price']; ?></td>
                          <td><?php echo $item['flag']; ?></td>
                          <td class="text-elise" title="<?php echo $item['content']; ?>"><span><?php echo $item['content']; ?></span></td>
                          <td>
                              <a href="foodAdd.php?id=<?php echo $item['id']; ?>"><i class="icon-pencil"></i></a>
                              <a href="javascript:;" onclick="location.href='foodList.php?id=<?php echo $item['id']; ?>'" role="button" data-toggle="modal"><i class="icon-remove"></i></a>
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


