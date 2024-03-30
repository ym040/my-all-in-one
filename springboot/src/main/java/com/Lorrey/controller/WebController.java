package com.Lorrey.controller;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.Lorrey.common.Result;
import com.Lorrey.common.enums.ResultCodeEnum;
import com.Lorrey.common.enums.RoleEnum;
import com.Lorrey.entity.Account;
import com.Lorrey.entity.Enterprise;
import com.Lorrey.entity.Student;
import com.Lorrey.entity.Teacher;
import com.Lorrey.service.AdminService;
import com.Lorrey.service.EnterpriseService;
import com.Lorrey.service.StudentService;
import com.Lorrey.service.TeacherService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * 基础前端接口
 */
@RestController
public class WebController {

    @Resource
    private AdminService adminService;
    @Resource
    private TeacherService teacherService;
    @Resource
    private StudentService studentService;
    @Resource
    private EnterpriseService enterpriseService;

    @GetMapping("/")
    public Result hello() {
        return Result.success("访问成功");
    }

    /**
     * 登录
     */
    @PostMapping("/login")
    public Result login(@RequestBody Account account) {
        if (ObjectUtil.isEmpty(account.getUsername()) || ObjectUtil.isEmpty(account.getPassword())
                || ObjectUtil.isEmpty(account.getRole())) {
            return Result.error(ResultCodeEnum.PARAM_LOST_ERROR);
        }
        if (RoleEnum.ADMIN.name().equals(account.getRole())) {
            account = adminService.login(account);
        }
        if (RoleEnum.TEACHER.name().equals(account.getRole())) {
            account = teacherService.login(account);
        }
        if (RoleEnum.STUDENT.name().equals(account.getRole())) {
            account = studentService.login(account);
        }
        if (RoleEnum.ENTERPRISE.name().equals(account.getRole())) {
            account = enterpriseService.login(account);
        }
        return Result.success(account);
    }

    /**
     * 注册
     */
    @PostMapping("/register")
    public Result register(@RequestBody Account account) {
        if (StrUtil.isBlank(account.getUsername()) || StrUtil.isBlank(account.getPassword())
                || ObjectUtil.isEmpty(account.getRole())) {
            return Result.error(ResultCodeEnum.PARAM_LOST_ERROR);
        }
        if (RoleEnum.ADMIN.name().equals(account.getRole())) {
            return Result.error(ResultCodeEnum.ADMIN_NOT_REGISTER);
        }
        if (RoleEnum.TEACHER.name().equals(account.getRole())) {
            teacherService.register(account);
        }
        if (RoleEnum.STUDENT.name().equals(account.getRole())) {
            studentService.register(account);
        }
        if (RoleEnum.ENTERPRISE.name().equals(account.getRole())) {
            enterpriseService.register(account);
        }
        return Result.success();
    }

    /**
     * 修改密码
     */
    @PutMapping("/updatePassword")
    public Result updatePassword(@RequestBody Account account) {
        if (StrUtil.isBlank(account.getUsername()) || StrUtil.isBlank(account.getPassword())
                || ObjectUtil.isEmpty(account.getNewPassword())) {
            return Result.error(ResultCodeEnum.PARAM_LOST_ERROR);
        }
        if (RoleEnum.ADMIN.name().equals(account.getRole())) {
            adminService.updatePassword(account);
        }
        if (RoleEnum.TEACHER.name().equals(account.getRole())) {
            teacherService.updatePassword(account);
        }
        if (RoleEnum.STUDENT.name().equals(account.getRole())) {
            studentService.updatePassword(account);
        }
        if (RoleEnum.ENTERPRISE.name().equals(account.getRole())) {
            enterpriseService.updatePassword(account);
        }
        return Result.success();
    }

}
