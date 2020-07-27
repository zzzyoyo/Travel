<%--
  Created by IntelliJ IDEA.
  User: Zhangyuru
  Date: 2020/7/27
  Time: 23:36
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
<div class="searchUser input-group">
    <input type="text" class="form-control" placeholder="Search for..." name="content">
    <span class="input-group-btn">
        <button class="btn btn-default" type="button">
            <span class="glyphicon glyphicon-search" aria-hidden="true"></span>Go!
        </button>
    </span>
</div>
<div class="friendList">
    <ul class="nav nav-tabs">
        <li role="presentation" class="active" onclick="showMyFriends()"><a href="#">我的好友</a></li>
        <li role="presentation" onclick="showMyInvitation()"><a href="#">我发出的邀请</a></li>
        <li role="presentation" onclick="showInviteMe()"><a href="#">我收到的邀请</a></li>
    </ul>
    <div class="list-group" id="myFriends">
        <a href="#" class="list-group-item active">
            我的好友
        </a>
        <a href="#" class="list-group-item">Dapibus ac facilisis in</a>
        <a href="#" class="list-group-item">Morbi leo risus</a>
        <a href="#" class="list-group-item">Porta ac consectetur ac</a>
        <a href="#" class="list-group-item">Vestibulum at eros</a>
        <a href="#" class="list-group-item">Dapibus ac facilisis in</a>
        <a href="#" class="list-group-item">Morbi leo risus</a>
        <a href="#" class="list-group-item">Porta ac consectetur ac</a>
        <a href="#" class="list-group-item">Vestibulum at eros</a>
    </div>
    <div class="list-group" id="inviteMe"  style="display: none">
        <a href="#" class="list-group-item active">
            我发出的邀请
        </a>
        <a href="#" class="list-group-item">Dapibus ac facilisis in</a>
        <a href="#" class="list-group-item">Morbi leo risus</a>
        <a href="#" class="list-group-item">Porta ac consectetur ac</a>
        <a href="#" class="list-group-item">Vestibulum at eros</a>
        <a href="#" class="list-group-item">Dapibus ac facilisis in</a>
        <a href="#" class="list-group-item">Morbi leo risus</a>
        <a href="#" class="list-group-item">Porta ac consectetur ac</a>
        <a href="#" class="list-group-item">Vestibulum at eros</a>
    </div>
    <div class="list-group" id="myInvitation" style="display: none">
        <a href="#" class="list-group-item active">
            我收到的邀请
        </a>
        <a href="#" class="list-group-item">Dapibus ac facilisis in</a>
        <a href="#" class="list-group-item">Morbi leo risus</a>
        <a href="#" class="list-group-item">Porta ac consectetur ac</a>
        <a href="#" class="list-group-item">Vestibulum at eros</a>
        <a href="#" class="list-group-item">Dapibus ac facilisis in</a>
        <a href="#" class="list-group-item">Morbi leo risus</a>
        <a href="#" class="list-group-item">Porta ac consectetur ac</a>
        <a href="#" class="list-group-item">Vestibulum at eros</a>
    </div>
</div>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
<script>
    function showMyFriends() {
        $("#myFriends").css("display","block");
        $("#myInvitation").css("display","none");
        $("#inviteMe").css("display","none");
    }
    function showMyInvitation() {
        $("#myInvitation").css("display","block");
        $("#myFriends").css("display","none");
        $("#inviteMe").css("display","none");
    }
    function showInviteMe() {
        $("#inviteMe").css("display","block");
        $("#myInvitation").css("display","none");
        $("#myFriends").css("display","none");
    }
    $("ul li").click(function () {
        $("ul li").removeClass("active");
        $(this).addClass("active");
    })
</script>
<style type="text/css">
    .friendList{
        border: 1px solid #00CCFF;
        margin: 20px;
        width: 350px;
    }
    .searchUser{
        width: 70%;
        margin: auto;
    }
</style>
</body>
</html>
