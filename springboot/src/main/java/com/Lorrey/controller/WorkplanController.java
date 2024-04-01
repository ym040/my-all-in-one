package com.Lorrey.controller;

import com.Lorrey.common.Result;
import com.Lorrey.entity.Workplan;
import com.Lorrey.service.WorkplanService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 实习安排表前端操作接口
 **/
@RestController
@RequestMapping("/workplan")
public class WorkplanController {

    @Resource
    private WorkplanService workplanService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Workplan workplan) {
        workplanService.add(workplan);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        workplanService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        workplanService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Workplan workplan) {
        workplanService.updateById(workplan);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Workplan workplan = workplanService.selectById(id);
        return Result.success(workplan);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Workplan workplan ) {
        List<Workplan> list = workplanService.selectAll(workplan);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Workplan workplan,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Workplan> page = workplanService.selectPage(workplan, pageNum, pageSize);
        return Result.success(page);
    }

}
