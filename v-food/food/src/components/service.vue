<template>
  <div>
    <!--banner-->
	<div id="slide" class="public-banner" style="margin: 0;">
		<swiper :options="swiperOption">
        	<!-- slides -->
	        <swiper-slide v-for="item in bannerFood" v-bind:key="item.id">
	          <img :src="item.thumb" />
	        </swiper-slide>

		</swiper>
	</div>

    <ul class="serviceList clearfix">
      <li>
        <router-link to="/tableware">
          <img src="/static/img/fuwu (2).png" />
          <p>要餐具</p>
        </router-link>				
      </li>
      <li>
        <router-link to="/invoice">
          <img src="/static/img/fuwu (5).png" />
          <p>发票</p>
        </router-link>				
      </li>	
      <li>
        <router-link to="/">
          <img src="/static/img/fuwu (6).png" />
          <p>点餐</p>
        </router-link>				
      </li>	
    </ul>
  </div>
</template>

<script>
import 'swiper/dist/css/swiper.css'
import { swiper, swiperSlide } from 'vue-awesome-swiper'
import proxy from '../proxy/index'

export default {
  components:{
    swiper,
    swiperSlide
  },
  name: 'services',
  created(){
    this.$emit("isActive",false);

    let userid = this.$cookies.get('user').userid ? this.$cookies.get('user').userid : 0;

    let data = {
      userid:userid
    }

    proxy.homeBanner().then((response) => {
      this.bannerFood = response.data;
    });

    
  },
  data () {
    return {
      swiperOption:{
        autoplay : 1000,
      },
      bannerFood:[],
    }
  },
}
</script>