import Vue from 'vue'
import Router from 'vue-router'

//把分组的路由引入进来
import HomeRouter from './home'
import UserRouter from './user'
import OrdersRouter from './orderlist'
import OrderRouter from './order'
import ServiceRouter from './service'

Vue.use(Router)

export default new Router({
  routes: [
    ...HomeRouter,
    ...UserRouter,
    ...OrderRouter,
    ...ServiceRouter,
    OrdersRouter
  ]
})
