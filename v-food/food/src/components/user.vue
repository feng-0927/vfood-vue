  <template>
  <div>
      <div class="w100 margin01rem userInfo">
        <div class="avatar">
          <el-upload
            class="avatar-uploader"
            action="http://localhost:8080/api/user.php?action=uploadAvatar"
            :data="{id: id}"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
            :before-upload="beforeAvatarUpload">
            <img class="imageUrl" v-if="imageUrl || user.avatar" :src="imageUrl == '' ? user.avatar : imageUrl">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload> 
        </div>
      </div>
      <ul class="inforList">
        <li>
          <router-link to="/other" class="isNext">
            <span><em><img src="/static/img/about4.png"></em>个人资料</span>
            <span></span>
          </router-link>
        </li>
        <li>
          <router-link to="/orderlist" class="isNext">
            <span><em><img src="/static/img/about3.png"></em>我的订单</span>
            <span></span>
          </router-link>
        </li>
        <li>
          <router-link to="/recharge" class="isNext">
            <span><em><img src="/static/img/about1.png"></em>余额充值</span>
            <span></span>
          </router-link>
        </li>
        <li>
          <router-link to="/coupon" class="isNext">
            <span><em><img style="height: 0.43rem;"  src="/static/img/about2.png"></em>我的优惠券</span>
            <span></span>
          </router-link>
        </li>
        <li>
          <a href="javascript:;" @click="out" class="isNext">
            <span><em><img style="height: 0.43rem;"  src="/static/img/about2.png"></em>退出</span>
            <span></span>
          </a>
        </li>
        
      </ul>
      <div style="height:1.2rem;"></div>
  </div>
</template>


<script>
  import proxy from "../proxy/index"
  export default {
    name:'user',
    created() {
      //切换导航
      this.$emit("isActive", false);
    },
    data(){
      return {
        user:this.$cookies.get("user"),
        imageUrl: '',
        id: this.$cookies.get("user").userid
      }
    },
    methods: {
      //文件上传成功
      handleAvatarSuccess(res, file) {
        this.imageUrl = URL.createObjectURL(file.raw);

        //重新设置cookie
        let id = this.id
        proxy.userInfo({id}).then(response => {
          if(response.result) {
            let user = {
              userid: id,
              username: response.data.username,
              avatar: response.data.avatar
            }
            this.$cookies.set("user",user);
            this.user = user
          }
        });
      },
      //文件上传之前
      beforeAvatarUpload(file) {
        const isJPG = file.type === 'image/jpeg';
        const isLt2M = file.size / 1024 / 1024 < 2;

        if (!isJPG) {
          this.$message.error('上传头像图片只能是 JPG 格式!');
        }
        if (!isLt2M) {
          this.$message.error('上传头像图片大小不能超过 2MB!');
        }

        return isJPG && isLt2M
      },
      out() {
        this.$cookies.remove("user");
        this.$alert("退出成功");
        this.$router.replace("/login");
      }
    }
  }
</script>

<style>
  .userInfo{
    width:100%;
    height:150px;
    background:url('../../static/img/aboutbanner.png') no-repeat;
    background-size:100%;
  }
  
  .avatar-uploader {
    position: relative;
    height: 100%;
  }
  .avatar-uploader .el-upload {
    border-radius: 100%;
    cursor: pointer;
    position: absolute;
    overflow: hidden;
    transform: translate(-50%, -50%);
    top: 50%;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 100px;
    height: 100px;
    line-height: 100px;
    text-align: center;
  }
  .avatar {
    width: 100px;
    height: 100%;
    display: block;
    margin: 0 auto;
    position: relative;
  }
  .imageUrl {
    border-radius: 100%;
    width: 100px;
    height: 100px;
  }
  
</style>