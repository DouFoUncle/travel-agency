package priv.project.service;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import priv.project.mapper.AreaMapper;
import priv.project.pojo.Area;

import java.util.List;

/**
 * @Author 斗佛
 * @Date 2022/2/9
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 区划表业务层
 */
@Service
@AllArgsConstructor
public class AreaService extends ServiceImpl<AreaMapper, Area> {

    private AreaMapper areaMapper;

    /**
     * 删除单条或多条
     * @param ids
     * @return
     */
    public boolean deleteInfo(String ids) {
        List<String> idList = StrUtil.split(ids, ',', true, true);
        // 删除数据
        areaMapper.deleteBatchIds(idList);
        areaMapper.delete(new QueryWrapper<Area>().in("province_id", idList));
        return true;
    }

    /**
     * 分页查询数据
     * @param page
     * @param limit
     * @param area
     * @return
     */
    public IPage<Area> getPageList(Integer page, Integer limit, Area area) {
        // 构建查询对象
        QueryWrapper<Area> queryWrapper = new QueryWrapper<Area>();
        queryWrapper.like(!StrUtil.isBlankOrUndefined(area.getAreaName()), "area_name", area.getAreaName());
        queryWrapper.orderByDesc("is_parent", "create_date").orderByAsc("province_id");
        // 创建分页对象
        IPage<Area> pageBean = new Page<Area>(page, limit);
        // 调用查询方法
        pageBean = areaMapper.selectPage(pageBean, queryWrapper);
        if(pageBean.getRecords() != null && pageBean.getRecords().size() > 0) {
            // 查询所有省份
            List<Area> provinceData = getProvinceData();
            // 循环比对, 将省份信息加入 数据中
            for (Area provinceDatum : provinceData) {
                for (Area record : pageBean.getRecords()) {
                    if("0".equals(record.getIsParent())) {
                        if(record.getProvinceId().equals(provinceDatum.getId())) {
                            record.setProvinceName(provinceDatum.getAreaName());
                        }
                    }
                }
            }
        }
        // 调用查询方法
        return pageBean;
    }

    /**
     * 查询所有省份信息
     * @return
     */
    public List<Area> getProvinceData() {
        // 创建查询条件,只查询省份信息
        QueryWrapper<Area> queryWrapper = new QueryWrapper<Area>();
        queryWrapper.eq("is_parent", "1");
        return areaMapper.selectList(queryWrapper);
    }

    /**
     * 查询所有城市信息
     * @return
     */
    public List<Area> getCityList() {
        // 创建查询条件,只查询城市信息
        QueryWrapper<Area> queryWrapper = new QueryWrapper<Area>();
        queryWrapper.eq("is_parent", "0");
        return areaMapper.selectList(queryWrapper);
    }
}
