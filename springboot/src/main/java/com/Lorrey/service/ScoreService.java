package com.Lorrey.service;

import com.Lorrey.common.enums.RoleEnum;
import com.Lorrey.entity.Account;
import com.Lorrey.entity.Score;
import com.Lorrey.mapper.ScoreMapper;
import com.Lorrey.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 成绩业务处理
 **/
@Service
public class ScoreService {

    @Resource
    private ScoreMapper scoreMapper;

    /**
     * 新增
     */
    public void add(Score score) {
        // 计算一下总成绩
        double total = score.getEnterpriseScore() * 0.3 + score.getTeacherScore() * 0.7;
        score.setScore(total);
        scoreMapper.insert(score);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        Score score = scoreMapper.selectById(id);
        scoreMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            scoreMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Score score) {
        scoreMapper.updateById(score);
    }

    /**
     * 根据ID查询
     */
    public Score selectById(Integer id) {
        return scoreMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Score> selectAll(Score score) {
        return scoreMapper.selectAll(score);
    }

    /**
     * 分页查询
     */
    public PageInfo<Score> selectPage(Score score, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.TEACHER.name().equals(currentUser.getRole())) {
            score.setTeacherId(currentUser.getId());
        }
        if (RoleEnum.STUDENT.name().equals(currentUser.getRole())) {
            score.setStudentId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Score> list = scoreMapper.selectAll(score);
        return PageInfo.of(list);
    }

}
