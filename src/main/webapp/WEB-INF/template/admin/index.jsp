<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html class="x-admin-sm">
    <head>
        <meta charset="UTF-8">
        <title>一旅阳光网</title>
        <meta name="renderer" content="webkit|ie-comp|ie-stand">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
        <meta http-equiv="Cache-Contro.l" content="no-siteapp" />
        <link rel="stylesheet" href="../css/font.css">
        <link rel="stylesheet" href="../css/xadmin.css">
        <link rel="stylesheet" href="../css/theme11black_purple.min.css">
        <!-- <link rel="stylesheet" href="./css/theme5.css"> -->
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery.min.js"></script>
        <script type="text/javascript" src="../js/xadmin.js"></script>
        <script type="text/javascript" src="../js/MyLayuiUtils.js"></script>
        <script>
            // 是否开启刷新记忆tab功能
            // var is_remember = false;
        </script>
    </head>
    <body class="index">
        <!-- 顶部开始 -->
        <div class="container">
            <div class="logo">
                <a href="index.jsp">一旅阳光网</a></div>
            <div class="left_open">
                <a><i title="展开左侧栏" class="iconfont">&#xe699;</i></a>
            </div>
            <ul class="layui-nav left fast-add" lay-filter="">
            </ul>
        </div>
        <!-- 顶部结束 -->

        <!-- 中部开始 -->
        <!-- 左侧菜单开始 -->
        <div class="left-nav">
            <div id="side-nav">
                <ul id="nav">
                    <li>
                        <a href="javascript:;" onclick="xadmin.add_tab('用户管理','toPage/user/user')">
                            <i class="layui-icon left-nav-li" lay-tips="用户管理">&#xe770;</i>
                            <cite>用户管理</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                    </li>
                    <li>
                        <a href="javascript:;" onclick="xadmin.add_tab('省市管理','toPage/area/area')">
                            <i class="layui-icon left-nav-li" lay-tips="省市管理">&#xe7ae;</i>
                            <cite>省市管理</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                    </li>
                    <li>
                        <a href="javascript:;" onclick="xadmin.add_tab('分类管理','toPage/scenicType/scenicType')">
                            <i class="layui-icon left-nav-li" lay-tips="分类管理">&#xe653;</i>
                            <cite>分类管理</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                    </li>
                    <li>
                        <a href="javascript:;" onclick="xadmin.add_tab('景点管理','toPage/scenicSpot/scenicSpot')">
                            <i class="layui-icon left-nav-li" lay-tips="景点管理">&#xe715;</i>
                            <cite>景点管理</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                    </li>
                    <li>
                        <a href="javascript:;" onclick="xadmin.add_tab('攻略管理','toPage/strategy/strategy')">
                            <i class="layui-icon left-nav-li" lay-tips="攻略管理">&#xe756;</i>
                            <cite>攻略管理</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                    </li>
                    <li>
                        <a href="javascript:;" onclick="xadmin.add_tab('评论管理','toPage/comment/comment')">
                            <i class="layui-icon left-nav-li" lay-tips="评论管理">&#xe63a;</i>
                            <cite>评论管理</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                    </li>
                    <li>
                        <a href="javascript:;" onclick="xadmin.add_tab('管理员账号','toPage/admin/admin')">
                            <i class="layui-icon left-nav-li" lay-tips="管理员账号">&#xe716;</i>
                            <cite>管理员账号</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                    </li>
                    <li>
                        <a href="javascript:;" id="toUpdatePwd">
                            <i class="iconfont left-nav-li" lay-tips="修改密码">&#xe82b;</i>
                            <cite>修改密码</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                    </li>
                    <li>
                        <a href="javascript:;" onclick="window.location.href = getPath() + '/web/system/toWebPage/index/0'">
                            <i class="iconfont left-nav-li" lay-tips="前台首页">&#xe718;</i>
                            <cite>前台首页</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                    </li>
                    <li>
                        <a href="javascript:;" onclick="window.location.href = '../system/adminLoginOut'">
                            <i class="iconfont left-nav-li" lay-tips="退出登录">&#xe69c;</i>
                            <cite>退出登录</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                    </li>
                </ul>
            </div>
        </div>
        <!-- <div class="x-slide_left"></div> -->
        <!-- 左侧菜单结束 -->
        <!-- 右侧主体开始 -->
        <div class="page-content">
            <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
                <ul class="layui-tab-title">
                    <li class="home layui-this">
                        <i class="layui-icon">&#xe68e;</i>我的桌面</li></ul>
                <div class="layui-unselect layui-form-select layui-form-selected" id="tab_right">
                    <dl>
                        <dd data-type="this">关闭当前</dd>
                        <dd data-type="other">关闭其它</dd>
                        <dd data-type="all">关闭全部</dd></dl>
                </div>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <iframe src='toWelcomePage' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
                    </div>
                </div>
                <div id="tab_show"></div>
            </div>
        </div>
        <div class="page-content-bg"></div>
        <style id="theme_style"></style>
        <script>
            layui.use(['form'], function() {
                var $ = layui.jquery;

                $("#toUpdatePwd").click(function() {
                    toWindow(getPath() + "/admin/toUpdatePwdWindows", "修改密码", "400px", "300px", true);
                })
            })
        </script>
    </body>
</html>