package com.Lorrey.mapper;

import com.Lorrey.entity.UserActions;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * 操作用户行为相关数据接口
*/
public interface UserActionsMapper {

    /**
      * 新增用户行为记录
    */
    int insert(UserActions userActions);

    /**
      * 根据ID删除用户行为记录
    */
    int deleteById(Integer id);

    /**
      * 根据ID更新用户行为记录
    */
    int updateById(UserActions userActions);

    /**
      * 根据ID查询用户行为记录
    */
    UserActions selectById(Integer id);

    /**
      * 查询所有用户行为记录
    */
    List<UserActions> selectAll(UserActions userActions);

    /**
     * 根据用户ID查询用户行为记录
     */
    List<UserActions> selectByUserId(Integer userId);

}
