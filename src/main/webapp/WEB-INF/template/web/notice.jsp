<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        .layui-table, .layui-table-view {
            margin: 0 !important;
        }

        .layui-panel {
            border-color: #DDD !important;
        }
    </style>
</head>
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

<body style="background-color: #FFF; height: 650px">
    <div class="layui-row layui-col-space15">
        <c:choose>
            <c:when test="${noticeList != null && noticeList.size() > 0}">
                <c:forEach items="${noticeList}" var="item">
                    <div class="layui-col-md6">
                        <div class="layui-panel" style="padding: 15px">
                            <div style="display: flex; flex-direction: column">
                                <div style="font-size: 18px; font-width: 700;">
                                    系统通知
                                </div>
                                <div style="margin-top: 10px; display: flex; flex-direction: row; align-items: center">
                                    <div>您在 <span style="color: red;">${item.strategy.title}</span> 攻略中评价的内容有新回复啦！</div>
                                    <div style="margin-left: 30px">
                                        <a href="javascript:;"
                                           onclick="parent.window.location.href = '<%= ServletUtils.getProjectHttpUrl(request)%>web/system/toWebStrategyDetailPage?id=${item.strategyId}'"
                                           style="text-decoration: underline">去看看</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div style="display: flex; justify-content: center; align-items: center;
                            flex-direction: column; min-height: 550px; box-sizing: border-box;">
                    <div>
                        <span class="layui-icon" style="font-size: 60px; color: #888">&#xe656;</span>
                    </div>
                    <div style="font-size: 16px; font-weight: 500; color: #888">
                        暂无信息
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
<script>
    layui.use(['element'], function () {
        let element = layui.element
    })
</script>
</html>
