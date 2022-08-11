package priv.project.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import priv.project.pojo.ScenicSpot;

import java.util.List;

/**
 * @Author 斗佛
 * @Date 2022/2/9
 * @description 文件描述
 */
public interface ScenicSpotMapper extends BaseMapper<ScenicSpot> {

    List<ScenicSpot> getListByPage(@Param("start") Integer start,
                                   @Param("end") Integer end,
                                   @Param("scenicSpot") ScenicSpot scenicSpot);

    long getDataCount(@Param("scenicSpot") ScenicSpot scenicSpot);
}