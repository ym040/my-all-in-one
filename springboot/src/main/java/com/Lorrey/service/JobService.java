package com.Lorrey.service;

import com.Lorrey.entity.Job;
import com.Lorrey.mapper.JobMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 岗位信息表业务处理
 **/
@Service
public class JobService {

    @Resource
    private JobMapper jobMapper;

    /**
     * 新增
     */
    public void add(Job job) {
        jobMapper.insert(job);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        jobMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            jobMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Job job) {
        jobMapper.updateById(job);
    }

    /**
     * 根据ID查询
     */
    public Job selectById(Integer id) {
        return jobMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Job> selectAll(Job job) {
        return jobMapper.selectAll(job);
    }

    /**
     * 分页查询
     */
    public PageInfo<Job> selectPage(Job job, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Job> list = jobMapper.selectAll(job);
        return PageInfo.of(list);
    }

    /**
     * 根据企业查询
     */
    public List<Job> selectByEnterpriseId(Integer enterpriseId) {
        return jobMapper.selectByEnterpriseId(enterpriseId);
    }
}
