package priv.project.service;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import priv.project.mapper.ScenicTypeMapper;
import priv.project.pojo.ScenicType;
import priv.project.pojo.ScenicType;
/**
 * @Author 斗佛
 * @Date 2022/2/9
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 景区分类表业务层
 */
@Service
@AllArgsConstructor
public class ScenicTypeService extends ServiceImpl<ScenicTypeMapper, ScenicType> {

    private ScenicTypeMapper scenicTypeMapper;

    /**
     * 根据ID删除信息
     * @param ids
     * @return
     */
    public boolean deleteInfo(String ids) {
        // 调用删除方法
        return scenicTypeMapper.deleteBatchIds(StrUtil.split(ids, ',', true, true)) > 0;
    }

    /**
     * 分页查询数据信息
     * @param page
     * @param limit
     * @param scenicType
     * @return
     */
    public IPage<ScenicType> getPageList(Integer page, Integer limit, ScenicType scenicType) {// 构建查询对象
        QueryWrapper<ScenicType> queryWrapper = new QueryWrapper<ScenicType>();
        queryWrapper.like(!StrUtil.isBlankOrUndefined(scenicType.getTypeName()), "type_name", scenicType.getTypeName());
        queryWrapper.orderByDesc("create_date");
        // 创建分页对象
        IPage<ScenicType> pageBean = new Page<ScenicType>(page, limit);
        // 调用查询方法
        return scenicTypeMapper.selectPage(pageBean, queryWrapper);
    }

    /**
     * 查询所有类型信息
     * @return
     */
    public List<ScenicType> getListData() {
        return scenicTypeMapper.selectList(null);
    }
}
