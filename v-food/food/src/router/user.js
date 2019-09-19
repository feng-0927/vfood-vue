import user from "@/components/user"
import other from "@/components/other"
import recharge from "@/components/recharge"
import coupon from "@/components/coupon"
import couponadd from "@/components/couponadd"
import register from "@/components/register"
import login from '@/components/login'

export default [
    {
        path: '/user',
        name: 'user',
        component: user,
        meta: {
            requireAuth: true //添加改字段，表示进入这个路由是需要登录的
        }
    },
    {
        path: '/other',
        name: 'other',
        component: other,
        meta: {
            requireAuth: true //添加改字段，表示进入这个路由是需要登录的
        }
    },
    {
        path: '/recharge',
        name: 'recharge',
        component: recharge,
        meta: {
            requireAuth: true
        }
    },
    {
        path: '/coupon',
        name: 'coupon',
        component: coupon,
        meta: {
            requireAuth: true
        }
    },
    {
        path: '/couponadd',
        name: 'couponadd',
        component: couponadd,
        meta: {
            requireAuth: true
        }
    },
    {
        path: '/register',
        name: 'register',
        component: register
    },
    {
        path: '/login',
        name: 'login',
        component: login
    }
]