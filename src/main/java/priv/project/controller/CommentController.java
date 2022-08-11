package priv.project.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import priv.project.pojo.ResultMessage;
import priv.project.pojo.Comment;
import priv.project.service.CommentService;

import java.util.Date;

/**
 * @Author 斗佛
 * @Date 2022/2/10
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 评论表控制器
 */
@RequestMapping("/comment")
@RestController
@AllArgsConstructor
public class CommentController {

    private CommentService commentService;

    /**
     * 获取分页数据
     * @return
     */
    @GetMapping("/getPageList")
    public ResultMessage getPageList(Integer page, Integer limit, Comment comment) {
        try {
            // 调用查询方法
            IPage<Comment> pageBean = commentService.getPageList(page, limit, comment);
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
    public ResultMessage saveOrUpdate(@RequestBody Comment comment) {
        try {
            // ID为空代表是新增, 设置创建时间
            if(comment.getId() == null) {
                // 创建时间
                comment.setCreateDate(new Date());
            }
            // 调用查询方法
            boolean result = commentService.saveOrUpdate(comment);
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
}
