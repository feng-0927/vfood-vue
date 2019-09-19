<script src="<?php echo ADMIN_PATH;?>/lib/bootstrap/js/bootstrap.js"></script>
<script charset="utf-8" src="<?php echo ADMIN_ASSETS_PATH; ?>/plugins/editor/kindeditor/kindeditor-all.js"></script>
<script type="text/javascript">
    $("[rel=tooltip]").tooltip();
    $(function() {
        $('.demo-cancel-click').click(function(){return false;});
    });
    KindEditor.ready(function(K) {
        window.editor = K.create('#editor_id');

        var options = { };
		var editor = K.create('textarea[name="content"]', options);
    });
</script>
<script src="<?php echo ADMIN_PATH . "/js/common.js" ?>"></script>
<script type="text/javascript">
	//发送ajax
	setInterval(function() {
		$.ajax({
			method: "get",
			url: "http://localhost/fooderp/api/services.php?action=show",
			dataType: 'json',
			success: function(res) {
				console.log(res)
				if(res.result) {
					let data = res.data
					for(let i = 0; i < data.length; i++) {
						let seat = data[i].seat;
						let type = data[i].type;

						$(`<p>您有一个新的${type}消息,座位号为：${seat}</p>`).notify();
					}
				}
			}
		})
	}, 3000)
</script>
