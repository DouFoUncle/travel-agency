package priv.project.controller.web;

import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import priv.project.pojo.*;
import priv.project.service.*;
import priv.project.util.ServletUtils;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;


/**
 * @Author Mr.Wang
 * @Date 2022/2/10
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 * 客户端页面跳转控制器
 */
@Controller
@RequestMapping("/web/system")
@AllArgsConstructor
public class WebSystemController {

    private ScenicSpotService scenicSpotService;

    private AreaService areaService;

    private ScenicTypeService scenicTypeService;

    private StrategyService strategyService;

    private UserService userService;

    private CollectService collectService;

    private VisitService visitService;

    private CommentService commentService;

    private NoticeService noticeService;

    /**
     * 跳转到用户登录页面
     * @return
     */
    @GetMapping("/toLoginPage")
    public ModelAndView toLoginPage(ModelAndView modelAndView, String backUrl) {
        modelAndView.addObject("backUrl", backUrl);
        modelAndView.setViewName("web/login");
        return modelAndView;
    }

    /**
     * 跳转到用户注册页面
     * @return
     */
    @GetMapping("/toRegisterPage")
    public ModelAndView toRegisterPage(ModelAndView modelAndView, String backUrl) {
        modelAndView.addObject("backUrl", backUrl);
        modelAndView.setViewName("web/register");
        return modelAndView;
    }

    /**
     * 用户登陆
     * @return
     */
    @PostMapping("/userLogin")
    @ResponseBody
    public ResultMessage verifyLogin(@RequestBody User user, HttpSession session, HttpServletResponse response) {
        try {
            // 验证登陆
            User selectResult = userService.getInfoByLogin(user);
            // 查询结果为空
            if (selectResult == null) {
                // 密码或用户名有误
                return new ResultMessage(207, "登录失败! 用户名或密码输入有误！");
            } else {
                // 清空一下缓存
                response.setHeader("Pragma", "No-cache");
                response.setHeader("Cache-Control", "no-cache");
                response.setDateHeader("Expires", 0);
                // 将用户信息保存到session中
                session.setAttribute("webUser", selectResult);
                return new ResultMessage(200, "登录成功！");
            }
        } catch(Exception e) {
            e.printStackTrace();
            return new ResultMessage(500, "操作异常！");
        }
    }

    /**
     * 退出登录
     * @param session
     * @param response
     * @return
     */
    @GetMapping("/toLogout")
    @ResponseBody
    public ResultMessage loginOut(HttpSession session, HttpServletResponse response) {
        response.setHeader("Pragma","No-cache");
        response.setHeader("Cache-Control","no-cache");
        response.setDateHeader("Expires", 0);
        session.removeAttribute("webUser");
        return new ResultMessage(200, "操作成功！");
    }

    /**
     * 跳转到前台首页
     * @return
     */
    @GetMapping("/toWebPage/{pageName}/{type}")
    public ModelAndView toWebIndexPage(ModelAndView modelAndView,
                                       @PathVariable("pageName") String pageName,
                                       @PathVariable(value = "type", required = false) String type) {
        // 如果是首页, 需要查询一些首页必须展示的数据
        if("index".equals(pageName)) {
            // 查询首页推荐景区
            List<ScenicSpot> indexData = scenicSpotService.getIndexDataList();
            // 查询首页推荐红色景区
            List<ScenicSpot> redData = scenicSpotService.getRedDataList();
            // 将查询结果保存到ModelAndView中 一起返回给页面
            modelAndView.addObject("indexData", indexData);
            modelAndView.addObject("redData", redData);
        }
        modelAndView.addObject("type", type);
        modelAndView.setViewName("web/" + pageName);
        return modelAndView;
    }

    /**
     * 跳转到景点列表页面
     * @return
     */
    @GetMapping("/toWebScenicSpotListPage")
    public ModelAndView toWebScenicSpotListPage(ModelAndView modelAndView,
                                                Integer type, Integer page, Integer limit,
                                                ScenicSpot scenicSpot) {
        // 查询所有省份信息
        List<Area> areaList = areaService.getProvinceData();
        List<ScenicType> scenicTypeList = scenicTypeService.getListData();
        // 查询所有分类信息
        if(page == null) {
            page = 1;
        }
        if(limit == null) {
            limit = 12;
        }
        // 调用查询数据方法
        IPage<ScenicSpot> pageList = scenicSpotService.getPageList(page, limit, scenicSpot);
        // 计算总页数
        long pageCount = pageList.getTotal() % limit == 0 ? pageList.getTotal() / limit : pageList.getTotal() / limit + 1;
        // 设置当前页
        pageList.setCurrent(page);
        System.out.println(pageCount);
        modelAndView.addObject("pageInfo", pageList);
        modelAndView.addObject("type", type);
        modelAndView.addObject("pageCount", pageCount);
        modelAndView.addObject("areaList", areaList);
        modelAndView.addObject("scenicTypeList", scenicTypeList);
        modelAndView.addObject("scenicSpot", scenicSpot);
        modelAndView.setViewName("web/piclist");
        return modelAndView;
    }

    /**
     * 跳转到攻略列表页面
     * @return
     */
    @GetMapping("/toWebStrategyListPage")
    public ModelAndView toWebScenicSpotListPage(ModelAndView modelAndView,
                                                Integer type, Integer page, Integer limit,
                                                Strategy strategy) {
        // 查询所有分类信息
        if(page == null) {
            page = 1;
        }
        if(limit == null) {
            limit = 5;
        }
        // 调用查询数据方法
        IPage<Strategy> pageList = strategyService.getPageList(page, limit, strategy);
        // 计算总页数
        long pageCount = pageList.getTotal() % limit == 0 ? pageList.getTotal() / limit : pageList.getTotal() / limit + 1;
        // 设置当前页
        pageList.setCurrent(page);
        System.out.println(pageCount);
        modelAndView.addObject("pageInfo", pageList);
        modelAndView.addObject("type", type);
        modelAndView.addObject("pageCount", pageCount);
        modelAndView.addObject("strategy", strategy);
        modelAndView.setViewName("web/list");
        return modelAndView;
    }

    /**
     * 跳转到我的信息页面
     * @return
     */
    @GetMapping("/toWebMeInfoPage")
    public ModelAndView toWebMeInfoPage(ModelAndView modelAndView, HttpSession session) {
        User webUserInfo = ServletUtils.getWebUserInfo(session);
        if(webUserInfo == null) {
            modelAndView.addObject("flag", "1");
            modelAndView.setViewName("web/me_info");
            return modelAndView;
        }
        modelAndView.addObject("obj", userService.getById(webUserInfo.getId()));
        modelAndView.setViewName("web/me_info");
        return modelAndView;
    }

    /**
     * 跳转到 修改密码页面
     * @param modelAndView
     * @return
     */
    @GetMapping("/toUpdatePwdWindows")
    public ModelAndView toUpdatePwdWindows(ModelAndView modelAndView) {
        modelAndView.setViewName("web/editUserPwd");
        return modelAndView;
    }

    /**
     * 跳转到浏览记录页面
     * @return
     */
    @GetMapping("/toWebVisitPage")
    public ModelAndView toWebVisitPage(ModelAndView modelAndView) {
        modelAndView.setViewName("web/visit");
        return modelAndView;
    }

    /**
     * 跳转到我的收藏页面
     * @return
     */
    @GetMapping("/toWebCollectPage")
    public ModelAndView toWebCollectPage(ModelAndView modelAndView) {
        modelAndView.setViewName("web/collect");
        return modelAndView;
    }

    /**
     * 跳转到我的评价页面
     * @return
     */
    @GetMapping("/toWebCommentPage")
    public ModelAndView toWebCommentPage(ModelAndView modelAndView) {
        modelAndView.setViewName("web/comment");
        return modelAndView;
    }

    /**
     * 跳转到消息通知页面
     * @return
     */
    @GetMapping("/toWebNoticePage")
    public ModelAndView toWebNoticePage(ModelAndView modelAndView, HttpSession session) {
        if(ServletUtils.getWebUserInfo(session) == null) {
            modelAndView.addObject("flag", "1");
            modelAndView.setViewName("web/notice");
            return modelAndView;
        }
        Notice notice = new Notice();
        notice.setUserId(ServletUtils.getWebUserIdInfo(session));
        List<Notice> listData = noticeService.getListData(notice);
        modelAndView.addObject("noticeList", listData);
        modelAndView.setViewName("web/notice");
        return modelAndView;
    }

    /**
     * 跳转到用户发布攻略页面
     * @return
     */
    @GetMapping("/toWebStrategyPage")
    public ModelAndView toWebStrategyPage(ModelAndView modelAndView) {
        modelAndView.setViewName("web/strategy/strategy");
        return modelAndView;
    }

    /**
     * 跳转到 添加攻略页面
     * @param modelAndView
     * @return
     */
    @GetMapping("/toAddWindow")
    public ModelAndView toAddStrategyWindow(ModelAndView modelAndView) {
        modelAndView.setViewName("web/strategy/add");
        return modelAndView;
    }

    /**
     * 跳转到 修改攻略页面
     * @param modelAndView
     * @return
     */
    @GetMapping("/toEditWindow")
    public ModelAndView toEditStrategyWindow(ModelAndView modelAndView, Integer id) {
        // 查询攻略信息
        modelAndView.addObject("obj", strategyService.getOne(new QueryWrapper<Strategy>().eq("id", id)));
        modelAndView.setViewName("web/strategy/edit");
        return modelAndView;
    }

    /**
     * 跳转到 查看攻略页面
     * @param modelAndView
     * @return
     */
    @GetMapping("/toFindWindow")
    public ModelAndView toFindStrategyWindow(ModelAndView modelAndView, Integer id) {
        // 查询攻略信息
        modelAndView.addObject("obj", strategyService.getOne(new QueryWrapper<Strategy>().eq("id", id)));
        modelAndView.setViewName("web/strategy/find");
        return modelAndView;
    }

    /**
     * 跳转到添加评论弹窗
     * @return
     */
    @GetMapping("/toAddCommentPage")
    public ModelAndView toAddCommentPage(ModelAndView modelAndView, Integer strategyId, Integer commentId) {
        modelAndView.addObject("strategyId", strategyId);
        modelAndView.addObject("commentId", commentId);
        modelAndView.setViewName("web/addComment");
        return modelAndView;
    }

    /**
     * 跳转到景区详情页
     * @return
     */
    @GetMapping("/toWebDetailPage")
    public ModelAndView toWebDetailPage(ModelAndView modelAndView, Integer id) {
        // 查询景区详情
        ScenicSpot scenicSpot = scenicSpotService.getOne(new QueryWrapper<ScenicSpot>().eq("id", id));
        // 时间转换
        scenicSpot.setCreateDateFormat(DateUtil.formatDate(scenicSpot.getCreateDate()));
        modelAndView.addObject("obj", scenicSpot);
        modelAndView.setViewName("web/picdetail");
        return modelAndView;
    }

    /**
     * 跳转到攻略详情页
     * @return
     */
    @GetMapping("/toWebStrategyDetailPage")
    public ModelAndView toWebStrategyDetailPage(ModelAndView modelAndView, Integer id, HttpSession session) {
        // 从session中取出登录用户信息, 判断是否已经登录, 如果登录则查询用户是否收藏了这篇攻略
        User user = (User) session.getAttribute("webUser");
        if(user != null) {
            // 登录用户信息不等于空, 则查询收藏表有没有收藏
            QueryWrapper<Collect> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("strategy_id", id);
            queryWrapper.eq("user_id", user.getId());
            Collect collcet = collectService.getOne(queryWrapper);
            if(collcet != null) {
                // 收藏信息不为空 则代表已收藏, 返回1
                modelAndView.addObject("isColl", "1");
            } else {
                // 为空则返回0 代表为收藏
                modelAndView.addObject("isColl", "0");
            }
            // 保存浏览记录
            Visit visit = new Visit();
            visit.setStrategyId(id);
            visit.setUserId(user.getId());
            visit.setCreateDate(new Date());
            visitService.save(visit);
        }
        // 查询攻略相关评论
        List<Comment> commentList = commentService.getListInfoByStrategyId(id);
        // 查询景区详情
        Strategy strategy = strategyService.getInfoById(id);
        // 时间转换
        strategy.setCreateDateFormat(DateUtil.formatDate(strategy.getCreateDate()));
        modelAndView.addObject("obj", strategy);
        modelAndView.addObject("commentList", commentList);
        modelAndView.setViewName("web/detail");
        return modelAndView;
    }
}
