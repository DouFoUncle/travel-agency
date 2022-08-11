package priv.project.controller.web;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import priv.project.pojo.Collect;
import priv.project.pojo.Comment;
import priv.project.pojo.ResultMessage;
import priv.project.pojo.Comment;
import priv.project.service.CollectService;
import priv.project.service.CommentService;
import priv.project.util.ServletUtils;

import javax.servlet.http.HttpSession;
import java.util.Date;


/**
 * @Author Mr.Wang
 * @Date 2022/2/10
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 客户端评价相关控制器
 */
@RestController
@RequestMapping("/web/member/comment")
@AllArgsConstructor
public class WebCommentController {

    private CommentService commentService;

    /**
     * 获取分页数据
     * @return
     */
    @GetMapping("/getPageList")
    public ResultMessage getPageList(Integer page, Integer limit, Comment comment, HttpSession session) {
        try {
            comment.setUserId(ServletUtils.getWebUserIdInfo(session));
            // 调用查询方法
            IPage<Comment> pageBean = commentService.getPageList(page, limit, comment);
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
            boolean result = commentService.deleteInfo(ids);
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
     * 新增信息
     * @return
     */
    @PostMapping("/saveInfo")
    public ResultMessage saveInfo(@RequestBody Comment comment) {
        try {
            // 保存评价时间
            comment.setCreateDate(new Date());
            // 调用查询方法
            boolean result = commentService.insertInfo(comment);
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
