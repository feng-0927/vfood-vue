<template>
  <div>
    <!--header-->
		<header >
			<router-link to="/scanCode" class="location" id="location" data-title-type="native">
				<img src="/static/img/sys.png" />
			</router-link>

			<div class="top-sch-box flex-col logoIcon">
				<a>
					<aside class="index-searchArea">
						<input class="input-text-searchArea" v-model="searchVal" @keyup.enter="search" type="text" placeholder="请输入餐品" />
					</aside>
				</a>
			</div>
			<router-link class="rt_searchIcon" to="/map"><img style="width:70%;" src="/static/img/mapIcon.png"></router-link>
		</header>

		<!--banner-->
		<div id="slide" class="public-banner">
			<swiper :options="swiperOption">
        <!-- slides -->
        <swiper-slide v-for="item in bannerFood" v-bind:key="item.id">
          <img :src="item.thumb" />
        </swiper-slide>

      </swiper>
		</div>
		
    <!--今日促销-->	
    <div class="swiper-container foodhot">
      <swiper :options="swiperOption2">
        <!-- slides -->
        <swiper-slide v-for="(item) in hotFood" v-bind:key="item.id">
          <div class="menu-img">
              <img :src="item.thumb" />
          </div>
          <div class="menu-txt">
            <h4>{{item.name}}</h4>
            <p class="list2">
              <b>￥{{item.price}}</b>
              <div class="btn">  
                <button class="minus" @click="minus(item.id)">-</button>  
                <i>{{item.num}}</i>  
                <button class="add" @click="add(item.id)">+</button>  
              </div> 
            </p>
          </div>
        </swiper-slide>
        <!-- Optional controls -->
        <div class="swiper-pagination" slot="pagination"></div>
      </swiper>
    </div>
      
    <!--分类商品-->
    <div class="main">
      <el-tabs v-model="activeName" :tab-position="tabPosition" @tab-click="handleClick">
        <el-tab-pane v-for="(item,key) in foodCate" :label="item.name" :name="item.name" v-bind:key="item.id">
          <div class="swiper-container foodcate">
            <swiper :options="swiperOption3">
              <!-- slides -->
              <swiper-slide v-for="item in foodList" v-bind:key="item.id">
                <div class="menu-img">
                    <img :src="item.thumb" />
                </div>
                <div class="menu-txt">
                  <h4>{{item.name}}</h4>
                  <p class="list2">
                    <b>￥{{item.price}}</b>
                    <div class="btn">  
                      <button class="minus" @click="minus(item.id)">-</button>  
                      <i>{{item.num ? item.num : 0}}</i>  
                      <button class="add" @click="add(item.id)">+</button>  
                    </div> 
                  </p>
                </div>
              </swiper-slide>
              <!-- Optional controls -->
              <div class="swiper-pagination" slot="pagination"></div>
            </swiper>
          </div>
        </el-tab-pane>
      </el-tabs>
    </div>

    <div class="footer">  
      <div class="left">
        <span id="cartN">
          <img src="/static/img/shop_03.png"/>
          <span id="totalcountshow">{{cart.count ? cart.count : 0}}</span>
          <span class="totalpriceshow">￥<em id="totalpriceshow">{{cart.price ? cart.price : 0}}</em></span>
        </span>				
        </div>  
      <div class="right">  
        <router-link to="/orderAdd" id="btnselect" class="xhlbtn">去结算</router-link>
      </div>   
    </div>
    <div style="height:1.2rem;"></div>
  </div>
</template>

<script>
//轮播图
import 'swiper/dist/css/swiper.css'
import { swiper, swiperSlide } from 'vue-awesome-swiper'
import proxy from '../proxy/index'

export default {
  components:{
    swiper,
    swiperSlide
  },
  name: 'home',
  created() {
    //切换导航
    this.$emit("isActive",false);

    let userid = this.userid = this.$cookies.get("user").userid
    let data = { userid }

    //轮播数据
    proxy.homeBanner().then(response => this.bannerFood = response.data);
    //热销产品
    proxy.hotFood(data).then(response => this.hotFood = response.data);

    //请求分类食品
    proxy.foodCate(data).then(response => {
      this.foodCate = response.data.foodcate;
      this.foodList = response.data.foodlist;
      this.activeName = this.foodCate[0].name;
    });

    //更新购物车方法
    this.updateCart();
  },
  data () {
    return {
      activeName:"first",
      tabPosition: 'left',
      swiperOption:{
        autoplay : 1000,
      },
      swiperOption2:{
        autoplay : 5000,
        slidesPerView: 2,
        spaceBetween: 30,
        pagination: {
          el: '.swiper-pagination',
          clickable: true
        }
      },
      swiperOption3:{
        direction : 'vertical',
        slidesPerView: 3,
        spaceBetween: 30,
        height:200,
        pagination: {
          el: '.swiper-pagination',
          clickable: true
        }
      },
      userid: 0,
      //轮播
      bannerFood:[],
      //热销
      hotFood:[],
      //食品分类
      foodCate:[],
      //食品列表
      foodList:[],
      //购物车
      cart:{},
      searchVal: ''
    }
  },
  methods: {
    handleClick(tab, event) {
      //获取标签页索引
      var index = tab.index ? tab.index : 0;

      //分类id
      var cateid = this.foodCate[index] ? this.foodCate[index].id : 0;
      //用户id
      let {userid} = this;

      //切换分类商品
      proxy.foodList({cateid, userid}).then(response => this.foodList = response.data);
    },
    //添加购物车 => 成功 => 更新购物车数据
    addCart(data) {
      proxy.addCart(data).then(response => response.result && this.updateCart());
    },
    delCart(data) {
      proxy.delCart(data).then(response => response.result && this.updateCart());
    },
    //更新购物车
    updateCart() {
      //获取用户id
      let {userid} = this;

      //更新数据
      proxy.countCart({userid}).then(cart => {
        console.log(cart)
        this.cart = cart.data
      });
    },
    //产品数量减少
    minusFood(foodlist, foodid) {
      let {userid} = this;

      let food = foodlist.find(item => item.id == foodid)

      //商品可能不存在
      if(typeof food == "undefined") {
        return false; 
      }

      let data = {
        userid,
        foodid
      }

      if(food.num > 0) {
        food.num--;
        data['foodnum'] = food.num;
      }

      if(food.num <= 0) {
        //取消产品在购物车的存在
        return this.delCart(data);
      }

      this.addCart(data);
    },
    //数量减少
    minus(foodid) {
      this.minusFood(this.hotFood, foodid)
      this.minusFood(this.foodList, foodid)
    },
    //数量的增加
    add(foodid) {
      let {userid} = this;

      //找到商品
      let food = this.hotFood.find(item => item.id == foodid)

      //没找到就找下面的
      if(!food) {
        food = this.foodList.find(item => item.id == foodid)
      }

      if(food.num > 0) {
        food.num++;
      }else {
        food.num = 1;
      }

      let data = {
        userid,
        foodid,
        foodnum: food.num
      }
      this.addCart(data);
    },
    //搜索
    search() { 
      this.$router.push({ path: '/search', query: { query: this.searchVal }});
    }
  }
}
</script>

<style scoped>
.menu-img{
  width:100%;
}

.menu-img img{
  width:100%;
  height:100%;
}

.foodhot .swiper-slide{
  margin:10px auto;
  margin-left:10px!important;
  margin-right:10px!important;
}

.foodhot .swiper-slide:nth-child(even)
{
  margin-left:0px!important;
}

.menu-txt h4{
  text-align:left;
}

.menu-txt .list2{
  color:red;
}

.menu-txt .btn{
    background-color: transparent;
    position: absolute;
    right: 0;
    bottom: 3%;
    cursor: pointer;
}

.menu-txt .btn button{
  background-color: #26C400;
  color: #fff;
  font-size: .3rem;
  width: 0.459rem;
  height: 0.459rem;
  border-radius: .5rem;
}

/* 分类 */
.foodcate{
  height:300px;
}
.foodcate .menu-img{
  width:35%;
  float:left;
}

.foodcate .menu-txt{
  float:left;
  margin-left:10px;
  width:60%;
}

.foodcate .menu-txt h4{
  margin:0;
  font-size:16px;
  margin-bottom:10px;
}

.foodcate .menu-txt .list2{
    color:red;
}

.foodcate .menu-txt .btn{
  background-color: transparent;
  position: absolute;
  right: 1%;
  top: 7%;
  cursor: pointer;
}
</style>