package com.Lorrey.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * 学院
*/
@Data
public class College implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 学院名称 */
    private String name;
    /** 学院描述 */
    private String content;

}
