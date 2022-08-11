<%--
  Created by IntelliJ IDEA.
  User: 斗佛Uncle
  Date: 2022/2/25
  Time: 23:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="logo">
    <a href="<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebPage/index/0">
        <img src="<%= ServletUtils.getProjectHttpUrl(request)%>/images/web_img/logo.jpg" />
    </a>
</div>
<div class="clear"></div>
<div class="nav">
    <div class="main">
        <ul id="headUl">
            <li <c:if test="${type eq '0'}">class="on" </c:if>><a href="<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebPage/index/0">首页</a></li>
            <li <c:if test="${type eq '1'}">class="on" </c:if>><a href="<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebScenicSpotListPage?type=1">景点列表</a></li>
            <li <c:if test="${type eq '2'}">class="on" </c:if>><a href="<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebStrategyListPage?type=2">旅游攻略</a></li>
            <c:if test="${sessionScope.webUser != null}">
            <li <c:if test="${type eq '3'}">class="on" </c:if>><a href="<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebPage/member/3">个人中心</a></li>
            </c:if>
            <li><a href="<%= ServletUtils.getProjectHttpUrl(request)%>system/toAdminLoginPage" target="_blank">网站后台</a></li>
            <c:if test="${sessionScope.webUser == null}">
            <li><a href="javascript:;" id="toLogin">登录</a></li>
            </c:if>
            <c:if test="${sessionScope.webUser != null}">
            <li><a href="javascript:;" id="logout">退出登录</a></li>
            </c:if>
        </ul>
    </div>
</div>
</body>
<script src="<%= ServletUtils.getProjectHttpUrl(request)%>/lib/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/MyLayuiUtils.js"></script>
<script>
    layui.use(['layer'], function() {

        let layer = layui.layer

        // 绑定登录按钮事件
        $("#toLogin").click(function () {
            let backUrl = window.location.href;
            window.location.href = "<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toLoginPage?backUrl=" + backUrl
        })

        $("#logout").click(function () {
            sendAjax("<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toLogout", "GET", false, (res) => {
                if(res.code == 200) {
                    layer.msg("已成功退出！", {
                        shade: .3
                        , offset: '300px'
                        , icon: 6
                        , end: () => {
                            window.location.reload();
                        }
                    });
                }
            })
        })
    })
</script>
</html>
