<template>
  <div class="resume">
    <el-card class="resume-card">
      <h2>{{ resume.name }}</h2>
      <p><strong>电话:</strong> {{ resume.tel }}</p>
      <p><strong>邮箱:</strong> {{ resume.email }}</p>
      <p><strong>现居城市:</strong> {{ resume.address }}</p>
      <p><strong>性别:</strong> {{ getGenderLabel(resume.gender) }}</p>
      <p><strong>求职意向:</strong> {{ resume.job }}</p>
      <p><strong>当前状态:</strong> {{ getStatusLabel(resume.status) }}</p>
      <p><strong>意向城市:</strong> {{ resume.city }}</p>
      <p><strong>期望职位:</strong> {{ resume.department }}</p>
      <p><strong>期望薪资:</strong> {{ resume.salary }}</p>
      <p><strong>个人总结:</strong> {{ resume.person }}</p>
      <p><strong>教育背景:</strong> {{ resume.education }}</p>
      <p><strong>项目经历:</strong> {{ resume.project }}</p>
      <p><strong>技能及证书:</strong> {{ resume.field120 }}</p>
      <p><strong>荣誉奖项:</strong> {{ resume.honor }}</p>
      <el-button type="primary" @click="openEditDialog">编辑简历</el-button>
    </el-card>

    <el-dialog :visible.sync="editDialogVisible" title="编辑简历">
      <el-form ref="elForm" :model="formData" :rules="rules" size="medium" label-width="100px">
        <!-- 同 MyResume.vue 文件中的表单内容 -->
        <!-- ... -->
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="resetForm">重置</el-button>
        <el-button type="primary" @click="submitForm">提交</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  data() {
    return {
      editDialogVisible: false,
      resume: {
        name: '张三',
        tel: '1234567890',
        email: 'zhangsan@example.com',
        address: '北京',
        gender: 1,
        job: '前端开发工程师',
        status: 1,
        city: '北京',
        department: '技术部',
        salary: '15k-20k',
        person: '热爱编程，乐于挑战。',
        education: '北京大学 计算机科学与技术 本科 2020.09-2023.06',
        project: '参与多个前端项目开发，熟悉Vue.js和React.js。',
        field120: '技能：JavaScript, Vue.js, React.js 证书:计算机一级',
        honor: '获得国家奖学金',
      },
      formData: {
        name: '',
        tel: '',
        email: '',
        address: '',
        gender: '',
        job: '',
        status: '',
        city: '',
        department: '',
        salary: '',
        person: '',
        education: '',
        project: '',
        field120: '',
        honor: '',
      },
      rules: {
        name: [{ required: true, message: '请输入姓名', trigger: 'blur' }],
        tel: [{ required: true, message: '请输入电话', trigger: 'blur' }],
        email: [{ required: true, message: '请输入邮箱', trigger: 'blur' }],
        address: [{ required: true, message: '请输入现居城市', trigger: 'blur' }],
        gender: [{ required: true, message: '请输入性别', trigger: 'change' }],
        job: [],
        status: [{ required: true, message: '请输入当前状态', trigger: 'change' }],
        city: [{ required: true, message: '请输入意向城市', trigger: 'blur' }],
        department: [{ required: true, message: '请输入期望职位', trigger: 'blur' }],
        salary: [{ required: true, message: '请输入期望薪资', trigger: 'blur' }],
        person: [{ required: true, message: '请输入个人总结', trigger: 'blur' }],
        education: [{ required: true, message: '请输入教育背景', trigger: 'blur' }],
        project: [{ required: true, message: '请输入项目经历', trigger: 'blur' }],
        field120: [{ required: true, message: '请输入技能及证书', trigger: 'blur' }],
        honor: [{ required: true, message: '请输入荣誉奖项', trigger: 'blur' }],
      },
      genderOptions: [
        { label: '男', value: 1 },
        { label: '女', value: 2 },
      ],
      statusOptions: [
        { label: '在职', value: 1 },
        { label: '离职', value: 2 },
        { label: '应届毕业生', value: 3 },
      ],
    };
  },
  methods: {
    getGenderLabel(value) {
      const gender = this.genderOptions.find(g => g.value === value);
      return gender ? gender.label : '';
    },
    getStatusLabel(value) {
      const status = this.statusOptions.find(s => s.value === value);
      return status ? status.label : '';
    },
    openEditDialog() {
      this.formData = { ...this.resume };
      this.editDialogVisible = true;
    },
    submitForm() {
      this.$refs['elForm'].validate(valid => {
        if (!valid) return;
        this.resume = { ...this.formData };
        this.editDialogVisible = false;
      });
    },
    resetForm() {
      this.$refs['elForm'].resetFields();
    },
  },
};
</script>

<style>
.resume {
  padding: 20px;
}
.resume-card {
  margin: 0 auto;
  max-width: 600px;
}
</style>
