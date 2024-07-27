package com.Lorrey.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * 实习任务
*/
@Data
public class Task implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 学生ID */
    private Integer studentId;
    /** 班级ID */
    private Integer classId;
    /** 教师ID */
    private Integer teacherId;
    /** 岗位ID */
    private Integer jobId;
    /** 企业ID */
    private Integer enterpriseId;
    /** 三方协议 */
    private String file;
    /** 签到次数 */
    private Integer count;
    /** 周志 */
    private String record;
    /** 企业评价 */
    private String enterpriseRemark;
    /** 教师评价 */
    private String teacherRemark;
    /** 实践报告 */
    private String report;
    /** 自我鉴定 */
    private String self;
    /** 成绩鉴定 */
    private String grade;


    /* 关联ID */
    private String studentName;
    private String className;
    private String teacherName;
    private String jobName;
    private String enterpriseName;
    private String status;


}
