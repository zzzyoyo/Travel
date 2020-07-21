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
    Require.requireLogin(request.getContextPath()+"/collection.jsp",session,response,request);
%>
<%
    User user = (User)session.getAttribute("userDetails");
%>
<jsp:include page="WEB-INF/jspFiles/navigation.jsp"></jsp:include>
<h2>我的收藏</h2>
<div id="collections" class="row" style="width: 90%;margin: auto">
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

<script>
    //global variables
    let pageCount;//页面数
    let count;//图片总数
    const pageSize = 10;//一页展示多少图片
    const paginationSize = 10;//分页条最多有多少个页码

    function getCount() {
        $.ajax({
            url:"${pageContext.request.contextPath}/collectionCount.get",
            type: "POST",
            data: {
                "uid":<%=user.getUid()%>
            },
            success(data) {
                count = data;
                pageCount = Math.ceil(data/pageSize);
                display(1);
            }
        })
    }

    //display one page
    function display(currPage) {
        //display page navigation
        pagination(currPage);
        //get results and display
        resultOfPage(currPage)
    }

    //page navigation
    function pagination(currPage) {
        let h = '';
        h += '<p class="help-block">共查到<strong>'+ count +'</strong>张图片,有<strong>'+ pageCount +'</strong>页</p>'
        if(count > 0){
            let start = 1;
            let end = pageCount;
            if(end - start + 1 > paginationSize){
                start = currPage > 5 ? (currPage - 5) : 1;
                end =  start + 9 > pageCount ? pageCount : (start + 9);
            }
            if(currPage == start){//leftest
                h += '<li class="disabled">\n' +
                    '      <span aria-label="Previous">\n' +
                    '        <span aria-hidden="true">&laquo;</span>\n' +
                    '      </span>\n' +
                    '    </li>'
            }
            else{
                h += '<li onclick="display('+ (currPage - 1) +')">\n' +
                    '      <span aria-label="Previous">\n' +
                    '        <span aria-hidden="true">&laquo;</span>\n' +
                    '      </span>\n' +
                    '    </li>'
            }
            for(let i = start;i <= end;i++){
                if(i == currPage){
                    h += '<li class="active">\n' +
                        '      <span>'+ i +' <span class="sr-only">(current)</span></span>\n' +
                        '    </li>'
                }
                else{
                    h += '<li onclick="display('+ i +')">\n' +
                        '      <span>'+ i +'</span>\n' +
                        '    </li>'
                }
            }
            if(currPage == end){//rightest
                h += '<li class="disabled">\n' +
                    '      <span aria-label="Next">\n' +
                    '        <span aria-hidden="true">&raquo;</span>\n' +
                    '      </span>\n' +
                    '    </li>'
            }
            else{
                h += '<li onclick="display('+ (currPage + 1) +')">\n' +
                    '      <span aria-label="Next">\n' +
                    '        <span aria-hidden="true">&raquo;</span>\n' +
                    '      </span>\n' +
                    '    </li>'
            }
        }
        $('#pagination').html(h)
    }

    function resultOfPage(page) {
        $.ajax({
            url:"${pageContext.request.contextPath}/collections.get",
            type:"POST",
            data:{
                "uid":<%=user.getUid()%>,
                "page":page,
                "pageSize":pageSize
            },
            dataType:"json",    //数据类型为json格式
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            success(data){
                console.log("search success")
                if(data.hasOwnProperty("pictures")){
                    console.log(data.pictures)
                    displayPictures(data.pictures)
                }
            }
        })
    }
    //display pictures
    function displayPictures(pictures) {
        let h = '';
        pictures.forEach(function (pictureElement) {
            h += '<div class="picture">\n' +
                '        <a href="details.jsp?imageID='+ pictureElement.id +'">' +
                '               <img src="resources/travel-images/square-medium/'+ pictureElement.path +'" alt="...">' +
                '        </a>\n' +
                '        <h6><strong>'+ pictureElement.title +'</strong></h6>  <strong>author</strong>:'+ pictureElement.author +'\n' +
                '    </div>'
        })
        $('#collections').html(h);
    }
</script>
<script>getCount()</script>
<style type="text/css">
    .picture{
        float: left;
        margin: 30px;
        padding: 4px;
        border: 1px solid #ddd;
        background-color: #fff;
        border-radius: 4px
    }
</style>
</body>
</html>
