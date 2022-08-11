package priv.project.util;

import priv.project.pojo.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @Author Mr.Wang
 * @Date 2022/2/10
 * @Description 下一位读我代码的人, 有任何疑问请联系我, WX：19935820631
 */
public class ServletUtils {

    /**
     * 获取当前前台已登录用户的信息
     * @param session
     * @return
     */
    public static Integer getWebUserIdInfo(HttpSession session) {
        User webUserInfo = (User) session.getAttribute("webUser");
        return webUserInfo.getId();
    }

    /**
     * 获取项目网络地址
     * http://ip:port/projectName/
     * @param request
     * @return
     */
    public static String getProjectHttpUrl(HttpServletRequest request) {
        // 获取项目名称
        String contextPath = request.getContextPath();
        // 获取协议
        String scheme = request.getScheme();
        // 获取ip
        String serverName = request.getServerName();
        // 获取端口
        int serverPort = request.getServerPort();
        String showPath = scheme + "://" + serverName + ":" + serverPort + contextPath + "/";
        return showPath;
    }

    /**
     * 获取登陆用户的信息
     * @param session
     * @return
     */
    public static User getWebUserInfo(HttpSession session) {
        User webUserInfo = (User) session.getAttribute("webUser");
        return webUserInfo;
    }
}
