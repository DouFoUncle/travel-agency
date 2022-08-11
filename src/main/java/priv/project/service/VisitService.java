package priv.project.service;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import priv.project.mapper.StrategyMapper;
import priv.project.mapper.VisitMapper;
import priv.project.pojo.Comment;
import priv.project.pojo.Strategy;
import priv.project.pojo.Visit;
/**
 * @Author 斗佛
 * @Date 2022/2/9
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 浏览记录表业务层
 */
@Service
@AllArgsConstructor
public class VisitService extends ServiceImpl<VisitMapper, Visit> {

    private VisitMapper visitMapper;

    private StrategyMapper strategyMapper;

    /**
     * 分页查询信息
     * @param page
     * @param limit
     * @param visit
     * @return
     */
    public IPage<Visit> getPageList(Integer page, Integer limit, Visit visit) {
        // 查询记录信息
        QueryWrapper<Visit> visitQueryWrapper = new QueryWrapper<Visit>();
        visitQueryWrapper.eq(visit.getUserId() != null, "user_id", visit.getUserId());
        visitQueryWrapper.orderByDesc("create_date");
        // 创建分页对象
        IPage<Visit> iPage = new Page<>(page, limit);
        iPage = visitMapper.selectPage(iPage, visitQueryWrapper);
        // 判读查询结果是否为空
        if(iPage.getRecords() != null && iPage.getRecords().size() > 0) {
            List<Visit> records = iPage.getRecords();
            // 循环查询每条记录中的攻略详情信息
            for (Visit record : records) {
                Strategy strategy = strategyMapper.selectOne(new QueryWrapper<Strategy>().eq("id", record.getStrategyId()));
                // 将查询结果保存进记录中
                record.setStrategy(strategy);
            }
            // 将集合重新保存
            iPage.setRecords(records);
        }
        return iPage;
    }

    /**
     * 删除信息
     * @param ids
     * @return
     */
    public boolean deleteInfo(String ids) {
        // 直接调用删除方法
        return visitMapper.deleteBatchIds(StrUtil.split(ids, ',', true, true)) > 0;
    }
}
