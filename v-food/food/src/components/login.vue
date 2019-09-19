<template>
  <div>
    <div class="topbox">
      <div class="topmain">
        <h1>登录</h1>
      </div>
    </div>
    <div class="conbox">
      <div class="conmain register">
        <h2>温馨提示：用户登录</h2>
          <form method="post" @submit.prevent="login()">
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
            <p style="text-align:center;">
              <router-link to="/register">免费注册</router-link>
            </p>
            <button>登录</button>
          </form>
      </div>
    </div>
  </div>
</template>

<script>
  import proxy from '../proxy/index'
  export default {
    name:"register",
    created() {
      this.$emit("isActive", true)
    },
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
      login()
      {
        if(!this.imgcode)
        {
          alert('请滑动验证码');
          return false;
        }
        
        var data = {username:this.user.username,password:this.user.password};

        //发送请求
        proxy.userLogin(data).then((response)=>{
          if(!response.result)
          {
            this.$alert(response.msg);
          }else{
            let user = {
              userid:response.data.id,
              username:response.data.username,
              avatar:response.data.avatar
            }
            this.$cookies.set("user",user);
            
            this.$router.push('/user');
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