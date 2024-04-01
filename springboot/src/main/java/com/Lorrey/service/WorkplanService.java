package com.Lorrey.service;

import cn.hutool.core.date.DateUtil;
import com.Lorrey.entity.Workplan;
import com.Lorrey.mapper.WorkplanMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 实习安排表业务处理
 **/
@Service
public class WorkplanService {

    @Resource
    private WorkplanMapper workplanMapper;

    /**
     * 新增
     */
    public void add(Workplan workplan) {
        workplan.setTime(DateUtil.now());
        workplanMapper.insert(workplan);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        workplanMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            workplanMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Workplan workplan) {
        workplanMapper.updateById(workplan);
    }

    /**
     * 根据ID查询
     */
    public Workplan selectById(Integer id) {
        return workplanMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Workplan> selectAll(Workplan workplan) {
        return workplanMapper.selectAll(workplan);
    }

    /**
     * 分页查询
     */
    public PageInfo<Workplan> selectPage(Workplan workplan, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Workplan> list = workplanMapper.selectAll(workplan);
        return PageInfo.of(list);
    }

}
