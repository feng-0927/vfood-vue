import orderAdd from '@/components/orderAdd'
export default [
  {
    path: '/orderAdd',
    name: 'orderAdd',
    component: orderAdd,
    meta: {
      requireAuth: true //添加该字段，表示进入这个路由是需要登录的
    }
  }
]
