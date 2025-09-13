/*
MySQL Backup
Database: i-manager
Backup Time: 2025-09-13 22:36:03
*/

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `i-manager`.`admin`;
DROP TABLE IF EXISTS `i-manager`.`apply`;
DROP TABLE IF EXISTS `i-manager`.`classes`;
DROP TABLE IF EXISTS `i-manager`.`college`;
DROP TABLE IF EXISTS `i-manager`.`enterprise`;
DROP TABLE IF EXISTS `i-manager`.`job`;
DROP TABLE IF EXISTS `i-manager`.`notice`;
DROP TABLE IF EXISTS `i-manager`.`resume`;
DROP TABLE IF EXISTS `i-manager`.`score`;
DROP TABLE IF EXISTS `i-manager`.`speciality`;
DROP TABLE IF EXISTS `i-manager`.`student`;
DROP TABLE IF EXISTS `i-manager`.`task`;
DROP TABLE IF EXISTS `i-manager`.`teacher`;
DROP TABLE IF EXISTS `i-manager`.`useractions`;
DROP TABLE IF EXISTS `i-manager`.`workplan`;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='管理员';
CREATE TABLE `apply` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `stu_id` int DEFAULT NULL COMMENT '学生Id',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `class_id` int DEFAULT NULL COMMENT '班级ID',
  `teacher_id` int DEFAULT NULL COMMENT '教师Id',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `enterprise_id` int DEFAULT NULL COMMENT '企业ID',
  `job_id` int NOT NULL COMMENT '岗位ID',
  `salary` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '薪资',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工作地点',
  `begin_time` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '开始时间',
  `end_time` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '结束时间',
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '未实习' COMMENT '实习状态',
  `read_status` int DEFAULT '1' COMMENT '阅读状态 1未读 2已读',
  `resume_status` int DEFAULT NULL COMMENT '简历状态 1：通过 2：未通过',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `apply_username_uindex` (`username`) USING BTREE,
  KEY `fk_apply_student` (`stu_id`),
  KEY `fk_apply_class` (`class_id`),
  KEY `fk_apply_teacher` (`teacher_id`),
  KEY `fk_apply_enterprise` (`enterprise_id`),
  KEY `fk_apply_job` (`job_id`),
  CONSTRAINT `fk_apply_class` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_apply_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `enterprise` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_apply_job` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_apply_student` FOREIGN KEY (`stu_id`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_apply_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='实习报名信息表';
CREATE TABLE `classes` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '班级名称',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '班级描述',
  `teacher_id` int DEFAULT NULL COMMENT '教师ID',
  `speciality_id` int DEFAULT NULL COMMENT '专业ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `classes_teacher_id_uindex` (`teacher_id`) USING BTREE,
  KEY `fk_classes_speciality` (`speciality_id`),
  CONSTRAINT `fk_classes_speciality` FOREIGN KEY (`speciality_id`) REFERENCES `speciality` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_classes_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='班级信息表';
CREATE TABLE `college` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学院名称',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学院介绍',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='学院信息表';
CREATE TABLE `enterprise` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司名称',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色',
  `person` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='企业信息表';
CREATE TABLE `job` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '岗位名称',
  `direction` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '行业方向',
  `enterprise_id` int DEFAULT NULL COMMENT '企业ID',
  `count` int DEFAULT NULL COMMENT '招聘人数',
  `salary` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '薪资',
  `job_describe` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '岗位描述',
  `job_require` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '专业要求',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工作地点',
  `work_time` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工作时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_job_enterprise` (`enterprise_id`),
  CONSTRAINT `fk_job_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `enterprise` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='岗位信息表';
CREATE TABLE `notice` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '内容',
  `time` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建时间',
  `user` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='公告信息表';
CREATE TABLE `resume` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '简历ID',
  `student_id` int NOT NULL COMMENT '学生ID',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '姓名',
  `tel` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `address` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '现居城市',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '求职状态',
  `city` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '意向城市',
  `department` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '期望职位',
  `salary` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '期望薪资',
  `person` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '个人总结',
  `education` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '教育背景',
  `project` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '项目经历',
  `skills` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '技能、证书',
  `honor` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '荣誉奖项',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `resume_student_id_uindex` (`student_id`) USING BTREE,
  CONSTRAINT `fk_resume_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
CREATE TABLE `score` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `student_id` int DEFAULT NULL COMMENT '学生ID',
  `enterprise_id` int DEFAULT NULL COMMENT '企业ID',
  `teacher_id` int DEFAULT NULL COMMENT '教师ID',
  `enterprise_score` double(10,2) DEFAULT NULL COMMENT '企业评分',
  `teacher_score` double(10,2) DEFAULT NULL COMMENT '教师评分',
  `score` double(10,2) DEFAULT NULL COMMENT '总成绩',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_score_student` (`student_id`),
  KEY `fk_score_enterprise` (`enterprise_id`),
  KEY `fk_score_teacher` (`teacher_id`),
  CONSTRAINT `fk_score_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `enterprise` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_score_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_score_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='成绩信息表';
CREATE TABLE `speciality` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '专业名称',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '专业描述',
  `college_id` int DEFAULT NULL COMMENT '所属学院',
  `score` int DEFAULT NULL COMMENT '学分限定',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_speciality_college` (`college_id`),
  CONSTRAINT `fk_speciality_college` FOREIGN KEY (`college_id`) REFERENCES `college` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='专业信息表';
CREATE TABLE `student` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色',
  `college_id` int DEFAULT NULL COMMENT '学院ID',
  `speciality_id` int DEFAULT NULL COMMENT '专业ID',
  `class_id` int DEFAULT NULL COMMENT '班级ID',
  `score` int DEFAULT '0' COMMENT '实习成绩',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_student_college` (`college_id`),
  KEY `fk_student_speciality` (`speciality_id`),
  KEY `fk_student_class` (`class_id`),
  CONSTRAINT `fk_student_class` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_college` FOREIGN KEY (`college_id`) REFERENCES `college` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_speciality` FOREIGN KEY (`speciality_id`) REFERENCES `speciality` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='学生信息表';
CREATE TABLE `task` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `student_id` int DEFAULT NULL COMMENT '学生ID',
  `class_id` int DEFAULT NULL COMMENT '班级ID',
  `teacher_id` int DEFAULT NULL COMMENT '指导老师ID',
  `job_id` int DEFAULT NULL COMMENT '岗位ID',
  `enterprise_id` int DEFAULT NULL COMMENT '企业ID',
  `file` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '三方协议',
  `count` int DEFAULT '0' COMMENT '签到次数',
  `record` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '周志',
  `enterprise_remark` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '企业评价',
  `teacher_remark` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '教师评价',
  `report` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '实践报告',
  `self` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '自我鉴定',
  `grade` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '成绩鉴定',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_task_student` (`student_id`),
  KEY `fk_task_class` (`class_id`),
  KEY `fk_task_teacher` (`teacher_id`),
  KEY `fk_task_job` (`job_id`),
  KEY `fk_task_enterprise` (`enterprise_id`),
  CONSTRAINT `fk_task_class` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_task_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `enterprise` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_task_job` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_task_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_task_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='实习任务表';
CREATE TABLE `teacher` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '职称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='教师信息表';
CREATE TABLE `useractions` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `job_id` int NOT NULL COMMENT '岗位ID',
  `action_type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户行为 VIEW/APPLY',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `useractions_job_id_fk` (`job_id`) USING BTREE,
  KEY `useractions_student_id_fk` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户行为记录';
CREATE TABLE `workplan` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='实习安排表';
BEGIN;
LOCK TABLES `i-manager`.`admin` WRITE;
DELETE FROM `i-manager`.`admin`;
INSERT INTO `i-manager`.`admin` (`id`,`username`,`password`,`name`,`avatar`,`role`,`phone`,`email`) VALUES (1, 'admin', 'admin', '管理员', 'http://localhost:9090/files/1.png', 'ADMIN', '11111111111', 'admin@i.com')
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `i-manager`.`apply` WRITE;
DELETE FROM `i-manager`.`apply`;
INSERT INTO `i-manager`.`apply` (`id`,`stu_id`,`username`,`name`,`class_id`,`teacher_id`,`phone`,`enterprise_id`,`job_id`,`salary`,`address`,`begin_time`,`end_time`,`status`,`read_status`,`resume_status`) VALUES (15, 1, 'gaoyujie', '高宇杰', 5, 6, '13685695684', 1, 2, '3k', '上海', '2025-09-10', '2026-09-17', '实习中', 2, 1),(16, 2, 'lijiaying', '李佳', 4, 8, '16653694569', 2, 1, '10k', '广州', '2025-09-23', '2026-07-27', '实习结束', 2, 1),(17, 3, 'liushiqi', '刘诗', 4, 8, '16956984536', 3, 9, '22k', '北京', '2025-09-22', '2026-07-27', '实习中', 2, 1),(18, 4, 'chenxinyi', '陈欣', 3, 4, '15936524698', 2, 6, '7k', '南京', '2025-09-23', '2026-08-03', '实习结束', 1, 1),(19, 6, 'limingxuan', '李明', 1, 2, '14965863569', 1, 7, '5k', '苏州', '2025-09-24', '2026-07-19', '未实习', 2, 2),(20, 5, 'songyifan', '宋帆', 3, 4, '16895684269', 1, 2, '8k', '上海', '2025-09-19', '2026-09-30', '实习中', 2, 1),(21, 9, 'yangzixuan', '杨紫', 1, 9, '16936963569', 4, 14, '16k', '南京', '2025-09-16', '2026-12-23', '实习中', 2, 1),(22, 8, 'xushijie', '许世', 5, 2, '13695681268', 1, 7, '9k', '杭州', '2025-09-20', '2026-09-25', '未实习', 2, NULL)
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `i-manager`.`classes` WRITE;
DELETE FROM `i-manager`.`classes`;
INSERT INTO `i-manager`.`classes` (`id`,`name`,`content`,`teacher_id`,`speciality_id`) VALUES (1, '计科1班', '计科1班', 4, 1),(2, '会计1班', '会计1班', 2, 2),(3, '英语1班', '英语1班', 3, 4),(4, '机械1班', '机械1班', 8, 5),(5, '古汉语1班', '古汉语1班', 6, 3),(6, '计科2班', '计算机科学与技术2班', 10, 1)
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `i-manager`.`college` WRITE;
DELETE FROM `i-manager`.`college`;
INSERT INTO `i-manager`.`college` (`id`,`name`,`content`) VALUES (1, '计算机学院', '这里是计算机学院'),(2, '商学院', '这里是商学院'),(3, '外国语学院', '这里是外国语学院'),(4, '马克思主义学院', '这里是马克思主义学院'),(5, '机械学院', '这里是机械学院')
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `i-manager`.`enterprise` WRITE;
DELETE FROM `i-manager`.`enterprise`;
INSERT INTO `i-manager`.`enterprise` (`id`,`username`,`password`,`name`,`avatar`,`role`,`person`,`phone`,`address`) VALUES (1, 'xingchen', '123', '星辰科技有限公司', 'http://localhost:9090/files/19.jpg', 'ENTERPRISE', '星辰', '13626954693', '上海市浦东新区陆家嘴环路1000号'),(2, 'zhilian', '123', '智联网络技术有限公司', 'http://localhost:9090/files/20.jpg', 'ENTERPRISE', '智联', '13626954692', '北京市海淀区中关村大街1号'),(3, 'yunfan', '123', '云帆信息技术股份有限公司', 'http://localhost:9090/files/21.png', 'ENTERPRISE', '云帆', '13626954694', '深圳市南山区科技园中区1栋'),(4, 'chuangxiang', '123', '创想未来软件发展有限公司', 'http://localhost:9090/files/22.jpg', 'ENTERPRISE', '创想', '13626954695', '杭州市西湖区文三路99号'),(5, 'xunjie', '123', '迅捷通信服务有限公司', 'http://localhost:9090/files/23.jpg', 'ENTERPRISE', '迅捷', '13626954696', '广州市天河区天河北路88号'),(6, 'lanhai', '123', '蓝海大数据处理中心', 'http://localhost:9090/files/24.jpg', 'ENTERPRISE', '蓝海', '13626954697', '成都市高新区天府大道北段999号'),(7, 'guanghui', '123', '光辉游戏开发工作室', 'http://localhost:9090/files/25.jpg', 'ENTERPRISE', '光辉', '13626954698', '武汉市东湖新技术开发区光谷大道1号'),(8, 'whs', '123', '威华胜科技有限公司', 'http://localhost:9090/files/26.jpg', 'ENTERPRISE', '威华', '13626954699', '上海市松江区九亭镇涞亭南路29、35、39、89、99号6幢105室')
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `i-manager`.`job` WRITE;
DELETE FROM `i-manager`.`job`;
INSERT INTO `i-manager`.`job` (`id`,`name`,`direction`,`enterprise_id`,`count`,`salary`,`job_describe`,`job_require`,`address`,`work_time`) VALUES (1, 'Python开发', '计算机', 2, 4, '18k', '负责数据处理、分析和建模工作。\n开发和维护数据处理脚本和工具。\n与数据科学家合作，实现算法模型的工程化。\n编写高质量的技术文档和代码注释。', '计算机科学、软件工程或相关领域的本科及以上学历。\n精通Python编程语言，熟悉常用库如NumPy, Pandas, Scikit-learn等。\n有数据处理和分析的经验，熟悉SQL查询语言。\n了解常用的版本控制系统（如Git）。\n有良好的沟通能力和团队合作精神。\n有机器学习或深度学习项目经验者优先。', '北京', '周一至周五 9:00-18:00'),(2, 'Java工程师', '软件', 1, 2, '20k', '负责企业级应用系统的后端开发。\n优化现有系统性能，提高系统稳定性。\n编写详细的技术文档。', '精通Java及J2EE相关技术。\n熟悉MyBatis、Hibernate等ORM框架。\n有高并发处理经验者优先。', '南京', '周一至周五 9:00-18:00'),(7, 'C语言工程师', '计算机', 1, 23, '18k', '负责嵌入式系统的软件开发。\n优化系统性能，提高代码质量。\n编写详细的开发文档和技术规范', '计算机、电子工程等相关专业本科及以上学历。\n精通C/C++编程语言。\n有嵌入式系统开发经验者优先。', '北京', '周一至周五 9:00-18:00'),(8, '爬虫工程师', '计算机', 2, 3, '12k', '开发和维护大规模的数据抓取系统。\n处理复杂的数据清洗和预处理任务。\n优化数据存储和检索效率。', '熟练使用Python或Java进行爬虫开发。\n了解分布式爬虫架构。\n有数据库管理和优化经验者优先。', '广州', '周一至周五 9:00-18:00'),(9, '运维工程师', '计算机', 3, 3, '12k', '负责服务器、网络设备的日常运维。\n监控系统运行状态，及时处理故障。\n优化系统配置，提升系统稳定性和安全性。', '熟悉Linux操作系统。\n了解Nginx、Apache等Web服务器。\n有云计算平台（如AWS, Azure）运维经验者优先。', '苏州', '周一至周五 9:00-18:00'),(10, '大数据分析', '大数据', 6, 3, '2k', '收集、处理并分析大量业务数据。\n使用统计学方法进行数据建模和预测。\n为业务决策提供数据支持。', '统计学、数学或计算机相关专业背景。\n精通SQL查询语言。\n熟悉Python或R等数据分析工具。', '成都', '周一至周五 9:00-18:00'),(11, 'Java开发', '软件设计', 4, 5, '8k', '参与公司核心业务系统的开发和维护。\n编写高质量、可维护的代码。\n与其他团队成员协作，解决技术难题。', '计算机相关专业本科及以上学历。\n精通Java编程语言，熟悉Spring Boot框架。\n有微服务架构经验者优先。', '杭州', '周一至周五 9:00-18:00'),(12, '爬虫工程师', '爬虫', 4, 2, '9k', '设计并实现高效的数据抓取系统。\n分析目标网站结构，编写爬虫脚本。\n优化爬虫策略，提高数据抓取效率和稳定性。', '熟练掌握Python编程语言。\n了解Scrapy、BeautifulSoup等爬虫框架。\n有反爬虫机制应对经验者优先。', '深圳', '周一至周五 9:00-18:00'),(14, '前端开发', '网站设计', 1, 5, '6k', '根据产品设计稿完成高质量的网页界面和功能实现。\n与后端开发人员协作，确保前后端数据交互的流畅性。\n持续优化前端性能，提升用户体验。', '熟悉HTML5, CSS3, JavaScript等前端技术。\n掌握React或Vue框架。\n有良好的团队合作精神和沟通能力。', '上海', '周一至周五 9:00-18:00'),(15, '软件开发工程师', '金融科技', 1, 5, '5k', '负责Web应用和服务的设计与实现；参与系统架构设计。', '计算机科学或相关专业本科及以上学历；熟练掌握Java/Python等编程语言；良好的团队合作精神。', '上海', '周一至周五 9:00-18:00'),(16, '前端开发工程师', '电子商务', 2, 3, '4k', '根据产品需求完成高质量的网页界面和功能实现。', '熟悉HTML5, CSS3, JavaScript等前端技术；了解React或Vue框架者优先。', '上海', '周一至周五 9:30-18:30'),(17, '数据分析师', '大数据分析', 3, 4, '6k', '收集、处理并分析业务数据；为决策提供支持', '统计学、数学或计算机等相关领域背景；精通SQL查询语言；熟悉至少一种数据分析工具（如Python, R）。', '深圳', '周一至周五 9:00-18:00'),(18, '网络安全工程师', '信息安全', 5, 2, '7k', '监控网络安全状态，及时响应安全事件；维护公司信息系统安全策略。', '信息安全、计算机科学或相关领域学士学位；持有CISSP或其他安全认证者优先考虑', '广州', '周一至周五 9:00-18:00'),(19, '产品经理', '移动互联网', 6, 3, '2k', '定义产品路线图；协调跨部门资源推进项目实施。', '具有2年以上互联网产品管理经验；优秀的沟通能力和项目管理技巧。', '杭州', '周一至周五 9:00-18:00'),(20, '大数据平台运维工程师', '云计算与大数据', 6, 3, '6k', '负责Hadoop集群及其他大数据平台的日常运维工作。', '具备Linux操作系统使用经验；熟悉Hadoop生态系统组件配置与调优。', '成都', '周一至周五 9:00-18:00'),(21, '游戏设计师', '游戏开发', 7, 2, '10k', '参与游戏玩法策划；制作游戏关卡设计文档。', '热爱游戏行业；有较强的艺术感知力和创造力；具备一定的编程基础更佳。', '武汉', '周一至周五 9:00-18:00'),(22, '软件开发工程师', '互联网/软件开发', 8, 5, '8k', '参与公司产品的设计和开发；负责按照项目需求进行程序编码；参与代码审查和技术文档编写。', '计算机科学或相关领域学士学位；熟悉Java/Python/C++至少一种编程语言；有良好的团队合作精神及沟通能力。', '上海市松江区', '周一至周五，早九晚六'),(23, '数据分析师', '大数据分析', 8, 3, '10k', '利用统计方法分析大量数据集以发现趋势；准备报告并呈现给管理层；协助制定基于数据分析的战略决策。', '数学、统计学、计算机科学或其他相关领域本科及以上学历；精通SQL数据库查询；熟悉使用Excel高级功能及至少一种数据分析工具如R语言或Python。', '上海浦东新区', '弹性工作制，平均每周40小时'),(24, '网络安全专家', '信息安全', 8, 2, '12k', '设计并实施网络安全解决方案来保护公司的信息系统；定期检查系统漏洞，并提出改进建议；对员工进行安全意识培训。', '拥有信息安全、计算机工程等相关专业的学士或硕士学位；持有CISSP等认证者优先考虑；具备较强的逻辑思维能力和问题解决技巧。', '上海市闵行区', '标准全职')
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `i-manager`.`notice` WRITE;
DELETE FROM `i-manager`.`notice`;
INSERT INTO `i-manager`.`notice` (`id`,`title`,`content`,`time`,`user`) VALUES (1, '今天系统正式上线，开始内测', '今天系统正式上线，开始内测', '2025-09-11', 'admin'),(2, '所有功能都已完成，可以正常使用', '所有功能都已完成，可以正常使用', '2025-09-12', 'admin'),(3, '一批新岗位正在招聘中', '2025.9一批新岗位正在招聘中', '2025-09-14', 'admin'),(4, '22级毕业生生开始申请实习', '22级毕业生生开始申请实习并落实实习单位', '2025-09-15', 'admin'),(5, '新增大批知名企业招聘', '知名企业招聘信息发布', '2025-09-15', 'admin')
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `i-manager`.`resume` WRITE;
DELETE FROM `i-manager`.`resume`;
INSERT INTO `i-manager`.`resume` (`id`,`student_id`,`name`,`tel`,`email`,`address`,`gender`,`status`,`city`,`department`,`salary`,`person`,`education`,`project`,`skills`,`honor`) VALUES (2, 6, '李明', '13656932536', 'liming@test.com', '南京', '男', '应届毕业生', '南京', 'Java', '5k', '具有5年软件开发经验，擅长Java和Python，熟悉敏捷开发流程，能够快速适应新技术。', '南京大学计算机科学与技术学士学位（2016-2020）。', '参与开发了企业级ERP系统，优化了系统性能并提高了用户满意度', 'Oracle Certified Professional, Java SE 8 Programmer；AWS Certified Solutions Architect - Associate。', '全国大学生程序设计竞赛一等奖（2019）。'),(3, 2, '李佳', '17769368598', 'lijia@test.com', '南京', '女', '应届毕业生', '南京', '后端开发工程师', '9k', '专注于后端服务的开发，具备良好的编程能力和问题解决能力', '清华大学软件工程学士学位（2020-2024）', '在校期间参与了一个社交平台的后端开发，处理了高并发的数据请求', '精通Node.js, Python, Go；AWS Certified Developer - Associate', '清华大学优秀毕业生（2024）'),(4, 3, '刘诗', '16865423698', 'liushi@test.com', '南京', '女', '应届毕业生', '南京', '数据库管理员', '7k', '具备数据库管理和优化的基础知识，熟悉多种数据库系统', '浙江大学计算机科学与技术学士学位（2020-2024）', '参与了一个校园图书馆系统的数据库设计和维护，确保了数据的安全性和完整性。', 'Oracle Certified Professional, MySQL 5.7 Database Administrator', '浙江大学优秀学生干部（2023）'),(5, 5, '宋帆', '17796583246', 'songfan@test.com', '上海', '男', '应届毕业生', '上海', '全栈开发工程师', '12k', '具有全栈开发能力，能够独立完成从数据库设计到前端展示的全流程开发。', '复旦大学信息管理与信息系统学士学位（2020-2024）。', '负责一个校园二手交易平台的全栈开发，快速迭代产品并成功上线。', '熟悉MEAN/MERN堆栈；MongoDB Certified Developer Associate', '全国大学生创新创业大赛优秀团队奖（2023）'),(6, 4, '陈欣', '13689567596', 'chenxin@test.com', '南京', '女', '应届毕业生', '南京', '云计算工程师', '8k', '具备云平台管理和运维的基础知识，专注于云基础设施的设计和优化。', '南京大学计算机科学与技术学士学位（2020-2024）', '参与了一个基于AWS的校园云存储项目，提高了数据存储和访问效率', 'AWS Certified Solutions Architect - Associate；Google Cloud Certified - Professional Cloud Architect', '南京大学优秀毕业生（2024）。'),(7, 9, '杨紫', '13592649236', 'yangzi@test.com', '南京', '女', '应届毕业生', '南京', '网络安全工程师', '7k', '对网络安全有浓厚兴趣，具备漏洞评估、入侵检测和安全策略制定的能力', '上海交通大学信息安全学士学位（2020-2024）。', '在校期间参与了一次校园网络的安全审计，发现了多个潜在的安全风险并提出解决方案。', 'CISSP, CEH, CompTIA Security+', '全国网络安全竞赛二等奖（2023）'),(8, 7, '张浩', '13656964265', 'zhanghao@test.com', '南京', '男', '应届毕业生', '南京', '前端开发工程师', '8k', '具备扎实的前端开发基础，熟悉现代Web技术栈，能够构建响应式和高性能的Web应用。', '北京大学计算机科学与技术学士学位（2020-2024）', '参与了一个校园在线书店项目的前端开发，使用React.js实现了用户友好的界面', '精通HTML, CSS, JavaScript；React.js认证开发者', '全国Web开发大赛一等奖（2023）。'),(9, 1, '高宇杰', '15696836542', 'gaoyujie@test.com', '杭州', '男', '应届毕业生', '杭州', 'DevOps工程师', '8k', '擅长自动化部署、持续集成/持续交付（CI/CD）流程，致力于提高开发效率。', '华中科技大学软件工程学士学位（2020-2024）。', '在校期间建立了一套完整的CI/CD流水线，大大缩短了学校内部项目的发布周期', 'Docker, Kubernetes, Jenkins；Certified Kubernetes Administrator (CKA)', '华中科技大学优秀学生干部（2023）'),(10, 8, '许世杰', '13685697264', 'xushijie@test.com', '北京', '男', '应届毕业生', '上海', '人工智能工程师', '9k', '专注于机器学习和深度学习，具备扎实的理论基础和实践能力。', '中国科学技术大学人工智能学士学位（2020-2024）', '参与了一个基于深度学习的图像识别项目，准确率达到98%以上', 'TensorFlow, PyTorch, Scikit-learn；Google AI Certification。', '国际人工智能大会论文发表（2023）。'),(12, 11, '刘期', '15690704413', 'liuq@test.com', '南京', '女', '应届毕业生', '上海市', '数据分析师', '12k', '毕业于复旦大学统计学专业，具备扎实的数据处理及分析能力。熟悉Python编程语言及相关数据分析库如Pandas、NumPy等。曾参与多项商业智能项目，在数据挖掘领域积累了丰富实践经验。热爱挑战，渴望在一个充满活力的工作环境中成长。', '2017年9月 - 2021年7月 复旦大学 统计学 本科', '项目名称：电商平台用户行为分析\n职责描述：利用Python进行数据清洗、特征工程及模型训练；应用机器学习算法预测消费者偏好变化。\n成果：为营销策略调整提供了有力支持，帮助企业在促销活动中实现了销售额增长15%。\n项目名称：银行信用卡风险评估系统建设\n职责描述：构建信用评分卡模型以辅助信贷审批决策过程。\n成果：有效降低了不良贷款率，提升了审批效率。', 'SAS Certified Specialist: Base Programming Using SAS 9.4\nIBM Data Science Professional Certificate (Coursera)', '2020年“中国青年数据科学家”提名奖\n全国大学生数学建模竞赛一等奖')
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `i-manager`.`score` WRITE;
DELETE FROM `i-manager`.`score`;
INSERT INTO `i-manager`.`score` (`id`,`student_id`,`enterprise_id`,`teacher_id`,`enterprise_score`,`teacher_score`,`score`) VALUES (1, 2, 1, 4, 90.00, 95.00, 93.50),(2, 4, 2, 2, 90.00, 90.00, 90.00),(3, 5, 3, 3, 95.00, 95.00, 95.00)
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `i-manager`.`speciality` WRITE;
DELETE FROM `i-manager`.`speciality`;
INSERT INTO `i-manager`.`speciality` (`id`,`name`,`content`,`college_id`,`score`) VALUES (1, '计算机科学与技术', '计算机科学与技术', 1, 50),(2, '会计', '会计', 2, 50),(3, '汉语言文学', '汉语言文学', 4, 50),(4, '英语', '英语', 3, 50),(5, '机械工程', '机械工程', 5, 50)
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `i-manager`.`student` WRITE;
DELETE FROM `i-manager`.`student`;
INSERT INTO `i-manager`.`student` (`id`,`username`,`password`,`name`,`avatar`,`role`,`college_id`,`speciality_id`,`class_id`,`score`) VALUES (1, 'gaoyujie', '123', '高宇杰', 'http://localhost:9090/files/2.jpg', 'STUDENT', 4, 3, 5, 0),(2, 'lijiaying', '123', '李佳', 'http://localhost:9090/files/3.png', 'STUDENT', 5, 5, 4, 0),(3, 'liushiqi', '123', '刘诗', 'http://localhost:9090/files/4.png', 'STUDENT', 5, 5, 4, 0),(4, 'chenxinyi', '123', '陈欣', 'http://localhost:9090/files/5.jpg', 'STUDENT', 3, 4, 3, 0),(5, 'songyifan', '123', '宋帆', 'http://localhost:9090/files/6.jpg', 'STUDENT', 3, 4, 3, 0),(6, 'limingxuan', '123', '李明', 'http://localhost:9090/files/7.jpg', 'STUDENT', 1, 1, 1, 0),(7, 'zhanghaoyu', '123', '张浩', 'http://localhost:9090/files/8.jpg', 'STUDENT', 1, 1, 1, 0),(8, 'xushijie', '123', '许世杰', 'http://localhost:9090/files/9.jpg', 'STUDENT', 4, 3, 5, 0),(9, 'yangzixuan', '123', '杨紫', 'http://localhost:9090/files/10.jpg', 'STUDENT', 1, 1, 1, 0),(11, 'liujq', '123', '刘佳', 'http://localhost:9090/files/11.jpg', 'STUDENT', 1, 1, 6, 0)
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `i-manager`.`task` WRITE;
DELETE FROM `i-manager`.`task`;
INSERT INTO `i-manager`.`task` (`id`,`student_id`,`class_id`,`teacher_id`,`job_id`,`enterprise_id`,`file`,`count`,`record`,`enterprise_remark`,`teacher_remark`,`report`,`self`,`grade`) VALUES (3, 2, 4, 8, 1, 2, 'http://localhost:9090/files/1720357761680-219-6.pdf', 0, 'http://localhost:9090/files/1720361245388-76-4.pdf', '该生实习期间业绩优秀', '实习合格', 'http://localhost:9090/files/1720361363328-管道原始记录.doc', '还有很大进步空间', '优秀'),(10, 5, 3, 4, 2, 1, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),(11, 4, 3, 4, 6, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),(12, 9, 1, 9, 14, 4, 'http://localhost:9090/files/1726464672091-美女8.jpeg', 0, 'http://localhost:9090/files/1726464674488-美女9.jpeg', '实习合格', '优秀', 'http://localhost:9090/files/1726464676811-美女3.jpeg', '自我评价良好', '优秀'),(13, 3, 4, 8, 9, 3, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),(17, 1, 5, 6, 2, 1, 'http://localhost:9090/files/1757492690453-D54877200BCE4E0D11AD699CC05E3062.jpg', 0, 'http://localhost:9090/files/1757492697878-打开代码.txt', 'fegrhtngfdwfeghrntm', 'dwfegregwefadcvbgfhj', 'http://localhost:9090/files/1757492704008-测试 销售单录入模板.xlsx', '的法国人替换即可，就很过分发达swerthy', '良好')
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `i-manager`.`teacher` WRITE;
DELETE FROM `i-manager`.`teacher`;
INSERT INTO `i-manager`.`teacher` (`id`,`username`,`password`,`name`,`avatar`,`role`,`phone`,`email`,`title`) VALUES (2, 'yangliuyi', '123', '杨柳依', 'http://localhost:9090/files/12.jpg', 'TEACHER', '16869351268', 'yangliuyi11@i.com', '副教授'),(3, 'chensijing', '123', '陈思静', 'http://localhost:9090/files/13.jpg', 'TEACHER', '16656942675', 'chensijing12@i.com', '副教授'),(4, 'zhangzhigang', '123', '张志刚', 'http://localhost:9090/files/14.jpg', 'TEACHER', '16664597856', 'zhigang23@i.com', '教授'),(6, 'wangyaqin', '123', '王雅琴', 'http://localhost:9090/files/15.jpg', 'TEACHER', '16594683569', 'wangyaqin77@i.com', '教授'),(8, 'lijianhui', '123', '李建辉', 'http://localhost:9090/files/16.jpg', 'TEACHER', '17633468533', 'lijianhui61@i.com', '研究生'),(9, 'zhanghuijuan', '123', '张慧娟', 'http://localhost:9090/files/17.jpg', 'TEACHER', '13569684596', 'zhanghuijuan@i.com', '研究生'),(10, 'zgg', '123', '张国光', 'http://localhost:9090/files/18.jpg', 'TEACHER', '19946866846', 'zgg@i.com', '高级工程师')
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `i-manager`.`useractions` WRITE;
DELETE FROM `i-manager`.`useractions`;
INSERT INTO `i-manager`.`useractions` (`id`,`user_id`,`job_id`,`action_type`,`create_time`) VALUES (1, 6, 1, 'VIEW', '2025-09-09 23:36:05'),(2, 6, 2, 'VIEW', '2025-09-09 23:36:48'),(3, 6, 7, 'APPLY', '2025-09-09 23:40:40'),(4, 1, 8, 'VIEW', '2025-09-10 22:02:24'),(5, 1, 7, 'VIEW', '2025-09-10 22:02:27'),(7, 1, 2, 'APPLY', '2025-09-10 22:02:37'),(8, 4, 10, 'VIEW', '2025-09-10 22:11:31'),(9, 4, 2, 'VIEW', '2025-09-10 22:11:34'),(10, 4, 1, 'VIEW', '2025-09-10 22:11:36'),(12, 2, 1, 'VIEW', '2025-09-10 22:12:00'),(13, 2, 2, 'VIEW', '2025-09-10 22:12:01'),(15, 2, 1, 'APPLY', '2025-09-10 22:12:10'),(16, 3, 9, 'VIEW', '2025-09-10 22:12:23'),(17, 3, 8, 'VIEW', '2025-09-10 22:12:24'),(18, 3, 7, 'VIEW', '2025-09-10 22:12:26'),(22, 9, 14, 'VIEW', '2025-09-16 13:08:41'),(23, 9, 11, 'VIEW', '2025-09-16 13:08:48'),(24, 9, 1, 'VIEW', '2025-09-16 13:08:52'),(25, 9, 12, 'VIEW', '2025-09-16 13:09:10'),(26, 9, 7, 'VIEW', '2025-09-16 13:09:19'),(27, 9, 11, 'VIEW', '2025-09-16 13:09:26'),(28, 9, 14, 'APPLY', '2025-09-16 13:25:26'),(29, 9, 14, 'APPLY', '2025-09-16 13:27:29'),(30, 8, 1, 'VIEW', '2025-09-18 10:32:40'),(31, 8, 11, 'VIEW', '2025-09-18 10:32:47'),(32, 9, 8, 'VIEW', '2025-09-19 09:50:08'),(33, 9, 11, 'VIEW', '2025-09-19 09:50:35'),(34, 9, 7, 'VIEW', '2025-09-19 10:01:33'),(35, 8, 7, 'APPLY', '2025-09-20 12:32:36'),(36, 8, 9, 'APPLY', '2025-09-20 22:05:23'),(37, 10, 24, 'VIEW', '2025-09-23 08:39:00'),(38, 10, 20, 'VIEW', '2025-09-23 08:39:04'),(39, 10, 8, 'VIEW', '2025-09-23 08:39:12'),(40, 10, 19, 'VIEW', '2025-09-23 08:41:22'),(41, 10, 7, 'VIEW', '2025-09-23 08:41:25'),(42, 10, 9, 'VIEW', '2025-09-23 08:41:27'),(43, 10, 22, 'APPLY', '2025-09-23 08:58:43'),(44, 10, 22, 'APPLY', '2025-09-23 08:59:14'),(45, 11, 24, 'VIEW', '2025-09-23 09:21:50'),(46, 11, 19, 'VIEW', '2025-09-23 09:21:52'),(47, 11, 21, 'VIEW', '2025-09-23 09:21:55'),(48, 11, 1, 'VIEW', '2025-09-23 09:22:02'),(49, 11, 11, 'VIEW', '2025-09-23 09:22:05'),(50, 11, 20, 'VIEW', '2025-09-23 09:22:10'),(51, 11, 16, 'VIEW', '2025-09-23 09:22:13'),(52, 11, 12, 'VIEW', '2025-09-23 09:22:15'),(53, 11, 18, 'VIEW', '2025-09-23 09:22:17'),(54, 11, 24, 'VIEW', '2025-09-23 09:22:25'),(55, 11, 20, 'VIEW', '2025-09-23 09:22:30'),(56, 11, 11, 'VIEW', '2025-09-23 09:22:36'),(57, 11, 10, 'VIEW', '2025-09-23 09:22:38'),(58, 11, 23, 'APPLY', '2025-09-23 18:11:31'),(59, 11, 23, 'APPLY', '2025-09-24 10:20:45'),(60, 11, 24, 'VIEW', '2025-09-24 10:23:41'),(61, 11, 23, 'VIEW', '2025-09-24 10:23:50'),(62, 11, 19, 'VIEW', '2025-09-24 10:24:06'),(63, 11, 24, 'VIEW', '2025-09-24 21:35:07'),(64, 11, 23, 'APPLY', '2025-09-24 21:36:46'),(65, 1, 24, 'VIEW', '2025-09-10 16:16:42'),(66, 1, 10, 'APPLY', '2025-09-10 16:17:13'),(67, 1, 10, 'APPLY', '2025-09-10 16:17:19'),(68, 1, 2, 'APPLY', '2025-09-10 16:17:40'),(69, 1, 2, 'APPLY', '2025-09-10 16:17:50'),(70, 6, 2, 'APPLY', '2025-09-10 16:19:06'),(71, 1, 2, 'APPLY', '2025-09-10 16:22:13'),(72, 1, 2, 'APPLY', '2025-09-10 16:22:25'),(73, 1, 2, 'APPLY', '2025-09-10 16:22:41'),(74, 1, 24, 'VIEW', '2025-09-10 16:22:53')
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `i-manager`.`workplan` WRITE;
DELETE FROM `i-manager`.`workplan`;
INSERT INTO `i-manager`.`workplan` (`id`,`name`,`content`,`time`) VALUES (1, '2022级计算机专业学生实习安排', '2022级计算机专业学生开始实习！', '2025-09-11 22:51:43')
;
UNLOCK TABLES;
COMMIT;
