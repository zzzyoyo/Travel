<%@ page import="functionPackage.Require" %><%--
  Created by IntelliJ IDEA.
  User: Zhangyuru
  Date: 2020/7/21
  Time: 14:16
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
</head>
<body>
<%
    //该页面需要登录
    Require.requireLogin(request.getContextPath()+"/collection.jsp",session,response,request);
%>
<jsp:include page="WEB-INF/jspFiles/navigation.jsp"></jsp:include>
</body>
</html>
