<%--
  Created by IntelliJ IDEA.
  User: 斗佛Uncle
  Date: 2022/2/25
  Time: 23:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="banner">
    <div class="b-img">
        <img src="<%= ServletUtils.getProjectHttpUrl(request)%>/images/web_img/banner.jpg" width="100%"/>
        <img src="<%= ServletUtils.getProjectHttpUrl(request)%>/images/web_img/banner2.jpg" width="100%" />
    </div>
    <div class="clear"></div>
    <div class="b-list"> </div>
</div>
</body>
</html>
