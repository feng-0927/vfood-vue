<template>
	<div id="tableware">
		<div class="tableware">
			<form method="post">
				<!--座位号-->
				<div class="seat-number">
					<h1>我的座位号：</h1>
					<input type="text" v-model="seatnum" placeholder="请输入座位号" />
				</div>

				<ul class="seat-list-choose">
					<li class="pretty" v-for="pretty in prettys">	
						<label>
							<i :class="{ addimg: pretty.addimg }"></i>
							<input type="checkbox" :value="pretty.value" @click="toggle(pretty.value)" />{{pretty.label}}
						</label>
					</li>
				</ul>
				<button type="button" class="button-true" @click="submit">确定</button>
			</form>
		</div>
	</div>
</template>

<script>
import proxy from "../proxy/index"
export default {
	name: "tableware",
	created() {
		this.$emit("isActive", true)
	},
	data() {
		return {
			prettys: [{
				label: "碗",
				value: "1",
				addimg: true
			},{
				label: "筷子",
				value: "2",
				addimg: false
			},{
				label: "勺子",
				value: "3",
				addimg: false
			},{
				label: "牙签",
				value: "4",
				addimg: false
			},{
				label: "餐巾纸",
				value: "5",
				addimg: false
			}],
			seatnum: ''
		}
	},
	methods: {
		toggle(value) {
			for(let i = 0; i < this.prettys.length; i++) {
				if(this.prettys[i].value == value) {
					this.prettys[i].addimg = !this.prettys[i].addimg
				}
			}
		},
		//通知后台要餐具
		submit() {
			let prettys = this.prettys.filter(pre => pre.addimg)
			let prettysStr = "";
			for(let i = 0; i < prettys.length; i++) {
				if(i == prettys.length -1) {
					prettysStr += prettys[i].value
				}else {
					prettysStr += prettys[i].value + ","
				}
			}

			let userid = this.$cookies.get("user").userid;
			//发送ajax
			let data = {
				userid,
				prettys: prettysStr,
				seatnum: this.seatnum
			}
			proxy.tableware(data).then(res => {
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
	input{background-color:transparent; border-color:transparent;-webkit-appearance: none;}
	.pretty input{border:solid 1px #889260;width: .36rem;height: .36rem;margin-right:8px;}
</style>