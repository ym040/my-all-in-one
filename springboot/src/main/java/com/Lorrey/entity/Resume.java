package com.Lorrey.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * 简历
*/
@Data
public class Resume implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 学生ID */
    private Integer studentId;
    /** 姓名 */
    private String name;
    /** 电话 */
    private String tel;
    /** 邮箱 */
    private String email;
    /** 现居城市 */
    private String address;
    /** 性别 */
    private String gender;
    /** 求职状态 */
    private String status;
    /** 意向城市 */
    private String city;
    /** 期望职位 */
    private String department;
    /** 期望薪资 */
    private String salary;
    /** 个人总结 */
    private String person;
    /** 教育背景 */
    private String education;
    /** 项目经历 */
    private String project;
    /** 技能、证书 */
    private String skills;
    /** 荣誉奖项 */
    private String honor;

    /* 关联ID */
    private String studentName;

}

