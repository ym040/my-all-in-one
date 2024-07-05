package com.Lorrey.mapper;

import com.Lorrey.entity.Task;

import java.util.List;

/**
 * 操作task相关数据接口
*/
public interface TaskMapper {

    /**
      * 新增
    */
    int insert(Task task);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(Task task);

    /**
      * 根据ID查询
    */
    Task selectById(Integer id);

    /**
      * 查询所有
    */
    List<Task> selectAll(Task task);

    /**
     * 批量新增
     */
    void batchAdd(List<Task> tasks);
}
