package com.Lorrey.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * 学生
*/
@Data
public class Student extends Account implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 用户名 */
    private String username;
    /** 密码 */
    private String password;
    /** 姓名 */
    private String name;
    /** 头像 */
    private String avatar;
    /** 角色标识 */
    private String role;
    /** 学院ID */
    private Integer collegeId;
    /** 专业ID */
    private Integer specialityId;
    /** 班级ID */
    private Integer classId;
    /** 实习成绩 */
    private Integer score;

    /* 关联ID */
    private String collegeName;
    private String specialityName;
    private String className;

}
