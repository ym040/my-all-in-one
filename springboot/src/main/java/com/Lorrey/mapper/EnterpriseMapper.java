package com.Lorrey.mapper;

import com.Lorrey.entity.Enterprise;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 操作enterprise相关数据接口
*/
public interface EnterpriseMapper {

    /**
      * 新增
    */
    int insert(Enterprise enterprise);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(Enterprise enterprise);

    /**
      * 根据ID查询
    */
    Enterprise selectById(Integer id);

    /**
      * 查询所有
    */
    List<Enterprise> selectAll(Enterprise enterprise);

    @Select("select * from enterprise where username = #{username}")
    Enterprise selectByUsername(String username);
}
