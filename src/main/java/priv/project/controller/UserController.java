package priv.project.controller;

import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.IdcardUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import priv.project.pojo.Admin;
import priv.project.pojo.ResultMessage;
import priv.project.pojo.Strategy;
import priv.project.pojo.User;
import priv.project.service.UserService;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * @Author 斗佛
 * @Date 2022/2/10
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 用户表控制器
 */
@RequestMapping("/user")
@RestController
@AllArgsConstructor
public class UserController {

    private UserService userService;

    /**
     * 获取分页数据
     * @return
     */
    @GetMapping("/getPageList")
    public ResultMessage getPageList(Integer page, Integer limit, User user) {
        try {
            // 调用查询方法
            IPage<User> userPage = userService.getPageList(page, limit, user);
            return new ResultMessage(0, "查询成功！", userPage.getRecords(), userPage.getTotal());
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultMessage(500, "查询失败！");
        }
    }

    /**
     * 新增或修改信息
     * @return
     */
    @PostMapping("/saveOrUpdate")
    public ResultMessage saveOrUpdate(@RequestBody User user) {
        try {
            // 查询用户名是否已存在
            // 存在则不可添加
            User selectUser = userService.getOne(new QueryWrapper<User>().eq("user_name", user.getUserName()));
            if(selectUser != null) {
                return new ResultMessage(207, "用户名已存在！");
            }
            // ID为空代表是新增, 设置创建时间
            if(user.getId() == null) {
                // 创建时间
                user.setCreateDate(new Date());
                // 加密密码
                user.setPassword(SecureUtil.md5(user.getPassword()));
            }
            // 如果身份证信息不为空, 则设置设置生日/年龄/性别
            if(!StrUtil.isBlankOrUndefined(user.getIdCard())) {
                user.setAge(IdcardUtil.getAgeByIdCard(user.getIdCard()));
                user.setSex(IdcardUtil.getGenderByIdCard(user.getIdCard()) + "");
                user.setBirthday(IdcardUtil.getBirthDate(user.getIdCard()));
            }
            // 调用查询方法
            boolean result = userService.saveOrUpdate(user);
            if(!result) {
                return new ResultMessage(207, "操作失败！");
            }
            return new ResultMessage(200, "操作成功！");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultMessage(500, "操作失败！");
        }
    }

}
