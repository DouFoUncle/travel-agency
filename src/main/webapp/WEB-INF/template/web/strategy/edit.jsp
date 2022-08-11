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
        <div class="layui-form-item">
            <label class="layui-form-label">攻略标题</label>
            <div class="layui-input-block">
                <input type="text" name="title" lay-verify="title" value="${obj.title}"
                       autocomplete="off" placeholder="请输入" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="background-color: #FFF">
            <div class="layui-card-header">攻略展示图</div>
            <div class="layui-card-body">
                <button type="button" class="layui-btn" id="test1">上传图片</button>
                <div style="">
                    <div class="layui-upload-list">
                        <img class="layui-upload-img"
                             src="${obj.indexImg}"
                             id="demo1" width="150" height="150">
                        <p id="demoText"></p>
                        <input type="hidden" name="indexImg" value="${obj.indexImg}"/>
                    </div>
                    <div style="width: 120px;">
                        <div class="layui-progress layui-progress-big" lay-showpercent="yes" lay-filter="demo">
                            <div class="layui-progress-bar" lay-percent=""></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">攻略简述</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入内容" name="resume" class="layui-textarea"
                          style="resize: none; height: 130px">${obj.resume}</textarea>
            </div>
        </div>
        <div class="layui-form-item layui-form-text" style="background-color: #FFF;">
            <div class="layui-card-header">攻略详情</div>
            <div class="layui-card-body">
                <textarea id="content" style="display: none;">${obj.content}</textarea>
            </div>
        </div>
        <div>
            <input type="hidden" name="id" value="${obj.id}">
            <input type="button" value="提交信息" id="subBtn" class="layui-btn layui-btn-normal"/>
        </div>
    </form>
</div>
<script type="text/javascript">
    layui.use(['upload', 'form', 'laydate', 'layedit'], function () {
        var upload = layui.upload,
            laydate = layui.laydate,
            layer = layui.layer,
            layedit = layui.layedit;

        //常规使用 - 普通图片上传
        var uploadInst = upload.render({
            elem: '#test1'
            ,url: getPath() + '/public/uploadImages' //接口url
            ,acceptMime: 'image/*'
            ,before: function(obj){
                //预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
                element.progress('demo', '0%'); //进度条复位
                layer.msg('上传中', {icon: 16, time: 0});
            }
            ,done: function(res){
                //如果上传失败
                if(res.code != 0){
                    return layer.msg(res.msg);
                }
                //上传成功的一些操作
                $('#demoText').html(''); //置空上传失败的状态
                // 将上传的图片信息保存在input标签中
                $("input[name='indexImg']").val(res.data.src);
            }
            ,error: function(){
                //失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            }
            //进度条
            ,progress: function(n, elem, e){
                console.log(n)
                element.progress('demo', n + '%'); //可配合 layui 进度条元素使用
                if(n == 100){
                    layer.msg('上传完毕', {icon: 1});
                }
            }
        });

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
            // 保存攻略内容
            jsonObj.content = layedit.getContent(editIndex);
            sendJsonObjRequest("POST", getPath() + "/web/member/strategy/saveOrUpdate", jsonObj, true);
        })

        /**
         * 验证表单数据
         * @returns {string}
         */
        function verifyInput() {
            // 获取字段信息
            let title = $("input[name='title']").val();
            let resume = $("textarea[name='resume']").val();
            // 攻略内容
            let content = layedit.getContent(editIndex)
            if(!title || !content || !resume) {
                return "请填写所有必填数据!";
            }
        }
    })
</script>
</body>
</html>