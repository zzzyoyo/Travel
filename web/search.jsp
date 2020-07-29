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
<jsp:include page="/WEB-INF/jspFiles/navigation.jsp"></jsp:include>
<div style="width: 50%;margin: auto">
    <p class="help-block" style="color: red">${requestScope.message}</p>
    <form id="searchForm">
        <div class="input-group">
            <input type="text" class="form-control" placeholder="Search for..." name="content">
            <span class="input-group-btn">
                <button class="btn btn-default" type="button"
                        onclick="firstPage('${pageContext.request.contextPath}/searchResultCount.get','${pageContext.request.contextPath}/searchResults.get',$('#searchForm').serialize())">
                    <span class="glyphicon glyphicon-search" aria-hidden="true"></span>Go!
                </button>
            </span>
        </div><!-- /input-group -->
        <div>
            <strong>筛选方式：</strong>
            <input type="radio" name="filter" value="title" checked="checked">标题
            <input type="radio" name="filter" value="theme">主题
            <strong style="margin-left: 30px">排序方式：</strong>
            <input type="radio" name="sort" value="hot" checked="checked">热度
            <input type="radio" name="sort" value="recentUpdate">时间
            <strong style="margin-left: 30px">相似度：</strong><span id="similarNumber">100</span>%
            <input type="range" name="similar" value="100" min="0"  max="100" id="mySlider">
            <span>0%</span><span style="float: right">100%</span>
        </div>
    </form>
</div>
<div id="results" class="row" style="width: 90%;margin: auto">
    <!-- 结果展示 -->
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
<script>
    $("#mySlider").change(function () {
        $("#similarNumber").html(this.value);
    })
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
        height: 220px;
    }
    .myImage{
        width: 150px;
        max-height: 150px;
    }
</style>
</body>
</html>
