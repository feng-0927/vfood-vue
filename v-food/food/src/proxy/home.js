import {request} from '../services/request'

export default {
    //banner部分
    homeBanner(params = {})
    {
        return request({
            method: "post",
            url: "/api/home.php?action=banner",
            params
        })
    },
    //hot
    hotFood(params = {}) {
        return request({
            method: "post",
            url: "/api/home.php?action=hotfood",
            params
        })
    },
    //分类
    foodCate(params = {}) {
        return request({
            method: "post",
            url: "/api/home.php?action=foodcate",
            params
        })
    },
    //指定分类
    foodList(params = {}) {
        return request({
            method: "post",
            url: "/api/home.php?action=foodlist",
            params
        })
    },
    //更新购物车
    addCart(params = {}) {
        return request({
            method: "post",
            url: "/api/home.php?action=addcart",
            params
        })
    },
    //获取最新的购物车数据
    countCart(params = {}) {
        return request({
            method: "post",
            url: "/api/home.php?action=countcart",
            params
        })
    },
    delCart(params = {}) {
        return request({
            method: "post",
            url: "/api/home.php?action=delcart",
            params
        })
    }
}