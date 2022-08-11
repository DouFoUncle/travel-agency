package priv.project.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import priv.project.mapper.CollectMapper;
import priv.project.mapper.StrategyMapper;
import priv.project.pojo.Collect;
import priv.project.pojo.Strategy;
import priv.project.pojo.Collect;

/**
 * @Author 斗佛
 * @Date 2022/2/9
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 收藏表业务层
 */
@Service
@AllArgsConstructor
public class CollectService extends ServiceImpl<CollectMapper, Collect> {

    private CollectMapper collectMapper;

    private StrategyMapper strategyMapper;

    /**
     * 收藏或删除
     * @param collect
     * @return
     */
    public boolean saveOrDelete(Collect collect) {
        // 查询这条攻略是否已保存
        QueryWrapper<Collect> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", collect.getUserId());
        queryWrapper.eq("strategy_id", collect.getStrategyId());
        Collect selectCollect = collectMapper.selectOne(queryWrapper);
        // 如果查询结果不等于空, 就是要取消收藏, 直接删除这条记录
        if(selectCollect != null) {
            return collectMapper.deleteById(selectCollect.getId()) > 0;
        } else {
            // 如果为空 就是保存, 设置收藏时间调用保存方法
            collect.setCreateDate(new Date());
            return collectMapper.insert(collect) > 0;
        }
    }

    public boolean deleteInfo(String ids) {
        return false;
    }

    public IPage<Collect> getPageList(Integer page, Integer limit, Collect collect) {
        // 查询记录信息
        QueryWrapper<Collect> visitQueryWrapper = new QueryWrapper<Collect>();
        visitQueryWrapper.eq(collect.getUserId() != null, "user_id", collect.getUserId());
        visitQueryWrapper.orderByDesc("create_date");
        // 创建分页对象
        IPage<Collect> iPage = new Page<>(page, limit);
        iPage = collectMapper.selectPage(iPage, visitQueryWrapper);
        // 判读查询结果是否为空
        if(iPage.getRecords() != null && iPage.getRecords().size() > 0) {
            List<Collect> records = iPage.getRecords();
            // 循环查询每条记录中的攻略详情信息
            for (Collect record : records) {
                Strategy strategy = strategyMapper.selectOne(new QueryWrapper<Strategy>().eq("id", record.getStrategyId()));
                // 将查询结果保存进记录中
                record.setStrategy(strategy);
            }
            // 将集合重新保存
            iPage.setRecords(records);
        }
        return iPage;
    }
}
