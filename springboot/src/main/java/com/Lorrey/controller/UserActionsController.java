package com.Lorrey.controller;

import com.Lorrey.common.Result;
import com.Lorrey.entity.Job;
import com.Lorrey.entity.UserActions;
import com.Lorrey.service.UserActionsService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 用户行为前端操作接口
 **/
@RestController
@RequestMapping("/userActions")
public class UserActionsController {

    @Resource
    private UserActionsService userActionsService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody UserActions userActions) {
        userActionsService.add(userActions);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        userActionsService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        userActionsService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody UserActions userActions) {
        userActionsService.updateById(userActions);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        UserActions userActions = userActionsService.selectById(id);
        return Result.success(userActions);
    }

    /**
     * 根据UserID查询
     */
    @GetMapping("/selectByUserId/{userId}")
    public Result selectByUserId(@PathVariable Integer userId) {
        List<UserActions> userActions = userActionsService.selectByUserId(userId);
        return Result.success(userActions);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(UserActions userActions ) {
        List<UserActions> list = userActionsService.selectAll(userActions);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(UserActions userActions,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<UserActions> page = userActionsService.selectPage(userActions, pageNum, pageSize);
        return Result.success(page);
    }

    /**
     * 基于协同过滤的推荐算法
     */
    @GetMapping("/recommend/{userId}")
    public Result recommend(@PathVariable Integer userId) {
        //查询该用户的所有行为
        List<UserActions> list = userActionsService.selectByUserId(userId);
        //System.out.println(list);
        //根据用户行为进行推荐算法逻辑计算
        List<Job> recommendList = userActionsService.recommend(list);
        //System.out.println(recommendList);
        return Result.success(recommendList);
    }

}
