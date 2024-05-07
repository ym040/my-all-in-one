<template>
  <div>
    <div class="search">
      <el-select v-model="enterpriseId" placeholder="请选择企业" style="width: 200px">
        <el-option v-for="item in enterpriseData" :label="item.name" :value="item.id"></el-option>
      </el-select>
      <el-select v-model="teacherId" placeholder="请选择教师" style="width: 200px">
        <el-option v-for="item in teacherData" :label="item.name" :value="item.id"></el-option>
      </el-select>

      <el-button type="info" plain style="margin-left: 10px" @click="load(1)">查询</el-button>
      <el-button type="warning" plain style="margin-left: 10px" @click="reset">重置</el-button>
    </div>

    <div class="operation">
      <el-button type="primary" plain @click="handleAdd">新增</el-button>
      <el-button type="danger" plain @click="delBatch">批量删除</el-button>
    </div>

    <div class="table">
      <el-table :data="tableData" stripe  @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center"></el-table-column>
        <el-table-column prop="id" label="序号" width="80" align="center" sortable></el-table-column>
        <el-table-column prop="studentName" label="学生姓名" show-overflow-tooltip></el-table-column>
        <el-table-column prop="enterpriseName" label="企业名称" show-overflow-tooltip></el-table-column>
        <el-table-column prop="teacherName" label="教师姓名" show-overflow-tooltip></el-table-column>
        <el-table-column prop="enterpriseScore" label="企业评分" show-overflow-tooltip></el-table-column>
        <el-table-column prop="teacherScore" label="教师评分" show-overflow-tooltip></el-table-column>
        <el-table-column prop="score" label="总成绩" show-overflow-tooltip></el-table-column>

        <el-table-column label="操作" width="180" align="center">
          <template v-slot="scope">
            <el-button size="mini" type="primary" plain @click="handleEdit(scope.row)">编辑</el-button>
            <el-button plain type="danger" size="mini" @click=del(scope.row.id)>删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination">
        <el-pagination
            background
            @current-change="handleCurrentChange"
            :current-page="pageNum"
            :page-sizes="[5, 10, 20]"
            :page-size="pageSize"
            layout="total, prev, pager, next"
            :total="total">
        </el-pagination>
      </div>
    </div>


    <el-dialog title="成绩信息" :visible.sync="fromVisible" width="40%" :close-on-click-modal="false" destroy-on-close>
      <el-form label-width="100px" style="padding-right: 50px" :model="form" :rules="rules" ref="formRef">
        <el-form-item prop="enterpriseId" label="选择企业">
          <el-select v-model="form.enterpriseId" placeholder="请选择企业" style="width: 100%">
            <el-option v-for="item in enterpriseData" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="studentId" label="选择学生">
          <el-select v-model="studentId" placeholder="请选择学生" style="width: 100%">
            <el-option v-for="item in studentData" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="teacherId" label="选择教师">
          <el-select v-model="form.teacherId" placeholder="请选择教师" style="width: 100%">
            <el-option v-for="item in teacherData" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="enterpriseScore" label="企业评分">
          <el-input v-model="form.enterpriseScore" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="teacherScore" label="教师评分">
          <el-input v-model="form.teacherScore" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="fromVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>


  </div>
</template>

<script>
export default {
  name: "Score",
  data() {
    return {
      tableData: [],  // 所有的数据
      pageNum: 1,   // 当前的页码
      pageSize: 10,  // 每页显示的个数
      total: 0,
      enterpriseId: null,
      teacherId: null,
      studentId: null,
      fromVisible: false,
      form: {},
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      rules: {
        enterpriseScore: [
          {required: true, message: '请输入企业评分', trigger: 'blur'},
        ],
        teacherScore: [
          {required: true, message: '请输入教师评分', trigger: 'blur'},
        ],
      },
      ids: [],
      enterpriseData: [],
      teacherData: [],
      studentData: [],
    }
  },
  created() {
    this.load(1)
    this.loadEnterprise()
    this.loadTeacher()
    this.loadStudent()
  },
  methods: {
    loadEnterprise() {
      this.$request.get('/enterprise/selectAll').then(res => {
        if (res.code ==='200') {
          this.enterpriseData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    loadStudent() {
      this.$request.get('/student/selectAll').then(res => {
        if (res.code ==='200') {
          this.studentData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    loadTeacher() {
      this.$request.get('/teacher/selectAll').then(res => {
        if (res.code ==='200') {
          this.teacherData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleAdd() {   // 新增数据
      this.form = {
      }  // 新增数据的时候清空数据
      this.fromVisible = true   // 打开弹窗
      this.studentId = null
    },
    handleEdit(row) {   // 编辑数据
      this.form = JSON.parse(JSON.stringify(row))  // 给form对象赋值  注意要深拷贝数据
      this.studentId = this.form.studentId
      this.fromVisible = true   // 打开弹窗
    },
    save() {   // 保存按钮触发的逻辑  它会触发新增或者更新
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.form.studentId = this.studentId
          this.$request({
            url: this.form.id ? '/score/update' : '/score/add',
            method: this.form.id ? 'PUT' : 'POST',
            data: this.form
          }).then(res => {
            if (res.code === '200') {  // 表示成功保存
              this.$message.success('保存成功')
              this.load(1)
              this.fromVisible = false
            } else {
              this.$message.error(res.msg)  // 弹出错误的信息
            }
          })
        }
      })
    },
    del(id) {   // 单个删除
      this.$confirm('您确定删除吗？删除后该学生的学分也会相应的减少，您需要重新再次录入？', '灵魂拷问', {type: "warning"}).then(response => {
        this.$request.delete('/score/delete/' + id).then(res => {
          if (res.code === '200') {   // 表示操作成功
            this.$message.success('操作成功')
            this.load(1)
          } else {
            this.$message.error(res.msg)  // 弹出错误的信息
          }
        })
      }).catch(() => {
      })
    },
    handleSelectionChange(rows) {   // 当前选中的所有的行数据
      this.ids = rows.map(v => v.id)   //  [1,2]
    },
    delBatch() {   // 批量删除
      if (!this.ids.length) {
        this.$message.warning('请选择数据')
        return
      }
      this.$confirm('您确定批量删除这些数据吗？', '确认删除', {type: "warning"}).then(response => {
        this.$request.delete('/score/delete/batch', {data: this.ids}).then(res => {
          if (res.code === '200') {   // 表示操作成功
            this.$message.success('操作成功')
            this.load(1)
          } else {
            this.$message.error(res.msg)  // 弹出错误的信息
          }
        })
      }).catch(() => {
      })
    },
    load(pageNum) {  // 分页查询
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/score/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          enterpriseId: this.enterpriseId,
          teacherId: this.teacherId
        }
      }).then(res => {
        this.tableData = res.data?.list
        this.total = res.data?.total
      })
    },
    reset() {
      this.enterpriseId = null
      this.teacherId = null
      this.load(1)
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
  }
}
</script>

<style scoped>

</style>
