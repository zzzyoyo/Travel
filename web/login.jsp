<%--
  Created by IntelliJ IDEA.
  User: Zhangyuru
  Date: 2020/7/18
  Time: 13:12
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
    <!-- Custom styles for this template -->
</head>
<%
    if(session.getAttribute("userDetails")!=null){
        //已经登陆
        response.sendRedirect(request.getContextPath());
    }
%>
<body style="background-image: url(${pageContext.request.contextPath}/resources/image/background.jpg)">
<jsp:include page="/WEB-INF/jspFiles/navigation.jsp"></jsp:include>
<div style="width: 50%;margin: auto">
    <p class="help-block" style="color: red">${requestScope.message}</p>
    <form action="<%=request.getContextPath()%>/login" method="post">
        <div class="form-group">
            <label for="exampleInputEmail1">Email address / Username</label>
            <input type="text" class="form-control" id="exampleInputEmail1" placeholder="邮箱/用户名" name="emailOrName" value="${param.emailOrName}" required>
        </div>
        <div class="form-group">
            <label for="exampleInputPassword1">Password</label>
            <input type="password" class="form-control" id="exampleInputPassword1" placeholder="密码" name="password" required>
        </div>
        <button type="submit" class="btn btn-default">登录</button>
        <a href="register.jsp"><p class="help-block">没有注册？点击此处注册<span class="glyphicon glyphicon-log-in" aria-hidden="true"></span></p></a>
    </form>
</div>


<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
</body>
</html>
