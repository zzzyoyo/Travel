<%@ page import="functionPackage.Require" %>
<%@ page import="domain.User" %><%--
  Created by IntelliJ IDEA.
  User: Zhangyuru
  Date: 2020/7/27
  Time: 14:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>Share Your Travel</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap-switch.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/highlight.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/docs.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/default.css">
</head>
<%
    //该页面需要登录
    if(!Require.requireLogin(request.getContextPath()+"/information.jsp",session,response,request)) return;
%>
<%
    User user = (User)session.getAttribute("userDetails");
%>
<body style="background-image: url(${pageContext.request.contextPath}/resources/image/background.jpg)">
<jsp:include page="/WEB-INF/jspFiles/navigation.jsp"></jsp:include>
<div class="panel panel-warning">
    <div class="panel-heading">
        <h3 class="panel-title">个人信息</h3>
    </div>
    <div class="panel-body">
        用户名：<%=user.getUsername()%>
        邮箱：<%=user.getEmail()%>
        是否公开收藏:<%=user.getState()%>
        <div class="bootstrap-switch bootstrap-switch-wrapper bootstrap-switch-id-switch-state bootstrap-switch-animate bootstrap-switch-on" style="width: 100px;">
            <div class="bootstrap-switch-container" style="width: 147px; margin-left: 0px;">
                <span class="bootstrap-switch-handle-on bootstrap-switch-primary" style="width: 49px;">ON</span>
                <span class="bootstrap-switch-label" style="width: 49px;">&nbsp;</span>
                <span class="bootstrap-switch-handle-off bootstrap-switch-default" style="width: 49px;">OFF</span>
                <input id="switch-state" type="checkbox" checked="">
            </div>
        </div>
        <div class="btn-group">
            <button type="button" data-switch-toggle="state" class="btn btn-default">Toggle</button>
            <button type="button" data-switch-set="state" data-switch-value="true" class="btn btn-default">Set true</button>
            <button type="button" data-switch-set="state" data-switch-value="false" class="btn btn-default">Set false</button>
            <button type="button" data-switch-get="state" class="btn btn-default">Get</button>
        </div>
    </div>
</div>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap-switch.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/highlight.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</body>
</html>
