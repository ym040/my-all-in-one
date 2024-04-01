package com.Lorrey.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * 实习安排表
*/
@Data
public class Workplan implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 标题 */
    private String name;
    /** 内容 */
    private String content;
    /** 发布时间 */
    private String time;


}
