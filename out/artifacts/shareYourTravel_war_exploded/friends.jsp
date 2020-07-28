<%@ page import="functionPackage.Require" %>
<%@ page import="domain.User" %><%--
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
    <!-- alert css -->
    <link href="${pageContext.request.contextPath}/resources/css/alert.css" rel="stylesheet">
</head>
<%
    //该页面需要登录
    if(!Require.requireLogin(request.getContextPath()+"/friends.jsp",session,response,request)) return;
%>
<%
    User user = (User)session.getAttribute("userDetails");
%>
<body style="background-image: url(${pageContext.request.contextPath}/resources/image/background.jpg)">
<jsp:include page="/WEB-INF/jspFiles/navigation.jsp"></jsp:include>
<div class="friendList">
    <ul class="nav nav-tabs">
        <li role="presentation" class="active" onclick="showMyFriends()"><a href="#">我的好友</a></li>
        <li role="presentation" onclick="showMyInvitation()"><a href="#">我的邀请</a></li>
        <li role="presentation" onclick="showInviteMe()"><a href="#">邀请我的</a></li>
    </ul>
    <div class="list-group pre-scrollable" id="myFriends">
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
    <div class="list-group pre-scrollable" id="inviteMe"  style="display: none">
        <a href="#" class="list-group-item active">
            我收到的邀请
        </a>
        <a href="#" class="list-group-item">Dapibus ac facilisis in</a>
        <a href="#" class="list-group-item">Morbi leo risus</a>
        <a href="#" class="list-group-item">Porta ac consectetur ac</a>
        <a href="#" class="list-group-item">Vestibulum at eros</a>
    </div>
    <div class="list-group pre-scrollable" id="myInvitation" style="display: none">
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
</div>
<div class="searchUser input-group">
    <input type="text" class="form-control" placeholder="Search for new friends" id="searchBar">
    <span class="input-group-btn">
        <button class="btn btn-default" type="button" onclick="searchUser()">
            <span class="glyphicon glyphicon-search" aria-hidden="true"></span>Go!
        </button>
    </span>
</div>
<div id="userResults">
    <table class="table table-striped table-hover table-border">
        <!-- 搜索结果 -->
    </table>
</div>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
<!-- 加载自定义alert方法 -->
<script src="${pageContext.request.contextPath}/resources/js/alert.js"></script>
<script>
    //css样式切换
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
    });
    //获取好友信息
    function getMyFriends() {
        $.ajax({
            url:"${pageContext.request.contextPath}/getMyFriends.friend",
            type:"POST",
            data:{
                uid:<%=user.getUid()%>
            },
            dataType:"json",    //数据类型为json格式
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            success(data){
                // console.log("search success");
                if(data.hasOwnProperty("myFriends")){
                     // console.log(data.myFriends);
                    renderMyFriends(data.myFriends)
                }
            }
        })
    }
    function getMyInvitation() {
        $.ajax({
            url:"${pageContext.request.contextPath}/getMyInvitation.friend",
            type:"POST",
            data:{
                uid:<%=user.getUid()%>
            },
            dataType:"json",    //数据类型为json格式
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            success(data){
                // console.log("search success")
                if(data.hasOwnProperty("invitation")){
                    // console.log(data.invitation)
                    renderMyInvitation(data.invitation);
                }
            }
        })
    }
    function getInviteMe() {
        $.ajax({
            url:"${pageContext.request.contextPath}/getInviteMe.friend",
            type:"POST",
            data:{
                uid:<%=user.getUid()%>
            },
            dataType:"json",    //数据类型为json格式
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            success(data){
                // console.log("search success")
                if(data.hasOwnProperty("inviteMe")){
                    // console.log(data.inviteMe);
                    renderInviteMe(data.inviteMe);
                }
            }
        })
    }
    //将数据渲染到页面上
    function renderMyFriends(myFriendsArray) {
        let myFriendsDiv = $("#myFriends");
        myFriendsDiv.empty();
        myFriendsArray.forEach(function (friend) {
            myFriendsDiv.append("<a href='${pageContext.request.contextPath}/collection.jsp?uid="+ friend.uid +"' class='list-group-item list-group-item-success'>"+ friend.username +"</a>");
        })
    }
    function renderMyInvitation(myInvitationArray) {
        let myInvitationDiv = $("#myInvitation");
        myInvitationDiv.empty();
        myInvitationArray.forEach(function (invitation) {
            if(invitation.invitationState === 0){
                myInvitationDiv.append(" <a class='list-group-item list-group-item-warning'><span class='badge'>waiting...</span>"+ invitation.username +"</a>");
            }
            else {
                myInvitationDiv.append(" <a class='list-group-item list-group-item-danger'><span class='badge'>refused..</span>"+ invitation.username +"</a>");
            }
        })
    }
    function renderInviteMe(inviteMeArray) {
        let inviteMeDiv = $("#inviteMe");
        inviteMeDiv.empty();
        inviteMeArray.forEach(function (invitation) {
            inviteMeDiv.append('<a class="list-group-item list-group-item-info">  ' +
                '<span class="badge" onclick="agreeInvitation('+ invitation.invitationId +')">agree</span> ' +
                '<span class="badge" onclick="refuseInvitation('+ invitation.invitationId +')">refuse</span>' +
                '<strong>Inviter</strong>: '+ invitation.username +'</a>');
        })
    }
    //好友操作
    function agreeInvitation(invitationId) {
        // alert("agree"+invitationId)
        $.ajax({
            url:"${pageContext.request.contextPath}/agreeInvitation.friend",
            type:"POST",
            data:{
                "invitationId":invitationId
            },
            success(data){
                if(data.indexOf("success") !== -1){
                    alertSuccess('你们已经成为好友啦，快去聊天吧');
                    getInviteMe();
                    getMyFriends();
                }
                else alertError("通过失败，请重试")
            }
        })
    }
    function refuseInvitation(invitationId) {
        // alert("refuse"+invitationId)
        $.ajax({
            url:"${pageContext.request.contextPath}/refuseInvitation.friend",
            type:"POST",
            data:{
                "invitationId":invitationId
            },
            success(data){
                if(data.indexOf("success") !== -1){
                    alertSuccess('你已成功拒绝对方的邀请');
                    getInviteMe();
                }
                else alertError("拒绝失败，请重试");
            }
        })
    }
    //搜索好友，可模糊查询
    function searchUser() {
        console.log("search")
        let content = $("#searchBar").val();
        $.ajax({
            url:"${pageContext.request.contextPath}/searchUser.friend",
            type:"POST",
            data:{
                fuzzyUsername:content,
                uid:<%=user.getUid()%>
            },
            dataType:"json",    //数据类型为json格式
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            success(data){
                console.log("search success");
                if(data.hasOwnProperty("users") && data.hasOwnProperty("states")){
                    console.log(data.users);
                    console.log(data.states);
                    showUsers(data.users,data.states)
                }
            }
        })
    }
    //展示搜索结果
    function showUsers(users,states) {
        let usersTable = $("#userResults table");
        usersTable.empty();
        usersTable.css("display","table");
        usersTable.append('<tr>\n' +
            '            <th>用户名</th>\n' +
            '            <th>邮箱</th>\n' +
            '            <th>状态</th>\n' +
            '        </tr>');
        for(let i = 0;i < users.length;i++){
            let user = users[i];
            let h = '<tr>\n' +
                '            <td>'+ user.username +'</td>\n' +
                '            <td>'+ user.email +'</td>\n' +
                '            <td>';
            let state = states[i];
            if(state === 0){
                h += '已邀请，等待回复中';
            }
            else if(state === 1){
                h += '已添加为好友';
            }
            else if(state === 2){
                h += '自己';
            }
            else {
                h += '<a onclick="invite('+ user.uid +',this)"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>邀请为好友</a>';
            }
            h += '</td></tr>';
            usersTable.append(h);
        }
    }
    //邀请好友
    function invite(uid,obj) {
        // alert("invite "+uid);
        $.ajax({
            url:"${pageContext.request.contextPath}/invite.friend",
            type:"POST",
            data:{
                inviteeId:uid,
                inviterId:<%=user.getUid()%>
            },
            success(data){
                // console.log("search success");
                if(data.indexOf('success') != -1){
                    alertSuccess('邀请成功!');
                    $(obj).parents("tr").remove();
                    getMyInvitation();
                }
                else {
                    alertError("邀请失败，请重试~")
                }
            }
        })
    }
</script>
<script>
    //initiate
    getMyFriends();
    getMyInvitation();
    getInviteMe();
</script>
<style type="text/css">
    .friendList{
        margin-left: 20px;
        float: left;
    }
    .searchUser{
        width: 30%;
        margin: auto;
    }
    #userResults table{
        margin: auto;
        display: none;
    }
    #userResults{
        height: 70%;
        overflow: scroll;
        margin: 10px;
        padding: 0 30px ;
    }
</style>
</body>
</html>
