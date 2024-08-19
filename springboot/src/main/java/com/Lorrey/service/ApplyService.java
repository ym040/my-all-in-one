package com.Lorrey.service;

import cn.hutool.core.util.ObjectUtil;
import com.Lorrey.common.enums.ResultCodeEnum;
import com.Lorrey.entity.Apply;
import com.Lorrey.exception.CustomException;
import com.Lorrey.mapper.ApplyMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 实习申请信息业务处理
 **/
@Service
public class ApplyService {

    @Resource
    private ApplyMapper applyMapper;

    /**
     * 新增
     */
    public void add(Apply apply) {
        Apply dbApply = applyMapper.selectByUsername(apply.getUsername());
        if (ObjectUtil.isNotNull(dbApply)) {
            throw new CustomException(ResultCodeEnum.USER_EXIST_ERROR);
        }
        applyMapper.insert(apply);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        applyMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            applyMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Apply apply) {
        applyMapper.updateById(apply);
    }

    /**
     * 根据ID查询
     */
    public Apply selectById(Integer id) {
        return applyMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Apply> selectAll(Apply apply) {
        return applyMapper.selectAll(apply);
    }

    /**
     * 分页查询
     */
    public PageInfo<Apply> selectPage(Apply apply, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Apply> list = applyMapper.selectAll(apply);
        //System.out.println(list);
        return PageInfo.of(list);
    }

    /**
     * 更新状态
     */
    public void updateStatus(Apply apply) {
        applyMapper.updateStatus(apply);
    }

    /**
     * 更新阅读状态
     */
    public void updateReadStatus(Apply apply) {
        applyMapper.updateReadStatus(apply);
    }

    /**
     * 根据用户名查找
     */
    public Apply selectByUsername(String username) {
        return applyMapper.selectByUsername(username);
    }

    /**
     * 根据学生ID查询
     */
    public Apply selectByStuId(Integer stuId) {
        return applyMapper.selectByStuId(stuId);
    }

    /**
     * 根据教师ID查询
     */
    public List<Apply> selectByTeacherId(Integer teacherId) {
        return applyMapper.selectByTeacherId(teacherId);
    }

    /**
     * 企业分页查询
     */
    public PageInfo<Apply> selectEnterprise(Apply apply, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Apply> list = applyMapper.selectEnterprise(apply);
        return PageInfo.of(list);
    }

    /**
     * 教师分页查询
     */
    public PageInfo<Apply> selectByTeacher(Apply apply, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Apply> list = applyMapper.selectByTeacher(apply);
        return PageInfo.of(list);
    }

    /**
     * 学生分页查询
     */
    public PageInfo<Apply> selectByStudent(Apply apply, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Apply> list = applyMapper.selectByStudent(apply);
        return PageInfo.of(list);
    }

    /**
     * 更新简历状态
     */
    public void updateResumeStatus(Integer stuId, Integer resumeStatus) {
        applyMapper.updateResumeStatus(stuId, resumeStatus);
    }
}

