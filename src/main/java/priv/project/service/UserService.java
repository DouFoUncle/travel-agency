package priv.project.service;

import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import priv.project.mapper.UserMapper;
import priv.project.pojo.Admin;
import priv.project.pojo.User;
/**
 * @Author 斗佛
 * @Date 2022/2/9
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 用户表业务层
 */
@Service
@AllArgsConstructor
public class UserService extends ServiceImpl<UserMapper, User> {

    private UserMapper userMapper;

    /**
     * 分页查询数据
     * @param page
     * @param limit
     * @param user
     * @return
     */
    public IPage<User> getPageList(Integer page, Integer limit, User user) {
        // 构建查询对象
        QueryWrapper<User> queryWrapper = new QueryWrapper<User>();
        queryWrapper.like(!StrUtil.isBlankOrUndefined(user.getLoginName()), "login_name", user.getLoginName());
        queryWrapper.eq(!StrUtil.isBlankOrUndefined(user.getSex()), "sex", user.getSex());
        queryWrapper.orderByDesc("create_date");
        // 创建分页对象
        IPage<User> userIPage = new Page<User>(page, limit);
        // 调用查询方法
        return userMapper.selectPage(userIPage, queryWrapper);
    }

    /**
     * 验证登录
     * @param user
     * @return
     */
    public User getInfoByLogin(User user) {
        // 加密密码
        String newPwd = SecureUtil.md5(user.getPassword());
        // 构建查询条件
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("password", newPwd);
        queryWrapper.eq("user_name", user.getUserName());
        // 调用查询方法
        return userMapper.selectOne(queryWrapper);
    }
}
