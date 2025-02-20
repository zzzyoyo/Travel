<%@ page import="domain.User" %><%--
  Created by IntelliJ IDEA.
  User: Zhangyuru
  Date: 2020/7/18
  Time: 10:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%--JSTL 核心标签--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
</head>
<body>
<%
    User user = (User) session.getAttribute("userDetails");
%>
<div id="navigation">
    <nav class="navbar navbar-default">
        <div class="container-fluid" style="background: black">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <img alt="Brand" src="${pageContext.request.contextPath}/resources/image/logo.PNG" width="50px">
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="${pageContext.request.contextPath}"><span class="glyphicon glyphicon-home" aria-hidden="true"></span>首页</a></li>
                    <li><a href="${pageContext.request.contextPath}/search.jsp"><span class="glyphicon glyphicon-search" aria-hidden="true"></span>搜索</a></li>
                    <c:choose>
                        <c:when test='<%=user!=null%>'>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                    <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                    <%=user.getUsername()%>
                                    <span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a href="${pageContext.request.contextPath}/information.jsp"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span>个人信息</a></li>
                                    <li><a href="${pageContext.request.contextPath}/collection.jsp"><span class="glyphicon glyphicon-star" aria-hidden="true"></span>我的收藏</a></li>
                                    <li><a href="${pageContext.request.contextPath}/update.jsp"><span class="glyphicon glyphicon-upload" aria-hidden="true"></span>上传图片</a></li>
                                    <li><a href="${pageContext.request.contextPath}/photos.jsp"><span class="glyphicon glyphicon-picture" aria-hidden="true"></span>我的图片</a></li>
                                    <li><a href="${pageContext.request.contextPath}/friends.jsp"><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span>我的好友</a></li>
                                    <li role="separator" class="divider"></li>
                                    <li><a href="${pageContext.request.contextPath}/logout"><span class="glyphicon glyphicon-log-out" aria-hidden="true"></span>退出登录</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${pageContext.request.contextPath}/login.jsp"><span class="glyphicon glyphicon-log-in" aria-hidden="true"></span>未登录</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
</div>
</body>
</html>
