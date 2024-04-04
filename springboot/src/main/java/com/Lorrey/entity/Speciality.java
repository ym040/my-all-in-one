package com.Lorrey.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * 专业
 */
@Data
public class Speciality implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 专业名称 */
    private String name;
    /** 专业描述 */
    private String content;
    /** 所属学院ID */
    private Integer collegeId;
    /** 学分限定 */
    private Integer score;

    /** 关联学院名称 */
    private String collegeName;

}

