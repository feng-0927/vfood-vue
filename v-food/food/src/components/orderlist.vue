<template>
  <div>
  	<el-tabs v-model="activeName" @tab-click="handleClick">
  		<el-tab-pane v-for="item in statusArr" :key="item.name" :label="item.label" :name="item.name">
  			<ul>
				<li class="bor-bottom5-f1 bg-fff padb03" v-for="o in order" v-if="o.status == item.name">
					<div class="order-details-header">
						<div class="order-det-logo fl"><img src="/static/img/logo.jpg.png"></div>
						<div class="order-det-time fl">
							<h4>合肥南站店</h4>
							<p>{{o.createtime | getDate}}</p>
						</div>
						<div class="my-order-iphone1 fr f032 text-right">
							<h4 class="f029">￥{{o.price}}</h4>
							<p class="f02 color999">订单号：{{o.ordersn}}</p>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="commodity-name f032">
						<ul>
							<li>
								<span v-for="(food, index) in orderfoodfilter(o.id)">
									<span>
										{{food.name}}
										<em>×</em>
										{{food.foodnum}}
									</span>
									<em v-if="orderfoodfilter(o.id).length != index+1">+</em>
								</span>
							</li>
							
							<div class="clearfix"></div>
						</ul>
					</div>
					<div class="bg-fff pay-button-myorder">
						<button class="bg99" v-if="activeName == 0" @click="statusSubmit" :data-id="o.id" :data-status="-1">取消</button>
						<button class="bg99" v-if="activeName == 1" @click="statusSubmit" :data-id="o.id" :data-status="-2">取消</button>

						<el-input
						  type="textarea"
						  :autosize="{ minRows: 2, maxRows: 4}"
						  placeholder="请输入评语"
						  v-model="content"
						  v-if="activeName == 4">
						</el-input>

						<p v-if="activeName == 5" class="content">
							评价：{{ o.content }}
						</p>
						
						<button class="bg26c400" v-for="(btn, index) in statusBtns" v-if="activeName == index && activeName != 1" @click="statusSubmit" :data-id="o.id" :data-status="index">{{btn}}</button>
					</div>
				</li>
			</ul>
  		</el-tab-pane>
	  </el-tabs>
  </div>
</template>

<script>
import proxy from "../proxy/index"
export default {
  name: 'orderlist',
  data(){
	  return {
	    activeName:"1",
	    tabPosition: 'top',
	    statusArr:[
	      {
	        label:"未支付",
	        name:"0",
	      },
	      {
	        label:"已支付",
	        name:"1",
	      },
	      {
	        label:"已取消",
	        name:"2",
	      },
	      {
	        label:"就餐",
	        name:"3",
	      },
	      {
	        label:"评价",
	        name:"4",
	      },
	      {
	        label:"已完成",
	        name:"5",
	      }
	    ],
	    statusBtns: ["去付款", "去就餐", "重新下单", "去评价", "完成", "再来一单"],
	    orderfood: [],   //订单食物数据
	    order: [],   //订单数据
	    submitStatus: false, //提交状态
	    content: ''
	  }
	},
	created() {
		//切换导航
    	this.$emit("isActive", false);
		this.requestOrderList();
	},
	methods: {
		requestOrderList() {
			let userid = this.$cookies.get("user").userid;
			proxy.orderlist({status: this.activeName, userid }).then(res => {
				if(res.data) {
					this.order = res.data.order;

					//评价
					for(let i = 0; i < this.order.length; i++) {
						let content = this.order[i].content;
						this.order[i].content = content ? content : '该用户没有任何评价，默认好评哦';
					}

					this.orderfood = res.data.orderfood;
				}else {
					this.order = [];
					this.orderfood = [];
				}
			})
		},
		//切换标签页
		handleClick(tab, event) {
			let index = tab.index ? tab.index : 0;

			//重新请求数据
			this.activeName = index + "";
			this.requestOrderList();
		},
		//筛选数据
		orderfoodfilter(oid) {
			return this.orderfood.filter(food => oid == food.id);
		},
		//移除某个订单数据
		removeOrder(id) {
			for(let i = 0; i < this.order.length; i++) {
				if(this.order[i].id == id) {
					this.order.splice(i, 1);  break;
				}
			}
		},
		//去付款", "去就餐", "重新下单", "去评价", "完成", "再来一单 表单提交
		statusSubmit(e) {
			let {submitStatus} = this;
			//订单id， 状态
			let { status, id } = e.target.dataset;
			let data = {
				orderid: id
			}

			if(submitStatus) {
				return false;
			}

			let userid = this.$cookies.get("user").userid;
			switch(status) {
				case "-2":
					//退款
					data['userid'] = userid;
					proxy.orderOut(data).then(res => {
						console.log(res)
						if(res.result) {
							data['status'] = 2;
						}
					})
					break;
				case "-1":
					data['status'] = 2; break;
				//未支付
				case "0":
					//去付款
					data['status'] = 1;
					data['userid'] = userid;
					proxy.orderSave(data).then(res => {
						if(res.result) 
							this.removeOrder(id);
					})
					return false;
				//已支付
				case "1": 
					data['status'] = 3; break;
				//已取消
				case "2":
					data['status'] = 0; break;
				//就餐
				case "3":
					data['status'] = 4; break;
				//评价
				case "4":
					data['content'] = this.content.trim();
					data['status'] = 5; 
					break;
				//已完成
				case "5":
					data['status'] = 0; break;
			}

			//移除当前列表数据
			this.removeOrder(id);

			proxy.orderChangeStatus(data).then(res => {
				console.log(res)
				this.submitStatus = false;
			})
		}
	},
	filters: {
		getDate(val) {
			let date = new Date(~~val * 1000);
			let year = date.getFullYear();
			let month = date.getMonth() + 1;
			let day = date.getDate();
			return `${year}-${month}-${day}`;
		}
	}
}
</script>

<style scoped>
	.tab {
		top:0;
	}
	.content {
		padding: 10px;
	}
</style>
