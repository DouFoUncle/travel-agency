package priv.project.controller.web;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import priv.project.pojo.ResultMessage;
import priv.project.pojo.ScenicSpot;
import priv.project.service.ScenicSpotService;

import java.util.Date;

/**
 * @Author 斗佛
 * @Date 2022/2/10
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 客户端景区表控制器
 */
@RequestMapping("/web/scenicSpot")
@RestController
@AllArgsConstructor
public class WebScenicSpotController {

    private ScenicSpotService scenicSpotService;

    /**
     * 获取分页数据
     * @return
     */
    @GetMapping("/getPageList")
    public ResultMessage getPageList(Integer page, Integer limit, ScenicSpot scenicSpot) {
        try {
            // 调用查询方法
            IPage<ScenicSpot> pageBean = scenicSpotService.getPageList(page, limit, scenicSpot);
            return new ResultMessage(0, "查询成功！", pageBean.getRecords(), pageBean.getTotal());
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultMessage(500, "查询失败！");
        }
    }
}
