<%--
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
    <title>Navigation</title>
</head>
<body>
<div id="navigation">
    <nav class="navbar navbar-default">
        <div class="container-fluid" style="background: black">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <img alt="Brand" src="${pageContext.request.contextPath}/resources/image/logo.PNG">
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#">首页</a></li>
                    <li><a href="#">搜索</a></li>
                    <c:choose>
                        <c:when test='${sessionScope.get("userDetails")!=null}'>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%="ZYR"%>> <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#">我的收藏</a></li>
                                    <li><a href="#">上传图片</a></li>
                                    <li><a href="#">我的图片</a></li>
                                    <li><a href="#">我的好友</a></li>
                                    <li role="separator" class="divider"></li>
                                    <li><a href="#">退出登录</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="login.jsp">未登录</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
</div>
</body>
</html>
