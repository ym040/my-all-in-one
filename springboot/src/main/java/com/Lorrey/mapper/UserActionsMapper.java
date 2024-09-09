package com.Lorrey.mapper;

import com.Lorrey.entity.UserActions;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 操作用户行为相关数据接口
*/
public interface UserActionsMapper {

    /**
      * 新增
    */
    int insert(UserActions userActions);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(UserActions userActions);

    /**
      * 根据ID查询
    */
    UserActions selectById(Integer id);

    /**
      * 查询所有
    */
    List<UserActions> selectAll(UserActions userActions);

}
