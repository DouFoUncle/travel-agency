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
            border: 1px solid #CCC;
            object-fit: contain;
        }
        .layui-anim.layui-anim-upbit {
            max-height: 200px;
        }
    </style>
</head>
<body>
<div style="padding: 15px;">
    <form id="myform" action="" method="post" class="layui-form-pane layui-form">
        <div class="layui-inline layui-show-xs-block layui-form-item">
            <label class="layui-form-label">所属省份</label>
            <div class="layui-input-inline">
                <select name="provinceId">
                    <option value="">请选择</option>
                    <c:forEach items="${areaList}" var="item">
                        <option value="${item.id}">${item.areaName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="layui-inline layui-show-xs-block layui-form-item">
            <label class="layui-form-label">区划名称</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="areaName" placeholder="请输入">
            </div>
        </div>

        <div style="position: absolute; bottom: 15px; left: 15px">
            <input type="hidden" class="layui-input" name="isParent" value="0">
            <input type="button" value="提交信息" id="subBtn" class="layui-btn layui-btn-normal"/>
        </div>
    </form>
</div>
<script>
    layui.use(['upload', 'form'], function () {
        var layer = layui.layer;

        /**
         * 响应提交按钮
         */
        $("#subBtn").click(function() {
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
            sendJsonObjRequest("POST", "saveOrUpdate", jsonObj, true);
        })

        /**
         * 验证表单数据
         * @returns {string}
         */
        function verifyInput() {
            // 获取字段信息
            let areaName = $("input[name='areaName']").val();
            let provinceId = $("select[name='provinceId']").val();
            if(!areaName || !provinceId) {
                return "请认真填写所有数据!";
            }
        }
    })
</script>
</body>
</html>