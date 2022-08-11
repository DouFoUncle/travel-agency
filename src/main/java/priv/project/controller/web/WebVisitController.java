package priv.project.controller.web;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import priv.project.pojo.Collect;
import priv.project.pojo.Comment;
import priv.project.pojo.ResultMessage;
import priv.project.pojo.Visit;
import priv.project.service.VisitService;
import priv.project.util.ServletUtils;

import javax.servlet.http.HttpSession;


/**
 * @Author Mr.Wang
 * @Date 2022/2/10
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 客户端浏览记录控制器
 */
@RestController
@RequestMapping("/web/member/visit")
@AllArgsConstructor
public class WebVisitController {

    private VisitService visitService;
    
    /**
     * 获取分页数据
     * @return
     */
    @GetMapping("/getPageList")
    public ResultMessage getPageList(Integer page, Integer limit, Visit visit, HttpSession session) {
        try {
            visit.setUserId(ServletUtils.getWebUserIdInfo(session));
            // 调用查询方法
            IPage<Visit> pageBean = visitService.getPageList(page, limit, visit);
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
            boolean result = visitService.deleteInfo(ids);
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
