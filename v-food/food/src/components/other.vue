<template>
	<div>
		<header>
			<a href="javascript:history.go(-1);" class="iconfont backIcon">&#60;</a>
			<h1>个人资料</h1>
		</header>
		<div style="height:1rem;"></div>
		<form method="POST">
			<ul class="formarea">
				<li>
					<label class="lit">用户名</label>
					<input name="username" type="text" v-model="username" placeholder="请输入您的用户名" class="textbox" />
				</li>
				<li>
					<label class="lit">邮箱</label>
					<input name="email" type="text" v-model="email" placeholder="请输入您的邮箱" class="textbox" />
					<input v-if="status == 0" type="button" class="emailCheck" @click="sendEmailCheck" value="邮箱认证">
				</li>
				<li>
					<label class="lit">余额</label>
					<input type="text" disabled="disabled" :value="price" class="textbox" />
				</li>
				<li class="clearfix">
					<label class="lit">性别</label>
					<div class="choose">
						<label><input name="sex" type="radio" v-model="sex" value="0" />男</label>
						<label><input name="sex" type="radio" v-model="sex" value="1" />女</label>
					</div>
				</li>
			</ul>
			<div style="height:1.2rem;"></div>
			<div class="button-order-det" @click="submit">确认</div>
		</form>
	</div>
</template>

<script>
import proxy from "../proxy/index"

export default {
	name: "other",
	created() {
		this.$emit("isActive", true);

		let userid = this.$cookies.get("user").userid;
		//查询用户信息
		proxy.getInfo(userid).then(res => {
			if(res.result) {
				this.price = res.data.money;
				this.sex = res.data.sex;
				this.username = res.data.username;
				this.email = res.data.email;
				this.status = res.data.status == 0 ? false : true;
			}
		}).catch(err => console.log(err))
	},
	data() {
		return {
			price: '',
			sex: 0,
			username: '',
			email: '',
			status: false
		}
	},
	methods: {
		submit() {
			let {sex, username, email} = this;
			let userid = this.$cookies.get("user").userid;

			let data = {
				sex,
				username,
				email,
				id: userid
			}
			proxy.info(data).then(res => {
				if(res.result) {
					//成功
					this.$alert(res.msg);
					this.$router.push("/user");
				}
			}).catch(err => console.log(err))
		},
		sendEmailCheck() {
			//发送邮箱认证
			let userid = this.$cookies.get("user").userid;
			let data = {
				email: this.email,
				id: userid
			}
			proxy.sendEmailCheck(data).then(res => {
				console.log(res)
			}).catch(err => console.log(err))
		}
	}
}
</script>

<style scope>
	.emailCheck {
		background-color: #27C400;
		position: absolute;
		right: 0;
		top:50%;
		transform: translateY(-50%);
		color: white;
		padding: 15px;
	}
</style>