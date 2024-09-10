package com.Lorrey.service;

import com.Lorrey.entity.Job;
import com.Lorrey.entity.UserActions;
import com.Lorrey.mapper.JobMapper;
import com.Lorrey.mapper.UserActionsMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 用户行为业务处理
 **/
@Service
public class UserActionsService {

    @Resource
    private UserActionsMapper userActionsMapper;

    @Resource
    private JobMapper jobMapper;

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

    /**
     * 根据UserID查询
     */
    public List<UserActions> selectByUserId(Integer userId) {
        return userActionsMapper.selectByUserId(userId);
    }

    /**
     * 基于协同过滤的推荐算法
     */
    public List<Job> recommend(List<UserActions> userActions) {
        //根据该用户的所有行为列表 进行推荐算法计算 最后返回值为岗位列表
        // 1. 获取所有用户的行为数据
        List<UserActions> allUserActions = userActionsMapper.selectAll(new UserActions());
        //System.out.println("所有用户行为数据：" + allUserActions);

        // 2. 将用户行为数据按照userId进行分组
        Map<Integer, List<UserActions>> userActionsMap = allUserActions.stream()
                .collect(Collectors.groupingBy(UserActions::getUserId));

        // 3. 计算当前用户的行为与其他用户的相似度
        Integer currentUserId = userActions.get(0).getUserId();  // 当前用户ID
        List<UserActions> currentUserActions = userActionsMap.get(currentUserId);
        Map<Integer, Double> userSimilarityMap = new HashMap<>();

        for (Map.Entry<Integer, List<UserActions>> entry : userActionsMap.entrySet()) {
            Integer otherUserId = entry.getKey();
            if (!otherUserId.equals(currentUserId)) {
                List<UserActions> otherUserActions = entry.getValue();
                double similarity = calculateSimilarity(currentUserActions, otherUserActions);
                userSimilarityMap.put(otherUserId, similarity);
            }
        }

        //System.out.println("相似度：" + userSimilarityMap);

        // 4. 根据相似度排序，取最相似的用户
        List<Integer> similarUserIds = userSimilarityMap.entrySet().stream()
                .sorted(Map.Entry.<Integer, Double>comparingByValue().reversed())  // 按相似度降序排列
                .limit(5)  // 取前5个最相似用户
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());

        //System.out.println("相似用户：" + similarUserIds);

        // 5. 获取这些相似用户的岗位行为，并排除当前用户已访问的岗位
        Set<Integer> currentUserJobIds = currentUserActions.stream()
                .map(UserActions::getJobId)
                .collect(Collectors.toSet());

        List<Job> recommendedJobs = new ArrayList<>();
        for (Integer similarUserId : similarUserIds) {
            List<UserActions> similarUserActions = userActionsMap.get(similarUserId);
            //System.out.println("相似用户ID" + similarUserId + "相似用户行为：" + similarUserActions);
            for (UserActions action : similarUserActions) {
                //System.out.println("Job ID: " + action.getJobId());
                if (!currentUserJobIds.contains(action.getJobId())) {
                    // 将该用户未访问过的岗位添加到推荐列表
                    Job job = jobMapper.selectById(action.getJobId());
                    recommendedJobs.add(job);
                    //System.out.println("Recommended job added: " + job);
                } else {
                    //System.out.println("Job not found for ID: " + action.getJobId());
                }
            }
        }

        // 去重操作：使用 stream() 去重
        List<Job> uniqueRecommendedJobs = recommendedJobs.stream()
                .distinct()
                .collect(Collectors.toList());

        // 6. 返回推荐的岗位列表
        return uniqueRecommendedJobs;
    }

    /**
     * 计算两个用户行为之间的相似度（余弦相似度）
     */
    private double calculateSimilarity(List<UserActions> currentUserActions, List<UserActions> otherUserActions) {
        Set<Integer> currentJobIds = currentUserActions.stream()
                .map(UserActions::getJobId)
                .collect(Collectors.toSet());

        Set<Integer> otherJobIds = otherUserActions.stream()
                .map(UserActions::getJobId)
                .collect(Collectors.toSet());

        // 计算交集大小
        Set<Integer> intersection = new HashSet<>(currentJobIds);
        intersection.retainAll(otherJobIds);

        // 计算余弦相似度：相似度 = 交集数量 / (用户1行为数量 * 用户2行为数量)的平方根
        double similarity = intersection.size() /
                (Math.sqrt(currentJobIds.size()) * Math.sqrt(otherJobIds.size()));

        return similarity;
    }
}
