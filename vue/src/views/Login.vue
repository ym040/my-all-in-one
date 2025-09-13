<template>
  <div class="container shinchan-theme">
    <div class="login-box shinchan-card">
      <div class="login-header">
        <div class="welcome-text">欢迎使用实习管理平台</div>
      </div>
      <el-form :model="form" :rules="rules" ref="formRef" class="login-form">
        <el-form-item prop="username">
          <div class="input-wrapper">
            <i class="el-icon-user input-icon"></i>
            <el-input
              prefix-icon="el-icon-user"
              placeholder="请输入账号"
              v-model="form.username"
              class="shinchan-input"
            ></el-input>
          </div>
        </el-form-item>
        <el-form-item prop="password">
          <div class="input-wrapper">
            <i class="el-icon-lock input-icon"></i>
            <el-input
              prefix-icon="el-icon-lock"
              placeholder="请输入密码"
              show-password
              v-model="form.password"
              class="shinchan-input"
            ></el-input>
          </div>
        </el-form-item>
        <el-form-item>
          <div class="input-wrapper">
            <i class="el-icon-s-custom input-icon"></i>
            <el-select
              v-model="form.role"
              placeholder="请选择角色"
              style="width: 100%"
              class="shinchan-select"
            >
              <el-option label="管理员" value="ADMIN"></el-option>
              <el-option label="教师" value="TEACHER"></el-option>
              <el-option label="学生" value="STUDENT"></el-option>
              <el-option label="企业" value="ENTERPRISE"></el-option>
            </el-select>
          </div>
        </el-form-item>
        <el-form-item>
          <el-button
            class="shinchan-button login-button"
            @click="login"
          >
            <i class="el-icon-upload2 button-icon"></i>
            登 录
          </el-button>
        </el-form-item>
        <div class="login-footer">
          <div class="register-link">
            还没有账号？请 <a href="/register">注册</a>
          </div>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  name: "Login",
  data() {
    return {
      form: {},
      rules: {
        username: [
          { required: true, message: '请输入账号', trigger: 'blur' },
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
        ]
      }
    }
  },
  created() {

  },
  methods: {
    login() {
      this.$refs['formRef'].validate((valid) => {
        if (valid) {
          // 验证通过
          this.$request.post('/login', this.form).then(res => {
            if (res.code === '200') {
              localStorage.setItem("xm-user", JSON.stringify(res.data))  // 存储用户数据
              this.$router.push('/')  // 跳转主页
              this.$message.success('登录成功')
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    }
  }
}
</script>

<style scoped>
.shinchan-theme {
  height: 100vh;
  overflow: hidden;
  background: linear-gradient(135deg, #FFE4E1, #E0FFFF);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #666;
  font-family: 'Comic Sans MS', '幼圆', '微软雅黑', sans-serif;
}

.login-box {
  width: 450px;
  padding: 30px;
  background-color: #FFFACD;
  border-radius: 25px;
  box-shadow: 0 10px 30px rgba(255, 105, 180, 0.3);
  border: 4px dashed #FF69B4;
  position: relative;
}

.login-header {
  text-align: center;
  margin-bottom: 25px;
}

.welcome-text {
  font-size: 20px;
  color: #FF4500;
  font-weight: bold;
  text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
}

.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
  background: white;
  border: 2px solid #87CEEB;
  border-radius: 20px;
  padding: 5px 15px;
  margin-bottom: 5px;
}

.input-icon {
  font-size: 20px;
  margin-right: 10px;
  color: #4169E1;
}

.shinchan-input ::v-deep .el-input__inner {
  border: none;
  outline: none;
  background: transparent;
  height: 40px;
  font-size: 14px;
}

.shinchan-select ::v-deep .el-input__inner {
  border: none;
  outline: none;
  background: transparent;
  height: 40px;
  font-size: 14px;
}

.shinchan-select ::v-deep .el-input__icon {
  display: none;
}

.login-button {
  width: 100%;
  background: linear-gradient(45deg, #FFB6C1, #FF69B4);
  border: none;
  color: white;
  font-size: 16px;
  font-weight: bold;
  letter-spacing: 2px;
  padding: 12px 20px;
  border-radius: 25px;
  box-shadow: 0 4px 10px rgba(255, 105, 180, 0.3);
  transition: all 0.3s;
}

.login-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 15px rgba(255, 105, 180, 0.4);
}

.button-icon {
  margin-right: 8px;
  font-size: 16px;
}

.login-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 20px;
}

.register-link {
  flex: 1;
  text-align: left;
  font-size: 14px;
}

a {
  color: #FF4500;
  font-weight: bold;
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}

.shinchan-card {
  background-color: #FFFACD;
  border: 3px solid #87CEEB;
  border-radius: 20px;
  box-shadow: 0 5px 15px rgba(135, 206, 235, 0.3);
}
</style>
