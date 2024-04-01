package com.Lorrey.mapper;

import com.Lorrey.entity.Workplan;

import java.util.List;

/**
 * 操作workplan相关数据接口
*/
public interface WorkplanMapper {

    /**
      * 新增
    */
    int insert(Workplan workplan);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(Workplan workplan);

    /**
      * 根据ID查询
    */
    Workplan selectById(Integer id);

    /**
      * 查询所有
    */
    List<Workplan> selectAll(Workplan workplan);

}
