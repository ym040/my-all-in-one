<template>
  <div class="manager-container shinchan-layout">
    <!--  头部  -->
    <div class="manager-header shinchan-header">
      <div class="manager-header-left">
        <div class="title">实习管理平台</div>
      </div>

      <div class="manager-header-center">
        <el-breadcrumb separator-class="el-icon-arrow-right" class="shinchan-breadcrumb">
          <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
          <el-breadcrumb-item :to="{ path: $route.path }">{{ $route.meta.name }}</el-breadcrumb-item>
        </el-breadcrumb>
      </div>

      <div class="manager-header-right">
        <el-dropdown placement="bottom">
          <div class="avatar">
            <img :src="user.avatar || 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'" class="user-avatar" />
            <div class="user-name">{{ user.name ||  '管理员' }}</div>
          </div>
          <el-dropdown-menu slot="dropdown" class="shinchan-dropdown">
            <el-dropdown-item @click.native="goToPerson">
              <i class="el-icon-user dropdown-icon"></i>
              个人信息
            </el-dropdown-item>
            <el-dropdown-item @click.native="$router.push('/password')">
              <i class="el-icon-lock dropdown-icon"></i>
              修改密码
            </el-dropdown-item>
            <el-dropdown-item @click.native="logout">
              <i class="el-icon-switch-button dropdown-icon"></i>
              退出登录
            </el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </div>

    <!--  主体  -->
    <div class="manager-main">
      <!--  侧边栏  -->
      <div class="manager-main-left shinchan-sidebar">
        <el-menu
          router
          style="border: none"
          :default-active="$route.path"
          class="shinchan-menu"
          background-color="#FFE4E1"
          text-color="#8B4513"
          active-text-color="#FF4500"
        >
          <el-menu-item index="/home" class="shinchan-menu-item">
            <i class="el-icon-s-home menu-icon"></i>
            <span slot="title">系统首页</span>
          </el-menu-item>
          <el-submenu index="info" class="shinchan-submenu">
            <template slot="title">
              <i class="el-icon-menu menu-icon"></i>
              <span>信息管理</span>
            </template>
            <el-menu-item index="/notice" v-if="user.role === 'ADMIN'" class="shinchan-menu-item">
              <i class="el-icon-message menu-icon"></i>
              公告信息
            </el-menu-item>
            <el-menu-item index="/workPlan" v-if="user.role === 'ADMIN'" class="shinchan-menu-item">
              <i class="el-icon-date menu-icon"></i>
              实习安排信息
            </el-menu-item>
            <el-menu-item index="/job" class="shinchan-menu-item">
              <i class="el-icon-s-custom menu-icon"></i>
              岗位信息
            </el-menu-item>
            <el-menu-item index="/resume" v-if="user.role === 'ADMIN'" class="shinchan-menu-item">
              <i class="el-icon-document menu-icon"></i>
              简历信息
            </el-menu-item>
            <el-menu-item index="/MyResume" v-if="user.role === 'STUDENT'" class="shinchan-menu-item">
              <i class="el-icon-user menu-icon"></i>
              我的简历
            </el-menu-item>
          </el-submenu>
          <el-submenu index="administration" v-if="user.role === 'ADMIN' || user.role === 'TEACHER'" class="shinchan-submenu">
            <template slot="title">
              <i class="el-icon-s-management menu-icon"></i>
              <span>行政管理</span>
            </template>
            <el-menu-item index="/college" class="shinchan-menu-item">
              <i class="el-icon-office-building menu-icon"></i>
              学院信息
            </el-menu-item>
            <el-menu-item index="/speciality" class="shinchan-menu-item">
              <i class="el-icon-collection menu-icon"></i>
              专业信息
            </el-menu-item>
            <el-menu-item index="/classes" class="shinchan-menu-item">
              <i class="el-icon-s-custom menu-icon"></i>
              班级信息
            </el-menu-item>
          </el-submenu>
          <el-submenu index="practice" class="shinchan-submenu">
            <template slot="title">
              <i class="el-icon-s-promotion menu-icon"></i>
              <span>实习管理</span>
            </template>
            <el-menu-item index="/apply" class="shinchan-menu-item">
              <i class="el-icon-edit menu-icon"></i>
              实习申请
            </el-menu-item>
            <el-menu-item index="/task" class="shinchan-menu-item">
              <i class="el-icon-s-operation menu-icon"></i>
              实习任务
            </el-menu-item>
          </el-submenu>
          <el-submenu index="user" v-if="user.role === 'ADMIN'" class="shinchan-submenu">
            <template slot="title">
              <i class="el-icon-user-solid menu-icon"></i>
              <span>用户管理</span>
            </template>
            <el-menu-item index="/admin" class="shinchan-menu-item">
              <i class="el-icon-s-custom menu-icon"></i>
              管理员信息
            </el-menu-item>
            <el-menu-item index="/teacher" class="shinchan-menu-item">
              <i class="el-icon-s-custom menu-icon"></i>
              教师信息
            </el-menu-item>
            <el-menu-item index="/student" class="shinchan-menu-item">
              <i class="el-icon-user menu-icon"></i>
              学生信息
            </el-menu-item>
            <el-menu-item index="/enterprise" class="shinchan-menu-item">
              <i class="el-icon-s-cooperation menu-icon"></i>
              企业信息
            </el-menu-item>
          </el-submenu>
        </el-menu>
      </div>

      <!--  数据表格  -->
      <div class="manager-main-right">
        <router-view @update:user="updateUser" />
      </div>
    </div>

  </div>
</template>

<script>
export default {
  name: "Manager",
  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
    }
  },
  created() {
    if (!this.user.id) {
      this.$router.push('/login')
    }
  },
  methods: {
    updateUser() {
      this.user = JSON.parse(localStorage.getItem('xm-user') || '{}')   // 重新获取下用户的最新信息
    },
    goToPerson() {
      if (this.user.role === 'ADMIN') {
        this.$router.push('/adminPerson')
      }
      if (this.user.role === 'TEACHER') {
        this.$router.push('/teacherPerson')
      }
      if (this.user.role === 'STUDENT') {
        this.$router.push('/studentPerson')
      }
      if (this.user.role === 'ENTERPRISE') {
        this.$router.push('/enterprisePerson')
      }
    },
    logout() {
      localStorage.removeItem('xm-user')
      this.$router.push('/login')
    }
  }
}
</script>

<style scoped>
.manager-container {
  height: 100vh;
  display: flex;
  flex-direction: column;
  font-family: 'Comic Sans MS', '幼圆', '微软雅黑', sans-serif;
}

.shinchan-layout {
  background: linear-gradient(135deg, #E0FFFF, #FFE4E1);
}

.shinchan-header {
  background: linear-gradient(90deg, #FFD700, #FFA500);
  border-bottom: 3px dashed #FF6347;
  display: flex;
  align-items: center;
  padding: 0 20px;
  height: 60px;
}

.manager-header-left {
  display: flex;
  align-items: center;
  flex: 1;
}

.title {
  font-size: 20px;
  font-weight: bold;
  color: #8B4513;
}

.manager-header-center {
  flex: 2;
  display: flex;
  justify-content: center;
}

.shinchan-breadcrumb ::v-deep .el-breadcrumb__item:last-child .el-breadcrumb__inner {
  color: #8B4513 !important;
  font-weight: bold;
}

.manager-header-right {
  flex: 1;
  display: flex;
  justify-content: flex-end;
}

.avatar {
  display: flex;
  align-items: center;
  cursor: pointer;
}

.user-avatar {
  width: 35px;
  height: 35px;
  border-radius: 50%;
  border: 2px solid #87CEEB;
  margin-right: 10px;
}

.user-name {
  color: #8B4513;
  font-weight: bold;
}

.shinchan-dropdown ::v-deep .el-dropdown-menu__item {
  display: flex;
  align-items: center;
}

.dropdown-icon {
  font-size: 16px;
  margin-right: 8px;
}

.manager-main {
  display: flex;
  flex: 1;
  overflow: hidden;
}

.shinchan-sidebar {
  width: 250px;
  background: linear-gradient(135deg, #FFE4E1, #E0FFFF);
  border-right: 3px dashed #FF69B4;
  box-shadow: 5px 0 15px rgba(255, 105, 180, 0.2);
  overflow-y: auto;
}

.shinchan-menu ::v-deep .el-menu-item,
.shinchan-menu ::v-deep .el-submenu__title {
  font-size: 15px;
  border-radius: 15px;
  margin: 5px 10px;
  display: flex;
  align-items: center;
}

.shinchan-menu ::v-deep .el-menu-item:hover,
.shinchan-menu ::v-deep .el-submenu__title:hover {
  background-color: #FFB6C1 !important;
}

.shinchan-menu ::v-deep .el-menu-item.is-active {
  background-color: #FF69B4 !important;
  color: white !important;
  border-radius: 15px;
}

.menu-icon {
  font-size: 20px;
  margin-right: 10px;
  vertical-align: middle;
}

.manager-main-right {
  flex: 1;
  overflow-y: auto;
  padding: 20px;
}
</style>
