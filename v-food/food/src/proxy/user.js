import {request} from "../services/request";

export default {
  //注册请求
  userRegister(params) {
    return request({
      method:"post",
      url:"/api/user.php?action=register",
      params: params
    })
  },
  //登录请求
  userLogin(params) {
    return request({
      method:"post",
      url:"/api/user.php?action=login",
      params:params
    })
  },
  //充值金额
  recharge(params) {
    return request({
      method: "post",
      url: "/api/user.php?action=recharge",
      params: params
    })
  },
  //获取个人资料
  getInfo(params) {
    return request({
      method: "get",
      url: `/api/user.php?action=info&id=${params}`
    })
  },
  //个人资料提交
  info(params) {
    return request({
      method: "post",
      url: "/api/user.php?action=info",
      params: params
    })
  },
  //发送邮箱
  sendEmailCheck(params) {
    return request({
      method: "post",
      url: "/api/user.php?action=sendEmailCheck",
      params
    })
  },
  //优惠卷列表
  coupon(params) {
    return request({
      method: "get",
      url: '/api/user.php?action=coupon&id=' + params.id
    })
  },
  //添加优惠卷
  couponadd(params) {
    return request({
      method: "post",
      url: '/api/user.php?action=couponadd',
      params
    });
  },
  userInfo(params) {
    return request({
      method: "get",
      url: '/api/user.php?action=userinfo&id=' + params.id
    });
  }
}