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
            max-width: 120px;
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

<body style="background-color: #FFF; height: 650px">
<div class="layui-fluid" style="padding: 0px">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body " style="padding: 0">
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
    <a class="layui-btn layui-btn-xs" style="height: 26px;line-height: 28px;font-size: 13px; padding: 0 10px;" lay-event="find">查看</a>
    <a class="layui-btn layui-btn-xs layui-btn-warm" style="height: 26px;line-height: 28px;font-size: 13px; padding: 0 10px;" lay-event="edit">修改</a>
</script>


<script>
    layui.use(['table', 'form', 'laydate'],
        function () {
            var table = layui.table,
                layer = layui.layer,
                form = layui.form;

            // 初始调用表格加载方法
            loadFunction(getPath() + "/web/member/strategy/getPageList");

            /**
             * 绑定查询按钮
             */
            $("#searchBtn").click(function () {
                // 获取表单数据
                var sendData = $("#form").serialize();
                // 重新调用表格加载方法
                loadFunction(getPath() + "/web/member/strategy/getPageList?" + sendData)
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
                    , height: 'full'
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
                                , {field: 'name', title: '发布人', width: '15%', templet: '<div>{{d.user.loginName}}</div>'}
                                , {field: 'name', title: '发布人类型', width: '15%', templet: '<div>{{d.userType == "1" ? "管理员发布" : "用户发布"}}</div>'}
                                , {field: 'title', title: '攻略标题', width: '14.5%'}
                                , {field: 'createDate', title: '发布时间', width: '14%'}
                                , {field: '操作', title: '操作', templet: '#operation', width: '17.5%'}
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
                let id = obj.data.id
                switch(obj.event){
                    // 查看详情
                    case 'find':
                        // 打开查看详情弹窗
                        toWindow(getPath() + "/web/system/toFindWindow?id=" + id, "查看信息", "730px", "610px", true);
                        break;
                    // 修改
                    case 'edit':
                        // 打开修改弹窗
                        toWindow(getPath() + "/web/system/toEditWindow?id=" + id, "修改信息", "730px", "610px", true);
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
                        toWindow(getPath() + "/web/system/toAddWindow", "新增信息", "730px", "610px", true);
                        break;
                    // 删除
                    case 'del':
                        // 参数分别表示：选中的数据， 请求方式， 请求地址， 提示消息（默认提示删除）， 提示显示的icon（默认显示删除）， 是否使用JSON对象传递参数
                        promptRequest(selectCount, "GET", getPath() + "/web/member/strategy/deleteInfo?ids=" + dataId, null, null, false);
                        break;
                }
            });
        });
</script>
</html>
