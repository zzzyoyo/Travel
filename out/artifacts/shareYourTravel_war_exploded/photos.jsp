<%@ page import="domain.User" %>
<%@ page import="functionPackage.Require" %><%--
  Created by IntelliJ IDEA.
  User: Zhangyuru
  Date: 2020/7/22
  Time: 12:47
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
    if(!Require.requireLogin(request.getContextPath()+"/photos.jsp",session,response,request)) return;
%>
<%
    User user = (User)session.getAttribute("userDetails");
%>
<jsp:include page="WEB-INF/jspFiles/navigation.jsp"></jsp:include>
<div class="page-header">
    <h1>我的照片 <small><%=user.getUsername()%>的照片</small></h1>
</div>
<div id="results" class="row" style="width: 90%;margin: auto">
    <!-- 展示 -->
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
    firstPage('${pageContext.request.contextPath}/photoCount.get','${pageContext.request.contextPath}/photos.get','uid=<%=user.getUid()%>')
</script>
<script>
    function deletePhoto(imageId) {
        alert('delete'+imageId);
        $.ajax({
            url:'${pageContext.request.contextPath}/delete.update',
            type:'POST',
            data:{
                'imageID':imageId
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
    function updatePhoto(imageId) {
        $(location).attr('href', '${pageContext.request.contextPath}/update.jsp?imageID='+imageId);
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
        height: 250px;
        position: relative;
    }
    .deleteButton{
        position: absolute;
        bottom: 1px;
        right: 20px;
    }
    .updateButton{
        position: absolute;
        bottom: 1px;
        left: 20px;
    }
    .myImage{
        width: 150px;
        height: 150px;
    }
</style>
</body>
</html>
