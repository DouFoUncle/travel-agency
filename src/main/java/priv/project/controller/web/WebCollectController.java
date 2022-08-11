package priv.project.controller.web;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import priv.project.pojo.*;
import priv.project.service.*;
import priv.project.util.ServletUtils;
import javax.servlet.http.HttpSession;


/**
 * @Author Mr.Wang
 * @Date 2022/2/10
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 客户端收藏相关控制器
 */
@RestController
@RequestMapping("/web/member/collect")
@AllArgsConstructor
public class WebCollectController {

    private CollectService collectService;
    /**
     * 获取分页数据
     * @return
     */
    @GetMapping("/getPageList")
    public ResultMessage getPageList(Integer page, Integer limit, Collect collect, HttpSession session) {
        try {
            collect.setUserId(ServletUtils.getWebUserIdInfo(session));
            // 调用查询方法
            IPage<Collect> pageBean = collectService.getPageList(page, limit, collect);
            return new ResultMessage(0, "查询成功！", pageBean.getRecords(), pageBean.getTotal());
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultMessage(500, "查询失败！");
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
            boolean result = collectService.deleteInfo(ids);
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
     * 新增或删除信息
     * @return
     */
    @PostMapping("/saveOrDelete")
    public ResultMessage saveOrDelete(@RequestBody Collect collect) {
        try {
            // 调用查询方法
            boolean result = collectService.saveOrDelete(collect);
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
