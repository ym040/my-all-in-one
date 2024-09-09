package com.Lorrey.entity;

import lombok.Data;

import java.io.Serializable;
import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 * 用户行为
*/
@Data
public class UserActions implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 用户ID */
    private Integer userId;
    /** 岗位ID */
    private Integer jobId;
    /** 用户行为 */
    private String actionType;
    /** 当前时间戳 */
    private LocalDateTime localDateTime;


}
