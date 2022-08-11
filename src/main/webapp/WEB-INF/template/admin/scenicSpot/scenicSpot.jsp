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
                            <label class="layui-form-label">景点名</label>
                            <div class="layui-input-inline">
                                <input type="text" class="layui-input" name="name" placeholder="请输入">
                            </div>
                        </div>

                        <div class="layui-inline layui-show-xs-block layui-form-item">
                            <label class="layui-form-label">景点类型</label>
                            <div class="layui-input-inline">
                                <input type="text" class="layui-input" name="scenicType.typeName" placeholder="请选择">
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
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm layui-icon layui-btn-normal" lay-event="add">&#xe654; 添加</button>
        <button class="layui-btn layui-btn-sm iconfont layui-btn-danger" lay-event="del">&#xe69d; 删除</button>
    </div>
</script>

<script id="operation" type="text/html">
    <a class="layui-btn layui-btn-xs layui-btn-warm" style="height: 26px;line-height: 28px;font-size: 13px; padding: 0 10px;" lay-event="edit">修改</a>
</script>

<script>
    layui.use(['table', 'form', 'laydate'],
        function () {
            var table = layui.table,
                layer = layui.layer,
                form = layui.form;

            // 初始调用表格加载方法
            loadFunction(getPath() + "/scenicSpot/getPageList");

            /**
             * 绑定查询按钮
             */
            $("#searchBtn").click(function () {
                // 获取表单数据
                var sendData = $("#form").serialize();
                // 重新调用表格加载方法
                loadFunction(getPath() + "/scenicSpot/getPageList?" + sendData)
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
                    , toolbar: '#toolbarDemo'
                    , defaultToolbar: ['filter', 'export']
                    , loading: false
                    , title: '商品信息'
                    , page: {
                        layout: ['limit', 'count', 'prev', 'page', 'next', 'skip', 'refresh'] //自定义分页布局
                        , groups: 5 //只显示 5 个连续页码
                        , theme: '#1E9FFF'
                    }
                    , cellMinWidth: 60
                    , limit: 20
                    , cols:
                        [
                            [ //表头
                                {type: 'checkbox'}
                                , {type: 'numbers', title: '序号'}
                                , {field: 'id', title: 'id', hide: true}
                                , {field: 'name', title: '景区名称', width: '14%'}
                                , {field: 'typeName', title: '景区类型', width: '10%', templet: '<div>{{d.scenicType.typeName}}</div>'}
                                , {field: 'areaName', title: '所属城市', width: '10%', templet: '<div>{{d.area.areaName}}</div>'}
                                , {field: 'isRed', title: '红色景区', width: '8%', templet: '<div>{{d.isRed == "0" ? "否" : "是"}}</div>'}
                                , {field: 'isIndex', title: '首页推荐', width: '8%', templet: '<div>{{d.isIndex == "0" ? "否" : "是"}}</div>'}
                                , {field: 'businessStartDate', title: '开始时间', width: '9%'}
                                , {field: 'businessEndDate', title: '结束时间', width: '9%'}
                                , {field: 'price', title: '票价', width: '10%', templet: '<div>¥{{d.price}}</div>'}
                                , {field: '操作', title: '操作', templet: '#operation', width: '10.1%'}
                            ]
                        ]
                    , done: function (res, curr, count) {
                        // 设置表格宽度100%
                        $("table").css("width", "100%");
                        layer.close(index);
                    }
                });
            }

            //行内工具条
            table.on('tool(listInfo)', function(obj){
                switch(obj.event){
                    // 修改按钮
                    case 'edit':
                        // 获取本条信息的数据
                        var id = obj.data.id;
                        // 跳转到修改页面
                        toWindow(getPath() + "/scenicSpot/toEditWindow?id=" + id, "修改信息", "730px", "600px", true);
                        break;
                }
            });

            //头工具栏事件
            table.on('toolbar(listInfo)', function (obj) {
                var checkStatus = table.checkStatus(obj.config.id);
                var data = checkStatus.data;
                //获取选中行
                var selectCount = data.length;
                //data是选中的所有数据，得到的是一个数组，将这个数组传入getIds方法进行处理
                var dataId = getIds(data) + "";
                switch (obj.event) {
                    case 'add':
                        // 跳转到新增页面
                        toWindow(getPath() + "/scenicSpot/toAddWindow", "新增信息", "730px", "600px", true);
                        break;
                    // 删除
                    case 'del':
                        // 参数分别表示：选中的数据， 请求方式， 请求地址， 提示消息（默认提示删除）， 提示显示的icon（默认显示删除）， 是否使用JSON对象传递参数
                        promptRequest(selectCount, "GET", getPath() + "/scenicSpot/deleteInfo?ids=" + dataId, null, null, false);
                        break;
                }
            });
        });
</script>
</html>
