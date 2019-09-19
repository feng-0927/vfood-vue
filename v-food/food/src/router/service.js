import invoice from "@/components/invoice"
import tableware from "@/components/tableware"
import service from "@/components/service"

export default [{
    path: '/service',
    name: 'service',
    component: service,
    meta:{
        requireAuth: true //添加该字段，表示进入这个路由是需要登录的
    }
},{
	path: '/tableware',
	name: 'tableware',
	component: tableware,
	meta:{
        requireAuth: true //添加该字段，表示进入这个路由是需要登录的
    }
},{
	path: '/invoice',
	name: 'invoice',
	component: invoice,
	meta:{
        requireAuth: true //添加该字段，表示进入这个路由是需要登录的
    }
}]