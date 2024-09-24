<template>
  <div>
    <div class="card" style="padding: 15px;">
      您好，{{ user?.name }}！欢迎使用本系统
    </div>

    <div style="display: flex; margin: 10px 0">
      <div style="width: 50%;" class="card card-fixed">
        <div style="margin-bottom: 30px; font-size: 20px; font-weight: bold">公告列表</div>
        <div>
          <el-timeline slot="reference">
            <el-timeline-item v-for="item in notices" :key="item.id" :timestamp="item.time">
              <el-popover
                  placement="right"
                  width="200"
                  trigger="hover"
                  :content="item.content">
                <span slot="reference">{{ item.title }}</span>
              </el-popover>
            </el-timeline-item>
          </el-timeline>
        </div>
      </div>
      <div style="width: 50%;" class="card card-fixed">
        <div style="margin-bottom: 30px; font-size: 20px; font-weight: bold">实习安排</div>
        <div>
          <el-timeline slot="reference"> <!--reverse-->
            <el-timeline-item v-for="item in workplans" :key="item.id" :timestamp="item.time">
              <el-popover
                  placement="right"
                  width="200"
                  trigger="hover"
                  :content="item.content">
                <span slot="reference">{{ item.name }}</span>
              </el-popover>
            </el-timeline-item>
          </el-timeline>
        </div>
      </div>
    </div>

    <div class="card" style="width: 50%; margin: 0 auto; padding: 20px; height: 300px;" v-if="user.role === 'ADMIN' || user.role === 'TEACHER'">
      <div style="font-size: 20px; font-weight: bold; text-align: center; margin-bottom: 10px">
        实习人数分布
      </div>
<!--      <div style="text-align: center; margin-bottom: 10px">总人数：{{ chartData.total }}</div> &lt;!&ndash; 显示总人数 &ndash;&gt;-->
      <div id="internship-pie-chart" style="width: 100%; height: 250px;"></div> <!-- 缩小图表高度 -->
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
.card {
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  border-radius: 6px;
  padding: 15px;
  overflow: hidden;
}
.card-fixed {
  max-height: 250px; /* 固定卡片高度，按需调整 */
  overflow: hidden;  /* 隐藏超出部分 */
}

</style>