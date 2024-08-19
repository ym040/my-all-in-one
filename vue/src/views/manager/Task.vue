<template>
  <div>
    <div class="operation"  v-if="user.role !== 'STUDENT'">
      <el-select v-model="selectedGrade" placeholder="请选择成绩">
        <el-option label="优秀" value="优秀"></el-option>
        <el-option label="不合格" value="不合格"></el-option>
      </el-select>
      <el-button type="primary" plain style="margin-left: 10px" @click="searchByGrade">查找</el-button>
      <el-button type="warning" plain style="margin-left: 10px" @click="reset">重置</el-button>
    </div>

    <div class="operation">
      <el-button type="primary" plain @click="handleAdd" v-if="user.role === 'ADMIN' || user.role === 'TEACHER'">发布任务</el-button>
      <el-button type="danger" plain @click="delBatch" v-if="user.role === 'ADMIN' || user.role === 'TEACHER'">批量删除</el-button>
    </div>

    <div class="table">
      <el-table :data="tableData" stripe @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" v-if="user.role === 'ADMIN' || user.role === 'TEACHER'"></el-table-column>
        <el-table-column prop="id" label="序号" width="70" align="center" sortable></el-table-column>
        <el-table-column prop="studentId" label="学生ID"></el-table-column>
        <el-table-column prop="studentName" label="姓名"></el-table-column>
        <el-table-column prop="className" label="班级"></el-table-column>
        <el-table-column prop="teacherName" label="指导老师"></el-table-column>
        <el-table-column prop="jobName" label="岗位"></el-table-column>
        <el-table-column prop="enterpriseName" label="公司名称"></el-table-column>
        <el-table-column prop="file" label="三方协议">
          <template v-slot="scope">
            <el-button v-if="scope.row.file" type="text" @click="viewFile(scope.row.file)">下载</el-button>
            <span v-else>无</span>
          </template>
        </el-table-column>
<!--        <el-table-column prop="count" label="签到次数"></el-table-column>-->
        <el-table-column prop="record" label="周志">
          <template v-slot="scope">
            <el-button v-if="scope.row.record" type="text" @click="viewFile(scope.row.record)">下载</el-button>
            <span v-else>无</span>
          </template>
        </el-table-column>
        <el-table-column prop="enterpriseRemark" label="企业评价"></el-table-column>
        <el-table-column prop="teacherRemark" label="教师评价"></el-table-column>
        <el-table-column prop="self" label="自我鉴定"></el-table-column>
        <el-table-column prop="grade" label="成绩鉴定"></el-table-column>
        <el-table-column prop="report" label="实践报告">
          <template v-slot="scope">
            <el-button v-if="scope.row.report" type="text" @click="viewFile(scope.row.report)">下载</el-button>
            <span v-else>无</span>
          </template>
        </el-table-column>
        <el-table-column label="实习状态" align="center">
          <template v-slot="scope">
            <el-switch
                v-model="scope.row.status"
                active-value="实习中"
                inactive-value="未实习"
                disabled
            ></el-switch>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="180">
          <template v-slot="scope">
            <el-button size="mini" type="primary" plain @click="handleEdit(scope.row)" v-if="user.role === 'ADMIN' || user.role === 'STUDENT' && scope.row.status === '实习中'">编辑</el-button>
            <el-button size="mini" type="danger" plain @click="del(scope.row.id)" v-if="user.role === 'ADMIN'">删除</el-button>
<!--            <el-button size="mini" type="success" plain @click="checkIn(scope.row)" v-if="user.role === 'STUDENT'">签到</el-button>-->
            <el-button size="mini" type="success" plain @click="evaluate(scope.row)"  v-if="user.role === 'TEACHER' || user.role === 'ENTERPRISE'">评价</el-button>
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

    <el-dialog title="发布任务" :visible.sync="fromVisible" width="40%" :close-on-click-modal="false" destroy-on-close>
      <el-table :data="studentData" @selection-change="handleStudentSelectionChange">
        <el-table-column type="selection" width="55"></el-table-column>
        <el-table-column prop="stuId" label="学生ID"></el-table-column>
        <el-table-column prop="name" label="姓名"></el-table-column>
        <el-table-column prop="className" label="班级"></el-table-column>
        <el-table-column prop="teacherName" label="教师"></el-table-column>
        <el-table-column prop="jobName" label="岗位"></el-table-column>
        <el-table-column prop="enterpriseName" label="公司名称"></el-table-column>
      </el-table>

      <div class="pagination">
        <el-pagination
            background
            @current-change="handleCurrentChange"
            :current-page="pageNum"
            :page-sizes="[5, 10, 20]"
            :page-size="pageSize"
            layout="total, prev, pager, next, jumper"
            :total="total">
        </el-pagination>
      </div>

      <div slot="footer" class="dialog-footer">
        <el-button @click="fromVisible = false">取消</el-button>
        <el-button type="primary" @click="publishTask">发布</el-button>
      </div>
    </el-dialog>

    <el-dialog title="编辑任务" :visible.sync="editVisible" width="40%" :close-on-click-modal="false" destroy-on-close>
      <el-form :model="form" ref="formRef" :rules="rules" label-width="100px">
        <el-form-item label="学生ID" prop="studentId">
          <el-input v-model="form.studentId" disabled></el-input>
        </el-form-item>
        <el-form-item label="姓名" prop="studentName">
          <el-input v-model="form.studentName" disabled></el-input>
        </el-form-item>
        <el-form-item label="班级" prop="className">
          <el-input v-model="form.className" disabled></el-input>
        </el-form-item>
        <el-form-item label="指导老师" prop="teacherName">
          <el-input v-model="form.teacherName" disabled></el-input>
        </el-form-item>
        <el-form-item label="岗位" prop="jobName">
          <el-input v-model="form.jobName" disabled></el-input>
        </el-form-item>
        <el-form-item label="公司名称" prop="enterpriseName">
          <el-input v-model="form.enterpriseName" disabled></el-input>
        </el-form-item>
        <el-form-item label="三方协议" prop="file">
          <el-upload
              :action="$baseUrl + '/files/upload'"
              :show-file-list="false"
              :on-success="handleFileSuccessForFile"
              v-if="user.role === 'STUDENT'"
          >
            <el-button size="small" type="primary">点击上传</el-button>
          </el-upload>
          <el-input v-model="form.file" disabled></el-input>
        </el-form-item>
        <el-form-item label="实习周志" prop="record">
          <el-upload
              :action="$baseUrl + '/files/upload'"
              :show-file-list="false"
              :on-success="handleFileSuccessForRecord"
              v-if="user.role === 'STUDENT'"
          >
            <el-button size="small" type="primary">点击上传</el-button>
          </el-upload>
          <el-input v-model="form.record" disabled></el-input>
        </el-form-item>
        <el-form-item label="实践报告" prop="report">
          <el-upload
              :action="$baseUrl + '/files/upload'"
              :show-file-list="false"
              :on-success="handleFileSuccessForReport"
              v-if="user.role === 'STUDENT'"
          >
            <el-button size="small" type="primary">点击上传</el-button>
          </el-upload>
          <el-input v-model="form.report" disabled></el-input>
        </el-form-item>
        <el-form-item label="自我鉴定" prop="self">
          <el-input type="textarea" v-model="form.self" rows="4" placeholder="请输入自我鉴定" :disabled="user.role !== 'STUDENT' && user.role !== 'ADMIN'"></el-input>
        </el-form-item>
        <el-form-item label="企业评价" prop="enterpriseRemark">
          <el-input type="textarea" v-model="form.enterpriseRemark" rows="4" placeholder="请输入企业评价" :disabled="user.role !== 'ENTERPRISE' && user.role !== 'ADMIN'"></el-input>
        </el-form-item>
        <el-form-item label="教师评价" prop="teacherRemark">
          <el-input type="textarea" v-model="form.teacherRemark" rows="4" placeholder="请输入教师评价" :disabled="user.role !== 'TEACHER' && user.role !== 'ADMIN'"></el-input>
        </el-form-item>
        <el-form-item label="成绩鉴定" prop="grade" v-if="user.role === 'TEACHER'">
          <el-select v-model="form.grade" placeholder="请选择成绩" :disabled="user.role !== 'TEACHER' && user.role !== 'ADMIN'">
            <el-option label="优秀" value="优秀"></el-option>
            <el-option label="良好" value="良好"></el-option>
            <el-option label="中等" value="中等"></el-option>
            <el-option label="不合格" value="不合格"></el-option>
          </el-select>
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="editVisible = false">取消</el-button>
        <el-button type="primary" @click="save">保存</el-button>
      </div>
    </el-dialog>
  </div>
</template>


<script>

export default {
  name: "Task",
  data() {
    return {
      tableData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      fromVisible: false,
      editVisible: false,
      form: {},
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      rules: {},
      ids: [],
      studentData: [],
      selectedStudents: [],  // 用于存储选中的学生
      selectedGrade: '', // 新增状态
    };
  },
  created() {
      this.load(1);
      this.loadStudentList();
  },
  methods: {

    handleAdd() {
      this.selectedStudents = [];
      this.fromVisible = true;
    },
    handleStudentSelectionChange(selected) {
      this.selectedStudents = selected;
    },

    loadStudentList() {
      // 使用教师ID作为查询参数
      this.$request.get('/apply/selectByTeacherId', {
        params: {
          teacherId: this.user.id
        }
      }).then(response => {
        // 成功处理逻辑
        this.studentData = response.data;
        console.log('学生列表:', this.studentData);

        // 获取已发布的任务
        this.$request.get('/task/selectByTeacher', {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            teacherId: this.user.id
          }
        }).then(taskRes => {
          if (taskRes.code === '200') {
            const publishedStudentIds = taskRes.data?.list.map(task => task.studentId);
            // 使用 includes 进行筛选
            this.unassignedStudentData = this.studentData.filter(student => !publishedStudentIds.includes(student.stuId));
            // 更新显示的数据
            this.studentData = this.unassignedStudentData;
          } else {
            this.$message.error(taskRes.msg);
          }
        }).catch(taskError => {
          console.error('获取任务列表失败:', taskError);
        });
      }).catch(error => {
        // 失败处理逻辑
        console.error('查询失败:', error);
      });
    },

    publishTask() {
      const tasks = this.selectedStudents.map(student => {
        return {
          studentId: student.stuId,  // 确保这里使用 studentId
          name: student.name,
          classId: student.classId,
          teacherId: student.teacherId,
          jobId: student.jobId,
          enterpriseId: student.enterpriseId,
        };
      });

      this.$request.post('/task/batchAdd', tasks).then(res => {
        if (res.code === '200') {
          this.$message.success('发布成功');
          this.load(1);  // 假设 load 方法用于重新加载数据
          this.loadStudentList();  // 重新加载未关联任务的学生列表
          this.fromVisible = false;  // 关闭发布任务的弹窗
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    handleEdit(row) {
      if (row.status === '实习中') {
        this.form = JSON.parse(JSON.stringify(row));
        // 自动设置指导老师
        this.getTeacherByClassId(this.form.classId).then(teacherInfo => {
          this.form.teacherName = teacherInfo.teacherName;
          this.editVisible = true;
        });
      } else {
        this.$message.error('只有状态为实习中的任务可以编辑');
      }
    },
    handleFileSuccessForFile(response, file, fileList) {
      this.form.file = response.data;  // 更新三方协议文件路径
    },
    handleFileSuccessForRecord(response, file, fileList) {
      this.form.record = response.data;  // 更新实习周志文件路径
    },
    handleFileSuccessForReport(response, file, fileList) {
      this.form.report = response.data;  // 更新实践报告文件路径
    },
    viewFile(filePath) {
      // 这里假设文件路径是相对路径，可以根据实际情况调整
      window.open(`${filePath}`, '_blank');
    },
    save() {
      this.$refs.formRef.validate(valid => {
        if (valid) {
          this.$request({
            url: this.form.id ? '/task/update' : '/task/add',
            method: this.form.id ? 'PUT' : 'POST',
            data: this.form
          }).then(res => {
            if (res.code === '200') {
              this.$message.success('保存成功');
              this.load(1)
              this.fromVisible = false;
              this.editVisible = false;
            } else {
              this.$message.error(res.msg);
            }
          });
        }
      });
    },
    del(id) {
      this.$confirm('您确定删除吗？', '确认删除', {type: "warning"}).then(response => {
        this.$request.delete('/task/delete/' + id).then(res => {
          if (res.code === '200') {
            this.$message.success('操作成功');
            this.load(1);
            this.loadStudentList();
          } else {
            this.$message.error(res.msg);
          }
        });
      }).catch(() => {});
    },
    handleSelectionChange(rows) {
      this.ids = rows.map(v => v.id);
    },
    delBatch() {
      if (!this.ids.length) {
        this.$message.warning('请选择数据');
        return;
      }
      this.$confirm('您确定批量删除这些数据吗？', '确认删除', {type: "warning"}).then(response => {
        this.$request.delete('/task/delete/batch', {data: this.ids}).then(res => {
          if (res.code === '200') {
            this.$message.success('操作成功');
            this.load(1);
            this.loadStudentList();
          } else {
            this.$message.error(res.msg);
          }
        });
      }).catch(() => {});
    },
    load(pageNum) {
      if (pageNum) this.pageNum = pageNum;
      if (this.user.role === 'ENTERPRISE') {
        this.$request.get('/task/selectByEnterprise', {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            enterpriseId: this.user.id
          }
        }).then(res => {
          this.tableData = res.data?.list;
          this.total = res.data?.total;
        });
      } else if (this.user.role === 'TEACHER') {
        this.$request.get('/task/selectByTeacher', {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            teacherId: this.user.id
          }
        }).then(res => {
          this.tableData = res.data?.list;
          this.total = res.data?.total;
        });
      } else if (this.user.role === 'STUDENT') {
        this.$request.get('/task/selectByStudent', {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            studentId: this.user.id
          }
        }).then(res => {
          this.tableData = res.data?.list;
          this.total = res.data?.total;
        });
      } else {
        this.$request.get('/task/selectPage', {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            username: this.username,
          }
        }).then(res => {
          this.tableData = res.data?.list;
          this.total = res.data?.total;
        });
      }

    },
    reset() {
      this.username = null;
      this.load(1);
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum);
    },
    handleAvatarSuccess(response, file, fileList) {
      this.form.avatar = response.data;
    },
    getTeacherByClassId(classId) {
      return this.$request.get(`/classes/selectById/${classId}`).then(res => {
        if (res.code === '200') {
          return { classId, teacherId: res.data.teacherId, teacherName: res.data.teacherName };
        } else {
          this.$message.error(res.msg);
          return { classId, teacherId: null, teacherName: '未指定' };
        }
      });
    },
    /*checkIn(row) {
      // 此处需要调用后端接口或直接更新前端数据，将对应行的签到次数加一
      const updatedRow = { ...row };
      updatedRow.count += 1; // 将签到次数加一

      // 调用保存方法或直接更新表格数据
      this.saveCheckIn(updatedRow); // 可能需要保存到后端
    },*/
    evaluate(row){
      if (row.status === '实习中') {
        this.form = JSON.parse(JSON.stringify(row));
        // 自动设置指导老师
        this.getTeacherByClassId(this.form.classId).then(teacherInfo => {
          this.form.teacherName = teacherInfo.teacherName;
          this.editVisible = true;
        });
      } else {
        this.$message.error('只有状态为实习中的任务可以评价');
      }
    },
    /*saveCheckIn(row) {
      // 调用后端接口保存签到次数
      this.$request.put('/task/update', row).then(res => {
        if (res.code === '200') {
          this.$message.success('签到成功');
          // 更新表格中的对应行数据
          const index = this.tableData.findIndex(item => item.id === row.id);
          this.loadSelfData();
          if (index !== -1) {
            this.tableData.splice(index, 1, row);
          }
        } else {
          this.$message.error(res.msg);
        }
      }).catch(err => {
        this.$message.error('签到失败');
      });
    },*/
    searchByGrade() {
      if (this.selectedGrade) {
        this.$request.get('/task/selectByGrade', {
          params: {
            grade: this.selectedGrade,
          }
        }).then(res => {
          if (res.code === '200') {
            this.tableData = res.data;
            this.total = res.data.length;
            this.pageNum = 1;
          } else {
            this.$message.error(res.msg);
          }
        });
      } else {
        this.$message.warning('请选择成绩');
      }
    },
  }
};
</script>

<style scoped>

</style>
