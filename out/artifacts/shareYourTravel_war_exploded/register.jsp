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
    <!-- bootstrapValidator -->
    <link href="https://cdn.bootcdn.net/ajax/libs/bootstrap-validator/0.5.3/css/bootstrapValidator.min.css" rel="stylesheet">
</head>
<body style="background-image: url(${pageContext.request.contextPath}/resources/image/background.jpg)">
<jsp:include page="/WEB-INF/jspFiles/navigation.jsp"></jsp:include>
<div style="width: 70%;margin: auto">
    <form class="form-horizontal" action="${pageContext.request.contextPath}/register" method="post">
        <div class="form-group">
            <label for="inputUsername3" class="col-sm-2 control-label">Username</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="inputUsername3" placeholder="请输入用户名" name="username">
            </div>
        </div>
        <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" id="inputEmail3" placeholder="请输入邮箱" name="email" >
            </div>
        </div>
        <div class="form-group">
            <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
            <div class="col-sm-10">
                <input type="password" class="form-control" id="inputPassword3" placeholder="请输入密码" name="password" required>
            </div>
        </div>
        <div class="form-group">
            <label for="inputConfirm" class="col-sm-2 control-label">Confirm</label>
            <div class="col-sm-10">
                <input type="password" class="form-control" id="inputConfirm" placeholder="请再次输入密码" name="confirmPassword">
            </div>
        </div>
        <div class="form-group">
            <label for="inputCaptcha" class="col-sm-2 control-label">Captcha</label>
            <div class="col-sm-10">
                <input type="password" class="form-control" id="inputCaptcha" placeholder="验证码" name="captcha">
                <img src="${pageContext.request.contextPath}/drawImage" onclick="changeImg()" id="validateCodeImg">
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
<!--表单验证插件-->
<script src="https://cdn.bootcdn.net/ajax/libs/bootstrap-validator/0.5.3/js/bootstrapValidator.min.js"></script>

<script>
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
            username: {
                message: '用户名验证失败',
                validators: {
                    notEmpty: {
                        message: '用户名不能为空'
                    },
                    stringLength: {  //长度限制
                        min: 4,
                        max: 15,
                        message: '用户名长度必须在4到15位之间'
                    },
                    remote: {   //后台验证，比如查询用户名是否存在
                        url: 'usernameUsed',
                        message: '此用户名已存在'
                    }
                }
            },
            email: {
                validators: {
                    notEmpty: {
                        message: '邮箱地址不能为空'
                    },
                    emailAddress: {
                        message: '邮箱地址格式有误'
                    }
                }
            },
            password:{
                validators:{
                    different: {  //比较
                        field: 'username', //需要进行比较的input name值
                        message: '密码不能与用户名相同'
                    },
                    notEmpty: {
                        message: '密码不能为空'
                    },
                    stringLength: {  //长度限制
                        min: 6,
                        max: 12,
                        message: '用户名长度必须在6到12位之间'
                    },
                    regexp: { //正则表达式
                        regexp: /^(((?=.*[0-9])(?=.*[a-zA-Z])|(?=.*[0-9])(?=.*[^\s0-9a-zA-Z])|(?=.*[a-zA-Z])(?=.*[^\s0-9a-zA-Z]))[^\s]+)$/,
                        message: '密码太弱，至少包含字母、数字和下划线的两种'
                    }
                }
            },
            confirmPassword:{
                validators:{
                    identical: {  //比较是否相同
                        field: 'password',  //需要进行比较的input name值
                        message: '两次密码不一致'
                    },
                    notEmpty: {
                        message: '确认密码不能为空'
                    }
                }
            },
            captcha:{
                validators:{
                    notEmpty: {
                        message: '验证码不能为空'
                    },
                    remote: {
                        url:'checkCode',
                        message:'验证码错误'
                    }
                }
            }
        }
    });
</script>
</body>
</html>
