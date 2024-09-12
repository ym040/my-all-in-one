package com.Lorrey.controller;

import com.Lorrey.common.Result;
import com.Lorrey.entity.Apply;
import com.Lorrey.entity.Student;
import com.Lorrey.service.ApplyService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

import static com.Lorrey.common.enums.ResultCodeEnum.PARAM_ERROR;

/**
 * 实习申请信息前端操作接口
 **/
@RestController
@RequestMapping("/apply")
public class ApplyController {

    @Resource
    private ApplyService applyService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Apply apply) {
        applyService.add(apply);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        applyService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        applyService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Apply apply) {
        applyService.updateById(apply);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Apply apply = applyService.selectById(id);
        return Result.success(apply);
    }

    /**
     * 根据学生ID查询
     */
    @GetMapping("/selectByStuId/{stuId}")
    public Result selectByStuId(@PathVariable Integer stuId) {
        Apply apply = applyService.selectByStuId(stuId);
        return Result.success(apply);
    }

    /**
     * 根据教师ID查询
     */
    @GetMapping("/selectByTeacherId")
    public Result selectByTeacherId(@RequestParam Integer teacherId) {
        List<Apply> list = applyService.selectByTeacherId(teacherId);
        return Result.success(list);
    }

    /**
     * 根据用户名查找
     */
    @GetMapping("/selectByUsername/{username}")
    public Result selectByUsername(@PathVariable String username) {
        Apply apply = applyService.selectByUsername(username);
        return Result.success(apply);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Apply apply ) {
        List<Apply> list = applyService.selectAll(apply);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Apply apply,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Apply> page = applyService.selectPage(apply, pageNum, pageSize);
        return Result.success(page);
    }

    /**
     * 企业分页查询
     */
    @GetMapping("/selectEnterprise")
    public Result selectEnterprise(Apply apply,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Apply> page = applyService.selectEnterprise(apply, pageNum, pageSize);
        return Result.success(page);
    }

    /**
     * 教师分页查询
     */
    @GetMapping("/selectByTeacher")
    public Result selectByTeacher(Apply apply,
                                   @RequestParam(defaultValue = "1") Integer pageNum,
                                   @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Apply> page = applyService.selectByTeacher(apply, pageNum, pageSize);
        return Result.success(page);
    }

    /**
     * 学生分页查询
     */
    @GetMapping("/selectByStudent")
    public Result selectByStudent(Apply apply,
                                  @RequestParam(defaultValue = "1") Integer pageNum,
                                  @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Apply> page = applyService.selectByStudent(apply, pageNum, pageSize);
        return Result.success(page);
    }

    /**
     * 更新状态
     */
    @PutMapping("/updateStatus")
    public Result updateStatus(@RequestBody Apply apply) {
        if (apply.getId() == null || apply.getStatus() == null) {
            return Result.error(PARAM_ERROR);
        }
        applyService.updateStatus(apply);
        return Result.success();
    }

    /**
     * 更新阅读状态
     */
    @PutMapping("/updateReadStatus")
    public Result updateReadStatus(@RequestBody Apply apply) {
        if (apply.getId() == null || apply.getReadStatus() == null) {
            return Result.error(PARAM_ERROR);
        }
        applyService.updateReadStatus(apply);
        return Result.success();
    }

    /**
     * 更新简历状态
     */
    @PutMapping("/updateResumeStatus/{studentId}/{resumeStatus}")
    public Result updateResumeStatus(@PathVariable Integer studentId, @PathVariable Integer resumeStatus) {
        applyService.updateResumeStatus(studentId,resumeStatus);
        return Result.success();
    }

    /**
     * 查询未实习人数总数
     */
    @GetMapping("/selectFStatusCount")
    public Result selectFStatusCount() {
        int count = applyService.selectFStatusCount();
        return Result.success(count);
    }

    /**
     * 查询实习中人数总数
     */
    @GetMapping("/selectTStatusCount")
    public Result selectTStatusCount() {
        int count = applyService.selectTStatusCount();
        return Result.success(count);
    }

    /**
     * 未申请人数总数
     */
    @GetMapping("/selectNoApplyCount")
    public Result selectNoApplyCount() {
        int count = applyService.selectNoApplyCount();
        return Result.success(count);
    }

}
