<template>
  <div>
    <!--header-->
		<header >
			<router-link to="/" class="location" id="location" data-title-type="native">
				<img src="/static/img/back.png" />
			</router-link >

			<div class="top-sch-box flex-col logoIcon">
				<a>
					<aside class="index-searchArea">
						<input class="input-text-searchArea" v-model="searchVal" type="text" @keyup.enter="search" placeholder="请输入餐品" />
					</aside>
				</a>
			</div>
		</header>

    <!--分类商品-->
    <div class="main">
      <el-tabs v-model="activeName" :tab-position="tabPosition" @tab-click="handleClick">
        <el-tab-pane v-for="(item,key) in foodCate" :label="item.name" :name="item.name" v-bind:key="item.id">
          <div class="swiper-container foodcate">
            <swiper :options="swiperOption3">
              <!-- slides -->
              <swiper-slide v-for="item in filterFoodList" v-bind:key="item.id">
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
  name: 'search',
  created(){
    this.$emit("isActive",false);

    let userid = this.$cookies.get('user').userid ? this.$cookies.get('user').userid : 0;

    let data = {
      userid:userid
    }

    proxy.foodCate(data).then((response) => {
      this.foodCate = response.data.foodcate;
      this.foodList = response.data.foodlist;
      this.activeName = this.foodCate[0].name;
    });

    //更新购物车方法
    this.updateCart();
  },
  computed: {
    filterFoodList() {
      let query = this.$route.query.query && this.$route.query.query != '' ? this.$route.query.query : false;

      //模糊搜索
      if(query) {
        return this.foodList.filter(food => food.name.indexOf(query) != -1)
      }

      return this.foodList;
    }
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
        // autoHeight:true,
        height:200,
        pagination: {
          el: '.swiper-pagination',
          clickable: true
        }
      },
      foodCate:[],
      foodList:[],
      cart:{},
      searchVal: ''
    }
  },
  methods: {
    handleClick(tab, event) {
      var index = tab.index ? tab.index : 0;
      var cateid = this.foodCate[index] ? this.foodCate[index].id : 0;
      let userid = this.$cookies.get('user').userid ? this.$cookies.get('user').userid : 0;
      proxy.foodList({cateid:cateid,userid:userid}).then(response => {
        this.foodList = response.data;
      });
    },
    addCart(data) {
      //添加购物车
      proxy.addCart(data).then((response)=>{
        if(response.result)
        {
            this.updateCart();
        }
      });
    },
    updateCart() {
      let data = {userid:this.$cookies.get('user').userid};
      //更新购物车
      proxy.countCart(data).then(cart => {
        this.cart = cart.data;
      });
    },
    minus(foodid) {
      this.foodList.forEach((item,key)=>{
        if(item.id == foodid)
        {
          if(this.foodList[key].num > 0)
          {
            this.foodList[key].num--;
          }else{
            this.foodList[key].num = 0;
          }

          let data = {
            userid:this.$cookies.get("user").userid,
            foodid:foodid,
            foodnum:this.foodList[key].num
          }
          this.addCart(data);
        }
      });
      

    },
    add(foodid) {
      this.foodList.forEach((item,key)=>{
        if(item.id == foodid)
        {
          if(this.foodList[key].num)
          {
            this.foodList[key].num++;
          }else{
            this.foodList[key].num = 1;
          }

          let data = {
            userid:this.$cookies.get("user").userid,
            foodid:foodid,
            foodnum:this.foodList[key].num
          }

          if(data.foodnum > 0) {
            this.addCart(data);
          }
        }
      });
    },
    search() { 
      this.$router.push({ path: '/search', query: { query: this.searchVal }}).catch(err => console.log(err));
    }
  }
}
</script>

<style scoped>
.swiper-container {
  top: 10px;
}
.main{
  height:600px;
  margin-top:50px;
}

.main div{
  height:100%;
}
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
    right: 1%;
    top: 84%;
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