package com.Lorrey.service;

import cn.hutool.core.util.ObjectUtil;
import com.Lorrey.common.Constants;
import com.Lorrey.common.enums.ResultCodeEnum;
import com.Lorrey.common.enums.RoleEnum;
import com.Lorrey.entity.Account;
import com.Lorrey.entity.Admin;
import com.Lorrey.entity.Enterprise;
import com.Lorrey.exception.CustomException;
import com.Lorrey.mapper.EnterpriseMapper;
import com.Lorrey.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 企业业务处理
 **/
@Service
public class EnterpriseService {

    @Resource
    private EnterpriseMapper enterpriseMapper;

    /**
     * 新增
     */
    public void add(Enterprise enterprise) {
        Enterprise dbEnterprise = enterpriseMapper.selectByUsername(enterprise.getUsername());
        if (ObjectUtil.isNotNull(dbEnterprise)) {
            throw new CustomException(ResultCodeEnum.USER_EXIST_ERROR);
        }
        if (ObjectUtil.isEmpty(enterprise.getPassword())) {
            enterprise.setPassword(Constants.USER_DEFAULT_PASSWORD);
        }
        if (ObjectUtil.isEmpty(enterprise.getName())) {
            enterprise.setName(enterprise.getUsername());
        }
        enterprise.setRole(RoleEnum.ENTERPRISE.name());
        enterpriseMapper.insert(enterprise);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        enterpriseMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            enterpriseMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Enterprise enterprise) {
        enterpriseMapper.updateById(enterprise);
    }

    /**
     * 根据ID查询
     */
    public Enterprise selectById(Integer id) {
        return enterpriseMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Enterprise> selectAll(Enterprise enterprise) {
        return enterpriseMapper.selectAll(enterprise);
    }

    /**
     * 分页查询
     */
    public PageInfo<Enterprise> selectPage(Enterprise enterprise, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Enterprise> list = enterpriseMapper.selectAll(enterprise);
        return PageInfo.of(list);
    }

    /**
     * 登录
     */
    public Account login(Account account) {
        Account dbEnterprise = enterpriseMapper.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbEnterprise)) {
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR);
        }
        if (!account.getPassword().equals(dbEnterprise.getPassword())) {
            throw new CustomException(ResultCodeEnum.USER_ACCOUNT_ERROR);
        }
        // 生成token
        String tokenData = dbEnterprise.getId() + "-" + RoleEnum.ENTERPRISE.name();
        String token = TokenUtils.createToken(tokenData, dbEnterprise.getPassword());
        dbEnterprise.setToken(token);
        return dbEnterprise;
    }

    /**
     * 注册
     */
    public void register(Account account) {
        Enterprise enterprise = new Enterprise();
        BeanUtils.copyProperties(account, enterprise);
        add(enterprise);
    }

    /**
     * 修改密码
     */
    public void updatePassword(Account account) {
        Enterprise dbEnterprise = enterpriseMapper.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbEnterprise)) {
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR);
        }
        if (!account.getPassword().equals(dbEnterprise.getPassword())) {
            throw new CustomException(ResultCodeEnum.PARAM_PASSWORD_ERROR);
        }
        dbEnterprise.setPassword(account.getNewPassword());
        enterpriseMapper.updateById(dbEnterprise);
    }
}

