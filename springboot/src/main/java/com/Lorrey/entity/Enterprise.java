package com.Lorrey.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * 企业
*/
@Data
public class Enterprise extends Account implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 用户名 */
    private String username;
    /** 密码 */
    private String password;
    /** 公司名称 */
    private String name;
    /** 头像 */
    private String avatar;
    /** 角色标识 */
    private String role;
    /** 负责人 */
    private String person;
    /** 联系电话 */
    private String phone;
    /** 地址 */
    private String address;

}
