<%@ page import="priv.project.util.ServletUtils" %><%--
  Created by IntelliJ IDEA.
  User: byqs
  Date: 2020/7/16
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>内容注入</title>
    <link rel="stylesheet" href="<%= ServletUtils.getProjectHttpUrl(request)%>/css/font.css">
    <link rel="stylesheet" href="<%= ServletUtils.getProjectHttpUrl(request)%>/css/xadmin.css">
    <script src="<%= ServletUtils.getProjectHttpUrl(request)%>/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/xadmin.js"></script>
    <script type="text/javascript" src="<%= ServletUtils.getProjectHttpUrl(request)%>/js/MyLayuiUtils.js"></script>
    <style>
        .layui-form-item {
            margin-bottom: 0;
        }

        .layui-form-pane .layui-form-label {
            max-width: 100px;
        }

        .layui-form-item .layui-input-inline {
            width: 180px;
        }

        .layui-form-pane .layui-form-label {
            padding: 9px 15px;
        }

        .layui-form-select dl {
            max-height: 225px;
        }
        .layui-table-cell .layui-form-checkbox[lay-skin="primary"] {
            top: 5px;
        }
        .layui-table td, .layui-table th {
             min-width: 80px;
        }
    </style>
</head>

<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body " style="padding-bottom: 0;">
                    <form class="layui-form layui-col-space5 layui-form-pane" id="form">

                        <div class="layui-inline layui-show-xs-block layui-form-item">
                            <label class="layui-form-label">用户昵称</label>
                            <div class="layui-input-inline">
                                <input type="text" class="layui-input" name="loginName" placeholder="请输入">
                            </div>
                        </div>

                        <div class="layui-inline layui-show-xs-block layui-form-item">
                            <label class="layui-form-label">用户性别</label>
                            <div class="layui-input-inline">
                                <select name="sex">
                                    <option value="">请选择</option>
                                    <option value="0">女</option>
                                    <option value="1">男</option>
                                </select>
                            </div>
                        </div>

                        <div class="layui-inline layui-show-xs-block">
                            <input class="layui-btn layui-btn-normal layui-icon layui-btn-sm" type="button" id="searchBtn"  value="&#xe615;"/>
                            <input class="layui-btn layui-btn-normal layui-icon layui-btn-sm" type="reset" value="&#xe669;"/>
                        </div>
                    </form>
                </div>
                <div class="layui-card-body ">
                    <table id="listInfo" lay-filter="listInfo"></table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>

<script>
    layui.use(['table', 'form', 'laydate'],
        function () {
            var table = layui.table,
                layer = layui.layer,
                form = layui.form;

            // 初始调用表格加载方法
            loadFunction("<%= ServletUtils.getProjectHttpUrl(request)%>user/getPageList");

            /**
             * 绑定查询按钮
             */
            $("#searchBtn").click(function () {
                // 获取表单数据
                var sendData = $("#form").serialize();
                // 重新调用表格加载方法
                loadFunction("<%= ServletUtils.getProjectHttpUrl(request)%>user/getPageList?" + sendData)
            })

            /**
             * 加载表格方法
             * @param url
             */
            function loadFunction(url) {
                var index = layer.load(1, {shade: false}); //0代表加载的风格，支持0-2
                //第一个实例
                table.render({
                    elem: '#listInfo'
                    , height: 'full-125'
                    , url: url //数据接口
                    , toolbar: true
                    , defaultToolbar: ['filter', 'export']
                    , loading: false
                    , title: '用户信息'
                    , page: {
                        layout: ['limit', 'count', 'prev', 'page', 'next', 'skip', 'refresh'] //自定义分页布局
                        , groups: 5 //只显示 5 个连续页码
                        , theme: '#1E9FFF'
                    }
                    , limit: 20
                    , cols:
                        [
                            [ //表头
                                {type: 'numbers', title: '序号'}
                                , {field: 'id', title: 'id', hide: true}
                                , {field: 'userName', title: '用户名', width: '18.1%'}
                                , {field: 'loginName', title: '用户昵称', width: '18%'}
                                , {field: 'age', title: '用户年龄', width: '12%'}
                                , {field: 'sex', title: '用户性别', width: '12%', templet: "<div>{{d.sex == 0 ? '女' : '男'}}</div>"}
                                , {field: 'birthday', title: '用户生日', width: '17%'}
                                , {field: 'createDate', title: '注册时间', width: '17%'}
                            ]
                        ]
                    , done: function (res, curr, count) {
                        // 设置表格宽度100%
                        // $("table").css("width", "100%");
                        layer.close(index);
                    }
                });
            }
        });
</script>
</html>
