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
<div class="part1">
  <div class="contitbox">
    <h2 class="ccsl">Scenic spot</h2>
    <p class="ccsl">景区景点</p>
    <p style="text-align: center; font-size: 14px">
      <a href="<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebScenicSpotListPage?type=1">查看更多 >></a>
    </p>
  </div>
  <div class="typebox">
  </div>
  <ul>
    <c:forEach items="${indexData}" var="item">
      <li>
        <a href="<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebDetailPage?id=${item.id}" class="pro">
          <img src="${item.headImg}" <c:if test="${item.headImg == null || item.headImg == ''}">alt="未上传图片"</c:if>/></a>
        <div class="txtbox">
          <p class="ccsl">${item.name}</p>
        </div>
      </li>
    </c:forEach>
  </ul>
</div>
<div class="clear"></div>
<div class="part1">
  <div class="contitbox">
    <h2 class="ccsl">Red Scenic spot</h2>
    <p class="ccsl">红色景区</p>
    <p style="text-align: center; font-size: 14px">
      <a href="<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebPage/piclist/?type=1">查看更多 >></a>
    </p>
  </div>
  <div class="typebox">
  </div>
  <ul>
    <c:forEach items="${redData}" var="item">
      <li>
        <a href="<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebDetailPage?id=${item.id}" class="pro">
          <img src="${item.headImg}" <c:if test="${item.headImg == null || item.headImg == ''}">alt="未上传图片"</c:if>/></a>
        <div class="txtbox">
          <p class="ccsl">${item.name}</p>
        </div>
      </li>
    </c:forEach>
  </ul>
</div>
<div class="clear"></div>
<div class="part4">
  <div class="main">
    <div class="titbox">
      <h2 class="ccsl">选择旅游的 <span>4</span> 大好处</h2>
    </div>
    <ul>
      <li>
        <div class="sub">旅游可以改变人的性格。不是说内向或者宅就是不好的性格，但人毕竟是群居动物，多出门可以增长见识，增加谈资，慢慢的就会发现旅游的好处了，性格会慢慢开朗，人也会变的健谈。</div>
      </li>
      <li>
        <div class="sub">旅游消耗钱财和时间，但是旅游可以增长见识。旅游就是行万里路，放松心情和陶冶情操。旅游可以使心情变得更加雀跃、欢快，可以选择风景好的地方旅游。</div>
      </li>
      <li>
        <div class="sub">旅游业推动了国家的经济发展。不得不说，在现在旅游业真的是越来越红火，旅游业发展的好，国民的收入等等也会有所提高的。</div>
      </li>
      <li>
        <div class="sub">旅游可以锻炼身体，爬爬山，游游水，哪怕仅仅只是走走路，也对身体有很多好处的，更不要提出去旅游可以多呼吸一些新鲜空气，洗洗肺了。</div>
      </li>
    </ul>
  </div>
</div>
<div class="clear"></div>
<div class="linkbox">
  <span>友情链接：</span>
  <div class="con">
  </div>
</div>
<div class="clear"></div>

<!-- 引入公共的底部部分 -->
<%@include file="footer.jsp"%>

<style>
.copyrights{text-indent:-9999px;height:0;line-height:0;font-size:0;overflow:hidden;}
</style>
<div class="copyrights" id="links20210126">
	Collect from <a href="http://www.cssmoban.com/"  title="网站模板">模板之家</a>
	<a href="http://cooco.net.cn/" title="组卷网">组卷网</a>
</div>
</body>
</html>                      
