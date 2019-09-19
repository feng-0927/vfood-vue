<template>
	<div class="recharge_con">
		<header>
			<a href="javascript:history.go(-1);" class="iconfont backIcon">&lt;</a> 
			<h1>充值中心</h1>
		</header>
		<ul class="formarea mobile-phone">
			<li>
				<label class="lit">充值金额</label>
				<input type="text" v-model="money" placeholder="请输入你要充值的金额" class="money" />
			</li>
		</ul>
		<div class="mobile-button" @click="submit">充值</div>
	</div>
</template>

<script>
import proxy from "../proxy/index"
export default {
	name: "recharge",
	created() {
		this.$emit("isActive", true)
	},
	data() {
		return {
			money: ''
		}
	},
	methods: {
		//充值金额
		submit() {
			let userid = this.$cookies.get("user").userid;
			proxy.recharge({userid, money: this.money}).then(res => {
				this.$alert(res.msg)
				if(res.result) {
					//充值成功
					this.$router.go(-1)
				}
			})
		}
	}
}
</script>

<style scope="scope">
	.formarea li .money {
		line-height: 45px;
		width: 50%;
	}
	.recharge_con header {
		position: static;
	}
</style>