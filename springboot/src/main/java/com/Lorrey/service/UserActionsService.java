package com.Lorrey.service;

import com.Lorrey.entity.UserActions;
import com.Lorrey.mapper.UserActionsMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 用户行为业务处理
 **/
@Service
public class UserActionsService {

    @Resource
    private UserActionsMapper userActionsMapper;

    /**
     * 新增
     */
    public void add(UserActions userActions) {
       userActions.setLocalDateTime(LocalDateTime.now());
        userActionsMapper.insert(userActions);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        userActionsMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            userActionsMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(UserActions userActions) {
        userActionsMapper.updateById(userActions);
    }

    /**
     * 根据ID查询
     */
    public UserActions selectById(Integer id) {
        return userActionsMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<UserActions> selectAll(UserActions userActions) {
        return userActionsMapper.selectAll(userActions);
    }

    /**
     * 分页查询
     */
    public PageInfo<UserActions> selectPage(UserActions userActions, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<UserActions> list = userActionsMapper.selectAll(userActions);
        return PageInfo.of(list);
    }

}
