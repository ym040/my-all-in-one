package com.Lorrey.mapper;

import com.Lorrey.entity.Job;

import java.util.List;

/**
 * 操作job相关数据接口
*/
public interface JobMapper {

    /**
      * 新增
    */
    int insert(Job job);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(Job job);

    /**
      * 根据ID查询
    */
    Job selectById(Integer id);

    /**
      * 查询所有
    */
    List<Job> selectAll(Job job);


    /**
     * 根据企业ID查询 + 企业名称模糊查询
     */
    List<Job> selectByEnterpriseId(Job job);
}
