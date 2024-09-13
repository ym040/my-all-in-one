<template>
  <div>
    <div class="search">
      <el-input placeholder="请输入岗位名称查询" style="width: 200px" v-model="name"></el-input>
      <el-button type="info" plain style="margin-left: 10px" @click="load(1)">查询</el-button>
      <el-button type="warning" plain style="margin-left: 10px" @click="reset">重置</el-button>
      <el-button type="primary" plain style="margin-left: 10px" @click="recommend(user.id)" v-if="user.role === 'STUDENT'">推荐岗位</el-button>
    </div>

    <div class="operation">
      <el-button type="primary" plain @click="handleAdd" v-if="user.role === 'ADMIN'">新增</el-button>
      <el-button type="danger" plain @click="delBatch" v-if="user.role === 'ADMIN'">批量删除</el-button>
    </div>

    <div class="table">
      <el-table :data="tableData" stripe  @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" v-if="user.role === 'ADMIN' || user.role === 'ENTERPRISE'"></el-table-column>
        <el-table-column prop="id" label="序号" width="80" align="center" sortable></el-table-column>
        <el-table-column prop="name" label="岗位名称"></el-table-column>
        <el-table-column prop="direction" label="行业方向"></el-table-column>
        <el-table-column prop="enterpriseName" label="单位名称" show-overflow-tooltip></el-table-column>
        <el-table-column prop="count" label="招聘人数"></el-table-column>
        <el-table-column prop="salary" label="薪水"></el-table-column>
        <el-table-column prop="jobDescribe" label="岗位描述" show-overflow-tooltip></el-table-column>
        <el-table-column prop="jobRequire" label="专业要求" show-overflow-tooltip></el-table-column>
        <el-table-column prop="address" label="工作地点"></el-table-column>
        <el-table-column prop="workTime" label="工作时间"></el-table-column>

        <el-table-column label="操作" width="180" align="center" v-if="user.role !== 'TEACHER'">
          <template v-slot="scope">
            <el-button plain type="primary" @click="handleEdit(scope.row)" size="mini" v-if="user.role === 'ADMIN' || user.role === 'ENTERPRISE'">编辑</el-button>
            <el-button plain type="info" @click="handleView(scope.row)" size="mini" v-if="user.role === 'STUDENT'">查看</el-button>
            <el-button plain type="danger" size="mini" @click=del(scope.row.id) v-if="user.role === 'ADMIN' || user.role === 'ENTERPRISE'">删除</el-button>
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


    <el-dialog title="岗位信息" :visible.sync="fromVisible" width="40%" :close-on-click-modal="false" destroy-on-close>
      <el-form label-width="100px" style="padding-right: 50px" :model="form" :rules="rules" ref="formRef">
        <el-form-item label="岗位名称" prop="name">
          <el-input v-model="form.name" placeholder="岗位名称"></el-input>
        </el-form-item>
        <el-form-item label="行业方向" prop="direction">
          <el-input v-model="form.direction" placeholder="行业方向"></el-input>
        </el-form-item>
        <el-form-item label="单位名称" prop="enterpriseId">
          <el-select v-model="form.enterpriseId" placeholder="请选择单位" style="width: 100%">
            <el-option v-for="item in enterpriseData" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="招聘人数" prop="count">
          <el-input v-model="form.count" placeholder="招聘人数"></el-input>
        </el-form-item>
        <el-form-item label="薪水" prop="salary">
          <el-input v-model="form.salary" placeholder="薪水"></el-input>
        </el-form-item>
        <el-form-item label="岗位描述" prop="jobDescribe">
          <el-input type="textarea" :rows="5" v-model="form.jobDescribe" placeholder="岗位描述"></el-input>
        </el-form-item>
        <el-form-item label="专业要求" prop="jobRequire">
          <el-input type="textarea" :rows="5" v-model="form.jobRequire" placeholder="专业要求"></el-input>
        </el-form-item>
        <el-form-item label="工作地点" prop="address">
          <el-input v-model="form.address" placeholder="工作地点"></el-input>
        </el-form-item>
        <el-form-item label="工作时间" prop="workTime">
          <el-input v-model="form.workTime" placeholder="开始时间"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="fromVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog :title="`${form.name || ''}详情`" :visible.sync="ViewfromVisible" width="40%" :close-on-click-modal="false" destroy-on-close>
      <el-form label-width="100px" style="padding-right: 50px" :model="form" ref="formRef">
        <el-form-item label="岗位名称">
          <el-input v-model="form.name" disabled placeholder="岗位名称"></el-input>
        </el-form-item>
        <el-form-item label="行业方向">
          <el-input v-model="form.direction" disabled placeholder="行业方向"></el-input>
        </el-form-item>
        <el-form-item label="单位名称">
          <el-select v-model="form.enterpriseId" disabled placeholder="请选择单位" style="width: 100%">
            <el-option v-for="item in enterpriseData" :label="item.name" :value="item.id" :key="item.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="招聘人数">
          <el-input v-model="form.count" disabled placeholder="招聘人数"></el-input>
        </el-form-item>
        <el-form-item label="薪水">
          <el-input v-model="form.salary" disabled placeholder="薪水"></el-input>
        </el-form-item>
        <el-form-item label="岗位描述">
          <el-input type="textarea" :rows="5" v-model="form.jobDescribe" disabled placeholder="岗位描述"></el-input>
        </el-form-item>
        <el-form-item label="专业要求">
          <el-input type="textarea" :rows="5" v-model="form.jobRequire" disabled placeholder="专业要求"></el-input>
        </el-form-item>
        <el-form-item label="工作地点">
          <el-input v-model="form.address" disabled placeholder="工作地点"></el-input>
        </el-form-item>
        <el-form-item label="工作时间">
          <el-input v-model="form.workTime" disabled placeholder="开始时间"></el-input>
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="ViewfromVisible = false">取 消</el-button>
      </div>
    </el-dialog>



  </div>
</template>

<script>
export default {
  name: "Job",
  data() {
    return {
      tableData: [],  // 所有的数据
      pageNum: 1,   // 当前的页码
      pageSize: 10,  // 每页显示的个数
      total: 0,
      name: null,
      fromVisible: false,
      ViewfromVisible: false,
      form: {
        alCount: 0
      },
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      rules: {
        name: [
          {required: true, message: '请输入岗位名称', trigger: 'blur'},
        ],
      },
      ids: [],
      enterpriseData: []
    }
  },
  created() {
    this.load(1)
    this.loadEnterprise()
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
    handleAdd() {   // 新增数据
      this.form = {}  // 新增数据的时候清空数据
      this.fromVisible = true   // 打开弹窗
    },
    handleEdit(row) {   // 编辑数据
      this.form = JSON.parse(JSON.stringify(row))  // 给form对象赋值  注意要深拷贝数据
      this.fromVisible = true   // 打开弹窗
    },
    handleView(row) {   // 查看数据
      this.form = JSON.parse(JSON.stringify(row))  // 给form对象赋值  注意要深拷贝数据
      this.ViewfromVisible = true   // 打开弹窗

      // 发送请求到后端接口 /userActions/add
      this.$request.post('/userActions/add', {
        userId: this.user.id,  // 学生 ID
        jobId: row.id,  // 岗位 ID
        actionType:  "VIEW"  // 用户行为
      })
    },
    save() {   // 保存按钮触发的逻辑  它会触发新增或者更新
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.$request({
            url: this.form.id ? '/job/update' : '/job/add',
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
      this.$confirm('您确定删除吗？', '确认删除', {type: "warning"}).then(response => {
        this.$request.delete('/job/delete/' + id).then(res => {
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
        this.$request.delete('/job/delete/batch', {data: this.ids}).then(res => {
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
      if (this.user.role === 'ENTERPRISE') {
        this.$request.get('/job/selectByEnterpriseId', {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            name: this.name,
            enterpriseId: this.user.id
          }
        }).then(res => {
          this.tableData = res.data?.list
          this.total = res.data?.total
        })
      } else {
        this.$request.get('/job/selectPage', {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            name: this.name,
          }
        }).then(res => {
          this.tableData = res.data?.list
          this.total = res.data?.total
        })
      }

    },
    reset() {
      this.name = null
      this.load(1)
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
    recommend(userId) {
      this.$request.get('userActions/recommend/' + userId).then(res => {
        if (res.code === '200') {
          this.$message.success('推荐成功')
          console.log(res)
          // 直接将推荐岗位列表绑定到 tableData
          this.tableData = res.data;  // res.data 应该是一个岗位数组

          // 如果有 total 的需求，可以手动设置
          this.total = res.data?.length || 0;  // 或者计算推荐列表的长度
        } else {
          this.$message.error(res.msg)
        }
      })
    }
  }
}
</script>

<style scoped>

</style>
