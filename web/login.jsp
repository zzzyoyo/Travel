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
    <form action="<%=request.getContextPath()%>/login" method="post" onsubmit="encrypt()">
        <div class="form-group">
            <label for="exampleInputEmail1">Email address / Username</label>
            <input type="text" class="form-control" id="exampleInputEmail1" placeholder="邮箱/用户名" name="emailOrName" value="${param.emailOrName}" required>
        </div>
        <div class="form-group">
            <label for="exampleInputPassword1">Password</label>
            <input type="password" class="form-control" id="exampleInputPassword1" placeholder="密码" required name="cleartextPassword">
        </div>
        <input type="hidden" name="password" id="md5password">
        <div class="form-group">
            <label for="inputCaptcha">Captcha</label>
            <input type="password" class="form-control" id="inputCaptcha" placeholder="验证码" name="captcha">
            <img src="${pageContext.request.contextPath}/drawImage" onclick="changeImg()" id="validateCodeImg">
        </div>
        <button type="submit" class="btn btn-default">登录</button>
        <a href="${pageContext.request.contextPath}/register.jsp"><p class="help-block">没有注册？点击此处注册<span class="glyphicon glyphicon-log-in" aria-hidden="true"></span></p></a>
    </form>
</div>


<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
<!-- MD5加密代码 -->
<script src="resources/js/md5.js"></script>
<!--表单验证插件-->
<script src="https://cdn.bootcdn.net/ajax/libs/bootstrap-validator/0.5.3/js/bootstrapValidator.min.js"></script>
<script>
    function encrypt() {
        $("#md5password").val(hex_md5($("#exampleInputPassword1").val()));
    }
    function changeImg(){
        document.getElementById("validateCodeImg").src="${pageContext.request.contextPath}/drawImage?"+Math.random();//为了防止缓存必须采用不同的url
    }
    $('form').bootstrapValidator({
        // 默认的提示消息
        message: 'This value is not valid',
        // 表单框里右侧的icon
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            emailOrName: {
                message: '用户名验证失败',
                validators: {
                    notEmpty: {
                        message: '用户名不能为空'
                    }
                }
            },
            cleartextPassword: {
                message: '密码验证失败',
                validators: {
                    notEmpty: {
                        message: '密码不能为空'
                    }
                }
            },
            captcha:{
                validators:{
                    notEmpty: {
                        message: '验证码不能为空'
                    },
                    remote: {
                        url:'${pageContext.request.contextPath}/checkCode.validate',
                        type:'POST',
                        message:'验证码错误'
                    }
                }
            }
        }
    });
</script>
</body>
</html>
