<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="priv.project.util.ServletUtils" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="renderer" content="webkit"/>
    <meta name="force-rendering" content="webkit"/>
    <title>一旅阳光网</title>
    <link rel="stylesheet" href="<%= ServletUtils.getProjectHttpUrl(request)%>/css/font.css">
    <link rel="stylesheet" href="<%= ServletUtils.getProjectHttpUrl(request)%>/css/xadmin.css">
    <link type="text/css" rel="stylesheet" href="<%= ServletUtils.getProjectHttpUrl(request)%>/css/web_css/style.css"/>
    <link type="text/css" rel="stylesheet" href="<%= ServletUtils.getProjectHttpUrl(request)%>/css/web_css/comment.css"/>
    <script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/web_js/banner.js"></script>
    <style>
        .ccsl a:hover {
            cursor: pointer;
        }
        .collDiv .collImg:hover, .collDiv .collText:hover {
            cursor: pointer;
        }
    </style>
</head>
<body style="background-color: #FFF">
<input type="hidden" name="userId" value="${sessionScope.webUser.id}">
<input type="hidden" name="strategyId" value="${obj.id}">

<!-- 引入公共的头部导航条 -->
<%@include file="header.jsp" %>

<div class="clear"></div>

<!-- 引入公共的轮播图部分 -->
<%@include file="banner.jsp" %>

<div class="clear"></div>
<div class="mabody">
    <div class="mainWarp" style="width: 900px">
        <div class="mainRight" style="margin: 0 auto; float: none; width: 100%">
            <div class="brandnavbox">
                <p class="ccsl">动态中心</p>
                <div class="con ccsl">
                    <a href="javascript:;" onclick="window.history.back()">返回</a>
                </div>
            </div>
            <div class="detailbox">
                <div class="xq">
                    <h1>${obj.title}</h1>
                    <div class="date">发布时间：${obj.createDateFormat}&emsp;&emsp;发布人：${obj.user.loginName}</div>
                    <div class="con">
                        ${obj.content}
                    </div>
                    <div style="text-align: center">
                        <div style="display: flex; align-items: center;justify-content: center;
                                    flex-direction: column;" class="collDiv noColl">
                            <div style="width: 30px; height: 30px; display: flex; align-items: center;justify-content: center;
                                 border-radius: 50%; border: 1px solid #888;" class="collImg">
                                <img width="20" src="<%= ServletUtils.getProjectHttpUrl(request)%>/images/web_img/coll_not.png" />
                            </div>
                            <div style="width: 80px; height: 20px;
                                        display: flex; align-items: center;justify-content: center;" class="collText">
                                <p style="font-size: 12px">收藏文章</p>
                            </div>
                        </div>

                        <div style="display: flex; align-items: center;justify-content: center;
                                    flex-direction: column;" class="collDiv yesColl">
                            <div style="width: 30px; height: 30px; display: flex; align-items: center;justify-content: center;
                             border-radius: 50%; border: 1px solid #ff9900;" class="collImg">
                                <img width="20" src="<%= ServletUtils.getProjectHttpUrl(request)%>/images/web_img/coll_yes.png" />
                            </div>
                            <div style="width: 80px; height: 20px;
                                        display: flex; align-items: center;justify-content: center;" class="collText">
                                <p style="font-size: 12px; color: #ff9900">取消收藏</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="clear"></div>
        <div id="commentDiv">
            <div class="comment_head">
                <div class="head_text">文章评论</div>
                <div class="head_btn">
                    <button class="layui-btn layui-btn-normal layui-btn-sm" type="button" id="sendComment">发表评论</button>
                </div>
            </div>
            <!-- 循环渲染评价集合 -->
            <c:if test="${commentList != null && commentList.size() > 0}">
            <c:forEach items="${commentList}" var="item">
            <div class="comment_body">
                <div class="comment_detail">
                    <div class="detail_left" style="border: 1px solid #DDD; font-size: 10px; text-align: center; line-height: 50px">
                        <img src="${item.user.headImg}"  <c:if test="${item.user.headImg == null}">alt="暂无头像"</c:if>>
                    </div>
                    <div class="detail_right">
                        <div class="detail_right_top">
                            ${item.user.loginName}
                        </div>
                        <div class="detail_right_mid">
                            ${item.content}
                        </div>
                        <div class="detail_right_bottom">
                            <div class="left">
                                ${item.createDateFormat}
                            </div>
                            <div class="right">
                                <a href="javascript:;" class="sendCommentSub" data-comment="${item.id}">回复</a>
                            </div>
                        </div>
                    </div>
                </div>
                <c:if test="${item.subComments != null && item.subComments.size() > 0}">
                <c:forEach items="${item.subComments}" var="subItem">
                <div class="comment_reply">
                    <div class="reply_detail_left" style="border: 1px solid #DDD; font-size: 9px; text-align: center; line-height: 40px">
                        <img src="${subItem.user.headImg}" <c:if test="${subItem.user.headImg == null}">alt="暂无头像"</c:if>>
                    </div>
                    <div class="reply_detail_right">
                        <div class="reply_detail_right_top">
                            ${subItem.user.loginName}
                        </div>
                        <div class="reply_detail_right_mid">
                            ${subItem.content}
                        </div>
                        <div class="reply_detail_right_bottom">
                            <div class="left">
                                ${subItem.createDateFormat}
                            </div>
                        </div>
                    </div>
                </div>
                </c:forEach>
                </c:if>
            </div>
            </c:forEach>
            </c:if>
        </div>
    </div>
</div>
<div class="clear"></div>

<!-- 引入公共的底部部分 -->
<%@include file="footer.jsp" %>

</body>
<script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/webUtil.js"></script>
<script>
    layui.use(['layer'], function() {

        // 弹出层组件
        let layer = layui.layer
        // 是否已收藏的标识
        let collFlag = '${isColl}'

        if(collFlag == "1") {
            // 1 已收藏, 隐藏未收藏标签
            $(".noColl").hide()
            $(".yesColl").show()
        } else {
            // 0 未收藏
            $(".noColl").show()
            $(".yesColl").hide()
        }

        /**
         * 响应收藏按钮事件
         */
        $(".collImg, .collText").click(function() {
            if(!checkLogin('${sessionScope.webUser}')) {
                return;
            }
            let sendParam = {
                strategyId: $("input[name='strategyId']").val(),
                userId: $("input[name='userId']").val()
            }
            // 调用后台接口
            sendAjax("<%= ServletUtils.getProjectHttpUrl(request)%>web/member/collect/saveOrDelete", "POST", sendParam, (res) => {
                if(res.code == "200") {
                    layer.msg(res.msg, {
                        shade: .3
                        , icon: 6
                        , time: 1300
                        , end: () => {
                            // 更新页面状态
                            // 如果当前显示的是未收藏, 则将未收藏隐藏, 将已收藏显示
                            console.log($(".noColl").is(":visible"))
                            if($(".noColl").is(":visible")) {
                                $(".noColl").hide()
                                $(".yesColl").show()
                            } else {
                                $(".noColl").show()
                                $(".yesColl").hide()
                            }
                        }
                    });
                }
            })
        })

        /**
         * 响应评论按钮
         */
        $("#sendComment").click(function() {
            let check = checkLogin('${sessionScope.webUser}');
            if(!check) {
                return;
            }
            // 打开评论弹窗
            toWindow(getPath() + "/web/system/toAddCommentPage?strategyId=" + $("input[name='strategyId']").val()
                     , false, "450px", "350px", true)
        })

        /**
         * 响应回复按钮
         */
        $(".sendCommentSub").click(function() {
            let check = checkLogin('${sessionScope.webUser}');
            if(!check) {
                return;
            }
            // 获取要回复的评论ID
            let commentId = $(this).attr("data-comment");
            // 打开评论弹窗
            toWindow(getPath() + "/web/system/toAddCommentPage?commentId=" + commentId + "&strategyId=" + $("input[name='strategyId']").val()
                     , false, "450px", "350px", true)
        })
    })
</script>
</html>
