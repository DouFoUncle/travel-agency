package priv.project.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import priv.project.pojo.*;
import priv.project.service.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @Author Mr.Wang
 * @Date 2022/2/10
 * @Description 控制页面的跳转和一些简单逻辑跳转
 */
@Controller
@AllArgsConstructor
public class SystemController {

    private ScenicSpotService scenicSpotService;

    private AdminService adminService;

    private AreaService areaService;

    private ScenicTypeService scenicTypeService;

    private StrategyService strategyService;

    /**
     * 跳转到后台首页
     * @return
     */
    @GetMapping("/system/toAdminMainPage")
    public String toAdminMainPage() {
        return "admin/index";
    }

    /**
     * 后台用户登陆
     * @return
     */
    @PostMapping("/system/adminLogin")
    public String verifyLogin(Admin admin, HttpSession session, HttpServletResponse response) {
        // 验证登陆
        Admin selectResult = adminService.getInfoByLogin(admin);
        // 查询结果为空
        if(selectResult == null) {
            // 密码或用户名有误
            session.setAttribute("msg", "登录失败! 用户名或密码输入有误! ");
            return "redirect:/system/toAdminLoginPage";
        } else {
            // 移除消息提示
            session.removeAttribute("msg");
            // 清空一下缓存
            response.setHeader("Pragma","No-cache");
            response.setHeader("Cache-Control","no-cache");
            response.setDateHeader("Expires", 0);
            // 将用户信息保存到session中
            // 设置前将用户密码剔除
            selectResult.setPassword("");
            session.setAttribute("adminUser", selectResult);
            return "redirect:/system/toAdminMainPage";
        }
    }

    /**
     * 退出登录
     * @param session
     * @param response
     * @return
     */
    @GetMapping("/system/adminLoginOut")
    public String loginOut(HttpSession session, HttpServletResponse response) {
        response.setHeader("Pragma","No-cache");
        response.setHeader("Cache-Control","no-cache");
        response.setDateHeader("Expires", 0);
        session.removeAttribute("adminUser");
        return "redirect:/system/toAdminLoginPage";
    }

    /**
     * 跳转到欢迎页
     * @return
     */
    @GetMapping("/system/toWelcomePage")
    public String toWelcomePage() {
        return "admin/welcome";
    }

    /**
     * 跳转到后台登陆页面
     * @return
     */
    @GetMapping("/system/toAdminLoginPage")
    public String toAdminLoginPage() {
        return "admin/login";
    }

    /**
     * 跳转到登录超时页面
     * @return
     */
    @GetMapping("/system/toTimeOutPage")
    public String toTimeOutPage() {
        return "admin/error/timeOut";
    }


    // + ---------------------------------------------------------------------------
    // +                           后台管理系统所有页面跳转 Start
    // + ---------------------------------------------------------------------------
    /**
     * 跳转到 admin 展示数据页面
     * @param modelAndView
     * @return
     */
    @GetMapping("/system/toPage/{type}/{pageName}")
    public ModelAndView toAdminDataPage(@PathVariable("type") String type,
                                        @PathVariable("pageName") String pageName,
                                        ModelAndView modelAndView) {
        modelAndView.setViewName("admin/" + type + "/" + pageName);
        return modelAndView;
    }

    /**
     * 跳转到 添加管理员页面
     * @param modelAndView
     * @return
     */
    @GetMapping("/admin/toAddWindow")
    public ModelAndView toAddWindow(ModelAndView modelAndView) {
        modelAndView.setViewName("admin/admin/add");
        return modelAndView;
    }

    /**
     * 跳转到 修改密码页面
     * @param modelAndView
     * @return
     */
    @GetMapping("/admin/toUpdatePwdWindows")
    public ModelAndView toUpdatePwdWindows(ModelAndView modelAndView) {
        modelAndView.setViewName("admin/admin/editPwd");
        return modelAndView;
    }

    /**
     * 跳转到 添加区划信息页面
     * @param modelAndView
     * @return
     */
    @GetMapping("/area/toAddWindow")
    public ModelAndView toAreaAddWindow(ModelAndView modelAndView, String type) {
        if("province".equals(type)) {
            modelAndView.setViewName("admin/area/addProvince");
        } else if("city".equals(type)) {
            // 查询所有省份信息, 在新增城市是可以选择省份
            List<Area> areaList = areaService.getProvinceData();
            modelAndView.addObject("areaList", areaList);
            modelAndView.setViewName("admin/area/addCity");
        }
        return modelAndView;
    }

    /**
     * 跳转到 添加区划信息页面
     * @param modelAndView
     * @return
     */
    @GetMapping("/area/toEditWindow")
    public ModelAndView toAreaEditWindow(ModelAndView modelAndView, Integer id) {
        // 根据ID查询信息
        Area area = areaService.getOne(new QueryWrapper<Area>().eq("id", id));
        modelAndView.addObject("obj", area);
        // 判断是不是省级信息
        if(!"1".equals(area.getIsParent())) {
            // 是市级
            // 查询所有一级省份信息
            List<Area> areaList = areaService.getProvinceData();
            modelAndView.addObject("areaList", areaList);
        }
        modelAndView.setViewName("admin/area/edit");
        return modelAndView;
    }

    /**
     * 跳转到 添加攻略页面
     * @param modelAndView
     * @return
     */
    @GetMapping("/strategy/toAddWindow")
    public ModelAndView toAddStrategyWindow(ModelAndView modelAndView) {
        modelAndView.setViewName("admin/strategy/add");
        return modelAndView;
    }

    /**
     * 跳转到 修改攻略页面
     * @param modelAndView
     * @return
     */
    @GetMapping("/strategy/toEditWindow")
    public ModelAndView toEditStrategyWindow(ModelAndView modelAndView, Integer id) {
        // 查询攻略信息
        modelAndView.addObject("obj", strategyService.getOne(new QueryWrapper<Strategy>().eq("id", id)));
        modelAndView.setViewName("admin/strategy/edit");
        return modelAndView;
    }

    /**
     * 跳转到 查看攻略页面
     * @param modelAndView
     * @return
     */
    @GetMapping("/strategy/toFindWindow")
    public ModelAndView toFindStrategyWindow(ModelAndView modelAndView, Integer id) {
        // 查询攻略信息
        modelAndView.addObject("obj", strategyService.getOne(new QueryWrapper<Strategy>().eq("id", id)));
        modelAndView.setViewName("admin/strategy/find");
        return modelAndView;
    }

    /**
     * 跳转到 添加景区分类页面
     * @param modelAndView
     * @return
     */
    @GetMapping("/scenicType/toAddWindow")
    public ModelAndView toAddTypeWindow(ModelAndView modelAndView) {
        modelAndView.setViewName("admin/scenicType/add");
        return modelAndView;
    }

    /**
     * 跳转到 添加景区页面
     * @param modelAndView
     * @return
     */
    @GetMapping("/scenicSpot/toAddWindow")
    public ModelAndView toScenicAddWindow(ModelAndView modelAndView) {
        // 查询所有城市信息
        List<Area> areaList = areaService.getCityList();
        modelAndView.addObject("areaList", areaList);
        // 查询所有景区类型
        List<ScenicType> typeList = scenicTypeService.getListData();
        modelAndView.addObject("typeList", typeList);
        modelAndView.setViewName("admin/scenicSpot/add");
        return modelAndView;
    }

    /**
     * 跳转到 修改景区页面
     * @param modelAndView
     * @return
     */
    @GetMapping("/scenicSpot/toEditWindow")
    public ModelAndView toScenicEditWindow(ModelAndView modelAndView, Integer id) {
        ScenicSpot serviceOne = scenicSpotService.getOne(new QueryWrapper<ScenicSpot>().eq("id", id));
        // 查询要修改的信息
        modelAndView.addObject("obj", serviceOne);
        // 查询所有城市信息
        List<Area> areaList = areaService.getCityList();
        modelAndView.addObject("areaList", areaList);
        // 查询所有景区类型
        List<ScenicType> typeList = scenicTypeService.getListData();
        modelAndView.addObject("typeList", typeList);
        modelAndView.setViewName("admin/scenicSpot/edit");
        return modelAndView;
    }

    // + ---------------------------------------------------------------------------
    // +                           后台管理系统所有页面跳转 End
    // + ---------------------------------------------------------------------------

}
