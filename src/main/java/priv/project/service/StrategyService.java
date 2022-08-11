package priv.project.service;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import priv.project.mapper.*;
import priv.project.pojo.*;

/**
 * @Author 斗佛
 * @Date 2022/2/9
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 攻略表业务层
 */
@Service
@AllArgsConstructor
public class StrategyService extends ServiceImpl<StrategyMapper, Strategy> {

    private StrategyMapper strategyMapper;

    private CommentMapper commentMapper;

    private AdminMapper adminMapper;

    private UserMapper userMapper;

    private NoticeMapper noticeMapper;

    private CollectMapper collectMapper;

    /**
     * 分页查询信息
     * @param page
     * @param limit
     * @param strategy
     * @return
     */
    public IPage<Strategy> getPageList(Integer page, Integer limit, Strategy strategy) {
        QueryWrapper<Strategy> queryWrapper = new QueryWrapper<>();
        queryWrapper.like(!StrUtil.isBlankOrUndefined(strategy.getTitle()), "title", strategy.getTitle());
        queryWrapper.eq(!StrUtil.isBlankOrUndefined(strategy.getUserType()), "user_type", strategy.getUserType());
        queryWrapper.eq(strategy.getUserId() != null, "user_id", strategy.getUserId());
        IPage<Strategy> iPage = new Page<>(page, limit);
        // 分页查询信息
        iPage = strategyMapper.selectPage(iPage, queryWrapper);
        // 拿到查询结果, 继续关联查询用户信息
        if(iPage.getRecords() != null && iPage.getRecords().size() > 0) {
            List<Strategy> records = iPage.getRecords();
            records.forEach(item -> {
                // 判断发布类型, 如果1 代表管理员发布的, 查询管理员表信息 0代表用户发的, 查询用户表
                if("1".equals(item.getUserType())) {
                    QueryWrapper<Admin> adminQuery = new QueryWrapper<>();
                    adminQuery.eq("id", item.getUserId());
                    Admin admin = adminMapper.selectOne(adminQuery);
                    // 将admin转换为用户对象
                    User user = new User();
                    user.setLoginName(admin.getLoginName());
                    item.setUser(user);
                } else if("0".equals(item.getUserType())) {
                    QueryWrapper<User> userQuery = new QueryWrapper<>();
                    userQuery.eq("id", item.getUserId());
                    User user = userMapper.selectOne(userQuery);
                    item.setUser(user);
                }
            });
            iPage.setRecords(records);
        }
        return iPage;
    }

    /**
     * 删除信息
     * @param ids
     * @return
     */
    public boolean deleteInfo(String ids) {
        // 封装删除攻略的条件
        QueryWrapper<Strategy> queryWrapper = new QueryWrapper<>();
        queryWrapper.in("id", StrUtil.split(ids, ',', true, true));
        // 封装删除攻略评论的条件
        QueryWrapper<Comment> commentQueryWrapper = new QueryWrapper<>();
        commentQueryWrapper.in("strategy_id", StrUtil.split(ids, ',', true, true));
        // 封装删除收藏记录的条件
        QueryWrapper<Collect> collectQueryWrapper = new QueryWrapper<>();
        collectQueryWrapper.in("strategy_id", StrUtil.split(ids, ',', true, true));
        // 封装删除消息通知记录的条件
        QueryWrapper<Notice> noticeQueryWrapper = new QueryWrapper<>();
        noticeQueryWrapper.in("strategy_id", StrUtil.split(ids, ',', true, true));
        // 调用删除攻略的方法/删除攻略评价的方法/删除消息通知的方法/删除收藏记录的方法
        commentMapper.delete(commentQueryWrapper);
        collectMapper.delete(collectQueryWrapper);
        noticeMapper.delete(noticeQueryWrapper);
        return strategyMapper.delete(queryWrapper) > 0;
    }

    /**
     * 根据攻略ID查询攻略详情
     * @param id
     * @return
     */
    public Strategy getInfoById(Integer id) {
        // 根据ID查询单条信息
        Strategy strategy = this.getOne(new QueryWrapper<Strategy>().eq("id", id));
        // 判断发布类型, 如果1 代表管理员发布的, 查询管理员表信息 0代表用户发的, 查询用户表
        if("1".equals(strategy.getUserType())) {
            QueryWrapper<Admin> adminQuery = new QueryWrapper<>();
            adminQuery.eq("id", strategy.getUserId());
            Admin admin = adminMapper.selectOne(adminQuery);
            // 将admin转换为用户对象
            User user = new User();
            user.setLoginName(admin.getLoginName());
            strategy.setUser(user);
        } else if("0".equals(strategy.getUserType())) {
            QueryWrapper<User> userQuery = new QueryWrapper<>();
            userQuery.eq("id", strategy.getUserId());
            User user = userMapper.selectOne(userQuery);
            strategy.setUser(user);
        }
        // 返回最终数据
        return strategy;
    }
}
