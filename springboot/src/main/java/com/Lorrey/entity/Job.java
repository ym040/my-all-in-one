package com.Lorrey.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 岗位
*/
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Job implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 岗位名称 */
    private String name;
    /** 行业方向 */
    private String direction;
    /** 企业ID */
    private Integer enterpriseId;
    /** 招聘人数 */
    private Integer count;
    /** 薪资 */
    private String salary;
    /** 岗位描述 */
    private String jobDescribe;
    /** 专业要求 */
    private String jobRequire;
    /** 工作地点 */
    private String address;
    /** 工作时间 */
    private String workTime;

    /* 关联ID */
    private String enterpriseName;

}
