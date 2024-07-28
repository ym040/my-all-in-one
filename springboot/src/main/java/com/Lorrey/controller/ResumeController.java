package com.Lorrey.controller;

import com.Lorrey.common.Result;
import com.Lorrey.entity.Resume;
import com.Lorrey.service.ResumeService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 简历信息表前端操作接口
 **/
@RestController
@RequestMapping("/resume")
public class ResumeController {

    @Resource
    private ResumeService resumeService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Resume resume) {
        resumeService.add(resume);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        resumeService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        resumeService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Resume resume) {
        resumeService.updateById(resume);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Resume resume = resumeService.selectById(id);
        return Result.success(resume);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Resume resume ) {
        List<Resume> list = resumeService.selectAll(resume);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Resume resume,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Resume> page = resumeService.selectPage(resume, pageNum, pageSize);
        return Result.success(page);
    }

}
