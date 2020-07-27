<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="functionPackage.Require" %>
<%@ page import="dao.PictureDao" %>
<%@ page import="java.util.List" %>
<%@ page import="domain.Picture" %>
<%@ page import="domain.User" %><%--
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
<body style="background-image: url(${pageContext.request.contextPath}/resources/image/background.jpg)">
<%
    //该页面需要登录
    if(!Require.requireLogin(request.getContextPath()+"/collection.jsp",session,response,request)) return;
%>
<%
    User user = (User)session.getAttribute("userDetails");
%>
<jsp:include page="WEB-INF/jspFiles/navigation.jsp"></jsp:include>
<h2 style="text-align: center;color: cornflowerblue;">我的收藏</h2>
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
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
<!-- 加载分页脚本  -->
<script src="${pageContext.request.contextPath}/resources/js/pagination.js"></script>
<!-- 请求第一页  -->
<script>
    firstPage('${pageContext.request.contextPath}/collectionCount.get','${pageContext.request.contextPath}/collections.get','uid=<%=user.getUid()%>')
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
                    display(currentPage)
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
        height: 260px;
        position: relative;
    }
    .myButton{
        position: absolute;
        bottom: 1px;
        right: 40px;
    }
    .myImage{
        width: 150px;
        height: 150px;
    }
    .myUl{
        list-style:decimal;
    }
</style>
</body>
</html>
