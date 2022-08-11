<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<script src="<%= ServletUtils.getProjectHttpUrl(request)%>/lib/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/MyLayuiUtils.js"></script>
</head>
<style>
    .menuLink.on {
        color: #ffae00 !important;
    }
    .layui-form-pane .layui-input {
        width: 220px;
    }
    .layui-form-pane .layui-form-label {
        width: 120px;
    }
</style>
<script>
    if("${flag}" == "1") {
        layer.msg('登录失效！请重新登录！', {
            icon: 6,
            time: 1500,
            shade: .2,
            end: () => {
                top.location.href = "<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toLoginPage?backUrl=";
            }
        });
    }
</script>
<body style="background-color: #FFF;">
<form id="myform" action="" method="post" class="layui-form-pane layui-form"
      style="display: flex; align-items: center; justify-content: center">
    <div>
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
            <legend>我的头像</legend>
        </fieldset>
        <div class="layui-form-item" style="background-color: #FFF;">
            <div style="display: flex; justify-content: center; flex-direction: column">
                <div style="display: inline-block">
                    <div class="layui-upload-list" style="text-align: center">
                        <div style="text-align: center; line-height: 120px; width: 120px; overflow: hidden;
                             height: 120px; border-radius: 50%; border: 1px solid #CCC; margin: 0 auto">
                        <img class="layui-upload-img" id="demo1" src="${obj.headImg}"
                             <c:if test="${obj.headImg == null || obj.headImg == ''}">alt="暂无头像"</c:if> />
                        </div>
                        <input type="hidden" name="headImg" value="${obj.headImg}"/>
                    </div>
                </div>
                <div style="text-align: center">
                    <button type="button" class="layui-btn layui-btn-sm" id="test1">上传头像</button>
                </div>
            </div>
        </div>
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
            <legend>基本信息</legend>
        </fieldset>
        <div class="layui-form-item">
            <label class="layui-form-label" style="font-size: 14px">用户名</label>
            <div class="layui-input-inline" onmouseenter="tipsMini('用户名不可修改！', '#userNameDiv')" id="userNameDiv">
                <input type="text" name="userNameShow" lay-verify="required" placeholder="请输入"
                       autocomplete="off" class="layui-input" value="${obj.userName}" readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="font-size: 14px">昵称</label>
            <div class="layui-input-inline">
                <input type="text" name="loginName" lay-verify="required" value="${obj.loginName}"
                       placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="font-size: 14px">身份证号</label>
            <div class="layui-input-inline">
                <input type="text" name="idCard" lay-verify="required" placeholder="请输入"
                       autocomplete="off" class="layui-input" value="${obj.idCard}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="font-size: 14px">注册时间</label>
            <div class="layui-input-inline" onmouseenter="tipsMini('注册时间不可修改！', '#createDateDiv')" id="createDateDiv">
                <fmt:formatDate value="${obj.createDate}" var="createDate" pattern="yyyy-MM-dd HH:mm:ss"/>
                <input type="text" name="createDateShow" lay-verify="required" placeholder="请输入"
                       autocomplete="off" class="layui-input"
                       value="${createDate}" readonly>
            </div>
        </div>
        <div style="display: flex; justify-content: center">
            <input type="hidden" name="id" value="${obj.id}">
            <input type="button" value="保存修改" id="subBtn" class="layui-btn layui-btn-normal"/>
            <input type="button" value="修改密码" id="editPwd" class="layui-btn layui-btn-warm"/>
        </div>
    </div>
</form>

</body>
<script>
    layui.use(['layer', 'upload'], function() {
        var upload = layui.upload,
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
                layer.msg('上传中', {icon: 16, time: 0, shade: .2});
            }
            ,done: function(res){
                setTimeout(function() {
                    layer.closeAll()
                    //如果上传失败
                    if(res.code != 0){
                        return layer.msg(res.msg);
                    }
                    //上传成功的一些操作
                    // 将上传的图片信息保存在input标签中
                    $("input[name='headImg']").val(res.data.src);
                }, 1000)
            }
        });

        /**
         * 响应保存信息按钮
         */
        $("#subBtn").click(function () {
            // 数据校验
            let msg = verifyData();
            if(msg) {
                layer.open({
                    title: '错误消息'
                    , content:  msg
                    , shade: 0.3
                    , icon: 5
                    , anim: 6
                    , closeBtn: 0
                });
                return;
            }
            // 校验通过, 提交表单
            // 获取表单数据
            let dataArr = $("#myform").serializeArray();
            var jsonObj={};
            $(dataArr).each(function(){
                jsonObj[this.name] = this.value;
            });
            // 请求接口
            sendAjax("<%= ServletUtils.getProjectHttpUrl(request)%>user/saveOrUpdate",
                "POST",
                jsonObj,
                (res) => {
                    if(res.code == 200) {
                        layer.open({
                            title: '成功提示'
                            , content:  res.msg
                            , shade: 0.3
                            , icon: 6
                            , closeBtn: 0
                            , end: () => {
                                // 跳转到登录页
                                window.location.reload()
                            }
                        });
                    } else {
                        layer.open({
                            title: '错误消息'
                            , content:  res.msg
                            , shade: 0.3
                            , icon: 5
                            , anim: 6
                            , closeBtn: 0
                        });
                    }
                }
            )
        })

        /**
         * 响应修改密码按钮
         */
        $("#editPwd").click(function() {
            toWindow(getPath() + "/web/system/toUpdatePwdWindows", "修改密码", "400px", "300px", true, () => {
            });
        })

        /**
         * 验证数据是否填写完整
         */
        function verifyData() {
            let loginName = $("input[name='loginName']").val()
            let idCard = $("input[name='idCard']").val()
            if(!loginName) {
                return "用户昵称不能为空！"
            }
            if(!idCard) {
                return "身份证号不可为空！"
            }
            if(checkID(idCard)) {
                return checkID(idCard);
            }
        }
    })
</script>
</html>                      
