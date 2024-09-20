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
        <el-table-column prop="username" label="用户名" width="120"></el-table-column>
        <el-table-column prop="name" label="姓名"></el-table-column>
        <el-table-column prop="className" label="班级"></el-table-column>
        <el-table-column prop="teacherName" label="教师"></el-table-column>
        <el-table-column prop="phone" label="联系电话" width="120"></el-table-column>
        <el-table-column prop="enterpriseName" label="单位名称" width="120"></el-table-column>
        <el-table-column prop="jobName" label="岗位名称" width="150"></el-table-column>
        <el-table-column prop="beginTime" label="开始时间" width="120"></el-table-column>
        <el-table-column prop="endTime" label="结束时间" width="100"></el-table-column>
        <el-table-column label="实习状态" align="center" width="120">
          <template v-slot="scope">
            <el-select
                v-model="scope.row.status"
                filterable
                placeholder="请选择实习状态"
                :disabled="user.role === 'STUDENT' || scope.row.resumeStatus !== 1 || user.role === 'ENTERPRISE'"
                @change="handleStatusChange(scope.row)"
            >
              <el-option
                  v-for="item in statusOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
              </el-option>

            </el-select>
          </template>
        </el-table-column>
        <el-table-column prop="read_status" label="阅读状态" align="center">
          <template v-slot="scope">
            <el-tag v-if="scope.row.readStatus === 2" type="success">已读</el-tag>
            <el-tag v-else type="warning">未读</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="resume_status" label="简历状态" align="center">
          <template v-slot="scope">
            <el-tag v-if="scope.row.resumeStatus === 1" type="success">已通过</el-tag>
            <el-tag v-if="scope.row.resumeStatus === 2" type="danger">未通过</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="300">
          <template v-slot="scope">
            <el-button size="mini" type="primary" plain @click="handleEdit(scope.row)" v-if="user.role === 'ADMIN' || user.role === 'STUDENT'">编辑</el-button>
            <el-button size="mini" type="danger" plain @click="del(scope.row.id)" v-if="user.role === 'ADMIN'">删除</el-button>
            <el-button size="mini" plain @click="handleView(scope.row)" v-if="user.role === 'TEACHER' || user.role === 'ADMIN'">查看</el-button>
            <el-button size="mini" plain @click="handleViewResume(scope.row.stuId)" v-if="user.role !== 'STUDENT'">查看简历</el-button>
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
          <el-select v-model="form.classId" placeholder="请选择班级" style="width: 100%" disabled>
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
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="fromVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="简历信息" :visible.sync="ResumeFromVisible" width="40%" :close-on-click-modal="false" destroy-on-close>
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

      <div slot="footer" class="dialog-footer">
        <el-button @click="ResumeFromVisible = false" v-if="user.role !== 'ENTERPRISE'">取 消</el-button>
        <el-button type="primary" @click="updateResume" v-if="user.role === 'TEACHER'">优 化</el-button>
        <el-button type="success" @click="ResumeStatus(form.studentId,1)" v-if="user.role === 'ENTERPRISE'">通 过</el-button>
        <el-button type="danger" @click="ResumeStatus(form.studentId,2)" v-if="user.role === 'ENTERPRISE'">拒 绝</el-button>
      </div>
    </el-dialog>

    <!-- 没有简历时的提示对话框 -->
    <el-dialog title="提示" :visible.sync="dialogVisible" width="30%" :close-on-click-modal="false">
      <span>您还没有简历，请新建后再申请岗位。</span>
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
      pageSize: 6,  // 每页显示的个数
      total: 0,
      username: null,
      fromVisible: false,
      ResumeFromVisible: false,
      dialogVisible: false,  // 控制对话框的显示
      form: {},
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      rules: {
        username: [
          {required: true, message: '请输入账号', trigger: 'blur'},
        ],
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
      statusOptions: [{
        value: '未实习',
        label: '未实习'
      }, {
        value: '实习中',
        label: '实习中'
      }, {
        value: '实习结束',
        label: '实习结束'
      }],
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
        if (res.code === '200') {
          this.classData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    loadEnterprise() {
      this.$request.get('/enterprise/selectAll').then(res => {
        if (res.code === '200') {
          this.enterpriseData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    loadTeachers() {
      this.$request.get('/teacher/selectAll').then(res => {
        if (res.code === '200') {
          this.teacherData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },

    loadJobByEnterpriseId(enterpriseId) {
      this.$request.get(`/job/selectEnterpriseJob/${enterpriseId}`).then(res => {
        if (res.code === '200') {
          console.log(res.data)
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
      if (this.user.role === 'STUDENT') {
        this.$request.get(`/resume/selectByStudentId/${this.user.id}`).then(res => {
          if (res.data) {
            this.fromVisible = true   // 打开弹窗
          } else {
            this.dialogVisible = true  // 如果没有简历，显示提示对话框
          }
        })
      }
    },
    handleEdit(row) {   // 编辑数据
      this.form = JSON.parse(JSON.stringify(row))  // 给form对象赋值  注意要深拷贝数据
      this.fromVisible = true   // 打开弹窗
    },
    handleViewResume(stuId) {   // 编辑数据
      this.$request.get(`/resume/selectByStudentId/${stuId}`).then(res => {
        if (res && res.data) {
          this.form = res.data;
          this.ResumeFromVisible = true;   // 打开弹窗
        } else {
          this.$message.warning('该学生暂无简历信息');
        }
      })
    },
    updateResume() {
      this.$request({
        url: '/resume/updateByStudentId',
        method: 'PUT',
        data: this.form
      }).then(res => {
        if (res.code === '200') {
          this.$message.success('简历优化成功');
          this.load(1); // 重新加载数据
          this.ResumeFromVisible = false; // 关闭弹窗
        } else {
          this.$message.error(res.msg);
        }
      })
    },

    ResumeStatus(studentId, status) {
      if (status === 1) {
        this.$confirm('确定通过该简历吗？', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.updateResumeStatus(studentId, status);
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消'
          });
        });
      } else if (status === 2) {
        this.$confirm('确定拒绝该简历吗？', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.updateResumeStatus(studentId, status);
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消'
          });
        });
      }
    },
    updateResumeStatus(studentId, status) {
      this.$request.put('/apply/updateResumeStatus/' + studentId + '/' + status)
          .then(res => {
            this.load(1); // 刷新列表
            this.ResumeFromVisible = false; // 关闭弹窗
          })
          .catch(error => {
            console.error('更新简历状态失败:', error);
          });
    },
    save() {   // 保存按钮触发的逻辑  它会触发新增或者更新
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          // 在保存之前检查并更新读取状态
          if (this.form.readStatus === 2 && this.user.role === 'STUDENT') {
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

          // 发送请求到后端接口 /userActions/add
          this.$request.post('/userActions/add', {
            userId: this.user.id,  // 学生 ID
            jobId: this.form.jobId,  // 岗位 ID
            actionType:  "APPLY"  // 用户行为
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
      // 判断简历状态是否为已通过 (resumeStatus = 1)
      if (!row.resumeStatus || row.resumeStatus === 1) {
        this.$request({
          url: '/apply/updateStatus',
          method: 'PUT',
          data: { id: row.id, status: row.status }
        }).then(res => {
          if (res.code === '200') {
            // 状态更新成功
            this.$message.success(`状态已更新为：${row.status}`);
          } else {
            this.$message.error(res.msg);
          }
        });
      } else {
        // 简历状态不是已通过，提示用户
        this.$message.warning('未通过简历审核，请修改实习申请信息');
      }
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
