import home from "@/components/home"
import map from "@/components/map"
import search from "@/components/search"
import scancode from "@/components/scanCode"

export default [
    {
        path: '/',
        name: 'home',
        component: home,
        meta:{
            requireAuth: true //添加该字段，表示进入这个路由是需要登录的
        }
    },
    //地图
    {
	    path: '/map',
	    name: 'map',
	    component: map,
	},
	//搜索
	{
		path: '/search',
		name: 'search',
		component: search,
		meta:{
            requireAuth: true //添加该字段，表示进入这个路由是需要登录的
        }
	},
    //扫码
    {
        path: '/scancode',
        name: 'scancode',
        component: scancode
    }
]