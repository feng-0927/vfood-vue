import orderlist from "@/components/orderlist"
export default {
    path: '/orderlist',
    name: 'orderlist',
    component: orderlist,
    meta:{
        requireAuth: true //添加该字段，表示进入这个路由是需要登录的
    }
}