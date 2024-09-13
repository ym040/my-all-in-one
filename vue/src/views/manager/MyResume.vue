<template>
  <div>
    <!-- 简历卡片 -->
    <el-card class="box-card" v-if="hasResume">
      <div slot="header" class="clearfix">
        <h1 class="my-resume-title">我的简历</h1>
      </div>
      <div>
        <el-form label-width="100px" :model="form" :rules="rules" ref="formRef">
          <!-- 个人信息 -->
          <h2>个人信息</h2>
          <el-form-item label="姓名" prop="name">
            <el-input v-model="form.name" placeholder="姓名" style="width: 200px"></el-input>
          </el-form-item>
          <el-form-item label="电话" prop="tel">
            <el-input v-model="form.tel" placeholder="电话" style="width: 200px"></el-input>
          </el-form-item>
          <el-form-item label="邮箱" prop="email">
            <el-input v-model="form.email" placeholder="邮箱" style="width: 200px"></el-input>
          </el-form-item>
          <el-form-item label="现居城市" prop="address">
            <el-input v-model="form.address" placeholder="现居城市" style="width: 200px"></el-input>
          </el-form-item>
          <el-form-item label="性别" prop="gender">
            <el-select v-model="form.gender" placeholder="请选择性别">
              <el-option label="男" value="男"></el-option>
              <el-option label="女" value="女"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="当前状态" prop="status">
            <el-select v-model="form.status" placeholder="请选择当前状态">
              <el-option label="在职" value="在职"></el-option>
              <el-option label="离职" value="离职"></el-option>
              <el-option label="应届毕业生" value="应届毕业生"></el-option>
            </el-select>
          </el-form-item>

          <!-- 求职意向 -->
          <h2>求职意向</h2>
          <el-form-item label="意向城市" prop="city">
            <el-input v-model="form.city" placeholder="意向城市" style="width: 200px"></el-input>
          </el-form-item>
          <el-form-item label="期望职位" prop="department">
            <el-input v-model="form.department" placeholder="期望职位" style="width: 200px"></el-input>
          </el-form-item>
          <el-form-item label="期望薪资" prop="salary">
            <el-input v-model="form.salary" placeholder="期望薪资" style="width: 200px"></el-input>
          </el-form-item>

          <!-- 个人总结 -->
          <h2>个人总结</h2>
          <el-form-item label="个人总结" prop="person">
            <el-input type="textarea" v-model="form.person" placeholder="个人总结"></el-input>
          </el-form-item>

          <!-- 教育背景 -->
          <h2>教育背景</h2>
          <el-form-item label="教育背景" prop="education">
            <el-input type="textarea" v-model="form.education" placeholder="教育背景"></el-input>
          </el-form-item>

          <!-- 项目经历 -->
          <h2>项目经历</h2>
          <el-form-item label="项目经历" prop="project">
            <el-input type="textarea" v-model="form.project" placeholder="项目经历"></el-input>
          </el-form-item>

          <!-- 技能及证书 -->
          <h2>技能及证书</h2>
          <el-form-item label="技能及证书" prop="skills">
            <el-input type="textarea" v-model="form.skills" placeholder="技能及证书"></el-input>
          </el-form-item>

          <!-- 荣誉奖项 -->
          <h2>荣誉奖项</h2>
          <el-form-item label="荣誉奖项" prop="honor">
            <el-input type="textarea" v-model="form.honor" placeholder="荣誉奖项"></el-input>
          </el-form-item>
        </el-form>
      </div>
    </el-card>

    <!-- 保存与重置按钮 -->
    <div class="button-group" v-if="hasResume">
      <el-button type="primary" @click="save">保存</el-button>
      <el-button @click="reset">重置</el-button>
    </div>

    <!-- 没有简历时的提示对话框 -->
    <el-dialog title="提示" :visible.sync="dialogVisible" width="30%" :close-on-click-modal="false">
      <span>您还没有简历，请新建一个。</span>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="handleAdd">新建简历</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "MyResume",
  data() {
    return {
      hasResume: false,  // 判断是否有简历
      dialogVisible: false,  // 控制对话框的显示
      form: {},          // 存储简历数据
      originalForm: {},  // 保存原始数据，用于重置
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'), // 获取当前登录用户
      rules: {
        name: [
          { required: true, message: '请输入姓名', trigger: 'blur' },
        ],
        tel: [
          { required: true, message: '请输入电话号码', trigger: 'blur' },
          { pattern: /^1[3-9]\d{9}$/, message: '请输入有效的手机号码', trigger: 'blur' }, // 假设是中国大陆手机号码
        ],
        email: [
          { required: true, message: '请输入电子邮箱', trigger: 'blur' },
          { type: 'email', message: '请输入有效的电子邮箱地址', trigger: ['blur', 'change'] },
        ],
      },
    }
  },
  created() {
    this.loadResume()
  },
  methods: {
    loadResume() {  // 加载当前用户的简历信息
      this.$request.get(`/resume/selectByStudentId/${this.user.id}`).then(res => {
        if (res.data) {
          console.log(res.data)
          this.form = res.data
          this.originalForm = JSON.parse(JSON.stringify(res.data))  // 保存原始数据
          this.hasResume = true
        } else {
          this.dialogVisible = true  // 如果没有简历，显示提示对话框
        }
      })
    },
    handleAdd() {   // 新建简历
      this.form = { studentId: this.user.id }  // 清空表单并添加学生ID
      this.hasResume = true
      this.dialogVisible = false  // 隐藏对话框，显示卡片
    },
    save() {   // 保存简历
      this.$refs.formRef.validate(valid => {
        if (valid) {
          const url = this.form.id ? '/resume/update' : '/resume/add'
          const method = this.form.id ? 'PUT' : 'POST'
          this.$request({
            url,
            method,
            data: this.form
          }).then(res => {
            if (res.code === '200') {
              this.$message.success('保存成功')
              this.loadResume()  // 重新加载简历数据
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    },
    reset() {   // 重置简历信息
      this.form = JSON.parse(JSON.stringify(this.originalForm))  // 恢复到原始数据
    },
  }
}
</script>

<style scoped>
.box-card {
  padding: 10px;
  width: 50%;
  margin: 0 auto;
  max-height: 600px; /* 设置最大高度，确保卡片不会无限增高 */
  overflow-y: auto; /* 当内容超出高度时，显示垂直滚动条 */
  box-sizing: border-box; /* 确保 padding 也被计算在高度内 */
}


.button-group {

  text-align: right;
}

.el-form-item {
  margin-bottom: 10px; /* 减少表单项之间的间距 */
}

.my-resume-title {
  font-family: 'WenQuanYi Micro Hei', sans-serif;  /* 字体 */
  font-size: 24px;  /* 字体大小 */
  color: #333;      /* 字体颜色 */
  text-align: center; /* 文本居中 */
  margin-bottom: 20px; /* 下边距 */
}


h2 {
  margin-top: 10px; /* 减少标题与内容之间的间距 */
  margin-bottom: 5px;
  font-size: 16px;
  font-weight: bold;
}

</style>