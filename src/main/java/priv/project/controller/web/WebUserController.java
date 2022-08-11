package priv.project.controller.web;

import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import priv.project.pojo.*;
import priv.project.service.UserService;
import priv.project.util.ServletUtils;

import javax.servlet.http.HttpSession;


/**
 * @Author Mr.Wang
 * @Date 2022/2/10
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 客户端用户表控制器
 */
@RestController
@RequestMapping("/web/member/user")
@AllArgsConstructor
public class WebUserController {

    private UserService userService;

    /**
     * 更新一条admin信息
     * @param editAdmin
     * @return
     */
    @PutMapping("/updateInfo")
    public ResultMessage updateInfo(@RequestBody EditAdmin editAdmin, HttpSession session) {
        try {
            // 取出保存的用户信息, 比对旧密码输入是否正确
            User loginUser = ServletUtils.getWebUserInfo(session);
            loginUser.setPassword(editAdmin.getPassword());
            // 进行查询
            User selectResult = userService.getInfoByLogin(loginUser);
            // 查询结果为null代表输入的密码不对
            if(selectResult == null) {
                return new ResultMessage(500, "输入的原密码不正确!");
            }
            // 正确则进行更改
            selectResult.setPassword(SecureUtil.md5(editAdmin.getNewPassword()));
            boolean result = userService.updateById(selectResult);
            if(result) {
                session.removeAttribute("webUser");
                return new ResultMessage(0, "操作成功! 请重新登录! ");
            } else {
                return new ResultMessage(500, "操作失败! ");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultMessage(500, "出现异常：" + e.getMessage());
        }
    }
}
