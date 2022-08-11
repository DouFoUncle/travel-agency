<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    <script src="../lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/xadmin.js"></script>
    <script type="text/javascript" src="../js/MyLayuiUtils.js"></script>
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
        <div class="layui-form-item">
            <label class="layui-form-label">攻略标题</label>
            <div class="layui-input-block">
                <input type="text" name="title" lay-verify="title" readonly value="${obj.title}"
                       autocomplete="off" placeholder="请输入" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="background-color: #FFF">
            <div class="layui-card-header">攻略展示图</div>
            <div class="layui-card-body">
                <div style="">
                    <div class="layui-upload-list">
                        <img src="${obj.indexImg}"
                             <c:if test="${obj.indexImg == null or obj.indexImg == ''}">alt="'暂无头像'"</c:if>
                             width="115px" height="115px">
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">攻略简述</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入内容" name="resume" class="layui-textarea"
                          style="resize: none; height: 130px" readonly>${obj.resume}</textarea>
            </div>
        </div>
        <div class="layui-form-item layui-form-text" style="background-color: #FFF;">
            <div class="layui-card-header">攻略详情</div>
            <div class="layui-card-body">
                ${obj.content}
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
    layui.use(['upload', 'form', 'laydate', 'layedit'], function () {
        var upload = layui.upload,
            laydate = layui.laydate,
            layer = layui.layer,
            layedit = layui.layedit;

        // 设置编辑器上传图片的接口
        layedit.set({
            uploadImage: {
                url: getPath() + '/public/uploadImages' //接口url
                ,type: 'post' //默认post
            }
        });

        // 初始化编辑器
        let editIndex = layedit.build('content', {
            height: 360
        }); //建立编辑器

    })
</script>
</body>
</html>