package com.Lorrey.mapper;

import com.Lorrey.entity.Resume;

import java.util.List;

/**
 * 操作resume相关数据接口
*/
public interface ResumeMapper {

    /**
      * 新增
    */
    int insert(Resume resume);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(Resume resume);

    /**
      * 根据ID查询
    */
    Resume selectById(Integer id);

    /**
      * 查询所有
    */
    List<Resume> selectAll(Resume resume);


    /**
     * 根据企业ID查询 + 企业名称模糊查询
     */
    List<Resume> selectByEnterpriseId(Resume resume);

    /**
     * 根据学生ID查询
     */
    Resume selectByStudentId(Integer studentId);

    /**
     * 根据学生ID修改
     */
    void updateByStudentId(Resume resume);
}
