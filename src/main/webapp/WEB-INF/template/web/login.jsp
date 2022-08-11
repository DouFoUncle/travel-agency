<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="priv.project.util.ServletUtils" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <title>一旅阳光网</title>
    <link rel="stylesheet" type="text/css" href="<%= ServletUtils.getProjectHttpUrl(request)%>/css/web_login/zui.css" media="all">
    <link rel="stylesheet" type="text/css" href="<%= ServletUtils.getProjectHttpUrl(request)%>/css/web_login/login.css" media="all">
    <link href="<%= ServletUtils.getProjectHttpUrl(request)%>/css/web_login/animate.min.css" rel="stylesheet">
    <link href="<%= ServletUtils.getProjectHttpUrl(request)%>/css/web_login/font-awesome.min.css" rel="stylesheet">
    <style> body {
        background-image: url(<%= ServletUtils.getProjectHttpUrl(request)%>/images/web_login/4.jpg);
    }</style>
</head>
<body>
<div id="main-box"></div>
<div id="main-content">
    <div class="login-body  animated fadeInLeft">
        <div class="login-main pr">
            <form action="javascript:;" method="post" class="login-form" id="loginForm">
                <h3> 一旅阳光网 </h3>
                <h5 style="padding-bottom: 10px"> Shine Travel Agency </h5>
                <!-- 账号登陆 -->
                <div id="MobileBox" class="item-box">
                    <div class="input-group user-name"><span class="input-group-addon"><i class="icon-user"></i></span>
                        <input type="text" name="userName" class="form-control" placeholder="用户名" autocomplete="off">
                    </div>
                    <div class="input-group password"><span class="input-group-addon"><i class="icon-lock"></i></span>
                        <input type="password" name="password" class="form-control" placeholder="密码" autocomplete="new-password">
                    </div>

                    <div class="login_btn_panel">
                        <input type="hidden" value="${backUrl}" name="backUrl">
                        <button class=" btn btn-primary btn-block btn-lg" id="loginBtn" type="button">登录
                        </button>
                        <div class="check-tips"></div>
                    </div>

                    <div class="login_btn_panel">
                        <input type="hidden" value="${backUrl}" name="backUrl">
                        <button class=" btn btn-primary btn-block btn-lg"
                                onclick="window.location.href = '<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebPage/index/0'"
                                type="button">返回首页
                        </button>
                        <div class="check-tips"></div>
                    </div>

                    <div class="login_btn_panel">
                        <button class=" btn btn-primary btn-block btn-lg" data-ajax="post" type="button"
                                data-callback="success"
                                onclick="window.location.href = '<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toRegisterPage?backUrl=${backUrl}'">
                            前往注册
                        </button>
                        <div class="check-tips"></div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<style>
    .copyrights {
        text-indent: -9999px;
        height: 0;
        line-height: 0;
        font-size: 0;
        overflow: hidden;
    }
</style>
<script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/jquery.min.js"></script>
<script src="<%= ServletUtils.getProjectHttpUrl(request)%>/lib/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/MyLayuiUtils.js"></script>
<script>
    layui.use(['layer'], function() {
        // 登陆成功后返回到哪个页面
        let backUrl = '${backUrl}'
        // 弹出层组件对象
        let layer = layui.layer;

        // 响应注册按钮
        $("#loginBtn").click(function() {
            // 数据校验
            let msg = verifyData();
            if(msg) {
                layer.open({
                    title: '错误消息'
                    , content:  msg
                    , shade: 0.3
                    , icon: 5
                    , anim: 6
                    , closeBtn: 0
                });
                return;
            }
            // 校验通过, 提交表单
            // 获取表单数据
            let dataArr = $("#loginForm").serializeArray();
            var jsonObj={};
            $(dataArr).each(function(){
                jsonObj[this.name] = this.value;
            });
            // 请求接口
            sendAjax("<%= ServletUtils.getProjectHttpUrl(request)%>web/system/userLogin",
                "POST",
                jsonObj,
                (res) => {
                    if(res.code == 200) {
                        layer.open({
                            title: '成功提示'
                            , content:  res.msg
                            , shade: 0.3
                            , icon: 6
                            , closeBtn: 0
                            , end: () => {
                                // 判断是否有返回路径, 有则跳转到返回路径, 没有则跳转首页
                                if(backUrl) {
                                    window.location.href = backUrl
                                } else {
                                    // 跳转到首页
                                    window.location.href = '<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebPage/index/0'
                                }
                            }
                        });
                    } else {
                        layer.open({
                            title: '错误消息'
                            , content:  res.msg
                            , shade: 0.3
                            , icon: 5
                            , anim: 6
                            , closeBtn: 0
                        });
                    }
                }
            )
        })

        /**
         * 验证数据是否填写完整
         */
        function verifyData() {
            let userName = $("input[name='userName']").val()
            let password = $("input[name='password']").val()
            if(!userName) {
                return "用户名不能为空！"
            }
            if(!password) {
                return "密码不能为空！"
            }
        }
    })
</script>
</body>
</html>
