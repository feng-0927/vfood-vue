<template>
	<div class="coupon_con">
		<header>
			<a href="javascript:history.go(-1);" class="iconfont backIcon">&lt;</a> 
			<h1>优惠卷<button type="button" class="add" @click="add">添加</button></h1>
		</header>
		<el-tabs v-model="activeName" @tab-click="handleClick" class="tab_proList">
		    <el-tab-pane label="未使用" name="notsed">
				<dd>
					<ul>
						<li class="coupon-list" v-for="item in getCoupons('1')">
							<a href="javascript:void(0)" class="clearfix">
								<div class="fl coupon-left" >
									<h1 class="f05 fl line-height14 colorfff">¥<em>{{item.price | toNumber}}</em></h1>
									<h2 class="f032 fl colorfff mt10 ml5 line-height-02rem">
										{{item.name}}</br>优惠券
									</h2>
								</div>
								<div class="fr coupon-right f028 ">
									<p>1.无限制优惠券</p>
									<p>2.有限期至：{{item.createtime | toDateStr}}</p>
								</div>
							</a>
						</li>
					</ul>
				</dd>
		    </el-tab-pane>
		    <el-tab-pane label="已使用" name="used">
				<dd id="bgImg-user1">
					<ul>
						<li class="coupon-list" v-for="item in getCoupons('2')">
							<a href="javascript:void(0)" class="clearfix">
								<div class="fl coupon-left">
									<h1 class="f05 fl line-height14 colorfff">¥<em>{{item.price | toNumber}}</em></h1>
									<h2 class="f032 fl colorfff mt10 ml5 line-height-02rem">
										{{item.name}}</br>优惠券
									</h2>
								</div>
								<div class="fr coupon-right f028 ">
									<p>1.无限制优惠券</p>
									<p>2.有限期至：{{item.createtime | toDateStr}}</p>
								</div>
								<div class="syImg"><img src="/static/img/sy.png" /></div>
							</a>
						</li>
					</ul>
				</dd>
		    </el-tab-pane>
		    <el-tab-pane label="已过期" name="expired">
				<dd id="bgImg-user">
					<ul>
						<li class="coupon-list" v-for="item in getCoupons('3')">
							<a href="javascript:void(0)" class="clearfix">
								<div class="fl coupon-left">
									<h1 class="f05 fl line-height14 colorfff">¥<em>{{item.price | toNumber}}</em></h1>
									<h2 class="f032 fl colorfff mt10 ml5 line-height-02rem">
										{{item.name}}</br>优惠券
									</h2>
								</div>
								<div class="fr coupon-right f028 ">
									<p>1.无限制优惠券</p>
									<p>2.有限期至：{{item.createtime | toDateStr}}</p>
								</div>
								<div class="syImg"><img src="/static/img/gq.png" /></div>
							</a>
						</li>
					</ul>
				</dd>
		    </el-tab-pane>
		</el-tabs>
	</div>
</template>

<script>
import proxy from "../proxy/index"
export default {
	name: "coupon",
	created() {
		this.$emit("isActive", true);

		let userid = this.$cookies.get("user").userid;		

		//请求优惠卷列表
		proxy.coupon({id: userid})
			.then(res => {
				if(res.result)
					this.coupons = res.data
			})
			.catch(err => console.log(err))
	},
	data() {
		return {
			activeName: 'notsed',
			coupons: []
		}
	},
	methods: {
		handleClick(tab, event) {
        },
        //跳到添加界面
      	add() {
      		this.$router.push("/couponadd")
      	},
      	getCoupons(status) {
			return this.coupons.filter(coupon => coupon.status == status)
		}
	},
	filters: {
		toNumber(num) {
			return parseInt(num);
		},
		toDateStr(str) {
			let d = new Date(~~str * 1000);
			let year = d.getFullYear();
			let month = d.getMonth() + 1;
			let day = d.getDate();
			
			return `${year}-${month}-${day}`
		}
	}
}
</script>

<style scoped>
	.add {
		position: absolute;
	    right: 0;
	    width: 100px;
	    background-color: #27c400;
	    border: none;
	}
	.clearfix .choose label input {
		width: auto;
	}
	.coupon_con header {
		position: static;
	}
	.el-tabs__nav {
		display: flex;
		width: 100%;
	}

	.el-tabs__nav .el-tabs__item {
		flex: 1;
		background-color: white;
	}
	.el-tabs__active-bar {
		background: #27c400;
		color: white;
	}

	.el-tabs__item.is-active {
		color: #27c400;
	}

	.tab_proList dd, .el-tabs__header {
		margin: 0;
	}
</style>