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
  <div class="mainRight" style="float: none; margin: 0 auto; min-width: 900px">
    <div class="brandnavbox">
       <p class="ccsl">景点详情</p>
       <div class="con ccsl">
         <a href="javascript:;" onclick="window.history.back();">返回</a>
       </div>
    </div>
    <div class="detailbox">
      <div class="xq">
        <h1>${obj.name}</h1>
        <div class="date">发布时间：${obj.createDateFormat}</div>
        <img src="${obj.headImg}" class="pprooimg"/>
        <div class="con">
          ${obj.readme}
        </div>
        <div style="text-align: center">
          <a href="${obj.skipUrl}" style="font-size: 18px" target="_blank">前往购票 >></a>
        </div>
      </div>
    </div>
  </div>
  <div class="clear"></div>
</div>
</div>
<div class="clear"></div>

<!-- 引入公共的底部部分 -->
<%@include file="footer.jsp"%>

</body>
</html>                      
