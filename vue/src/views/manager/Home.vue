<template>
  <div class="shinchan-home">
    <div class="welcome-card shinchan-card">
      <div class="welcome-content">
        <div class="welcome-text">您好，{{ user?.name }}！欢迎使用本系统</div>
      </div>
    </div>

    <div class="content-container">
      <div class="notices-section shinchan-card">
        <div class="section-header">
          <i class="el-icon-message section-icon"></i>
          <div class="section-title">公告列表</div>
        </div>
        <div class="timeline-container">
          <el-timeline slot="reference">
            <el-timeline-item
              v-for="item in notices"
              :key="item.id"
              :timestamp="item.time"
              class="shinchan-timeline-item"
            >
              <el-popover
                placement="right"
                width="200"
                trigger="hover"
                :content="item.content"
              >
                <span slot="reference" class="timeline-content">{{ item.title }}</span>
              </el-popover>
            </el-timeline-item>
          </el-timeline>
        </div>
      </div>

      <div class="workplans-section shinchan-card">
        <div class="section-header">
          <i class="el-icon-date section-icon"></i>
          <div class="section-title">实习安排</div>
        </div>
        <div class="timeline-container">
          <el-timeline slot="reference">
            <el-timeline-item
              v-for="item in workplans"
              :key="item.id"
              :timestamp="item.time"
              class="shinchan-timeline-item"
            >
              <el-popover
                placement="right"
                width="200"
                trigger="hover"
                :content="item.content"
              >
                <span slot="reference" class="timeline-content">{{ item.name }}</span>
              </el-popover>
            </el-timeline-item>
          </el-timeline>
        </div>
      </div>
    </div>

    <div
      class="chart-card shinchan-card"
      v-if="user.role === 'ADMIN' || user.role === 'TEACHER'"
    >
      <div class="chart-header">
        <i class="el-icon-data-analysis chart-icon"></i>
        <div class="chart-title">实习人数分布</div>
      </div>
      <div id="internship-pie-chart" class="chart-container"></div>
    </div>
  </div>
</template>

<script>
import * as echarts from 'echarts'; // 引入 ECharts

export default {
  name: 'Home',
  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      notices: [],
      workplans: [],
      chartData: {
        total: 0,
        noInternship: 0,
        inProgress: 0,
        completed: 0,
        notApplied: 0,
      }
    }
  },
  created() {
    this.$request.get('/notice/selectAll').then(res => {
      this.notices = res.data || []
    })
    this.$request.get('/workplan/selectAll').then(res => {
      if (res.code === '200') {
        this.workplans = res.data || []
      } else {
        this.$message.error(res.msg)
      }
    })
    // 获取饼图数据
    this.fetchChartData();
  },
  mounted() {
    this.initChart();
    // 禁用滚动条
    document.body.style.overflow = 'hidden';
  },
  methods: {
    fetchChartData() {
      // 获取饼图数据并更新图表（只有 ADMIN 和 TEACHER 角色才需要）
      if (this.user.role === 'ADMIN' || this.user.role === 'TEACHER') {
        Promise.all([
          this.$request.get('student/selectCount'),          // 总人数
          this.$request.get('apply/selectFStatusCount'),    // 未实习
          this.$request.get('apply/selectTStatusCount'),    // 实习中
          this.$request.get('apply/selectEndStatusCount'),  // 实习结束
          this.$request.get('apply/selectNoApplyCount')     // 未申请
        ]).then(([totalRes, noInternRes, inProgressRes, completedRes, noApplyRes]) => {
          this.chartData.total = totalRes.data || 0;
          this.chartData.noInternship = noInternRes.data || 0;
          this.chartData.inProgress = inProgressRes.data || 0;
          this.chartData.completed = completedRes.data || 0;
          this.chartData.notApplied = noApplyRes.data || 0;
          this.updateChart(); // 数据获取后更新图表
        });
      }
    },
    initChart() {
      // 只有在 ADMIN 或 TEACHER 角色时才初始化图表
      if (this.user.role === 'ADMIN' || this.user.role === 'TEACHER') {
        this.chart = echarts.init(document.getElementById('internship-pie-chart'));
        const option = {
          tooltip: {
            trigger: 'item'
          },
          legend: {
            top: '0%',
            left: 'center',
            orient: 'horizontal'
          },
          series: [
            {
              name: '人数分布',
              type: 'pie',
              radius: ['40%', '70%'], // 内环半径40%，外环半径70%
              center: ['50%', '50%'], // 图表居中
              data: [
                { value: this.chartData.noInternship, name: '未实习' },
                { value: this.chartData.inProgress, name: '实习中' },
                { value: this.chartData.completed, name: '实习结束' },
                { value: this.chartData.notApplied, name: '未申请' }
              ],
              itemStyle: {
                borderRadius: 5,
                borderWidth: 2, // 设置扇形的边框宽度以产生间隙效果
                borderColor: '#fff' // 设置扇形的边框颜色为白色或者透明色
              },
              emphasis: {
                itemStyle: {
                  shadowBlur: 10,
                  shadowOffsetX: 0,
                  shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
              }
            }
          ]
        };
        this.chart.setOption(option);
      }
    },
    updateChart() {
      // 检查图表实例是否已初始化
      if (this.chart) {
        this.chart.setOption({
          series: [
            {
              data: [
                { value: this.chartData.noInternship, name: '未实习' },
                { value: this.chartData.inProgress, name: '实习中' },
                { value: this.chartData.completed, name: '实习结束' },
                { value: this.chartData.notApplied, name: '未申请' }
              ]
            }
          ]
        });
      }
    }
  }
}
</script>

<style scoped>
.shinchan-home {
  padding: 20px;
  background: linear-gradient(135deg, #E0FFFF, #FFE4E1);
  min-height: 100vh;
}

.welcome-card {
  background: linear-gradient(90deg, #FFD700, #FFA500);
  border: 3px dashed #FF6347;
  border-radius: 20px;
  padding: 20px;
  margin-bottom: 30px;
  box-shadow: 0 5px 15px rgba(255, 105, 180, 0.3);
}

.welcome-content {
  display: flex;
  align-items: center;
  justify-content: center;
}

.welcome-text {
  font-size: 20px;
  font-weight: bold;
  color: #8B4513;
  text-shadow: 1px 1px 2px rgba(255, 255, 255, 0.5);
}

.content-container {
  display: flex;
  gap: 20px;
  margin-bottom: 30px;
}

.notices-section, .workplans-section {
  flex: 1;
  padding: 20px;
  border: 3px solid #87CEEB;
  border-radius: 20px;
  background-color: #FFFACD;
  box-shadow: 0 5px 15px rgba(135, 206, 235, 0.3);
}

.section-header {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 2px dashed #FF69B4;
}

.section-icon {
  font-size: 24px;
  margin-right: 10px;
  color: #4169E1;
}

.section-title {
  font-size: 20px;
  font-weight: bold;
  color: #4169E1;
}

.timeline-container {
  max-height: 200px;
  overflow-y: auto;
}

.shinchan-timeline-item ::v-deep .el-timeline-item__timestamp {
  color: #808080;
  font-size: 12px;
}

.timeline-content {
  color: #4682B4;
  font-weight: 500;
  cursor: pointer;
}

.timeline-content:hover {
  color: #FF4500;
  text-decoration: underline;
}

.chart-card {
  width: 50%;
  margin: 0 auto;
  padding: 20px;
  height: 350px;
  background-color: #FFFACD;
  border: 3px solid #98FB98;
  border-radius: 20px;
  box-shadow: 0 5px 15px rgba(152, 251, 152, 0.3);
}

.chart-header {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 15px;
}

.chart-icon {
  font-size: 24px;
  margin-right: 10px;
  color: #32CD32;
}

.chart-title {
  font-size: 20px;
  font-weight: bold;
  color: #32CD32;
  text-align: center;
}

.chart-container {
  width: 100%;
  height: 280px;
}

.shinchan-card {
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
  border-radius: 15px;
  overflow: hidden;
}

/* 滚动条样式 */
.timeline-container::-webkit-scrollbar {
  width: 6px;
}

.timeline-container::-webkit-scrollbar-thumb {
  background-color: #FFB6C1;
  border-radius: 3px;
}

@media (max-width: 768px) {
  .content-container {
    flex-direction: column;
  }

  .chart-card {
    width: 100%;
  }
}
</style>
