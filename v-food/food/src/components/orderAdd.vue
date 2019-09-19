<template>
 <div>
    <div class="pay-order-header">
			<ul>
				<li>订单详情</li>
			</ul>
		</div>
    <div class="invoice" id="order-settlement">
      <span>
        <input type="radio" v-model="order.ordertype" name="ordertype" value="0"> 即时 
      </span>
      <span>
        <input type="radio" v-model="order.ordertype" name="ordertype" value="1">预约时间
        <input type="date" id="endTime" v-model="order.ordertime" class="kbtn" placeholder="预约时间" />
      </span>
    </div>
    <table width="100%" class="bg-fff order-det-cont" >
      <tbody>
        <tr style="border-bottom: solid 8px #f1f1f1;">
          <td align="left" class="padl3">就餐地点</td>
          <td align="right" width="50%">合肥南站店</td>	
        </tr>
        <tr>
          <td align="left" class="padl3" style="color:#999">餐品详情</td>
          <td align="right" width="50%" style="color:#999">更多<img style="width:.3rem;" src="/static/img/jtx1.png" /></td>	
        </tr>
        <tr v-for="item in cart" v-bind:key="item.id">
          <td align="left" class="padl3">{{item.name}}</td>
          <td align="left" width="50%">×
            <em>{{item.foodnum}}</em>
            <span :style="{float:'right',lineHeight:'20px',marginTop:'10px'}">￥{{item.price}}</span>
          </td>	
        </tr>
        <tr>
          <td align="left" colspan="1" class="padl3">餐品总额</td>
          <td align="right" class="padr3">￥<em>{{order.foodPrice}}</em></td>
        </tr>		
        <tr>
          <td align="left" colspan="1" class="padl3">优惠券</td>
          <td align="right" class="padl3">
            <select class="coupon" @change="changeCoupon" v-model="coupon">
              <option v-for="item in coupons" :value="item.id">￥{{item.price}}</option>
            </select>
          </td>
        </tr>
        <tr style="border-top: solid 8px #f1f1f1;">
          <td align="left" colspan="1" class="padl3">实付金额:</td>
          <td align="right" class="padr3">
            <a class="padding-right23 colorf00">￥{{price}}</a>
          </td>
        </tr>			
      </tbody>
    </table>
    <div style="height:1rem;"></div>
    <div class="order-set-paybutton">
      <router-link to="/" class="paybutton-left fl" style="width: 40%;text-align: center;">返回</router-link>
      <div class="paybutton-right fr" style="width: 60%;text-align: center;"><a @click.prevent="orderAdd">确认订单</a></div>
      <div class="clearfix"></div>
    </div>
  </div>
</template>

<script>
 import proxy from '../proxy/index'
 export default {
     name: "orderAdd",
     //初始化会自动调用created()函数
     created() {
      this.$emit("isActive", true);

      let userid = this.$cookies.get("user").userid

      //请求购物车
      proxy.orderCart({userid}).then(response => {
        this.cart = response.data.cart;
        this.order.price = response.data.cartBack.price;
        this.order.foodPrice = response.data.cartBack.price;
      })

      //请求未使用的优惠券
      proxy.coupon({id: userid}).then(response => {
        if(response.result) {
          let coupons = response.data.filter(coupon => coupon.status == 1);
          //默认使用第一张优惠券
          if(coupons.length > 0) {
            this.coupon = coupons[0].id
          }
          this.coupons = coupons
        }
      });
     },
     computed: {
        price() {
          let coupon = this.coupons.find(c => c.id == this.coupon)
          if(coupon) {
            return this.order.price = this.order.foodPrice - coupon.price
          }
          return this.order.price
        }
     },
     data() {
      return {
        cart:[],
        order:{
          ordertype: 0,
          ordertime: null,
          price: 0,
          content: ""
        },
        coupons: [],
        coupon: 0
      }
     },
     methods:{
      orderAdd() {
        let data = {
          order: this.order,
          cart: this.cart,
          coupon: this.coupon,
          userid: this.$cookies.get('user').userid
        };
        proxy.orderAdd(data).then(response => {
          if(!response.result) {
            this.$alert(response.msg);
          }else{
            this.$alert(response.msg).then(res=> this.$router.push('/user'));
          }
        });
      },
      //使用优惠券
      changeCoupon() {

      }
     }
 }
</script>

<style>
    #endTime{
        width:55%;
    }
    select.coupon  {
      color: red;
    }
</style>