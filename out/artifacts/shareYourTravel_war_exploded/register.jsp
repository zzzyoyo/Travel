<%--
  Created by IntelliJ IDEA.
  User: Zhangyuru
  Date: 2020/7/18
  Time: 23:23
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
<jsp:include page="WEB-INF/jspFiles/navigation.jsp"></jsp:include>
<div style="width: 70%;margin: auto">
    <form class="form-horizontal">
        <div class="form-group">
            <label for="inputUsername3" class="col-sm-2 control-label">Username</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="inputUsername3" placeholder="请输入用户名">
            </div>
        </div>
        <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" id="inputEmail3" placeholder="请输入邮箱">
            </div>
        </div>
        <div class="form-group">
            <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
            <div class="col-sm-10">
                <input type="password" class="form-control" id="inputPassword3" placeholder="请输入密码">
            </div>
        </div>
        <div class="form-group">
            <label for="inputConfirm" class="col-sm-2 control-label">Confirm</label>
            <div class="col-sm-10">
                <input type="password" class="form-control" id="inputConfirm" placeholder="请再次输入密码">
            </div>
        </div>
        <div class="form-group">
            <label for="inputCaptcha" class="col-sm-2 control-label">Captcha</label>
            <div class="col-sm-10">
                <input type="password" class="form-control" id="inputCaptcha" placeholder="验证码">
                <img src="resources/image/5b8abc339a62b.jpg" style="width: 100px">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-default">注册</button>
            </div>
        </div>
    </form>
</div>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
</body>
</html>
