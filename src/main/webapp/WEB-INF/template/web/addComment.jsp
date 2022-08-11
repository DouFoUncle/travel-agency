<%@ page import="priv.project.util.ServletUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="<%= ServletUtils.getProjectHttpUrl(request)%>/css/font.css">
    <link rel="stylesheet" href="<%= ServletUtils.getProjectHttpUrl(request)%>/css/xadmin.css">
    <script src="<%= ServletUtils.getProjectHttpUrl(request)%>/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/xadmin.js"></script>
    <script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/MyLayuiUtils.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script>
        // 是否开启刷新记忆tab功能
        // var is_remember = false;
    </script>
    <style>
        .layui-upload-img {
            width: 120px;
            height: 120px;
            margin: 0 10px 10px 0;
            object-fit: contain;
        }
        .layui-form-item .layui-input-inline {
            float: left;
            width: 220px;
            margin-right: 10px;
        }
        .layui-anim.layui-anim-upbit {
            max-height: 200px;
        }
    </style>
</head>
<body>
<div style="padding: 15px;">
    <form id="myform" action="" method="post" class="layui-form-pane layui-form">

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">评价内容</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入内容" name="content" class="layui-textarea" style="resize: none; height: 220px"></textarea>
            </div>
        </div>

        <div>
            <input type="hidden" value="${sessionScope.webUser.id}" name="userId">
            <input type="hidden" value="${strategyId}" name="strategyId">
            <input type="hidden" value="${commentId}" name="commentId">
            <input type="button" value="提交信息" id="subBtn" class="layui-btn layui-btn-normal layui-btn-sm"/>
        </div>
    </form>
</div>
<script type="text/javascript">
    layui.use(['upload', 'form', 'laydate', 'layedit'], function () {
        var upload = layui.upload,
            laydate = layui.laydate,
            layer = layui.layer,
            layedit = layui.layedit;

        /**
         * 响应提交按钮
         */
        $("#subBtn").click(function() {
            console.log();
            // 验证数据
            let verifyResult = verifyInput();
            if(verifyResult) {
                layer.open({
                    title: '错误消息'
                    , content:  verifyResult
                    , shade: 0.1
                    , icon: 5
                    , anim: 6
                    , closeBtn: 0
                });
                return;
            }
            // 发起请求
            let dataArr = $("#myform").serializeArray();
            var jsonObj={};
            $(dataArr).each(function(){
                jsonObj[this.name] = this.value;
            });
            sendJsonObjRequest("POST", getPath() + "/web/member/comment/saveInfo", jsonObj, true);
        })

        /**
         * 验证表单数据
         * @returns {string}
         */
        function verifyInput() {
            // 获取字段信息
            let content = $("textarea[name='content']").val();
            if(!content) {
                return "请填写所有必填数据!";
            }
        }
    })
</script>
</body>
</html>