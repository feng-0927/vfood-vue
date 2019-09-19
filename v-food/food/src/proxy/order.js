import {request} from '../services/request'

export default {
    //获取订单购物车数据
    orderCart(params = {})
    {
        return request({
            method:"post",
            url:"/api/order.php?action=ordercart",
            params: params
        })
    },
    //添加订单
    orderAdd(params = {})
    {
        return request({
            method:"post",
            url: "/api/order.php?action=orderadd",
            params: params
        })
    },
    //0 未支付 1 已支付 2 已取消 3 就餐 4 评价 5 已完成
    orderlist(params = {}) {
        return request({
            method: "get",
            url: `/api/order.php?action=orderlist&status=${params.status}&userid=${params.userid}` 
        })
    },
    orderChangeStatus(params = {}) {
        return request({
            method: "post",
            url: "/api/order.php?action=changestatus",
            params
        })
    },
    orderSave(params = {})
    {
        return request({
            method:"post",
            url: "/api/order.php?action=ordersave",
            params: params
        })
    },
    orderOut(params = {}) {
        return request({
            method: "post",
            url: "/api/order.php?action=orderout",
            params
        })
    }
}