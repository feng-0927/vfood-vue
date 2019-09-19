<template>
    <nav :class="{'active':active}">
        <router-link v-for="(item,index) in nav" :to="item.path" :key="index" @click.native="toggleNav(index)">
            <img :src="item.active ? item.active_src : item.src">
            {{item.name}}
        </router-link>
    </nav>
</template>

<script>
export default {
    name: "footerComponent",
    props:[
        "active"
    ],
    data() {
        return {
            nav: [{
                path: '/',
                src: '/static/img/index1.png',
                active_src: '/static/img/index1-1.png',
                name: '点餐',
                active: true
            },{
                path: '/orderlist',
                src: '/static/img/index2.png',
                active_src: '/static/img/index2-1.png',
                name: '订单',
                active: false
            },{
                path: '/service',
                src: '/static/img/index3.png',
                active_src: '/static/img/index3-1.png',
                name: '服务',
                active: false
            },{
                path: '/user',
                src: '/static/img/index4.png',
                active_src: '/static/img/index4-1.png',
                name: '我的',
                active: false
            }]
        }
    },
    methods: {
        toggleNav(index) {
            for(let i = 0; i < this.nav.length; i++) {
                this.nav[i].active = false;
                if(i == index) {
                    this.nav[i].active = true;
                }
            }
        }
    }
}
</script>

<style scoped>
    .active{
        display: none;
    }
</style>