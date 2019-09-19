<template>
  <div>
    <div class="topbox">
      <div class="topmain">
        <router-link to="/login">
          <img src="/static/img/back.png">
        </router-link>
        <h1>免费注册</h1>
      </div>
    </div>
    <div class="conbox">
      <div class="conmain register">
        <h2>温馨提示：以下所有为必填项</h2>
          <form method="post" @submit.prevent="register()">
            <div>
              <input type="text" placeholder="请输入用户名" name="username" required v-model="user.username" />
            </div>
            <div>
              <input type="password" placeholder="请输入您的密码" name="password" required v-model="user.password" />
            </div>
            <div class="win_yzm imgcode">
              <slide-verify :l="42"
                :r="10"
                :w="310"
                :h="155"
                slider-text="向右滑动"
                @success="onSuccess"
                @fail="onFail"
                @refresh="onRefresh"
                ></slide-verify>
            </div>
            <p>
              <a href="register.html#">《网站服务协议》</a>
            </p>
            <button>同意以上协议并注册</button>
          </form>
      </div>
    </div>
  </div>
</template>

<script>
  import proxy from '../proxy/index'
  export default {
    name:"register",
    data()
    {
      return {
        user:{
          username:'',
          password:''
        },
        imgcode:false
      }
    },
    methods:{
      onSuccess(){
          this.imgcode = true
      },
      onFail(){
          this.imgcode = false
      },
      onRefresh(){
          this.imgcode = false
      },
      register()
      {
        if(!this.imgcode)
        {
          alert('请滑动验证码');
          return false;
        }
        
        var data = {username:this.user.username,password:this.user.password};

        //发送请求
        proxy.userRegister(data).then((response)=>{
          if(!response.result)
          {
            this.$alert(response.msg)
          }else{
            this.$router.push('/login');
          }
        });
      }
    }
  }
</script>

<style scoped>
  @import '../../static/css/register.css';
  .imgcode div{
    margin:0 auto;
  }
</style>