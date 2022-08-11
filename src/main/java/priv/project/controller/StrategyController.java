package priv.project.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import priv.project.pojo.Admin;
import priv.project.pojo.Strategy;
import priv.project.pojo.ResultMessage;
import priv.project.service.StrategyService;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * @Author 斗佛
 * @Date 2022/2/10
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 评论表控制器
 */
@RequestMapping("/strategy")
@RestController
@AllArgsConstructor
public class StrategyController {

    private StrategyService strategyService;

    /**
     * 获取分页数据
     * @return
     */
    @GetMapping("/getPageList")
    public ResultMessage getPageList(Integer page, Integer limit, Strategy strategy) {
        try {
            // 调用查询方法
            IPage<Strategy> pageBean = strategyService.getPageList(page, limit, strategy);
            return new ResultMessage(0, "查询成功！", pageBean.getRecords(), pageBean.getTotal());
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
    public ResultMessage saveOrUpdate(@RequestBody Strategy strategy, HttpSession session) {
        try {
            // ID为空代表是新增, 设置创建时间
            if(strategy.getId() == null) {
                // 创建时间
                strategy.setCreateDate(new Date());
                // 保存用户ID
                Admin adminUser = (Admin) session.getAttribute("adminUser");
                strategy.setUserId(adminUser.getId());
                strategy.setUserType("1");
            }
            // 调用查询方法
            boolean result = strategyService.saveOrUpdate(strategy);
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
            boolean result = strategyService.deleteInfo(ids);
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
