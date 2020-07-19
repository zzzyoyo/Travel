<%--
  Created by IntelliJ IDEA.
  User: Zhangyuru
  Date: 2020/7/19
  Time: 21:06
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
<jsp:include page="WEB-INF/jspFiles/navigation.jsp"></jsp:include>
<div style="width: 50%;margin: auto">
    <p class="help-block" style="color: red">${requestScope.message}</p>
    <form id="searchForm">
        <div class="input-group">
            <input type="text" class="form-control" placeholder="Search for..." name="content">
            <span class="input-group-btn"><button class="btn btn-default" type="button" onclick="search()"><span class="glyphicon glyphicon-search" aria-hidden="true"></span>Go!</button></span>
        </div><!-- /input-group -->

        <div>
            <strong>筛选方式：</strong>
            <input type="radio" name="filter" value="theme" checked="checked">主题
            <input type="radio" name="filter" value="title">标题
            <strong style="margin-left: 30px">排序方式：</strong>
            <input type="radio" name="sort" value="hot" checked="checked">热度
            <input type="radio" name="sort" value="time">时间
        </div>
    </form>
</div>

<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
<script>
    function search() {
        $.ajax({
            url:"${pageContext.request.contextPath}/search",
            type:"POST",
            data:$("#searchForm").serialize(),
            dataType:"json",    //数据类型为json格式
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            success(data,textStatus){
                console.log(data)
            }
        })
    }
</script>
</body>
</html>
