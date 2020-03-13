<template>
  <div class="personal-panel">
    <div class="personal-desc" :style="{'background':this.$store.state.app.themeColor}">
      <div class="avatar-container">
        <img class="avatar" :src="require('@/assets/user.png')"/>
      </div>
      <div class="name-role">
        <span class="sender">{{ user.name }} - {{ user.name == "admin" ? "超级管理员" : "普通用户" }}</span>
      </div>
      <div >
          <span >
            <li class="fa fa-clock-o"></li>
            {{ this.nowTime }}
          </span>
      </div>
    </div>
    <div class="main-operation">
        <span class="main-operation-item">
          <el-button size="small" icon="fa fa-male"> 个人中心</el-button>
        </span>
      <span class="main-operation-item">
          <el-button size="small" icon="fa fa-key"> 修改密码</el-button>
        </span>
    </div>
    <div class="personal-footer" @click="logout">
      <li class="fa fa-sign-out"></li>
      {{$t("common.logout")}}
    </div>
  </div>
</template>

<script>
  import Cookies from "js-cookie"

  export default {
    name: 'PersonalPanel',
    props: {
      user: {
        type: Object,
        default: {
          name: "",
          avatar: "@/assets/user.png",
          role: ""
        }
      }
    },
    data() {
      return {
        nowTime: ''
      }
    },
    methods: {
      // 退出登录
      logout: function () {
        this.$confirm("确认退出吗?", "提示", {
          type: "warning"
        })
          .then(() => {
            sessionStorage.removeItem("user")
            sessionStorage.removeItem("token")
            this.$router.push("/login")
            this.$api.login.logout().then((res) => {
            }).catch(function (res) {
            })
          })
          .catch(() => {
          })
      },
      // 删除cookie
      deleteCookie: function (name) {
        Cookies.remove(name)
      },
      currentTime() {
        setInterval(this.getTime, 500);
      },
      getTime:function(){
        let yy = new Date().getFullYear();
        let mm = new Date().getMonth()+1;
        let dd = new Date().getDate();
        let hh = new Date().getHours();
        let mf = new Date().getMinutes()<10 ? '0'+new Date().getMinutes() : new Date().getMinutes();
        let ss = new Date().getSeconds()<10 ? '0'+new Date().getSeconds() : new Date().getSeconds();
        this.nowTime = yy+'-'+mm+'-'+dd+' '+hh+':'+mf+':'+ss;
      },
    },
    mounted() {
      this.currentTime();
    }
  }
</script>

<style scoped>
  .personal-panel {
    font-size: 14px;
    width: 280px;
    text-align: center;
    border-color: rgba(180, 190, 190, 0.2);
    border-width: 1px;
    border-style: solid;
    background: rgba(182, 172, 172, 0.1);
    margin: -14px;
  }

  .personal-desc {
    padding: 15px;
    color: #fff;
  }

  .avatar {
    width: 80px;
    height: 80px;
    border-radius: 90px;
  }

  .name-role {
    font-size: 16px;
    padding: 5px;
  }

  .personal-relation {
    font-size: 16px;
    padding: 12px;
    margin-right: 1px;
    background: rgba(200, 209, 204, 0.3);
  }

  .relation-item {
    padding: 12px;
  }

  .relation-item:hover {
    cursor: pointer;
    color: rgb(19, 138, 156);
  }

  .main-operation {
    padding: 8px;
    margin-right: 1px;
    /* background: rgba(175, 182, 179, 0.3); */
    border-color: rgba(201, 206, 206, 0.2);
    border-top-width: 1px;
    border-top-style: solid;
  }

  .main-operation-item {
    margin: 15px;
  }

  .other-operation {
    padding: 15px;
    margin-right: 1px;
    text-align: left;
    border-color: rgba(180, 190, 190, 0.2);
    border-top-width: 1px;
    border-top-style: solid;
  }

  .other-operation-item {
    padding: 12px;
  }

  .other-operation-item:hover {
    cursor: pointer;
    background: #9e94941e;
    color: rgb(19, 138, 156);
  }

  .personal-footer {
    margin-right: 1px;
    font-size: 14px;
    text-align: center;
    padding-top: 10px;
    padding-bottom: 10px;
    border-color: rgba(180, 190, 190, 0.2);
    border-top-width: 1px;
    border-top-style: solid;
  }

  .personal-footer:hover {
    cursor: pointer;
    color: rgb(19, 138, 156);
    background: #b1a6a61e;
  }
</style>
