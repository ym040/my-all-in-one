package com.Lorrey.mapper;

import com.Lorrey.entity.Apply;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 操作apply相关数据接口
*/
public interface ApplyMapper {

    /**
      * 新增
    */
    int insert(Apply apply);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(Apply apply);

    /**
      * 根据ID查询
    */
    Apply selectById(Integer id);

    /**
      * 查询所有
    */
    List<Apply> selectAll(Apply apply);

    /**
     * 根据用户名查找
     */
    @Select("select * from apply where username = #{username}")
    Apply selectByUsername(String name);

    /**
     * 更新状态
     */
    void updateStatus(Apply apply);

    /**
     * 更新阅读状态
     */
    void updateReadStatus(Apply apply);

    /**
     * 根据学生ID查询
     */
    Apply selectByStuId(Integer stuId);

    /**
     * 根据教师ID查询
     */
    List<Apply> selectByTeacherId(Integer teacherId);
}
