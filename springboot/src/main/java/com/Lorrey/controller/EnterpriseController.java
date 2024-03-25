package com.Lorrey.controller;

import com.Lorrey.common.Result;
import com.Lorrey.entity.Enterprise;
import com.Lorrey.service.EnterpriseService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 企业前端操作接口
 **/
@RestController
@RequestMapping("/enterprise")
public class EnterpriseController {

    @Resource
    private EnterpriseService enterpriseService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Enterprise enterprise) {
        enterpriseService.add(enterprise);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        enterpriseService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        enterpriseService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Enterprise enterprise) {
        enterpriseService.updateById(enterprise);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Enterprise enterprise = enterpriseService.selectById(id);
        return Result.success(enterprise);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Enterprise enterprise ) {
        List<Enterprise> list = enterpriseService.selectAll(enterprise);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Enterprise enterprise,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Enterprise> page = enterpriseService.selectPage(enterprise, pageNum, pageSize);
        return Result.success(page);
    }

}
