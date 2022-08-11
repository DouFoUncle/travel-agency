package priv.project.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import priv.project.mapper.CollectMapper;
import priv.project.mapper.StrategyMapper;
import priv.project.pojo.Notice;
import priv.project.pojo.Notice;
import priv.project.mapper.NoticeMapper;
import priv.project.pojo.Strategy;

/**
 * @Author 斗佛
 * @Date 2022/3/4
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 消息通知表业务层
 */
@Service
@AllArgsConstructor
public class NoticeService extends ServiceImpl<NoticeMapper, Notice> {
    
    private NoticeMapper noticeMapper;

    private StrategyMapper strategyMapper;

    /**
     * 查询消息通知
     * @param notice
     * @return
     */
    public List<Notice> getListData(Notice notice) {
        // 查询记录信息
        QueryWrapper<Notice> visitQueryWrapper = new QueryWrapper<Notice>();
        visitQueryWrapper.eq(notice.getUserId() != null, "user_id", notice.getUserId());
        visitQueryWrapper.orderByDesc("create_date");
        List<Notice> notices = noticeMapper.selectList(visitQueryWrapper);
        // 判读查询结果是否为空
        if(notices != null && notices.size() > 0) {
            // 循环查询每条记录中的攻略详情信息
            for (Notice record : notices) {
                Strategy strategy = strategyMapper.selectOne(new QueryWrapper<Strategy>().eq("id", record.getStrategyId()));
                // 将查询结果保存进记录中
                record.setStrategy(strategy);
            }
        }
        return notices;
    }
}
