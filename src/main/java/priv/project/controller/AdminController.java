package priv.project.controller;

import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import priv.project.pojo.EditAdmin;
import priv.project.pojo.ResultMessage;
import priv.project.pojo.Admin;
import priv.project.service.AdminService;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * @Author 斗佛
 * @Date 2022/2/10
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 管理员表控制器
 */
@RequestMapping("/admin")
@RestController
@AllArgsConstructor
public class AdminController {

    private AdminService adminService;

    /**
     * 获取分页数据
     * @return
     */
    @GetMapping("/getPageList")
    public ResultMessage getPageList(Integer page, Integer limit, Admin admin) {
        try {
            // 调用查询方法
            IPage<Admin> pageBean = adminService.getPageList(page, limit, admin);
            return new ResultMessage(0, "查询成功！", pageBean.getRecords(), pageBean.getTotal());
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultMessage(500, "查询失败！");
        }
    }

    /**
     * 新增信息
     * @return
     */
    @PostMapping("/insertInfo")
    public ResultMessage insertInfo(@RequestBody Admin admin) {
        try {
            // 加密密码
            admin.setCreateDate(new Date());
            admin.setPassword(SecureUtil.md5(admin.getPassword()));
            // 调用查询方法
            boolean result = adminService.save(admin);
            if(!result) {
                return new ResultMessage(207, "操作失败！");
            }
            return new ResultMessage(200, "操作成功！");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultMessage(500, "操作失败！");
        }
    }

    /**
     * 删除一条或多条数据
     * @return
     */
    @GetMapping("/deleteInfo")
    public ResultMessage deleteInfo(String ids) {
        try {
            // 调用查询方法
            boolean result = adminService.deleteInfo(ids);
            if(!result) {
                return new ResultMessage(207, "操作失败！");
            }
            return new ResultMessage(200, "操作成功！");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultMessage(500, "操作失败！");
        }
    }

    /**
     * 更新一条admin信息
     * @param editAdmin
     * @return
     */
    @PutMapping("/updateInfo")
    public ResultMessage updateInfo(@RequestBody EditAdmin editAdmin, HttpSession session) {
        try {
            // 取出保存的用户信息, 比对旧密码输入是否正确
            Admin loginAdmin = (Admin) session.getAttribute("adminUser");
            loginAdmin.setPassword(editAdmin.getPassword());
            // 进行查询
            Admin selectResult = adminService.getInfoByLogin(loginAdmin);
            // 查询结果为null代表输入的密码不对
            if(selectResult == null) {
                return new ResultMessage(500, "输入的原密码不正确!");
            }
            // 正确则进行更改
            selectResult.setPassword(SecureUtil.md5(editAdmin.getNewPassword()));
            int result = adminService.updateInfo(selectResult);
            if(result > 0) {
                session.removeAttribute("adminUser");
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
