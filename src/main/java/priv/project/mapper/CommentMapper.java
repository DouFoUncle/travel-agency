package priv.project.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import priv.project.pojo.Comment;

import java.util.List;

/**
 * @Author 斗佛
 * @Date 2022/2/9
 * @description 文件描述
 */
public interface CommentMapper extends BaseMapper<Comment> {

    /**
     * 分页查询信息
     * @param start
     * @param end
     * @param comment
     * @return
     */
    List<Comment> getListByPage(@Param("start") Integer start,
                                @Param("end") Integer end,
                                @Param("comment") Comment comment);

    /**
     * 查询数据总量
     * @param comment
     * @return
     */
    long getDataCount(@Param("comment") Comment comment);

    /**
     * 根据评价ID查询评价下的回复信息
     * @param id
     * @return
     */
    List<Comment> getListByCommentId(Integer id);
}