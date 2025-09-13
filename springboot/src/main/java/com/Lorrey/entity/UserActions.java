package com.Lorrey.entity;

import lombok.Data;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

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
    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime localDateTime; // 保持变量名不变，但注释改为"创建时间"

    // 可以添加构造函数和其他方法
}
