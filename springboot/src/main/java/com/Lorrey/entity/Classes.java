package com.Lorrey.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * 班级
 */
@Data
public class Classes implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 班级名称 */
    private String name;
    /** 班级描述 */
    private String content;
    /** 教师ID */
    private Integer teacherId;
    /** 学院ID */
    private Integer specialityId;

    /** 关联教师姓名 */
    private String teacherName;
    /** 关联专业名称 */
    private String specialityName;

}

