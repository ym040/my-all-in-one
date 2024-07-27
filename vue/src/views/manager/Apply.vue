<template>
  <div>
    <div class="search" v-if="user.role !== 'STUDENT'">
      <el-input placeholder="请输入账号查询" style="width: 200px" v-model="username"></el-input>
      <el-button type="info" plain style="margin-left: 10px" @click="load(1)">查询</el-button>
      <el-button type="warning" plain style="margin-left: 10px" @click="reset">重置</el-button>
    </div>

    <div class="operation">
      <el-button type="primary" plain @click="handleAdd" v-if="user.role === 'ADMIN' || user.role === 'STUDENT'">新增</el-button>
      <el-button type="danger" plain @click="delBatch" v-if="user.role === 'ADMIN'">批量删除</el-button>
    </div>

    <div class="table">
      <el-table :data="tableData" stripe @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" v-if="user.role === 'ADMIN'"></el-table-column>
        <el-table-column prop="id" label="序号" width="70" align="center" sortable></el-table-column>
        <el-table-column prop="stuId" label="学生ID"></el-table-column>
        <el-table-column prop="username" label="用户名"></el-table-column>
        <el-table-column prop="name" label="姓名"></el-table-column>
        <el-table-column prop="className" label="班级"></el-table-column>
        <el-table-column prop="teacherName" label="教师"></el-table-column>
        <el-table-column prop="phone" label="联系电话"></el-table-column>
        <el-table-column prop="enterpriseName" label="单位名称"></el-table-column>
        <el-table-column prop="jobName" label="岗位名称"></el-table-column>
        <el-table-column prop="salary" label="薪资"></el-table-column>
        <el-table-column prop="address" label="工作地点"></el-table-column>
        <el-table-column prop="beginTime" label="开始时间"></el-table-column>
        <el-table-column prop="endTime" label="结束时间"></el-table-column>
        <el-table-column label="实习状态" align="center">
          <template v-slot="scope">
            <el-switch
                v-model="scope.row.status"
                active-value="实习中"
                inactive-value="未实习"
                :disabled="user.role === 'STUDENT'"
                @change="handleStatusChange(scope.row)"
            ></el-switch>
          </template>
        </el-table-column>
        <el-table-column prop="read_status" label="阅读状态" align="center">
          <template v-slot="scope">
            <el-tag v-if="scope.row.readStatus === 2" type="success">已读</el-tag>
            <el-tag v-else type="warning">未读</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="180">
          <template v-slot="scope">
            <el-button size="mini" type="primary" plain @click="handleEdit(scope.row)" v-if="user.role === 'ADMIN' || user.role === 'STUDENT'">编辑</el-button>
            <el-button size="mini" type="danger" plain @click="del(scope.row.id)" v-if="user.role === 'ADMIN'">删除</el-button>
            <el-button size="mini" plain @click="handleView(scope.row)" v-if="user.role === 'TEACHER' || user.role === 'ADMIN'">查看</el-button>
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


    <el-dialog title="实习信息" :visible.sync="fromVisible" width="40%" :close-on-click-modal="false" destroy-on-close>
      <el-form :model="form" label-width="100px" style="padding-right: 50px" :rules="rules" ref="formRef">
        <el-form-item label="学生ID" prop="stuId">
          <el-input v-model="form.stuId" placeholder="学生ID" :disabled="user.role === 'STUDENT'"></el-input>
        </el-form-item>
        <el-form-item label="用户名" prop="username">
          <el-input v-model="form.username" placeholder="用户名" :disabled="user.role === 'STUDENT'"></el-input>
        </el-form-item>
        <el-form-item label="姓名" prop="name">
          <el-input v-model="form.name" placeholder="姓名" :disabled="user.role === 'STUDENT'"></el-input>
        </el-form-item>
        <el-form-item label="班级" prop="classId">
          <el-select v-model="form.classId" placeholder="请选择班级" style="width: 100%">
            <el-option v-for="item in classData" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="教师" prop="teacherId">
          <el-select v-model="form.teacherId" placeholder="请选择教师" style="width: 100%">
            <el-option v-for="item in teacherData" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="联系电话" prop="phone">
          <el-input v-model="form.phone" placeholder="联系电话"></el-input>
        </el-form-item>
        <el-form-item label="单位名称" prop="enterpriseId">
          <el-select v-model="form.enterpriseId" placeholder="请选择单位" style="width: 100%" @change="loadJobByEnterpriseId">
            <el-option v-for="item in enterpriseData" :key="item.id" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="岗位名称" prop="jobId">
          <el-select v-model="form.jobId" placeholder="请选择岗位" style="width: 100%">
            <el-option v-for="item in jobData" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="薪资" prop="salary">
          <el-input v-model="form.salary" placeholder="薪资"></el-input>
        </el-form-item>
        <el-form-item label="工作地点" prop="address">
          <el-input v-model="form.address" placeholder="工作地点"></el-input>
        </el-form-item>
        <el-form-item label="开始时间" prop="beginTime">
          <div class="block">
            <el-date-picker
                v-model="form.beginTime"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="开始时间"
                :picker-options="pickerOptions">
            </el-date-picker>
          </div>
        </el-form-item>
        <el-form-item label="结束时间" prop="endTime">
          <div class="block">
            <el-date-picker
                v-model="form.endTime"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="结束时间"
                :picker-options="pickerOptions">
            </el-date-picker>
          </div>
        </el-form-item>
        <el-form-item label="实习状态" prop="status">
          <el-switch
              v-model="form.status"
              active-value="实习中"
              inactive-value="未实习"
              :disabled="user.role === 'STUDENT'"
          ></el-switch>
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
  name: "Apply",
  data() {
    return {
      tableData: [],  // 所有的数据
      pageNum: 1,   // 当前的页码
      pageSize: 10,  // 每页显示的个数
      total: 0,
      username: null,
      fromVisible: false,
      form: {},
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      rules: {
        username: [
          {required: true, message: '请输入账号', trigger: 'blur'},
        ]
      },
      ids: [],
      classData: [],
      teacherData: [],
      enterpriseData: [],
      jobData: [],
      timeDate: "",
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() < Date.now() - 8.64e7; //只能选择今天及今天之后的日期
        }
      },
    }
  },
  created() {
    this.load(1);
    this.loadTeachers();
    this.loadClasses();
    this.loadEnterprise();
    this.loadJob();
  },
  methods: {
    loadClasses() {
      this.$request.get('/classes/selectAll').then(res => {
        if (res.code ==='200') {
          this.classData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    loadEnterprise() {
      this.$request.get('/enterprise/selectAll').then(res => {
        if (res.code ==='200') {
          this.enterpriseData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    loadTeachers() {
      this.$request.get('/teacher/selectAll').then(res => {
        if (res.code ==='200') {
          this.teacherData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    loadJob() {
      this.$request.get('/job/selectAll').then(res => {
        if (res.code ==='200') {
          this.jobData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    loadJobByEnterpriseId(enterpriseId) {
      this.$request.get(`/job/selectByEnterpriseId/${enterpriseId}`).then(res => {
        if (res.code === '200') {
          this.jobData = res.data;
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    handleAdd() {   // 新增数据
      this.form = {}  // 新增数据的时候清空数据
      if (this.user.role === 'STUDENT') {
        this.form.stuId = this.user.id;
        this.form.username = this.user.username;
        this.form.classId = this.user.classId;
        this.form.name = this.user.name;
      }
      this.fromVisible = true   // 打开弹窗
    },
    handleEdit(row) {   // 编辑数据
      this.form = JSON.parse(JSON.stringify(row))  // 给form对象赋值  注意要深拷贝数据
      this.fromVisible = true   // 打开弹窗
    },
    save() {   // 保存按钮触发的逻辑  它会触发新增或者更新
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          // 在保存之前检查并更新读取状态
          if (this.form.readStatus === 2) {
            this.form.readStatus = 1; // 如果当前是已读状态，则改为未读
          }

          this.$request({
            url: this.form.id ? '/apply/update' : '/apply/add',
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
        this.$request.delete('/apply/delete/' + id).then(res => {
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
      this.ids = rows.map(v => v.id)
    },
    delBatch() {   // 批量删除
      if (!this.ids.length) {
        this.$message.warning('请选择数据')
        return
      }
      this.$confirm('您确定批量删除这些数据吗？', '确认删除', {type: "warning"}).then(response => {
        this.$request.delete('/apply/delete/batch', {data: this.ids}).then(res => {
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
        this.$request.get('/apply/selectEnterprise', {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            username: this.username,
            enterpriseId: this.user.id
          }
        }).then(res => {
          this.tableData = res.data?.list
          this.total = res.data?.total
        })
      } else if (this.user.role === 'TEACHER') {
        this.$request.get('/apply/selectByTeacher', {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            username: this.username,
            teacherId: this.user.id
          }
        }).then(res => {
          this.tableData = res.data?.list;
          this.total = res.data?.total;
        });
      } else if (this.user.role === 'STUDENT') {
        this.$request.get('/apply/selectByStudent', {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            username: this.username,
            stuId: this.user.id
          }
        }).then(res => {
          this.tableData = res.data?.list;
          this.total = res.data?.total;
        });
      } else {
        this.$request.get('/apply/selectPage', {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            username: this.username,
          }
        }).then(res => {
          this.tableData = res.data?.list
          this.total = res.data?.total
        })
      }

    },
    reset() {
      this.username = null
      this.load(1)
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
    handleAvatarSuccess(response, file, fileList) {
      // 把头像属性换成上传的图片的链接
      this.form.avatar = response.data
    },
    handleStatusChange(row) {
      this.$request({
        url: '/apply/updateStatus',
        method: 'PUT',
        data: { id: row.id, status: row.status }
      }).then(res => {
        if (res.code === '200') {
          if (row.status === '实习中') {
            this.$message.success(`状态更新成功，当前状态：${row.status}`);
          } else {
            this.$message.error(`状态更新成功，当前状态：${row.status}`);
          }
        } else {
          this.$message.error(res.msg);
        }
      })
    },
    handleView(row) {
      //console.log(row)
      // 更新读取状态为已读
      if (row.readStatus === 1) {  // 如果是未读状态
        row.readStatus = 2;  // 更新为已读状态
        //console.log(row.readStatus)
        this.updateReadStatus(row).then(() => {
          this.$message.success('读取状态更新成功');
        }).catch(error => {
          this.$message.error('读取状态更新失败');
        });
      }

      // 将当前行数据赋值给表单，并打开对话框
      this.form = JSON.parse(JSON.stringify(row));
      this.fromVisible = true;
    },

    updateReadStatus(row) {
      return new Promise((resolve, reject) => {
        this.$request({
          url: '/apply/updateReadStatus',
          method: 'PUT',
          data: { id: row.id, readStatus: row.readStatus}
        }).then(res => {
          if (res.code === '200') {
            resolve();
          } else {
            reject();
          }
        }).catch(error => {
          reject();
        });
      });
    },
  }
}
</script>

<style scoped>

</style>
