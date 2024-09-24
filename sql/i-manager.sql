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

 Date: 24/09/2024 23:19:12
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
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '实习报名信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of apply
-- ----------------------------
INSERT INTO `apply` VALUES (15, 1, 'gaoyujie', '高宇杰', 5, 6, '13685695684', 1, '2', '3k', '上海', '2024-07-15', '2024-07-27', '未实习', 2, NULL);
INSERT INTO `apply` VALUES (16, 2, 'lijiaying', '李佳颖', 4, 8, '16653694569', 2, '1', '10k', '广州', '2024-07-23', '2024-07-27', '实习结束', 1, 1);
INSERT INTO `apply` VALUES (17, 3, 'liushiqi', '刘诗琪', 4, 8, '16956984536', 3, '9', '22k', '北京', '2024-07-22', '2024-07-27', '实习中', 2, 1);
INSERT INTO `apply` VALUES (18, 4, 'chenxinyi', '陈欣怡', 3, 4, '15936524698', 2, '6', '7k', '南京', '2024-07-23', '2024-08-03', '实习结束', 1, 1);
INSERT INTO `apply` VALUES (19, 6, 'limingxuan', '李明轩', 1, 2, '14965863569', 1, '7', '5k', '苏州', '2024-07-24', '2024-07-19', '未实习', 2, 2);
INSERT INTO `apply` VALUES (20, 5, 'songyifan', '宋一帆', 3, 4, '16895684269', 1, '2', '8k', '上海', '2024-08-19', '2025-08-18', '实习中', 2, 1);
INSERT INTO `apply` VALUES (21, 9, 'yangzixuan', '杨紫萱', 1, 9, '16936963569', 4, '14', '16k', '南京', '2024-09-16', '2024-12-23', '实习中', 2, 1);
INSERT INTO `apply` VALUES (22, 8, 'xushijie', '许世杰', 5, 2, '13695681268', 1, '7', '9k', '杭州', '2024-09-20', '2025-09-25', '未实习', 2, NULL);
INSERT INTO `apply` VALUES (23, 10, 'zake', '张坤', 6, 10, '16523695846', 8, '22', NULL, NULL, '2024-09-23', '2025-09-12', '实习结束', 2, 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '班级信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of classes
-- ----------------------------
INSERT INTO `classes` VALUES (1, '计科1班', '计科1班~~~', 4, 1);
INSERT INTO `classes` VALUES (2, '会计1班', '会计1班~~~', 2, 2);
INSERT INTO `classes` VALUES (3, '英语1班', '英语1班~~~', 3, 4);
INSERT INTO `classes` VALUES (4, '机械1班', '机械1班~~~', 8, 5);
INSERT INTO `classes` VALUES (5, '古汉语1班', '古汉语1班~~~', 6, 3);
INSERT INTO `classes` VALUES (6, '计科2班', '计算机科学与技术2班', 10, 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '企业信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of enterprise
-- ----------------------------
INSERT INTO `enterprise` VALUES (1, 'xingchen', '123', '星辰科技有限公司', 'http://localhost:9090/files/1711376902034-19.jpg', 'ENTERPRISE', '李星辰', '13626954693', '上海市浦东新区陆家嘴环路1000号');
INSERT INTO `enterprise` VALUES (2, 'zhilian', '123', '智联网络技术有限公司', 'http://localhost:9090/files/1711376964003-13.jpg', 'ENTERPRISE', '张智', '13564857952', '北京市海淀区中关村大街1号');
INSERT INTO `enterprise` VALUES (3, 'yunfan', '123', '云帆信息技术股份有限公司', 'http://localhost:9090/files/1711810657865-羊村.webp', 'ENTERPRISE', '王丽', '13598647536', '深圳市南山区科技园中区1栋');
INSERT INTO `enterprise` VALUES (4, 'chuangxiang', '123', '创想未来软件发展有限公司', 'http://localhost:9090/files/1726459193948-美女13.jpg', 'ENTERPRISE', '刘洋', '13659468536', '杭州市西湖区文三路99号');
INSERT INTO `enterprise` VALUES (5, 'xunjie', '123', '迅捷通信服务有限公司', 'http://localhost:9090/files/1726714976790-04.jpg', 'ENTERPRISE', '赵刚', '13695963659', '广州市天河区天河北路88号');
INSERT INTO `enterprise` VALUES (6, 'lanhai', '123', '蓝海大数据处理中心', 'http://localhost:9090/files/1726715049350-美女28.jpeg', 'ENTERPRISE', '孙健', '16934652563', '成都市高新区天府大道北段999号');
INSERT INTO `enterprise` VALUES (7, 'guanghui', '123', '光辉游戏开发工作室', 'http://localhost:9090/files/1726715112122-美女49.jpeg', 'ENTERPRISE', '周洁', '13265968694', '武汉市东湖新技术开发区光谷大道1号');
INSERT INTO `enterprise` VALUES (8, 'whs', '123', '威华胜科技有限公司', 'http://localhost:9090/files/1727051031063-whs.png', 'ENTERPRISE', '李健', '17633468538', '上海市松江区九亭镇涞亭南路29、35、39、89、99号6幢105室');

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
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job
-- ----------------------------
INSERT INTO `job` VALUES (1, 'Python开发', '计算机', 2, 4, '18k', '负责数据处理、分析和建模工作。\n开发和维护数据处理脚本和工具。\n与数据科学家合作，实现算法模型的工程化。\n编写高质量的技术文档和代码注释。', '计算机科学、软件工程或相关领域的本科及以上学历。\n精通Python编程语言，熟悉常用库如NumPy, Pandas, Scikit-learn等。\n有数据处理和分析的经验，熟悉SQL查询语言。\n了解常用的版本控制系统（如Git）。\n有良好的沟通能力和团队合作精神。\n有机器学习或深度学习项目经验者优先。', '北京', '周一至周五 9:00-18:00');
INSERT INTO `job` VALUES (2, 'Java工程师', '软件', 1, 2, '20k', '负责企业级应用系统的后端开发。\n优化现有系统性能，提高系统稳定性。\n编写详细的技术文档。', '精通Java及J2EE相关技术。\n熟悉MyBatis、Hibernate等ORM框架。\n有高并发处理经验者优先。', '南京', '周一至周五 9:00-18:00');
INSERT INTO `job` VALUES (7, 'C语言工程师', '计算机', 1, 23, '18k', '负责嵌入式系统的软件开发。\n优化系统性能，提高代码质量。\n编写详细的开发文档和技术规范', '计算机、电子工程等相关专业本科及以上学历。\n精通C/C++编程语言。\n有嵌入式系统开发经验者优先。', '北京', '周一至周五 9:00-18:00');
INSERT INTO `job` VALUES (8, '爬虫工程师', '计算机', 2, 3, '12k', '开发和维护大规模的数据抓取系统。\n处理复杂的数据清洗和预处理任务。\n优化数据存储和检索效率。', '熟练使用Python或Java进行爬虫开发。\n了解分布式爬虫架构。\n有数据库管理和优化经验者优先。', '广州', '周一至周五 9:00-18:00');
INSERT INTO `job` VALUES (9, '运维工程师', '计算机', 3, 3, '12k', '负责服务器、网络设备的日常运维。\n监控系统运行状态，及时处理故障。\n优化系统配置，提升系统稳定性和安全性。', '熟悉Linux操作系统。\n了解Nginx、Apache等Web服务器。\n有云计算平台（如AWS, Azure）运维经验者优先。', '苏州', '周一至周五 9:00-18:00');
INSERT INTO `job` VALUES (10, '大数据分析', '大数据', 6, 3, '2k', '收集、处理并分析大量业务数据。\n使用统计学方法进行数据建模和预测。\n为业务决策提供数据支持。', '统计学、数学或计算机相关专业背景。\n精通SQL查询语言。\n熟悉Python或R等数据分析工具。', '成都', '周一至周五 9:00-18:00');
INSERT INTO `job` VALUES (11, 'Java开发', '软件设计', 4, 5, '8k', '参与公司核心业务系统的开发和维护。\n编写高质量、可维护的代码。\n与其他团队成员协作，解决技术难题。', '计算机相关专业本科及以上学历。\n精通Java编程语言，熟悉Spring Boot框架。\n有微服务架构经验者优先。', '杭州', '周一至周五 9:00-18:00');
INSERT INTO `job` VALUES (12, '爬虫工程师', '爬虫', 4, 2, '9k', '设计并实现高效的数据抓取系统。\n分析目标网站结构，编写爬虫脚本。\n优化爬虫策略，提高数据抓取效率和稳定性。', '熟练掌握Python编程语言。\n了解Scrapy、BeautifulSoup等爬虫框架。\n有反爬虫机制应对经验者优先。', '深圳', '周一至周五 9:00-18:00');
INSERT INTO `job` VALUES (14, '前端开发', '网站设计', 1, 5, '6k', '根据产品设计稿完成高质量的网页界面和功能实现。\n与后端开发人员协作，确保前后端数据交互的流畅性。\n持续优化前端性能，提升用户体验。', '熟悉HTML5, CSS3, JavaScript等前端技术。\n掌握React或Vue框架。\n有良好的团队合作精神和沟通能力。', '上海', '周一至周五 9:00-18:00');
INSERT INTO `job` VALUES (15, '软件开发工程师', '金融科技', 1, 5, '5k', '负责Web应用和服务的设计与实现；参与系统架构设计。', '计算机科学或相关专业本科及以上学历；熟练掌握Java/Python等编程语言；良好的团队合作精神。', '上海', '周一至周五 9:00-18:00');
INSERT INTO `job` VALUES (16, '前端开发工程师', '电子商务', 2, 3, '4k', '根据产品需求完成高质量的网页界面和功能实现。', '熟悉HTML5, CSS3, JavaScript等前端技术；了解React或Vue框架者优先。', '上海', '周一至周五 9:30-18:30');
INSERT INTO `job` VALUES (17, '数据分析师', '大数据分析', 3, 4, '6k', '收集、处理并分析业务数据；为决策提供支持', '统计学、数学或计算机等相关领域背景；精通SQL查询语言；熟悉至少一种数据分析工具（如Python, R）。', '深圳', '周一至周五 9:00-18:00');
INSERT INTO `job` VALUES (18, '网络安全工程师', '信息安全', 5, 2, '7k', '监控网络安全状态，及时响应安全事件；维护公司信息系统安全策略。', '信息安全、计算机科学或相关领域学士学位；持有CISSP或其他安全认证者优先考虑', '广州', '周一至周五 9:00-18:00');
INSERT INTO `job` VALUES (19, '产品经理', '移动互联网', 6, 3, '2k', '定义产品路线图；协调跨部门资源推进项目实施。', '具有2年以上互联网产品管理经验；优秀的沟通能力和项目管理技巧。', '杭州', '周一至周五 9:00-18:00');
INSERT INTO `job` VALUES (20, '大数据平台运维工程师', '云计算与大数据', 6, 3, '6k', '负责Hadoop集群及其他大数据平台的日常运维工作。', '具备Linux操作系统使用经验；熟悉Hadoop生态系统组件配置与调优。', '成都', '周一至周五 9:00-18:00');
INSERT INTO `job` VALUES (21, '游戏设计师', '游戏开发', 7, 2, '10k', '参与游戏玩法策划；制作游戏关卡设计文档。', '热爱游戏行业；有较强的艺术感知力和创造力；具备一定的编程基础更佳。', '武汉', '周一至周五 9:00-18:00');
INSERT INTO `job` VALUES (22, '软件开发工程师', '互联网/软件开发', 8, 5, '8k', '参与公司产品的设计和开发；负责按照项目需求进行程序编码；参与代码审查和技术文档编写。', '计算机科学或相关领域学士学位；熟悉Java/Python/C++至少一种编程语言；有良好的团队合作精神及沟通能力。', '上海市松江区', '周一至周五，早九晚六');
INSERT INTO `job` VALUES (23, '数据分析师', '大数据分析', 8, 3, '10k', '利用统计方法分析大量数据集以发现趋势；准备报告并呈现给管理层；协助制定基于数据分析的战略决策。', '数学、统计学、计算机科学或其他相关领域本科及以上学历；精通SQL数据库查询；熟悉使用Excel高级功能及至少一种数据分析工具如R语言或Python。', '上海浦东新区', '弹性工作制，平均每周40小时');
INSERT INTO `job` VALUES (24, '网络安全专家', '信息安全', 8, 2, '12k', '设计并实施网络安全解决方案来保护公司的信息系统；定期检查系统漏洞，并提出改进建议；对员工进行安全意识培训。', '拥有信息安全、计算机工程等相关专业的学士或硕士学位；持有CISSP等认证者优先考虑；具备较强的逻辑思维能力和问题解决技巧。', '上海市闵行区', '标准全职');

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '公告信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '今天系统正式上线，开始内测', '今天系统正式上线，开始内测', '2024-03-05', 'admin');
INSERT INTO `notice` VALUES (2, '所有功能都已完成，可以正常使用', '所有功能都已完成，可以正常使用', '2024-03-05', 'admin');
INSERT INTO `notice` VALUES (3, '一批新岗位正在招聘中', '2024.3一批新岗位正在招聘中', '2024-03-05', 'admin');
INSERT INTO `notice` VALUES (4, '21级毕业生生开始申请实习', '21级毕业生生开始申请实习并落实实习单位', '2024-09-16', 'admin');
INSERT INTO `notice` VALUES (5, '新增大批知名企业招聘', '知名企业招聘信息发布', '2024-09-16', 'admin');

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
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resume
-- ----------------------------
INSERT INTO `resume` VALUES (2, 6, '李明轩', '13656932536', 'limingxuan@i.com', '南京', '男', '应届毕业生', '南京', 'Java', '5k', '具有5年软件开发经验，擅长Java和Python，熟悉敏捷开发流程，能够快速适应新技术。', '南京大学计算机科学与技术学士学位（2016-2020）。', '参与开发了企业级ERP系统，优化了系统性能并提高了用户满意度', 'Oracle Certified Professional, Java SE 8 Programmer；AWS Certified Solutions Architect - Associate。', '全国大学生程序设计竞赛一等奖（2019）。');
INSERT INTO `resume` VALUES (3, 2, '李佳颖', '17769368598', 'lijiaying@i.com', '南京', '女', '应届毕业生', '南京', '后端开发工程师', '9k', '专注于后端服务的开发，具备良好的编程能力和问题解决能力', '清华大学软件工程学士学位（2020-2024）', '在校期间参与了一个社交平台的后端开发，处理了高并发的数据请求', '精通Node.js, Python, Go；AWS Certified Developer - Associate', '清华大学优秀毕业生（2024）');
INSERT INTO `resume` VALUES (4, 3, '刘诗琪', '16865423698', 'liushiqi@i.com', '南京', '女', '应届毕业生', '南京', '数据库管理员', '7k', '具备数据库管理和优化的基础知识，熟悉多种数据库系统', '浙江大学计算机科学与技术学士学位（2020-2024）', '参与了一个校园图书馆系统的数据库设计和维护，确保了数据的安全性和完整性。', 'Oracle Certified Professional, MySQL 5.7 Database Administrator', '浙江大学优秀学生干部（2023）');
INSERT INTO `resume` VALUES (5, 5, '宋一帆', '17796583246', 'songyifan@i.com', '上海', '男', '应届毕业生', '上海', '全栈开发工程师', '12k', '具有全栈开发能力，能够独立完成从数据库设计到前端展示的全流程开发。', '复旦大学信息管理与信息系统学士学位（2020-2024）。', '负责一个校园二手交易平台的全栈开发，快速迭代产品并成功上线。', '熟悉MEAN/MERN堆栈；MongoDB Certified Developer Associate', '全国大学生创新创业大赛优秀团队奖（2023）');
INSERT INTO `resume` VALUES (6, 4, '陈欣怡', '13689567596', 'chenxinyi@i.com', '南京', '女', '应届毕业生', '南京', '云计算工程师', '8k', '具备云平台管理和运维的基础知识，专注于云基础设施的设计和优化。', '南京大学计算机科学与技术学士学位（2020-2024）', '参与了一个基于AWS的校园云存储项目，提高了数据存储和访问效率', 'AWS Certified Solutions Architect - Associate；Google Cloud Certified - Professional Cloud Architect', '南京大学优秀毕业生（2024）。');
INSERT INTO `resume` VALUES (7, 9, '杨紫萱', '13592649236', 'yangzixuan@i.com', '南京', '女', '应届毕业生', '南京', '网络安全工程师', '7k', '对网络安全有浓厚兴趣，具备漏洞评估、入侵检测和安全策略制定的能力', '上海交通大学信息安全学士学位（2020-2024）。', '在校期间参与了一次校园网络的安全审计，发现了多个潜在的安全风险并提出解决方案。', 'CISSP, CEH, CompTIA Security+', '全国网络安全竞赛二等奖（2023）');
INSERT INTO `resume` VALUES (8, 7, '张浩宇', '13656964265', 'zhanghaoyu@i.com', '南京', '男', '应届毕业生', '南京', '前端开发工程师', '8k', '具备扎实的前端开发基础，熟悉现代Web技术栈，能够构建响应式和高性能的Web应用。', '北京大学计算机科学与技术学士学位（2020-2024）', '参与了一个校园在线书店项目的前端开发，使用React.js实现了用户友好的界面', '精通HTML, CSS, JavaScript；React.js认证开发者', '全国Web开发大赛一等奖（2023）。');
INSERT INTO `resume` VALUES (9, 1, '高宇杰', '15696836542', 'gaoyujie@i.com', '杭州', '男', '应届毕业生', '杭州', 'DevOps工程师', '8k', '擅长自动化部署、持续集成/持续交付（CI/CD）流程，致力于提高开发效率。', '华中科技大学软件工程学士学位（2020-2024）。', '在校期间建立了一套完整的CI/CD流水线，大大缩短了学校内部项目的发布周期', 'Docker, Kubernetes, Jenkins；Certified Kubernetes Administrator (CKA)', '华中科技大学优秀学生干部（2023）');
INSERT INTO `resume` VALUES (10, 8, '许世杰', '13685697264', 'xushijie@i.com', '北京', '男', '应届毕业生', '上海', '人工智能工程师', '9k', '专注于机器学习和深度学习，具备扎实的理论基础和实践能力。', '中国科学技术大学人工智能学士学位（2020-2024）', '参与了一个基于深度学习的图像识别项目，准确率达到98%以上', 'TensorFlow, PyTorch, Scikit-learn；Google AI Certification。', '国际人工智能大会论文发表（2023）。');
INSERT INTO `resume` VALUES (11, 10, '张坤', '16542669851', 'zake@i.com', '南京', '男', '离职', '北京', '前端开发工程师', '15k', '具有超过4年的Web前端开发经验，熟练掌握HTML5、CSS3、JavaScript等技术，并对React和Vue框架有深入理解。在多个大型项目中担任关键角色，善于解决复杂问题并优化用户体验。拥有良好的团队协作能力和快速学习新知识的能力。', '2015年9月 - 2019年7月 北京邮电大学 计算机科学与技术 本科', '项目名称：在线教育平台前端重构\n职责描述：负责整个网站的界面设计与前端交互实现；采用React框架提升页面加载速度。\n成果：提高了用户满意度评分20%，显著减少了服务器请求次数。\n项目名称：企业级CRM系统客户端开发\n职责描述：参与需求分析，使用Vue.js完成主要功能模块的编码工作。\n成果：成功上线后获得客户好评，成为公司标杆案例之一。', 'Oracle Certified Associate, Java SE 8 Programmer\nMicrosoft Certified: Azure Developer Associate', '2018年度全国大学生软件设计大赛二等奖\n校优秀毕业生称号');
INSERT INTO `resume` VALUES (12, 11, '刘佳期', '15690704413', 'liujq@i.com', '南京', '女', '应届毕业生', '上海市', '数据分析师', '12k', '毕业于复旦大学统计学专业，具备扎实的数据处理及分析能力。熟悉Python编程语言及相关数据分析库如Pandas、NumPy等。曾参与多项商业智能项目，在数据挖掘领域积累了丰富实践经验。热爱挑战，渴望在一个充满活力的工作环境中成长。', '2017年9月 - 2021年7月 复旦大学 统计学 本科', '项目名称：电商平台用户行为分析\n职责描述：利用Python进行数据清洗、特征工程及模型训练；应用机器学习算法预测消费者偏好变化。\n成果：为营销策略调整提供了有力支持，帮助企业在促销活动中实现了销售额增长15%。\n项目名称：银行信用卡风险评估系统建设\n职责描述：构建信用评分卡模型以辅助信贷审批决策过程。\n成果：有效降低了不良贷款率，提升了审批效率。', 'SAS Certified Specialist: Base Programming Using SAS 9.4\nIBM Data Science Professional Certificate (Coursera)', '2020年“中国青年数据科学家”提名奖\n全国大学生数学建模竞赛一等奖');

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
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '学生信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, 'gaoyujie', '123', '高宇杰', 'http://localhost:9090/files/1720350173015-05.jpg', 'STUDENT', 4, 3, 5, 0);
INSERT INTO `student` VALUES (2, 'lijiaying', '123', '李佳颖', 'http://localhost:9090/files/1711373922289-24.jpeg', 'STUDENT', 5, 5, 4, 0);
INSERT INTO `student` VALUES (3, 'liushiqi', '123', '刘诗琪', 'http://localhost:9090/files/1711810606782-喜羊羊.webp', 'STUDENT', 5, 5, 4, 0);
INSERT INTO `student` VALUES (4, 'chenxinyi', '123', '陈欣怡', 'http://localhost:9090/files/1712242984816-02.png', 'STUDENT', 3, 4, 3, 0);
INSERT INTO `student` VALUES (5, 'songyifan', '123', '宋一帆', 'http://localhost:9090/files/1712243018985-10.png', 'STUDENT', 3, 4, 3, 0);
INSERT INTO `student` VALUES (6, 'limingxuan', '123', '李明轩', 'http://localhost:9090/files/1720075379227-06.jpg', 'STUDENT', 1, 1, 1, 0);
INSERT INTO `student` VALUES (7, 'zhanghaoyu', '123', '张浩宇', 'http://localhost:9090/files/1726714100332-美女23.jpeg', 'STUDENT', 1, 1, 1, 0);
INSERT INTO `student` VALUES (8, 'xushijie', '123', '许世杰', 'http://localhost:9090/files/1720078099034-01.jpeg', 'STUDENT', 4, 3, 5, 0);
INSERT INTO `student` VALUES (9, 'yangzixuan', '123', '杨紫萱', 'http://localhost:9090/files/1726463182712-美女14.jpeg', 'STUDENT', 1, 1, 1, 0);
INSERT INTO `student` VALUES (10, 'zake', '123', '张坤', 'http://localhost:9090/files/1727051715241-zake.webp', 'STUDENT', 1, 1, 6, 0);
INSERT INTO `student` VALUES (11, 'liujq', '123', '刘佳期', 'http://localhost:9090/files/1727054420572-ljq.webp', 'STUDENT', 1, 1, 6, 0);

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
  `enterprise_remark` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '企业评价',
  `teacher_remark` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '教师评价',
  `report` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '实践报告',
  `self` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '自我鉴定',
  `grade` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '成绩鉴定',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '实习任务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES (3, 2, 4, 8, 1, 2, 'http://localhost:9090/files/1720357761680-219-6.pdf', 0, 'http://localhost:9090/files/1720361245388-76-4.pdf', '该生实习期间业绩优秀', '实习合格', 'http://localhost:9090/files/1720361363328-管道原始记录.doc', '还有很大进步空间', '优秀');
INSERT INTO `task` VALUES (10, 5, 3, 4, 2, 1, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `task` VALUES (11, 4, 3, 4, 6, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `task` VALUES (12, 9, 1, 9, 14, 4, 'http://localhost:9090/files/1726464672091-美女8.jpeg', 0, 'http://localhost:9090/files/1726464674488-美女9.jpeg', '实习合格', '优秀', 'http://localhost:9090/files/1726464676811-美女3.jpeg', '自我评价良好', '优秀');
INSERT INTO `task` VALUES (13, 3, 4, 8, 9, 3, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `task` VALUES (14, 10, 6, 10, 22, 8, 'http://localhost:9090/files/1727054338058-尼麦角林片信息公开 (1).docx', 0, 'http://localhost:9090/files/1727054341072-尼麦角林片信息公开 (3).docx', '张坤同学在实习期间展现出了良好的职业素养和技术潜力。他快速适应了公司的文化氛围，并积极参与到实际项目中去。特别值得称赞的是他对新技术的学习热情以及解决问题时表现出的责任感。张晨能够很好地融入团队，并且乐于分享自己的想法，为团队带来了新鲜活力。我们非常看好他在IT领域的发展前景。', '作为张坤同学的专业指导老师，我对他在光辉未来科技有限公司实习期间的表现感到十分满意。根据他的反馈以及提交的相关报告来看，张晨不仅将课堂上学到的知识很好地应用到了实践中，而且还展现出了很强的学习能力和适应性。他对待工作的认真态度给我留下了深刻的印象。我相信这段实习经历对他个人成长及未来职业生涯都将产生积极影响。\n\n以上内容是基于一个理想情况下的示例。实际情况中的自我鉴定、企业评价和教师评价可能会根据具体表现和个人特点有所不同。', 'http://localhost:9090/files/1727054343739-尼麦角林片信息公开.docx', '在这段的实习期间，我有幸在光辉未来科技有限公司担任前端开发实习生。通过这段时间的工作和学习，我在以下几个方面有了显著的成长：\n\n技术能力提升：我深入学习了React框架，并掌握了组件化开发的基本方法。此外，我还提高了对CSS布局的理解，能够更有效地实现响应式设计。\n团队合作：与项目组成员紧密合作的过程中，我学会了如何在快节奏的环境中有效沟通，同时也提升了我的问题解决能力。\n工作态度：始终保持积极主动的态度面对工作中遇到的各种挑战，按时完成了分配给我的各项任务，并且不断寻求改进的空间。\n这次宝贵的实习经历不仅增强了我的专业技能，还让我更加明确了自己未来的职业发展方向。感谢公司提供的机会和支持！', '优秀');

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
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '教师信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES (2, 'yangliuyi', '123', '杨柳依', 'http://localhost:9090/files/1711294329463-09.jpg', 'TEACHER', '16869351268', 'yangliuyi11@i.com', '副教授');
INSERT INTO `teacher` VALUES (3, 'chensijing', '123', '陈思静', 'http://localhost:9090/files/1711294370010-02.jpg', 'TEACHER', '16656942675', 'chensijing12@i.com', '副教授');
INSERT INTO `teacher` VALUES (4, 'zhangzhigang', '123', '张志刚', 'http://localhost:9090/files/1711373826062-26.jpg', 'TEACHER', '16664597856', 'zhigang23@i.com', '教授');
INSERT INTO `teacher` VALUES (6, 'wangyaqin', '123', '王雅琴', 'http://localhost:9090/files/1712241945652-公孙离1.png', 'TEACHER', '16594683569', 'wangyaqin77@i.com', '教授');
INSERT INTO `teacher` VALUES (8, 'lijianhui', '123', '李建辉', 'http://localhost:9090/files/1720075167169-10.png', 'TEACHER', '17633468533', 'lijianhui61@i.com', '研究生');
INSERT INTO `teacher` VALUES (9, 'zhanghuijuan', '123', '张慧娟', 'http://localhost:9090/files/1726459110933-美女2.jpeg', 'TEACHER', '13569684596', 'zhanghuijuan@i.com', '研究生');
INSERT INTO `teacher` VALUES (10, 'zgg', '123', '张国光', 'http://localhost:9090/files/1727051827849-zgg.webp', 'TEACHER', '19946866846', 'zgg@i.com', '高级工程师');

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
  INDEX `useractions_student_id_fk`(`userId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户行为记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of useractions
-- ----------------------------
INSERT INTO `useractions` VALUES (1, 6, 1, 'VIEW', '2024-09-09 23:36:05');
INSERT INTO `useractions` VALUES (2, 6, 2, 'VIEW', '2024-09-09 23:36:48');
INSERT INTO `useractions` VALUES (3, 6, 7, 'APPLY', '2024-09-09 23:40:40');
INSERT INTO `useractions` VALUES (4, 1, 8, 'VIEW', '2024-09-10 22:02:24');
INSERT INTO `useractions` VALUES (5, 1, 7, 'VIEW', '2024-09-10 22:02:27');
INSERT INTO `useractions` VALUES (7, 1, 2, 'APPLY', '2024-09-10 22:02:37');
INSERT INTO `useractions` VALUES (8, 4, 10, 'VIEW', '2024-09-10 22:11:31');
INSERT INTO `useractions` VALUES (9, 4, 2, 'VIEW', '2024-09-10 22:11:34');
INSERT INTO `useractions` VALUES (10, 4, 1, 'VIEW', '2024-09-10 22:11:36');
INSERT INTO `useractions` VALUES (12, 2, 1, 'VIEW', '2024-09-10 22:12:00');
INSERT INTO `useractions` VALUES (13, 2, 2, 'VIEW', '2024-09-10 22:12:01');
INSERT INTO `useractions` VALUES (15, 2, 1, 'APPLY', '2024-09-10 22:12:10');
INSERT INTO `useractions` VALUES (16, 3, 9, 'VIEW', '2024-09-10 22:12:23');
INSERT INTO `useractions` VALUES (17, 3, 8, 'VIEW', '2024-09-10 22:12:24');
INSERT INTO `useractions` VALUES (18, 3, 7, 'VIEW', '2024-09-10 22:12:26');
INSERT INTO `useractions` VALUES (22, 9, 14, 'VIEW', '2024-09-16 13:08:41');
INSERT INTO `useractions` VALUES (23, 9, 11, 'VIEW', '2024-09-16 13:08:48');
INSERT INTO `useractions` VALUES (24, 9, 1, 'VIEW', '2024-09-16 13:08:52');
INSERT INTO `useractions` VALUES (25, 9, 12, 'VIEW', '2024-09-16 13:09:10');
INSERT INTO `useractions` VALUES (26, 9, 7, 'VIEW', '2024-09-16 13:09:19');
INSERT INTO `useractions` VALUES (27, 9, 11, 'VIEW', '2024-09-16 13:09:26');
INSERT INTO `useractions` VALUES (28, 9, 14, 'APPLY', '2024-09-16 13:25:26');
INSERT INTO `useractions` VALUES (29, 9, 14, 'APPLY', '2024-09-16 13:27:29');
INSERT INTO `useractions` VALUES (30, 8, 1, 'VIEW', '2024-09-18 10:32:40');
INSERT INTO `useractions` VALUES (31, 8, 11, 'VIEW', '2024-09-18 10:32:47');
INSERT INTO `useractions` VALUES (32, 9, 8, 'VIEW', '2024-09-19 09:50:08');
INSERT INTO `useractions` VALUES (33, 9, 11, 'VIEW', '2024-09-19 09:50:35');
INSERT INTO `useractions` VALUES (34, 9, 7, 'VIEW', '2024-09-19 10:01:33');
INSERT INTO `useractions` VALUES (35, 8, 7, 'APPLY', '2024-09-20 12:32:36');
INSERT INTO `useractions` VALUES (36, 8, 9, 'APPLY', '2024-09-20 22:05:23');
INSERT INTO `useractions` VALUES (37, 10, 24, 'VIEW', '2024-09-23 08:39:00');
INSERT INTO `useractions` VALUES (38, 10, 20, 'VIEW', '2024-09-23 08:39:04');
INSERT INTO `useractions` VALUES (39, 10, 8, 'VIEW', '2024-09-23 08:39:12');
INSERT INTO `useractions` VALUES (40, 10, 19, 'VIEW', '2024-09-23 08:41:22');
INSERT INTO `useractions` VALUES (41, 10, 7, 'VIEW', '2024-09-23 08:41:25');
INSERT INTO `useractions` VALUES (42, 10, 9, 'VIEW', '2024-09-23 08:41:27');
INSERT INTO `useractions` VALUES (43, 10, 22, 'APPLY', '2024-09-23 08:58:43');
INSERT INTO `useractions` VALUES (44, 10, 22, 'APPLY', '2024-09-23 08:59:14');
INSERT INTO `useractions` VALUES (45, 11, 24, 'VIEW', '2024-09-23 09:21:50');
INSERT INTO `useractions` VALUES (46, 11, 19, 'VIEW', '2024-09-23 09:21:52');
INSERT INTO `useractions` VALUES (47, 11, 21, 'VIEW', '2024-09-23 09:21:55');
INSERT INTO `useractions` VALUES (48, 11, 1, 'VIEW', '2024-09-23 09:22:02');
INSERT INTO `useractions` VALUES (49, 11, 11, 'VIEW', '2024-09-23 09:22:05');
INSERT INTO `useractions` VALUES (50, 11, 20, 'VIEW', '2024-09-23 09:22:10');
INSERT INTO `useractions` VALUES (51, 11, 16, 'VIEW', '2024-09-23 09:22:13');
INSERT INTO `useractions` VALUES (52, 11, 12, 'VIEW', '2024-09-23 09:22:15');
INSERT INTO `useractions` VALUES (53, 11, 18, 'VIEW', '2024-09-23 09:22:17');
INSERT INTO `useractions` VALUES (54, 11, 24, 'VIEW', '2024-09-23 09:22:25');
INSERT INTO `useractions` VALUES (55, 11, 20, 'VIEW', '2024-09-23 09:22:30');
INSERT INTO `useractions` VALUES (56, 11, 11, 'VIEW', '2024-09-23 09:22:36');
INSERT INTO `useractions` VALUES (57, 11, 10, 'VIEW', '2024-09-23 09:22:38');
INSERT INTO `useractions` VALUES (58, 11, 23, 'APPLY', '2024-09-23 18:11:31');
INSERT INTO `useractions` VALUES (59, 11, 23, 'APPLY', '2024-09-24 10:20:45');
INSERT INTO `useractions` VALUES (60, 11, 24, 'VIEW', '2024-09-24 10:23:41');
INSERT INTO `useractions` VALUES (61, 11, 23, 'VIEW', '2024-09-24 10:23:50');
INSERT INTO `useractions` VALUES (62, 11, 19, 'VIEW', '2024-09-24 10:24:06');
INSERT INTO `useractions` VALUES (63, 11, 24, 'VIEW', '2024-09-24 21:35:07');
INSERT INTO `useractions` VALUES (64, 11, 23, 'APPLY', '2024-09-24 21:36:46');

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
