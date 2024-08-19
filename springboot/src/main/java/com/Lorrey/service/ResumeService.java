package com.Lorrey.service;

import com.Lorrey.entity.Resume;
import com.Lorrey.mapper.ResumeMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 简历信息表业务处理
 **/
@Service
public class ResumeService {

    @Resource
    private ResumeMapper resumeMapper;

    /**
     * 新增
     */
    public void add(Resume resume) {
        resumeMapper.insert(resume);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        resumeMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            resumeMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Resume resume) {
        resumeMapper.updateById(resume);
    }

    /**
     * 根据ID查询
     */
    public Resume selectById(Integer id) {
        return resumeMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Resume> selectAll(Resume resume) {
        return resumeMapper.selectAll(resume);
    }

    /**
     * 分页查询
     */
    public PageInfo<Resume> selectPage(Resume resume, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Resume> list = resumeMapper.selectAll(resume);
        return PageInfo.of(list);
    }


    /**
     * 根据企业ID查询 + 企业名称模糊查询
     */
    public PageInfo<Resume> selectByEnterpriseId(Resume resume, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Resume> list = resumeMapper.selectByEnterpriseId(resume);
        return PageInfo.of(list);
    }

    /**
     * 根据学生ID查询
     */
    public Resume selectByStudentId(Integer studentId) {
        return resumeMapper.selectByStudentId(studentId);
    }

    /**
     * 根据学生ID修改
     */
    public void updateByStudentId(Resume resume) {
        resumeMapper.updateByStudentId(resume);
    }
}
