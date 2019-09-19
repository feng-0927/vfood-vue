<template>
	<div>
		<header>
			<a href="javascript:history.go(-1);" class="iconfont backIcon">&lt;</a> 
			<h1>优惠卷领取入口</h1>
		</header>
		<ul class="formarea mobile-phone">
			<li>
				<input required="required" type="text" v-model="password" placeholder="请输入口令" class="password" />
			</li>
		</ul>
		<div class="mobile-button" @click="submit">领取</div>
	</div>
</template>

<script>
import proxy from "../proxy/index";
export default {
	name: "couponadd",
	created() {
		this.$emit("isActive", true);
	},
	data() {
		return {
			password: ''
		}
	},
	methods: {
		submit() {
			let id = this.$cookies.get("user").userid;
			let password = this.password.trim();
			if(password == '') {
				return false;
			}

			proxy.couponadd({id, password}).then(res => {
				this.password = '';
				this.$alert(res.msg);

				if(res.result) {
					this.$router.go(-1);
				}
			})
		}
	}
}
</script>

<style scoped>
	.password {
		line-height: 45px;
	}
	header {
		position: static;
	}
	.formarea li input {
		width: 100%;
		padding: 0 10px;
	}
</style>