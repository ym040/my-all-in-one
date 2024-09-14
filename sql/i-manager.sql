/*
 Navicat Premium Data Transfer

 Source Server         : MySQL57
 Source Server Type    : MySQL
 Source Server Version : 50735
 Source Host           : localhost:3307
 Source Schema         : i-manager

 Target Server Type    : MySQL
 Target Server Version : 50735
 File Encoding         : 65001

 Date: 14/09/2024 15:03:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', '管理员', 'http://localhost:9090/files/海绵宝宝.webp', 'ADMIN', '16832645262', 'admin@i.com');

-- ----------------------------
-- Table structure for apply
-- ----------------------------
DROP TABLE IF EXISTS `apply`;
CREATE TABLE `apply`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `stu_id` int(11) NULL DEFAULT NULL COMMENT '学生Id',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `class_id` int(10) NULL DEFAULT NULL COMMENT '班级ID',
  `teacher_id` int(11) NULL DEFAULT NULL COMMENT '教师Id',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `enterprise_id` int(10) NULL DEFAULT NULL COMMENT '企业ID',
  `job_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '岗位ID',
  `salary` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '薪资',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '工作地点',
  `begin_time` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '结束时间',
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '未实习' COMMENT '实习状态',
  `read_status` int(11) NULL DEFAULT 1 COMMENT '阅读状态 1未读 2已读',
  `resume_status` int(11) NULL DEFAULT NULL COMMENT '简历状态 1：通过 2：未通过',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `apply_username_uindex`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '实习报名信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of apply
-- ----------------------------
INSERT INTO `apply` VALUES (15, 1, 'lna', '懒羊羊', 5, 6, '13155558888', 1, '2', '12', '这里', '2024-07-15', '2024-07-27', '未实习', 2, NULL);
INSERT INTO `apply` VALUES (16, 2, 'xin', '小新', 4, 8, '15688889999', 2, '1', '111', '那里', '2024-07-23', '2024-07-27', '实习结束', 1, 1);
INSERT INTO `apply` VALUES (17, 3, 'xiyy', '喜羊羊', 4, 8, '14466668888', 2, '6', '22', 'here', '2024-07-22', '2024-07-27', '实习中', 1, 1);
INSERT INTO `apply` VALUES (18, 4, 'rou', '小柔', 3, 4, '11155557777', 2, '6', '77', '77', '2024-07-23', '2024-08-03', '实习结束', 1, 1);
INSERT INTO `apply` VALUES (19, 6, 'stu', '学生', 1, 2, '12345677777', 1, '7', '45', '44', '2024-07-24', '2024-07-19', '未实习', 1, 2);
INSERT INTO `apply` VALUES (20, 5, 'spider', '蜘蛛侠', 3, 4, '16896364695', 1, '2', '80/s', '汤姆家', '2024-08-19', '2025-08-18', '实习中', 2, 1);

-- ----------------------------
-- Table structure for classes
-- ----------------------------
DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '班级名称',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '班级描述',
  `teacher_id` int(10) NULL DEFAULT NULL COMMENT '教师ID',
  `speciality_id` int(10) NULL DEFAULT NULL COMMENT '专业ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `classes_teacher_id_uindex`(`teacher_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '班级信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of classes
-- ----------------------------
INSERT INTO `classes` VALUES (1, '计科1班', '计科1班~~~', 4, 1);
INSERT INTO `classes` VALUES (2, '会计1班', '会计1班~~~', 2, 2);
INSERT INTO `classes` VALUES (3, '英语1班', '英语1班~~~', 3, 4);
INSERT INTO `classes` VALUES (4, '机械1班', '机械1班~~~', 8, 5);
INSERT INTO `classes` VALUES (5, '古汉语1班', '古汉语1班~~~', 6, 3);

-- ----------------------------
-- Table structure for college
-- ----------------------------
DROP TABLE IF EXISTS `college`;
CREATE TABLE `college`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '学院名称',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '学院介绍',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '学院信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of college
-- ----------------------------
INSERT INTO `college` VALUES (1, '计算机学院', '这里是计算机学院~~~');
INSERT INTO `college` VALUES (2, '商学院', '这里是商学院~~~');
INSERT INTO `college` VALUES (3, '外国语学院', '这里是外国语学院~~~');
INSERT INTO `college` VALUES (4, '马克思主义学院', '这里是马克思主义学院~~~');
INSERT INTO `college` VALUES (5, '机械学院', '这里是机械学院~~~');

-- ----------------------------
-- Table structure for enterprise
-- ----------------------------
DROP TABLE IF EXISTS `enterprise`;
CREATE TABLE `enterprise`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公司名称',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `person` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '企业信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of enterprise
-- ----------------------------
INSERT INTO `enterprise` VALUES (1, 'cat', '123', '猫和老鼠有限公司', 'http://localhost:9090/files/1711376902034-19.jpg', 'ENTERPRISE', '汤姆', '12345678912', '杰瑞家');
INSERT INTO `enterprise` VALUES (2, 'earch', '123', '地球有限公司', 'http://localhost:9090/files/1711376964003-13.jpg', 'ENTERPRISE', '罗辑', '13564857952', '行星防御理事会');
INSERT INTO `enterprise` VALUES (3, 'yangcun', '123', '羊村', 'http://localhost:9090/files/1711810657865-羊村.webp', 'ENTERPRISE', 'mna', '13598647536', '青青草原12138号');

-- ----------------------------
-- Table structure for job
-- ----------------------------
DROP TABLE IF EXISTS `job`;
CREATE TABLE `job`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '岗位名称',
  `direction` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '行业方向',
  `enterprise_id` int(10) NULL DEFAULT NULL COMMENT '企业ID',
  `count` int(255) NULL DEFAULT NULL COMMENT '招聘人数',
  `salary` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '薪资',
  `job_describe` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '岗位描述',
  `job_require` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '专业要求',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '工作地点',
  `work_time` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '工作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job
-- ----------------------------
INSERT INTO `job` VALUES (1, 'Java后端开发工程师', '计算机', 2, 7, '7千-1.2万', '1、参与项目需求分析, 独立完成相应软件模块的概要设计及详细设计；\n2、根据新产品开发进度、任务分配和流程，独立完成相应软件模块的开发及测试验证；\n3、根据公司技术文档规范编写相应的技术文档；\n4、独立完成产品软件缺陷和现场反馈问题的跟踪、定位工作，提供完善的解决方案；\n5、持续改进优化相关软件模块；\n6、对前沿技术的预研与学习，编写相关的学习培训材料；\n7、执行上级领导安排的其他相关工作。', '1、全日制本科以上，通信、电子、计算机等相关专业，3年以上相关工作经验；\n2、精通JAVA编程，熟悉JAVA常用开源框架Spring，SpringMVC，MyBatis、Spring Boot、Spring Cloud，熟悉设计模式、异步、多线程、线程池技术；\n3、熟悉至少一种常用的数据库操作，如MySQL、PostgreSQL等，并能对SQL进行性能优化；\n4、熟悉分布式系统基础设施中常用的技术，如缓存、消息队列、搜索引擎等；\n5，熟悉Docker/K8S等容器技术，理解微服务的主要思想。', '星火路9号软件大厦A座2楼', '朝九晚五');
INSERT INTO `job` VALUES (2, 'Python工程师', '软件', 1, 3, '20', '1、设计和建立物联网云平台和数据设施；\n2、优化大数据处理算法及数据库性能，实现大数据的数据挖掘及AI算法；\n3、搭建系统开发环境，完成系统框架和核心代码的实现，负责解决开发过程中的技术问题；\n4、同业务分析师和算法工程师协作，完成产品化落地；\n5、参与软件工程文档、产品文档编写，满足质量要求；\n6、做好模块集成、单元测试、模块测试及确认工作；\n7、解决工程项目中遇到的问题，进行系统功能优化，安全等保证系统安全、稳定和快速运行；', '1、***相关专业本科及以上学历，5年及以上相关工作经验；\n2、掌握常见的Python框架，熟悉Flask、Numpy、Pandas；\n3、精通MySQL，熟悉关系型数据库，懂数据库配置、查询优化者优先；\n4、熟练掌握Pycharm、SVN等常见工具；\n5、熟悉Socket编程、HTTP、TCP协议等，有网络开发经验；\n6、熟悉XML、JSON、protobuf等数据封装方式；\n7、熟悉Linux常用命令，能独立完成Linux环境的搭建及应用的部署，熟悉Web容器性能调优，根据日志跟踪并定位问题；\n8、能承受一定的工作压力，有责任心和上进心，能通过持续学习和完善自身，自信、有担当、执行力强、乐于分享；\n9、熟悉大数据量、高并发、高性能系统优化者优先；\n10、有物联网、车联网、云计算项目开发经验者优先。', '北京市朝阳区永安东里8号', '996');
INSERT INTO `job` VALUES (6, '测试', '测试', 2, 1, '11', 'this.tableData = res.data?.list.map(item => {\n        if (!item.alCount) {\n          item.alCount = 0;  // 如果 alCount 为空，则设置为 0\n        }\n        return item;\n      });', '测试', 'c而是', 'ce时');
INSERT INTO `job` VALUES (7, 'C语言工程师', '计算机', 1, 7, '88', '我们的C语言开发工程师将负责开发和维护公司内部的一些C语言程序，包括但不仅限于：\n- 编写高效、可靠且易于维护的C语言代码；\n- 使用C语言实现公司内部的业务逻辑和功能需求；\n- 与公司内的其他开发人员合作，确保C语言代码与整个系统的兼容性和可靠性；\n- 按照项目要求，编写测试用例并参与代码的单元测试；\n- 对现有的C语言代码进行优化，以提高系统性能和稳定性', '- 熟悉C语言，具有扎实的编程基础；\n- 熟悉Linux系统，并能够在Linux环境下进行开发工作；\n- 熟悉或了解常用的开发工具和技术，如Git等版本控制工具，以及常用的Linux命令；\n- 具备良好的编程习惯，熟悉代码规范，对代码风格有敏感的认识；\n- 具备较强的学习能力和自我驱动能力，能够快速学习新的技术，并将其应用到工作中', '郑州市二七区北二七路224号正弘大厦A座601', '55');
INSERT INTO `job` VALUES (8, '爬虫工程师', '计算机', 2, 1, '12', '1、 对现有爬虫平台进行优化维护，不断总结新的优化思路和方案；\n2、 根据业务需要编写分布式爬虫代码，对海量的目标网站编写规则进行抓取，处理常见的反爬问题；\n3、 对抓取过来的数据进行初步的格式化与清洗工作；\n4、 掌握一定的机器学习技术和AI技术，对现有系统进行智能化改造能有思路并提出建设性意见；\n5、 维护爬虫服务器，保证其稳定运行；\n6、 对已爬取的数据定期进行巡检工作，保证各渠道源爬取稳定。', '1、 有两年以上Python开发团队管理经验，善于沟通，工作积极，态度认真，有主动学习精神；\n2、 熟悉常用的开发框架，如Spring、MyBatis等；\n3、 熟练掌握Python语言，能够基于Python独立完成功能设计以及编码工作；\n4、 精通爬虫相关技术(requests/xpath/scrapy/正则表达式/验证码加密处理/代理池)；\n5、 熟悉HTTP协议，掌握html/css/js/jquery/ajax等相关知识；\n6、 熟悉js加密，了解python常见执行js方法，如pyv8；\n7、 掌握常用数据库（如：MySQL，Mongodb）及相应DDL/DML，熟悉索引及常规SQL调优。', '诚信街22号中交投资大厦', NULL);
INSERT INTO `job` VALUES (9, '运维工程师', '计算机', 3, 12, '45', '1、负责管理本地服务器及阿里云资源等日常维护，技术支持、系统优化、故障处理、相关维护文档编制；\n2、负责以及应用系统日常维护工作，系统上线、升级、部署日常操作；\n3、负责管理办公及网络设备（如路由器、交换机、防火墙）；\n4、负责对现行自动化建设与维护。', '1、本科以上学历，一年以上相关工作经验；\n2、具有Linux系统维护经验以及云服务器相关经验，熟练操作常见的Linux发行版（如CentOS, Ubuntu）系统的安装、配置及日常使用；\n3、具备Shell/Python脚本编写能力，能高效地通过脚本自动化处理日常运维任务；\n4、熟悉Nginx/mysql/redis/消息队列等软件的日常维护及故障排查；\n5、熟悉TCP/IP协议栈以及HTTP协议，能够理解并解决相关的网络通信问题；了解基本的路由与交换技术，能够对交换机、路由器以及防火墙进行必要的配置工作；\n6、熟悉常用的监控工具（如Prometheus, Zabbix等）和日志管理系统（如ELK Stack等），能够设置和维护这些工具以确保系统的稳定运行；\n7、掌握Docker容器技术及Kubernetes集群管理，能够部署、管理和优化容器化应用。', '清华科技园8号楼8层B801', NULL);
INSERT INTO `job` VALUES (10, '大数据分析', '大数据', 1, 12, '344', '1.负责项目业务数据分析工作，利用sql/tableau等报表开发工具，针对成熟的分析模型进行可视化呈现，产出数据分析报表，输出可视化报告；\n2.负责部门各项目数据分析，监控和评估各项目业务所需数据；为部门负责人和业务提供策略分析及业务优化建议；\n3.跟踪项目业务数据，监控数据波动和异常，通过数据分析发现项目问题和机会点，并能提出有效的解决策略；\n4.与项目团队有效沟通，准确分析与把握需求，创建贴合项目需求的数据看板，有效地向项目团队传达解决方案和分析结果，推动业务和项目流程优化。\n5.建立和优化部门数据分析体系，包括报表体系、专题分析体系；\n6. 能够独立完成团队分配的其他任务。', '1.1-3年医疗领域数据分析师工作经验，医疗成本核算，医保支付服务（DIP/DRG）、医疗服务价格等相关领域数据分析师优先考虑；\n2.数学、统计、计算机软件等相关专业大专或以上学历；\n3.较强的数据处理能力，具备独立编写数据分析报告的能力，擅长Excel、PPT、SPSS等；\n4.熟悉SQL语言，熟悉Mysql、Oracle、SqlServer、Caché至少一种数据库，熟悉一门编程语言，Python语言优先；\n5.善于观察与学习，耐心且具有良好的沟通能力与团队协作意识；\n6.能够适应一定程度项目短期出差的工作节奏；\n7.具有较强的表达、沟通、协调、组织能力，责任心强，具有较强执行力、创新服务意识，积极主动完成各项工作。', '医保局', NULL);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `time` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建时间',
  `user` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '公告信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '今天系统正式上线，开始内测', '今天系统正式上线，开始内测', '2024-03-05', 'admin');
INSERT INTO `notice` VALUES (2, '所有功能都已完成，可以正常使用', '所有功能都已完成，可以正常使用', '2024-03-05', 'admin');
INSERT INTO `notice` VALUES (3, '一批新岗位正在招聘中', '2024.3一批新岗位正在招聘中', '2024-03-05', 'admin');

-- ----------------------------
-- Table structure for resume
-- ----------------------------
DROP TABLE IF EXISTS `resume`;
CREATE TABLE `resume`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '简历ID',
  `student_id` int(10) NOT NULL COMMENT '学生ID',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '姓名',
  `tel` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `address` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '现居城市',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '求职状态',
  `city` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '意向城市',
  `department` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '期望职位',
  `salary` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '期望薪资',
  `person` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '个人总结',
  `education` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '教育背景',
  `project` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '项目经历',
  `skills` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '技能、证书',
  `honor` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '荣誉奖项',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `resume_student_id_uindex`(`student_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resume
-- ----------------------------
INSERT INTO `resume` VALUES (1, 0, 'ceshi', '16826483569', '59663@i.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `resume` VALUES (2, 6, '懒羊羊', '13313131313', '556@i.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `resume` VALUES (3, 2, '小新', '17769368598', '456@i.com', '南京', '男', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `resume` VALUES (4, 3, '喜羊羊', '16865423698', '369@i.com', '南京', NULL, NULL, '南京', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `resume` VALUES (5, 5, '蜘蛛侠', '17796583246', '987@i.com', NULL, '男', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `resume` VALUES (6, 4, '小柔', '13689567596', '987@i.com', '南京', '女', '应届毕业生', '南京', 'Java工程师', '5k', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `student_id` int(10) NULL DEFAULT NULL COMMENT '学生ID',
  `enterprise_id` int(10) NULL DEFAULT NULL COMMENT '企业ID',
  `teacher_id` int(10) NULL DEFAULT NULL COMMENT '教师ID',
  `enterprise_score` double(10, 2) NULL DEFAULT NULL COMMENT '企业评分',
  `teacher_score` double(10, 2) NULL DEFAULT NULL COMMENT '教师评分',
  `score` double(10, 2) NULL DEFAULT NULL COMMENT '总成绩',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '成绩信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES (1, 2, 1, 4, 90.00, 95.00, 93.50);
INSERT INTO `score` VALUES (2, 4, 2, 2, 90.00, 90.00, 90.00);
INSERT INTO `score` VALUES (3, 5, 3, 3, 95.00, 95.00, 95.00);

-- ----------------------------
-- Table structure for speciality
-- ----------------------------
DROP TABLE IF EXISTS `speciality`;
CREATE TABLE `speciality`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '专业名称',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '专业描述',
  `college_id` int(10) NULL DEFAULT NULL COMMENT '所属学院',
  `score` int(10) NULL DEFAULT NULL COMMENT '学分限定',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '专业信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of speciality
-- ----------------------------
INSERT INTO `speciality` VALUES (1, '计算机科学与技术', '计算机科学与技术~~~', 1, 50);
INSERT INTO `speciality` VALUES (2, '会计', '会计~~~', 2, 50);
INSERT INTO `speciality` VALUES (3, '汉语言文学', '汉语言文学~~~', 4, 50);
INSERT INTO `speciality` VALUES (4, '英语', '英语~~~', 3, 50);
INSERT INTO `speciality` VALUES (5, '机械工程', '机械工程~~~', 5, 50);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `college_id` int(10) NULL DEFAULT NULL COMMENT '学院ID',
  `speciality_id` int(10) NULL DEFAULT NULL COMMENT '专业ID',
  `class_id` int(10) NULL DEFAULT NULL COMMENT '班级ID',
  `score` int(10) NULL DEFAULT 0 COMMENT '实习成绩',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '学生信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, 'lna', '123', '懒羊羊', 'http://localhost:9090/files/1720350173015-05.jpg', 'STUDENT', 4, 3, 5, 0);
INSERT INTO `student` VALUES (2, 'xin', '123', '小新', 'http://localhost:9090/files/1711373922289-24.jpeg', 'STUDENT', 5, 5, 4, 0);
INSERT INTO `student` VALUES (3, 'xiyy', '123', '喜羊羊', 'http://localhost:9090/files/1711810606782-喜羊羊.webp', 'STUDENT', 5, 5, 4, 0);
INSERT INTO `student` VALUES (4, 'rou', '123', '小柔', 'http://localhost:9090/files/1712242984816-02.png', 'STUDENT', 3, 4, 3, 0);
INSERT INTO `student` VALUES (5, 'spider', '123', '蜘蛛侠', 'http://localhost:9090/files/1712243018985-10.png', 'STUDENT', 3, 4, 3, 0);
INSERT INTO `student` VALUES (6, 'stu', '123', '学生', 'http://localhost:9090/files/1720075379227-06.jpg', 'STUDENT', 1, 1, 1, 0);
INSERT INTO `student` VALUES (7, '1111', '123', '111111', NULL, 'STUDENT', 1, 1, 1, 0);
INSERT INTO `student` VALUES (8, 'test', '123', '学生测试', 'http://localhost:9090/files/1720078099034-01.jpeg', 'STUDENT', 4, 3, 5, 0);

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `student_id` int(10) NULL DEFAULT NULL COMMENT '学生ID',
  `class_id` int(10) NULL DEFAULT NULL COMMENT '班级ID',
  `teacher_id` int(10) NULL DEFAULT NULL COMMENT '指导老师ID',
  `job_id` int(10) NULL DEFAULT NULL COMMENT '岗位ID',
  `enterprise_id` int(10) NULL DEFAULT NULL COMMENT '企业ID',
  `file` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '三方协议',
  `count` int(10) NULL DEFAULT 0 COMMENT '签到次数',
  `record` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '周志',
  `enterprise_remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '企业评价',
  `teacher_remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '教师评价',
  `report` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '实践报告',
  `self` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自我鉴定',
  `grade` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '成绩鉴定',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '实习任务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES (3, 2, 4, 8, 1, 2, 'http://localhost:9090/files/1720357761680-219-6.pdf', 0, 'http://localhost:9090/files/1720361245388-76-4.pdf', '111', '222', 'http://localhost:9090/files/1720361363328-管道原始记录.doc', '333', '优秀');
INSERT INTO `task` VALUES (7, 3, 4, 8, 6, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `task` VALUES (10, 5, 3, 4, 2, 1, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `task` VALUES (11, 4, 3, 4, 6, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '职称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '教师信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES (2, 'lan', '123', '小兰', 'http://localhost:9090/files/1711294329463-09.jpg', 'TEACHER', '13344446666', '666@i.com', '副教授');
INSERT INTO `teacher` VALUES (3, '02', '123', '达令', 'http://localhost:9090/files/1711294370010-02.jpg', 'TEACHER', '16656942675', '366@i.com', '副教授');
INSERT INTO `teacher` VALUES (4, 'xinyi', '123', '新一', 'http://localhost:9090/files/1711373826062-26.jpg', 'TEACHER', '16664597856', '666@i.com', '教授');
INSERT INTO `teacher` VALUES (6, 'ali', '123', '阿离', 'http://localhost:9090/files/1712241945652-公孙离1.png', 'TEACHER', '16594683569', '999@i.com', '教授');
INSERT INTO `teacher` VALUES (8, 'tea', '123', '教师', 'http://localhost:9090/files/1720075167169-10.png', 'TEACHER', '17633468533', '133@i.com', '研究生');

-- ----------------------------
-- Table structure for useractions
-- ----------------------------
DROP TABLE IF EXISTS `useractions`;
CREATE TABLE `useractions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `userId` int(11) NOT NULL COMMENT '用户ID',
  `jobId` int(11) NOT NULL COMMENT '岗位ID',
  `actionType` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户行为 VIEW/APPLY',
  `localDateTime` datetime(0) NULL DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `useractions_job_id_fk`(`jobId`) USING BTREE,
  INDEX `useractions_student_id_fk`(`userId`) USING BTREE,
  CONSTRAINT `useractions_job_id_fk` FOREIGN KEY (`jobId`) REFERENCES `job` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `useractions_student_id_fk` FOREIGN KEY (`userId`) REFERENCES `student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户行为记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of useractions
-- ----------------------------
INSERT INTO `useractions` VALUES (1, 6, 1, 'VIEW', '2024-09-09 23:36:05');
INSERT INTO `useractions` VALUES (2, 6, 2, 'VIEW', '2024-09-09 23:36:48');
INSERT INTO `useractions` VALUES (3, 6, 7, 'APPLY', '2024-09-09 23:40:40');
INSERT INTO `useractions` VALUES (4, 1, 8, 'VIEW', '2024-09-10 22:02:24');
INSERT INTO `useractions` VALUES (5, 1, 7, 'VIEW', '2024-09-10 22:02:27');
INSERT INTO `useractions` VALUES (6, 1, 1, 'VIEW', '2024-09-10 22:02:29');
INSERT INTO `useractions` VALUES (7, 1, 2, 'APPLY', '2024-09-10 22:02:37');
INSERT INTO `useractions` VALUES (8, 4, 10, 'VIEW', '2024-09-10 22:11:31');
INSERT INTO `useractions` VALUES (9, 4, 2, 'VIEW', '2024-09-10 22:11:34');
INSERT INTO `useractions` VALUES (10, 4, 1, 'VIEW', '2024-09-10 22:11:36');
INSERT INTO `useractions` VALUES (11, 4, 6, 'APPLY', '2024-09-10 22:11:45');
INSERT INTO `useractions` VALUES (12, 2, 1, 'VIEW', '2024-09-10 22:12:00');
INSERT INTO `useractions` VALUES (13, 2, 2, 'VIEW', '2024-09-10 22:12:01');
INSERT INTO `useractions` VALUES (14, 2, 6, 'VIEW', '2024-09-10 22:12:03');
INSERT INTO `useractions` VALUES (15, 2, 1, 'APPLY', '2024-09-10 22:12:10');
INSERT INTO `useractions` VALUES (16, 3, 9, 'VIEW', '2024-09-10 22:12:23');
INSERT INTO `useractions` VALUES (17, 3, 8, 'VIEW', '2024-09-10 22:12:24');
INSERT INTO `useractions` VALUES (18, 3, 7, 'VIEW', '2024-09-10 22:12:26');
INSERT INTO `useractions` VALUES (19, 3, 6, 'APPLY', '2024-09-10 22:12:32');
INSERT INTO `useractions` VALUES (20, 1, 6, 'APPLY', '2024-09-13 21:30:09');
INSERT INTO `useractions` VALUES (21, 1, 6, 'APPLY', '2024-09-13 21:30:15');

-- ----------------------------
-- Table structure for workplan
-- ----------------------------
DROP TABLE IF EXISTS `workplan`;
CREATE TABLE `workplan`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '实习安排表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of workplan
-- ----------------------------
INSERT INTO `workplan` VALUES (1, '2021级计算机专业学生实习安排', '2021级计算机专业学生开始实习！', '2024-04-01 22:51:43');

SET FOREIGN_KEY_CHECKS = 1;
