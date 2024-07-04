package com.Lorrey.controller;

import com.Lorrey.common.Result;
import com.Lorrey.entity.Job;
import com.Lorrey.service.JobService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 岗位信息表前端操作接口
 **/
@RestController
@RequestMapping("/job")
public class JobController {

    @Resource
    private JobService jobService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Job job) {
        jobService.add(job);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        jobService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        jobService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Job job) {
        jobService.updateById(job);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Job job = jobService.selectById(id);
        return Result.success(job);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Job job ) {
        List<Job> list = jobService.selectAll(job);
        return Result.success(list);
    }

    /**
     * 根据企业查询
     */
    @GetMapping("/selectByEnterpriseId/{enterpriseId}")
    public Result selectByEnterpriseId(@PathVariable Integer enterpriseId) {
        List<Job> list = jobService.selectByEnterpriseId(enterpriseId);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Job job,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Job> page = jobService.selectPage(job, pageNum, pageSize);
        return Result.success(page);
    }

}
