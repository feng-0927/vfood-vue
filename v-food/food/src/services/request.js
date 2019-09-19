import axios from 'axios';//基于promise用于浏览器和node.js的http客户端
import QS from 'qs';  //字符串序列化的一个库

//自动切换环境
// if (process.env.NODE_ENV == 'development'){
//     axios.defaults.baseURL = '/api';
// } else if (process.env.NODE_ENV == 'debug'){
//     axios.defaults.baseURL = '/api';
// } else if (process.env.NODE_ENV == 'production') { 
//     axios.defaults.baseURL = 'http://***********/';
// }
//设置超时时间
axios.defaults.timeout = 50000;
// post请求头
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=UTF-8';

//对外接口
export function request({ method, url, params }) {
  if (method == 'get') {
    return get(url, params);
  } else if (method == 'post') {
    return post(url, params);
  }
}

// 封装get方法
function get(url, params) {
  return new Promise((resolve, reject) => {
    axios.get(url, params).then(res => {
      resolve(res.data);
    }).catch(err => {
      reject(false);
    })
  });

}

// 封装post方法      
function post(url, params) {
  return new Promise((resolve, reject) => {
    axios.post(url, QS.stringify(params)).then(res => {
      resolve(res.data);
    }).catch(err => {
      reject(false);
    })

  });
}

//请求拦截(请求发出前处理请求)
// axios.interceptors.request.use(
//     confirm => {
//         //将token放入header，这里用Vuex把token放在store中，取出
//        const token = store.state.token;
//        token && (config.headers.Authorization = token);  
//        return config; 
//     },
//     error =>{
//         return Promise.error(error); 
//     }

// )

// 响应拦截器（处理响应数据）
// axios.interceptors.response.use( 
//     response => {
//         if(response.state === 200){
//             return Promise.resolve(response);
//         }else{
//             //这个地方可以由后台编辑状态码区分不同情况，做不同的逻辑处理
//             return Promise.reject(response);
//         }
//     },
//     error => {
//         // //请求失败，这个地方可以根据error.response.status统一处理一些界面逻辑，比如status为401未登录,可以进行重定向
//         // router.replace({      
//         //     path: '/login',      
//         //     query: { redirect: router.currentRoute.fullPath } 
//         //    });
//         return Promise.reject(error.response);  

//     }
// )
