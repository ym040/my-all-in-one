package com.Lorrey.service;

import com.Lorrey.entity.Task;
import com.Lorrey.mapper.TaskMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 实习任务业务处理
 **/
@Service
public class TaskService {

    @Resource
    private TaskMapper taskMapper;

    /**
     * 新增
     */
    public void add(Task task) {
        taskMapper.insert(task);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        taskMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            taskMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Task task) {
        taskMapper.updateById(task);
    }

    /**
     * 根据ID查询
     */
    public Task selectById(Integer id) {
        return taskMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Task> selectAll(Task task) {
        return taskMapper.selectAll(task);
    }

    /**
     * 分页查询
     */
    public PageInfo<Task> selectPage(Task task, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Task> list = taskMapper.selectAll(task);
        return PageInfo.of(list);
    }

    /**
     * 批量新增
     */
    public void batchAdd(List<Task> tasks) {
        taskMapper.batchAdd(tasks);
    }

    /**
     * 根据学生ID查询
     */
    public Task selectByStuId(Integer stuId) {
        return taskMapper.selectByStuId(stuId);
    }

    /**
     * 根据学生成绩查询
     */
    public List<Task> selectByGrade(String grade) {
        return taskMapper.selectByGrade(grade);
    }
}

