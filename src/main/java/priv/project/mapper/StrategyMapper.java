package priv.project.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import priv.project.pojo.Strategy;
import priv.project.pojo.Strategy;

import java.util.List;

/**
 * @Author 斗佛
 * @Date 2022/2/9
 * @description 文件描述
 */
public interface StrategyMapper extends BaseMapper<Strategy> {

    /**
     * 分页查询信息
     * @param start
     * @param end
     * @param strategy
     * @return
     */
    List<Strategy> getListByPage(@Param("start") Integer start,
                                @Param("end") Integer end,
                                @Param("strategy") Strategy strategy);

    /**
     * 查询数据总量
     * @param strategy
     * @return
     */
    long getDataCount(@Param("strategy") Strategy strategy);
}