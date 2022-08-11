package priv.project.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import priv.project.pojo.ScenicType;
import priv.project.pojo.ResultMessage;
import priv.project.service.ScenicTypeService;

import java.util.Date;

/**
 * @Author 斗佛
 * @Date 2022/2/10
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 景区类型表控制器
 */
@RequestMapping("/scenicType")
@RestController
@AllArgsConstructor
public class ScenicTypeController {

    private ScenicTypeService scenicTypeService;

    /**
     * 获取分页数据
     * @return
     */
    @GetMapping("/getPageList")
    public ResultMessage getPageList(Integer page, Integer limit, ScenicType scenicType) {
        try {
            // 调用查询方法
            IPage<ScenicType> pageBean = scenicTypeService.getPageList(page, limit, scenicType);
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
    public ResultMessage saveOrUpdate(@RequestBody ScenicType scenicType) {
        try {
            // ID为空代表是新增, 设置创建时间
            if(scenicType.getId() == null) {
                // 创建时间
                scenicType.setCreateDate(new Date());
            }
            // 调用查询方法
            boolean result = scenicTypeService.saveOrUpdate(scenicType);
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
            boolean result = scenicTypeService.deleteInfo(ids);
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
