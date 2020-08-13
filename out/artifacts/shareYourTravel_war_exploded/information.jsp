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
    <!--alert-->
    <link href="${pageContext.request.contextPath}/resources/css/alert.css" rel="stylesheet">
</head>
<%--
    //该页面需要登录
    if(!Require.requireLogin(request.getContextPath()+"/information.jsp",session,response,request)) return;
--%>
<%
    User user = (User)session.getAttribute("userDetails");
%>
<body style="background-image: url(${pageContext.request.contextPath}/resources/image/background.jpg)">
<jsp:include page="/WEB-INF/jspFiles/navigation.jsp"></jsp:include>
<div class="panel panel-warning myPanel">
    <div class="panel-heading">
        <h3 class="panel-title">个人信息</h3>
    </div>
    <div class="panel-body">
        <strong>用户名：</strong><%=user.getUsername()%><br>
        <strong>邮箱：</strong><%=user.getEmail()%><br>
        <strong>是否公开收藏:</strong><input type="radio" name="state" value="1">是<input type="radio" name="state" value="0">否
    </div>
</div>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
<!--自定义alert-->
<script src="${pageContext.request.contextPath}/resources/js/alert.js"></script>
<script>
    //initiate
    $(":radio[name='state'][value='" + <%=user.getState()%> + "']").prop("checked", "checked");
    $(":radio[name='state']").change(function () {
        $.ajax({
            url:"${pageContext.request.contextPath}/changeState",
            data:{
                state:this.value,
                uid:<%=user.getUid()%>
            },
            success(data){
                if(data.indexOf('success') !== -1){
                    alertSuccess("修改成功");
                }
            }
        })
    })
</script>
<style>
    .myPanel{
        width: 30%;
        margin: auto;
        font-size: large;
    }
</style>
</body>
</html>
