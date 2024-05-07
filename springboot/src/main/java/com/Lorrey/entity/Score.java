package com.Lorrey.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * 成绩
*/
@Data
public class Score implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 学生ID */
    private Integer studentId;
    /** 企业ID */
    private Integer enterpriseId;
    /** 教师ID */
    private Integer teacherId;
    /** 企业评分 */
    private Double enterpriseScore;
    /** 教师评分 */
    private Double teacherScore;
    /** 总评 */
    private Double score;

    /** 关联ID */
    private String studentName;
    private String enterpriseName;
    private String teacherName;


}
