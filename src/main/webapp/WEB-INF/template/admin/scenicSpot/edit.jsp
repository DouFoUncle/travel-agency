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
            <label class="layui-form-label" style="font-size: 14px">景区名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name" value="${obj.name}" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>

            <label class="layui-form-label" style="font-size: 14px">票价</label>
            <div class="layui-input-inline">
                <input type="text" name="price" value="${obj.price}" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="font-size: 14px">景区类型</label>
            <div class="layui-input-inline">
                <select name="typeId" autocomplete="off">
                    <option value="">请选择</option>
                    <c:forEach var="item" items="${typeList}">
                        <option value="${item.id}"
                                <c:if test="${obj.typeId eq item.id}">selected</c:if>>${item.typeName}</option>
                    </c:forEach>
                </select>
            </div>

            <label class="layui-form-label" style="font-size: 14px">所属区域</label>
            <div class="layui-input-inline">
                <select name="areaId" autocomplete="off">
                    <option value="">请选择</option>
                    <c:forEach var="item" items="${areaList}">
                        <option value="${item.id}"
                                <c:if test="${obj.areaId eq item.id}">selected</c:if>>${item.areaName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="font-size: 14px">开始时间</label>
            <div class="layui-input-inline">
                <input type="text" name="businessStartDate" id="businessStartDate" value="${obj.businessStartDate}"
                       lay-verify="required" placeholder="请选择" autocomplete="off" class="layui-input">
            </div>

            <label class="layui-form-label" style="font-size: 14px">结束时间</label>
            <div class="layui-input-inline">
                <input type="text" name="businessEndDate" id="businessEndDate" value="${obj.businessEndDate}"
                       lay-verify="required" placeholder="请选择" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="font-size: 14px">红色景区</label>
            <div class="layui-input-inline">
                <input type="radio" name="isRed" title="是" value="1" <c:if test="${obj.isRed eq '1'}">checked</c:if>
                       lay-verify="required" autocomplete="off" class="layui-input">
                <input type="radio" name="isRed" title="否" value="0" <c:if test="${obj.isRed eq '0'}">checked</c:if>
                       lay-verify="required" autocomplete="off" class="layui-input">
            </div>

            <label class="layui-form-label" style="font-size: 14px">首页推荐</label>
            <div class="layui-input-inline">
                <input type="radio" name="isIndex" title="是" value="1" <c:if test="${obj.isIndex eq '1'}">checked</c:if>
                       lay-verify="required" autocomplete="off" class="layui-input">
                <input type="radio" name="isIndex" title="否" value="0" <c:if test="${obj.isIndex eq '0'}">checked</c:if>
                       lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="font-size: 14px">搜索关键字</label>
            <div class="layui-input-block">
                <input type="text" name="searchKeyword" value="${obj.searchKeyword}" lay-verify="required" placeholder="例如：山;五岳(多个用;英文分号隔开)" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="font-size: 14px">购票地址</label>
            <div class="layui-input-block">
                <input type="text" name="skipUrl" lay-verify="required" value="${obj.skipUrl}" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="background-color: #FFF">
            <div class="layui-card-header">景区图</div>
            <div class="layui-card-body">
                <button type="button" class="layui-btn" id="test1">上传图片</button>
                <div style="">
                    <div class="layui-upload-list">
                        <img class="layui-upload-img"
                             src="${obj.headImg}"
                             style="border: 1px solid #DDD; width: 200px; height: 130px"
                             <c:if test="${obj.headImg == null || obj.headImg == ''}">alt="暂无图片"</c:if>
                             id="demo1" width="150" height="150">
                        <p id="demoText"></p>
                        <input type="hidden" name="headImg" value="${obj.headImg}"/>
                    </div>
                    <div style="width: 200px;">
                        <div class="layui-progress layui-progress-big" lay-showpercent="yes" lay-filter="demo">
                            <div class="layui-progress-bar" lay-percent=""></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">景区描述</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入" autocomplete="off"
                          class="layui-textarea" name="readme" style="height: 80px; resize: none">${obj.readme}</textarea>
            </div>
        </div>
        <div>
            <input type="hidden" value="${obj.id}" name="id">
            <input type="button" value="提交信息" id="subBtn" class="layui-btn layui-btn-normal"/>
        </div>
    </form>
</div>
<script type="text/javascript">
    layui.use(['upload', 'form', 'laydate'], function () {
        var upload = layui.upload,
            laydate = layui.laydate,
            layer = layui.layer;

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
                $("input[name='headImg']").val(res.data.src);
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

        //时间选择器
        laydate.render({
            elem: '#businessStartDate'
            ,type: 'time'
            ,format: 'HH:mm:ss'
        });

        //时间选择器
        laydate.render({
            elem: '#businessEndDate'
            ,type: 'time'
            ,format: 'HH:mm:ss'
        });

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
            console.log(jsonObj);
            sendJsonObjRequest("POST", "saveOrUpdate", jsonObj, true);
        })

        /**
         * 验证表单数据
         * @returns {string}
         */
        function verifyInput() {
            // 获取字段信息
            let name = $("input[name='name']").val();
            let typeId = $("select[name='typeId']").val();
            let areaId = $("select[name='areaId']").val();
            let price = $("input[name='price']").val();
            let searchKeyword = $("input[name='searchKeyword']").val();
            let skipUrl = $("input[name='skipUrl']").val();
            let businessStartDate = $("input[name='businessStartDate']").val();
            let businessEndDate = $("input[name='businessEndDate']").val();
            if(!name || !typeId || !areaId || !skipUrl
                || !searchKeyword || !businessStartDate || !businessEndDate) {
                return "请填写所有必填数据!";
            }
            if(checkNumber(price, true)) {
                return checkNumber(price, true);
            }
        }
    })
</script>
</body>
</html>