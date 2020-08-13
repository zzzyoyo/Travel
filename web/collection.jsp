<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="functionPackage.Require" %>
<%@ page import="domain.User" %>
<%@ page import="dao.UserDao" %><%--
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
    <!-- alert css -->
    <link href="${pageContext.request.contextPath}/resources/css/alert.css" rel="stylesheet">
</head>
<body style="background-image: url(${pageContext.request.contextPath}/resources/image/background.jpg)">
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
<%--
    //该页面需要登录
    if(!Require.requireLogin(request.getContextPath()+"/collection.jsp",session,response,request)) return;
--%>
<%
    User user = (User)session.getAttribute("userDetails");
%>
<jsp:include page="WEB-INF/jspFiles/navigation.jsp"></jsp:include>
<div class="page-header">
    <c:choose>
        <c:when test="<%=request.getParameter(\"uid\") == null || Integer.parseInt(request.getParameter(\"uid\")) == user.getUid()%>">
            <h1>我的收藏 <small><%=user.getUsername()%>的收藏</small></h1>
        </c:when>
        <c:otherwise>
            <%
                UserDao userDao = new UserDao();
                int uid = Integer.parseInt(request.getParameter("uid"));
                User friend = userDao.getUserByUid(uid);
            %>
            <h1>好友收藏 <small><%=friend.getUsername()%>的收藏</small></h1>
            <%
                if(friend.getState() == 0){
                    out.print("<p class='text-warning' style='text-align: center'>"+ friend.getUsername() +"未公开收藏，无法查看</p>");
                    return;
                }
            %>
        </c:otherwise>
    </c:choose>
</div>
<div class="btn-group" style="margin-left: 20px">
    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        我的足迹 <span class="caret"></span>
    </button>
    <ul class="dropdown-menu myUl">
        <c:forEach var="picture" items="${sessionScope.footprints}">
            <li><a href="${pageContext.request.contextPath}/details.jsp?imageID=${picture.getId()}">${picture.getTitle()}</a></li>
        </c:forEach>
    </ul>
</div>
<div id="results" class="row" style="width: 90%;margin: auto">
    <!-- 收藏展示 -->
</div>
<div style="margin: auto;width: 50%">
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination">
            <!-- 分页条 -->
        </ul>
    </nav>
</div>
<!-- 加载自定义alert方法 -->
<script src="${pageContext.request.contextPath}/resources/js/alert.js"></script>
<!-- 加载分页脚本  -->
<script src="${pageContext.request.contextPath}/resources/js/pagination.js"></script>
<!-- 请求第一页  -->
<script>
    firstPage('${pageContext.request.contextPath}/collectionCount.get','${pageContext.request.contextPath}/collections.get','uid=<%=request.getParameter("uid")==null?user.getUid():request.getParameter("uid")%>');
</script>
<script>
    function cancelCollection(imageID){
        $.ajax({
            url:'${pageContext.request.contextPath}/delete.collect',
            type:'POST',
            data:{
                'imageID':imageID,
                'uid':<%=user.getUid()%>
            },
            success(data){
                if(data.indexOf('success') !== -1){
                    count --;
                    pageCount = Math.ceil(count/pageSize);
                    display(currentPage);
                    alertSuccess('取消成功')
                }
                console.log(data);
            }
        })
    }
</script>
<style type="text/css">
    .picture{
        float: left;
        margin: 60px;
        padding: 4px;
        border: 1px solid #ddd;
        background-color: #fff;
        border-radius: 4px;
        width: 160px;
        height: <%=request.getParameter("uid") == null || Integer.parseInt(request.getParameter("uid")) == user.getUid()?260:230%>px;
        position: relative;
    }
    .myButton{
        position: absolute;
        bottom: 1px;
        right: 40px;
        display: <%=request.getParameter("uid") == null || Integer.parseInt(request.getParameter("uid")) == user.getUid()?"block":"none"%>;
    }
    .myImage{
        width: 150px;
        max-height: 150px;
    }
</style>
</body>
</html>
