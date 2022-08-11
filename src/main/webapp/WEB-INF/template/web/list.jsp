<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="priv.project.util.ServletUtils" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit"/>
<meta name="force-rendering" content="webkit"/>
<title>一旅阳光网</title>
<link type="text/css" rel="stylesheet" href="<%= ServletUtils.getProjectHttpUrl(request)%>/css/web_css/style.css" />
<script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/web_js/banner.js"></script>
</head>

<body>

<!-- 引入公共的头部导航条 -->
<%@include file="header.jsp"%>

<div class="clear"></div>

<!-- 引入公共的轮播图部分 -->
<%@include file="banner.jsp"%>

<div class="clear"></div>
<div class="mabody">
<div class="mainWarp">
  <div class="mainRight" style="margin: 0 auto; float: none; width: 100%">
    <div class="brandnavbox">
       <p class="ccsl">旅游攻略</p>
    </div>
    <ul class="listul">
      <c:forEach items="${pageInfo.records}" var="item">
        <li>
          <div class="newsl">
            <a href="<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebPage/detail/3">
              <img src="${item.indexImg}" />
            </a>
          </div>
          <div class="newsr" style="width: 850px">
            <a href="<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebStrategyDetailPage?id=${item.id}" class="ccsl">${item.title}</a>
            <hr>
            <div class="sub" style="min-height: 75px; max-height: 75px;">${item.resume}</div>
            <a href="<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebStrategyDetailPage?id=${item.id}" class="more">查看详情>> </a>
          </div>
        </li>
      </c:forEach>
    </ul>
    <div class="clear"></div>
    <div class="pagebox">
      <a href="javascript:;" data-pages="${pageCount}" data-current="${pageInfo.current}" id="prev">上一页</a>
      <c:forEach begin="1" end="${pageCount}" var="item">
        <a class="page-numbers pageBtn <c:if test="${pageInfo.current == item}">on</c:if>"
           href="javascript:;" data-current="${pageInfo.current}" data-num="${item}">${item}</a>
      </c:forEach>
      <a href="javascript:;" data-pages="${pageCount}" data-current="${pageInfo.current}" id="next">下一页</a>
    </div>
  </div>
  <div class="clear"></div>
</div>
</div>
<div class="clear"></div>

<!-- 引入公共的底部部分 -->
<%@include file="footer.jsp"%>

</body>
<script src="<%= ServletUtils.getProjectHttpUrl(request)%>/lib/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/MyLayuiUtils.js"></script>
<script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/me_js/page.js"></script>
</html>                      
