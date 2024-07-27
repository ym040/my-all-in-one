package com.Lorrey.controller;

import com.Lorrey.common.Result;
import com.Lorrey.entity.Apply;
import com.Lorrey.entity.Task;
import com.Lorrey.service.TaskService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

import static com.Lorrey.common.enums.ResultCodeEnum.FILE_UPLOAD_ERROR;

/**
 * 实习任务2前端操作接口
 **/
@RestController
@RequestMapping("/task")
public class TaskController {

    @Resource
    private TaskService taskService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Task task) {
        taskService.add(task);
        return Result.success();
    }

    /**
     * 批量新增
     */
    @PostMapping("/batchAdd")
    public Result batchAdd(@RequestBody List<Task> tasks) {
        System.out.println(tasks);
        taskService.batchAdd(tasks);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        taskService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        taskService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Task task) {
        taskService.updateById(task);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Task task = taskService.selectById(id);
        return Result.success(task);
    }

    /**
     * 根据学生ID查询
     */
    @GetMapping("/selectByStuId")
    public Result selectByStuId(@RequestParam Integer stuId) {
        Task task = taskService.selectByStuId(stuId);
        return Result.success(task);
    }

    /**
     * 根据教师ID查询
     */
    @GetMapping("/selectByTeacherId")
    public Result selectByTeacherId(@RequestParam Integer teacherId) {
        List<Task> tasks = taskService.selectByTeacherId(teacherId);
        return Result.success(tasks);
    }

    /**
     * 根据学生成绩查询
     */
    @GetMapping("/selectByGrade")
    public Result selectByGrade(@RequestParam String grade) {
        List<Task> tasks = taskService.selectByGrade(grade);
        return Result.success(tasks);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Task task ) {
        List<Task> list = taskService.selectAll(task);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Task task,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Task> page = taskService.selectPage(task, pageNum, pageSize);
        return Result.success(page);
    }

    /**
     * 企业分页查询
     */
    @GetMapping("/selectByEnterprise")
    public Result selectByEnterprise(Task task,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Task> page = taskService.selectByEnterprise(task, pageNum, pageSize);
        return Result.success(page);
    }

    /**
     * 教师分页查询
     */
    @GetMapping("/selectByTeacher")
    public Result selectByTeacher(Task task,
                                     @RequestParam(defaultValue = "1") Integer pageNum,
                                     @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Task> page = taskService.selectByTeacher(task, pageNum, pageSize);
        return Result.success(page);
    }

    /**
     * 学生分页查询
     */
    @GetMapping("/selectByStudent")
    public Result selectByStudent(Task task,
                                  @RequestParam(defaultValue = "1") Integer pageNum,
                                  @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Task> page = taskService.selectByStudent(task, pageNum, pageSize);
        return Result.success(page);
    }

}
