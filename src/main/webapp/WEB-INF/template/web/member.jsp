<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="priv.project.util.ServletUtils" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit"/>
<meta name="force-rendering" content="webkit"/>
<title>一旅阳光网</title>
<link type="text/css" rel="stylesheet" href="<%= ServletUtils.getProjectHttpUrl(request)%>/css/xadmin.css" />
<link type="text/css" rel="stylesheet" href="<%= ServletUtils.getProjectHttpUrl(request)%>/css/web_css/style.css" />
<script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/web_js/banner.js"></script>
</head>
<style>
    .menuLink.on {
        color: #ffae00 !important;
    }
</style>
<body style="background-color: #FFF">

<!-- 引入公共的头部导航条 -->
<%@include file="header.jsp"%>

<div class="clear"></div>

<!-- 引入公共的轮播图部分 -->
<%@include file="banner.jsp"%>

<div class="clear"></div>
<div class="mabody">
<div class="mainWarp" style="width: 1300px">
  <div class="mainLeft">
    <div class="typebox">
      <div class="titbox">
        <h3 class="ccsl" style="font-size: 20px">个人中心</h3>
        <hr />
        <p class="ccsl" style="font-size: 16px">Member</p>
      </div>
      <ul>
          <li><a href="javascript:;" data-type="1" class="ccsl menuLink on">我的信息</a></li>
          <li><a href="javascript:;" data-type="2" class="ccsl menuLink">浏览记录</a></li>
          <li><a href="javascript:;" data-type="3" class="ccsl menuLink">我的收藏</a></li>
          <li><a href="javascript:;" data-type="4" class="ccsl menuLink">我的评论</a></li>
          <li><a href="javascript:;" data-type="5" class="ccsl menuLink">消息通知</a></li>
          <li><a href="javascript:;" data-type="6" class="ccsl menuLink">发布攻略</a></li>
      </ul>
    </div>
  </div>
  <div class="mainRight" style="width: 980px; padding: 15px">
    <!-- 默认打开我的信息页面 -->
    <iframe name="rightBody" frameborder="0" scrolling="yes" style="overflow: hidden; width: 100%; min-height: 650px;"
            src="<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebMeInfoPage"></iframe>
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
<script>
    layui.use(['layer'], function() {

        let layer = layui.layer;

        // 默认跳转到我的信息页面
        $("iframe[name='rightBody']").attr("src", "<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebMeInfoPage");

        $(".menuLink").click(function () {
            // 判断点击的哪个链接
            let type = $(this).attr("data-type");
            dataTypeFun(type);
            switch (type) {
                case "1":
                    // 我的信息
                    // 设置iframe的跳转路径
                    $("iframe[name='rightBody']").attr("src", "<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebMeInfoPage");
                    break;
                case "2":
                    // 浏览记录
                    // 设置iframe的跳转路径
                    $("iframe[name='rightBody']").attr("src", "<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebVisitPage");
                    break;
                case "3":
                    // 我的收藏
                    // 设置iframe的跳转路径
                    $("iframe[name='rightBody']").attr("src", "<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebCollectPage");
                    break;
                case "4":
                    // 我的评论
                    // 设置iframe的跳转路径
                    $("iframe[name='rightBody']").attr("src", "<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebCommentPage");
                    break;
                case "5":
                    // 消息通知
                    $("iframe[name='rightBody']").attr("src", "<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebNoticePage");
                    break;
                case "6":
                    // 消息通知
                    $("iframe[name='rightBody']").attr("src", "<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebStrategyPage");
                    break;
            }
        })

        function dataTypeFun(dataType) {
            // 根据iframe的data-type属性判断哪个菜单颜色标注
            $(".menuLink").removeClass("on");
            $("a[data-type='"+dataType+"']").addClass("on");
        }


    })
</script>
</html>                      
