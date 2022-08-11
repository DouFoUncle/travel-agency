package priv.project.service;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import priv.project.mapper.CommentMapper;
import priv.project.mapper.NoticeMapper;
import priv.project.mapper.UserMapper;
import priv.project.pojo.Comment;
import priv.project.pojo.Notice;
import priv.project.pojo.ScenicSpot;
import priv.project.pojo.User;

/**
 * @Author 斗佛
 * @Date 2022/2/9
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 评价表业务层
 */
@Service
@AllArgsConstructor
public class CommentService extends ServiceImpl<CommentMapper, Comment> {

    private CommentMapper commentMapper;

    private UserMapper userMapper;

    private NoticeMapper noticeMapper;

    /**
     * 删除信息
     * @param ids
     * @return
     */
    public boolean deleteInfo(String ids) {
        // 将id转为lsit
        List<String> idsList = StrUtil.split(ids, ',', true, true);
        // 删除所有相关评论和回复
        QueryWrapper<Comment> queryWrapper = new QueryWrapper<>();
        queryWrapper.in("id", idsList).or().in("comment_id", idsList);
        return commentMapper.delete(queryWrapper) > 0;
    }

    /**
     * 分页查询信息
     * @param page
     * @param limit
     * @param comment
     * @return
     */
    public IPage<Comment> getPageList(Integer page, Integer limit, Comment comment) {
        IPage<Comment> iPage = new Page<>();
        // 分页查询信息
        iPage.setRecords(commentMapper.getListByPage((page - 1) * limit, limit, comment));
        // 查询所有记录总数
        iPage.setTotal(commentMapper.getDataCount(comment));
        iPage.setPages(page);
        iPage.setSize(limit);
        return iPage;
    }

    /**
     * 根据攻略ID查询该攻略下的评价
     * @param strategyId
     * @return
     */
    public List<Comment> getListInfoByStrategyId(Integer strategyId) {
        QueryWrapper<Comment> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("strategy_id", strategyId);
        queryWrapper.isNull("comment_id");
        queryWrapper.orderByDesc("create_date");
        List<Comment> commentList = commentMapper.selectList(queryWrapper);
        // 循环继续查询评价下的回复信息
        if(commentList != null && commentList.size() > 0) {
            for (Comment comment : commentList) {
                comment.setCreateDateFormat(DateUtil.formatDateTime(comment.getCreateDate()));
                // 循环查询
                List<Comment> subComments = commentMapper.getListByCommentId(comment.getId());
                for (Comment subComment : subComments) {
                    subComment.setCreateDateFormat(DateUtil.formatDateTime(subComment.getCreateDate()));
                }
                // 将查询结果存入
                comment.setSubComments(subComments);
                // 继续查询用户信息
                QueryWrapper<User> userQueryWrapper = new QueryWrapper<User>();
                userQueryWrapper.eq("id", comment.getUserId());
                comment.setUser(userMapper.selectOne(userQueryWrapper));
            }
        }
        return commentList;
    }

    /**
     * 保存评价
     * @param comment
     * @return
     */
    public boolean insertInfo(Comment comment) {
        // 首先查看是否有 comment_id
        if(comment.getCommentId() == null) {
            // 没有评价ID直接调用保存方法
            return this.save(comment);
        } else {
            // 有评价ID, 代表这条评价是回复别人的评价, 需要给楼主添加一条消息提示记录
            // 根据评价ID查询评价信息
            Comment parentComment = this.getOne(new QueryWrapper<Comment>().eq("id", comment.getCommentId()));
            // 创建消息提示对象
            Notice notice = new Notice();
            notice.setUserId(parentComment.getUserId());
            notice.setStrategyId(parentComment.getStrategyId());
            notice.setCreateDate(new Date());
            // 保存消息提示信息和评价信息
            return noticeMapper.insert(notice) > 0 && this.save(comment);
        }
    }
}
