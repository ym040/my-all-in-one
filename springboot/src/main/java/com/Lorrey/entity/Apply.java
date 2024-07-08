package com.Lorrey.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 实习申请信息
*/
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Apply implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 学生ID */
    private Integer stuId;
    /** 用户名 */
    private String username;
    /** 姓名 */
    private String name;
    /** 班级ID */
    private Integer classId;
    /** 联系电话 */
    private String phone;
    /** 企业ID */
    private Integer enterpriseId;
    /** 岗位ID */
    private Integer jobId;
    /** 薪资 */
    private String salary;
    /** 工作地点 */
    private String address;
    /** 开始时间 */
    private String beginTime;
    /** 结束时间 */
    private String endTime;
    /** 实习状态 */
    private String status;
    /** 阅读状态 */
    private String readStatus;

    /* 关联ID */
    private String className;
    private String enterpriseName;
    private String jobName;

}
