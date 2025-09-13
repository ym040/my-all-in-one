<template>
  <div class="shinchan-student">
    <div class="search">
      <el-input
        placeholder="请输入账号查询"
        style="width: 200px"
        v-model="username"
        class="shinchan-input"
      ></el-input>
      <el-button
        type="primary"
        plain
        style="margin-left: 10px"
        @click="load(1)"
        class="shinchan-button"
      >
        <i class="el-icon-search button-icon"></i>
        查询
      </el-button>
      <el-button
        type="warning"
        plain
        style="margin-left: 10px"
        @click="reset"
        class="shinchan-button"
      >
        <i class="el-icon-refresh button-icon"></i>
        重置
      </el-button>
    </div>

    <div class="operation">
      <el-button
        type="primary"
        plain
        @click="handleAdd"
        class="shinchan-button"
      >
        <i class="el-icon-circle-plus button-icon"></i>
        新增
      </el-button>
      <el-button
        type="danger"
        plain
        @click="delBatch"
        class="shinchan-button"
      >
        <i class="el-icon-delete button-icon"></i>
        批量删除
      </el-button>
    </div>

    <div class="table">
      <el-table
        :data="tableData"
        stripe
        @selection-change="handleSelectionChange"
        class="shinchan-table"
      >
        <el-table-column type="selection" width="55" align="center"></el-table-column>
        <el-table-column prop="id" label="序号" width="70" align="center" sortable></el-table-column>
        <el-table-column label="头像">
          <template v-slot="scope">
            <div style="display: flex; align-items: center; justify-content: center;">
              <el-image
                style="width: 40px; height: 40px; border-radius: 50%"
                v-if="scope.row.avatar"
                :src="scope.row.avatar"
                :preview-src-list="[scope.row.avatar]"
              ></el-image>
              <img
                v-else
                src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                style="width: 40px; height: 40px; border-radius: 50%"
              />
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="username" label="账号"></el-table-column>
        <el-table-column prop="name" label="姓名"></el-table-column>
        <el-table-column prop="role" label="角色"></el-table-column>
        <el-table-column prop="collegeName" label="学院"></el-table-column>
        <el-table-column prop="specialityName" label="专业"></el-table-column>
        <el-table-column prop="className" label="班级"></el-table-column>
        <el-table-column label="操作" align="center" width="180">
          <template v-slot="scope">
            <el-button
              size="mini"
              type="primary"
              plain
              @click="handleEdit(scope.row)"
              class="shinchan-button edit-button"
            >
              <i class="el-icon-edit button-icon-small"></i>
              编辑
            </el-button>
            <el-button
              size="mini"
              type="danger"
              plain
              @click="del(scope.row.id)"
              class="shinchan-button delete-button"
            >
              <i class="el-icon-delete button-icon-small"></i>
              删除
            </el-button>
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
            :total="total"
            class="shinchan-pagination"
        >
        </el-pagination>
      </div>
    </div>


    <el-dialog
      title="学生信息"
      :visible.sync="fromVisible"
      width="40%"
      :close-on-click-modal="false"
      destroy-on-close
      class="shinchan-dialog"
    >
      <div class="dialog-header">
        <i class="el-icon-edit-outline form-icon"></i>
        <span>填写学生信息</span>
      </div>

      <el-form
        :model="form"
        label-width="100px"
        style="padding-right: 50px"
        :rules="rules"
        ref="formRef"
        class="shinchan-form"
      >
        <el-form-item label="头像">
          <el-upload
              class="avatar-uploader"
              :action="$baseUrl + '/files/upload'"
              :headers="{ token: user.token }"
              list-type="picture"
              :on-success="handleAvatarSuccess"
          >
            <el-button
              type="primary"
              class="shinchan-button upload-button"
            >
              <i class="el-icon-upload button-icon"></i>
              上传头像
            </el-button>
          </el-upload>
        </el-form-item>
        <el-form-item label="用户名" prop="username">
          <div class="input-wrapper">
            <i class="el-icon-user input-icon"></i>
            <el-input
              v-model="form.username"
              placeholder="用户名"
              class="shinchan-input"
            ></el-input>
          </div>
        </el-form-item>
        <el-form-item label="姓名" prop="name">
          <div class="input-wrapper">
            <i class="el-icon-user input-icon"></i>
            <el-input
              v-model="form.name"
              placeholder="姓名"
              class="shinchan-input"
            ></el-input>
          </div>
        </el-form-item>
        <el-form-item label="学院" prop="collegeId">
          <div class="select-wrapper">
            <i class="el-icon-office-building input-icon"></i>
            <el-select
              v-model="form.collegeId"
              placeholder="请选择学院"
              style="width: 100%"
              @change="handleCollegeChange"
              class="shinchan-select"
            >
              <el-option
                v-for="item in collegeData"
                :key="item.id"
                :label="item.name"
                :value="item.id"
              ></el-option>
            </el-select>
          </div>
        </el-form-item>
        <el-form-item label="专业" prop="specialityId">
          <div class="select-wrapper">
            <i class="el-icon-collection input-icon"></i>
            <el-select
              v-model="form.specialityId"
              placeholder="请选择专业"
              style="width: 100%"
              @change="handleSpecialityChange"
              class="shinchan-select"
            >
              <el-option
                v-for="item in specialityData"
                :key="item.id"
                :label="item.name"
                :value="item.id"
              ></el-option>
            </el-select>
          </div>
        </el-form-item>
        <el-form-item label="班级" prop="classId">
          <div class="select-wrapper">
            <i class="el-icon-s-custom input-icon"></i>
            <el-select
              v-model="form.classId"
              placeholder="请选择班级"
              style="width: 100%"
              class="shinchan-select"
            >
              <el-option
                v-for="item in classData"
                :key="item.id"
                :label="item.name"
                :value="item.id"
              ></el-option>
            </el-select>
          </div>
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button
          @click="fromVisible = false"
          class="shinchan-button cancel-button"
        >
          <i class="el-icon-close button-icon"></i>
          取 消
        </el-button>
        <el-button
          type="primary"
          @click="save"
          class="shinchan-button confirm-button"
        >
          <i class="el-icon-check button-icon"></i>
          确 定
        </el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "Student",
  data() {
    return {
      tableData: [],  // 所有的数据
      pageNum: 1,   // 当前的页码
      pageSize: 7,  // 每页显示的个数
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
      collegeData: [],
      specialityData: [],
      classData: [],
    }
  },
  created() {
    this.load(1)
    this.loadCollege()
  },
  methods: {
    loadCollege() {
      this.$request.get('/college/selectAll').then(res => {
        if (res.code === '200') {
          this.collegeData = res.data;
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    loadSpeciality(collegeId) {
      return this.$request.get(`/speciality/selectByCollegeId/${collegeId}`).then(res => {
        if (res.code === '200') {
          this.specialityData = res.data; // 确保这里接收的是列表
          this.classData = []; // 清空班级数据
          this.form.specialityId = null; // 清空选中的专业
          this.form.classId = null; // 清空选中的班级
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    loadClasses(specialityId) {
      return this.$request.get(`/classes/selectBySpecialityId/${specialityId}`).then(res => {
        if (res.code === '200') {
          this.classData = res.data; // 确保这里接收的是列表
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    handleAdd() {
      this.form = {};  // 新增数据的时候清空数据
      this.fromVisible = true;   // 打开弹窗
      this.loadCollege();  // 加载学院数据
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row));  // 深拷贝数据
      this.fromVisible = true;   // 打开弹窗

      // 加载学院的专业
      this.loadSpeciality(row.collegeId).then(() => {
        this.form.specialityId = row.specialityId;  // 设置专业
        // 在专业加载完成后加载班级
        this.loadClasses(row.specialityId).then(() => {
          this.form.classId = row.classId;  // 设置班级
        });
      });
    },
    handleCollegeChange(collegeId) {
      this.loadSpeciality(collegeId); // 加载新的专业
    },
    handleSpecialityChange(specialityId) {
      this.loadClasses(specialityId); // 加载新的班级
    },
    save() {   // 保存按钮触发的逻辑  它会触发新增或者更新
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.$request({
            url: this.form.id ? '/student/update' : '/student/add',
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
        this.$request.delete('/student/delete/' + id).then(res => {
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
        this.$request.delete('/student/delete/batch', {data: this.ids}).then(res => {
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
      this.$request.get('/student/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          username: this.username,
        }
      }).then(res => {
        this.tableData = res.data?.list
        this.total = res.data?.total
      })
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
  }
}
</script>

<style scoped>
.shinchan-student {
  padding: 20px;
  background: linear-gradient(135deg, #E0FFFF, #FFE4E1);
  min-height: 100vh;
  font-family: 'Comic Sans MS', '幼圆', '微软雅黑', sans-serif;
}

.shinchan-input ::v-deep .el-input__inner {
  border: 2px solid #87CEEB;
  border-radius: 20px;
  background-color: white;
}

.shinchan-button {
  border-radius: 20px;
  font-weight: bold;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}

.button-icon {
  margin-right: 5px;
  font-size: 16px;
}

.button-icon-small {
  margin-right: 3px;
  font-size: 12px;
}

.shinchan-table ::v-deep .el-table__header th {
  background-color: #FFD700;
  color: #8B4513;
  font-weight: bold;
}

.shinchan-table ::v-deep .el-table__row:hover {
  background-color: #FFE4E1 !important;
}

.edit-button {
  background-color: #87CEEB;
  border: none;
  color: white;
  margin-right: 5px;
}

.delete-button {
  background-color: #FF6347;
  border: none;
  color: white;
}

.shinchan-pagination ::v-deep .el-pager li.active {
  background-color: #FF69B4 !important;
  color: white;
}

.shinchan-pagination ::v-deep .el-pager li:hover {
  color: #FF69B4;
}

.shinchan-dialog ::v-deep .el-dialog__header {
  background: linear-gradient(90deg, #FFD700, #FFA500);
  border-bottom: 2px dashed #FF6347;
  padding: 15px 20px;
  border-radius: 15px 15px 0 0;
}

.shinchan-dialog ::v-deep .el-dialog__title {
  color: #8B4513;
  font-weight: bold;
  font-size: 18px;
}

.dialog-header {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

.form-icon {
  font-size: 24px;
  margin-right: 10px;
  color: #8B4513;
}

.input-wrapper, .select-wrapper {
  position: relative;
  display: flex;
  align-items: center;
  background: white;
  border: 2px solid #87CEEB;
  border-radius: 20px;
  padding: 5px 15px;
}

.input-icon {
  font-size: 20px;
  margin-right: 10px;
  color: #4169E1;
}

.shinchan-select ::v-deep .el-input__inner {
  border: none;
  outline: none;
  background: transparent;
  height: 40px;
}

.shinchan-select ::v-deep .el-input__icon {
  display: none;
}

.upload-button {
  background: linear-gradient(45deg, #98FB98, #32CD32);
  border: none;
  color: white;
}

.dialog-footer {
  display: flex;
  justify-content: center;
  padding: 20px;
  border-top: 2px dashed #87CEEB;
}

.cancel-button {
  background: linear-gradient(45deg, #D3D3D3, #A9A9A9);
  border: none;
  color: white;
  margin-right: 20px;
}

.confirm-button {
  background: linear-gradient(45deg, #87CEEB, #4169E1);
  border: none;
  color: white;
}
</style>
