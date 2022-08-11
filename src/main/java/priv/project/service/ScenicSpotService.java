package priv.project.service;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import priv.project.mapper.ScenicSpotMapper;
import priv.project.pojo.ScenicSpot;
/**
 * @Author 斗佛
 * @Date 2022/2/9
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 景区表业务层
 */
@Service
@AllArgsConstructor
public class ScenicSpotService extends ServiceImpl<ScenicSpotMapper, ScenicSpot> {

    private ScenicSpotMapper scenicSpotMapper;

    public boolean deleteInfo(String ids) {
        // 调用删除方法
        return scenicSpotMapper.deleteBatchIds(StrUtil.split(ids, ',', true, true)) > 0;
    }

    /**
     * 分页查询信息
     * @param page
     * @param limit
     * @param scenicSpot
     * @return
     */
    public IPage<ScenicSpot> getPageList(Integer page, Integer limit, ScenicSpot scenicSpot) {
        IPage<ScenicSpot> iPage = new Page<>();
        // 分页查询信息
        iPage.setRecords(scenicSpotMapper.getListByPage((page - 1) * limit, limit, scenicSpot));
        // 查询所有记录总数
        iPage.setTotal(scenicSpotMapper.getDataCount(scenicSpot));
        iPage.setPages(page);
        iPage.setSize(limit);
        return iPage;
    }

    /**
     * 查询首页推荐数据
     * @return
     */
    public List<ScenicSpot> getIndexDataList() {
        QueryWrapper<ScenicSpot> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("is_index", "1");
        queryWrapper.eq("is_red", "0");
        return scenicSpotMapper.selectList(queryWrapper);
    }

    /**
     * 查询首页推荐红色景区
     * @return
     */
    public List<ScenicSpot> getRedDataList() {
        QueryWrapper<ScenicSpot> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("is_index", "1");
        queryWrapper.eq("is_red", "1");
        return scenicSpotMapper.selectList(queryWrapper);
    }
}
