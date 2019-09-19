<template>
	<div class="invoiceCon" style="background-color: white;">
		<div class="invoice">
			<span><input type="radio" name="radiobutton" value="radiobutton" checked> 普通发票 </span>
			<span><input type="radio" name="radiobutton" value="radiobutton" checked> 专用发票</span>
		</div>
		<ul class="invoice-list-choose">
			<li class="prettys">
			  <!--座位号-->
				<div class="seat-number">
					<input type="text" style="border: none;width: 100%;" v-model="seatnum" placeholder="请输入座位号" />
				</div>
			</li>
		</ul>
		<div class="billing"><a @click="submit">开票</a></div>
	</div>
	<!--弹窗内容-->
	<!-- <div id="wrapper">
		<div class="box">
			<div id="dialogBg"></div>
			<div id="dialog" class="animated">
				<div class="dialogTop">
					<a href="javascript:;" class="claseDialogBtn">关闭</a>
				</div>
				<form action="" method="post" id="editForm">
					<ul class="editInfos">
						<input type="text" name="" required value="" class="ipt"  placeholder="请输入您的抬头"/>
						<input type="text" name="" required value="" class="ipt" placeholder="请输入您的税号" />
						<input type="submit" value="确认提交" class="submitBtn" />
					</ul>
				</form>
			</div>
		</div>
	</div> -->
</template>

<script>
import proxy from "../proxy/index"
export default {
	name: "invoice",
	created() {
		this.$emit("isActive", true)
	},
	data() {
		return {
			seatnum: ''
		}
	},
	methods: {
		//通知后台开发票
		submit() {
			//seatnum
			let userid = this.$cookies.get("user").userid;
			//发送ajax
			let data = {
				userid,
				seatnum: this.seatnum
			}
			proxy.invoice(data).then(res => {
				this.$alert(res.msg);
				if(res.result) {
					this.$router.push("/service")
				}
			});
		}
	}
}
</script>

<style scope>
#dialogBg {
	width: 100%;
	height: 100%;
	background-color: #000000;
	opacity: .8;
	filter: alpha(opacity=60);
	position: fixed;
	top: 0;
	left: 0;
	z-index: 9999;
	display: none;
}

#dialog {
	width: 80%;
	display: none;
	background-color: #ffffff;
	position: fixed;
	top: 20%;
	left: 10%;
	z-index: 10000;
}

.dialogTop {
	width: 90%;
	margin: 0 auto;
	border-bottom: 1px dotted #ccc;
	letter-spacing: 1px;
	padding: 10px 0;
	text-align: right;
}
.dialogTop a{color: #ccc;}
.dialogIco {
	width: 50px;
	height: 50px;
	position: absolute;
	top: -25px;
	left: 50%;
	margin-left: -25px;
}

.editInfos {padding-bottom: .3rem;}

.editInfos input {display: block;width: 80%;margin:.3rem auto auto;}

.ipt {border: 1px solid #ccc;padding: 5px;}

.ipt:focus {
	outline: none;
	border-color: #66afe9;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset, 0 0 8px rgba(102, 175, 233, 0.6);
	-webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset, 0 0 8px rgba(102, 175, 233, 0.6);
}

.submitBtn {
	cursor: pointer;
	display: inline-block;
	border-radius: 5px;
	-webkit-border-radius: 5px;
	text-align: center;
	background-color: #27C400;
	color: #fff;
	font-size: .3rem;
	padding: .2rem 0;
}
input{background-color:transparent; border-color:transparent;-webkit-appearance: none;}
</style>

<style scope>

</style>