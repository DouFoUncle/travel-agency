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
  <div class="mainLeft">
    <div class="typebox">
      <div class="titbox">
        <h3 class="ccsl">景区景点</h3>
        <hr />
        <p class="ccsl">product center</p>
      </div>
      <ul>
        <li><a href="piclist.jsp" class="ccsl">巴厘岛</a></li>
        <li><a href="piclist.jsp" class="ccsl">马尔代夫</a></li>
        <li><a href="piclist.jsp" class="ccsl">迪拜</a></li>
        <li><a href="piclist.jsp" class="ccsl">香港</a></li>
        <li><a href="piclist.jsp" class="ccsl">旧金山</a></li>
        <li><a href="piclist.jsp" class="ccsl">云南</a></li>
      </ul>
    </div>
    <div class="newsbox">
      <div class="titbox">
        <p class="ccsl">最新资讯 </p>
        <a href="list.jsp">更多>> </a>
      </div>
      <ul>
        <li><a href="detail.jsp" class="ccsl">跟团旅游需要注意什么？</a></li>
        <li><a href="detail.jsp" class="ccsl">跟团旅游需要注意什么？</a></li>
        <li><a href="detail.jsp" class="ccsl">跟团旅游需要注意什么？</a></li>
        <li><a href="detail.jsp" class="ccsl">跟团旅游需要注意什么？</a></li>
        <li><a href="detail.jsp" class="ccsl">跟团旅游需要注意什么？</a></li>
      </ul>
    </div>
    <div class="newsbox">
      <div class="titbox">
        <p class="ccsl">联系我们 </p>
        <a href="about.jsp">更多>> </a>
      </div>
      <div class="lxwmbox">
        <div>湖南省长沙地区<br />XXX10（马）<br />lvyou***@qq.com</div>
      </div>
    </div>
  </div>
  <div class="mainRight">
    <div class="brandnavbox">
       <p class="ccsl">联系我们</p>
       <div class="con ccsl">首页 > 联系我们 ></div>
    </div>
    <div class="detailbox">
      <div class="xq">
        <div class="con">
          <p>创意景区景点模板公司</p>
          <p>地址：湖南省长沙地区</p>
          <p>联系人：马经理</p>
          <p>电话：000-000-0000</p>
          <p>邮箱：lvyou***@qq.com</p>
          <p>QQ：XXX</p>
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
