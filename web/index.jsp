<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.PictureDao" %>
<%@ page import="domain.Picture" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Zhangyuru
  Date: 2020/7/18
  Time: 8:16
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
    <!-- Custom styles for this template -->

  </head>
  <body style="background-image: url(${pageContext.request.contextPath}/resources/image/background.jpg)">
  <jsp:include page="/WEB-INF/jspFiles/navigation.jsp"></jsp:include>
  <%
    PictureDao pictureDao = new PictureDao();
    List<Picture> hottest = pictureDao.getSortedPictures(5,"hot");
    List<Picture> recent = pictureDao.getSortedPictures(5,"RecentUpdate");
  %>
  <!--最热图片-->
  <h2 style="color: #9F79EE;text-align: left;margin: 10px">最热图片</h2>
  <div id="carousel-example-generic" class="carousel slide hot-works" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
      <c:forEach var="i" begin="1" end="<%=hottest.size()-1%>">
        <li data-target="#carousel-example-generic" data-slide-to="${i}"></li>
      </c:forEach>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
      <div class="item active">
        <a href="details.jsp?imageID=<%=hottest.get(0).getId()%>"><img src="${pageContext.request.contextPath}/resources/travel-images/large/<%=hottest.get(0).getPath()%>" alt="..." style="height: 500px;margin: auto"></a>
        <div class="carousel-caption">
          <h3><%=hottest.get(0).getTitle()%></h3>
          <span class="glyphicon glyphicon-camera" aria-hidden="true"></span><%=hottest.get(0).getAuthor()%>
        </div>
      </div>
      <c:forEach var="picture" items="<%=hottest%>" begin="1">
        <div class="item">
          <a href="details.jsp?imageID=${picture.getId()}"><img src="${pageContext.request.contextPath}/resources/travel-images/large/${picture.getPath()}" alt="..." style="height: 500px;margin: auto"></a>
          <div class="carousel-caption">
            <h3>${picture.getTitle()}</h3>
            <span class="glyphicon glyphicon-camera" aria-hidden="true"></span>${picture.getAuthor()}
          </div>
        </div>
      </c:forEach>
    </div>

    <!-- Controls -->
    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>

  <br><br>
  <!--最新-->
  <h2 style="color: #9F79EE;text-align: right;margin: 10px">最新作品</h2>
  <fieldset class="hot-works">
    <div class="wrap">
      <div class="my_container">
        <c:forEach var="picture" items="<%=recent%>">
          <div class="holder">
            <a href="details.jsp?imageID=${picture.getId()}"><img src="${pageContext.request.contextPath}/resources/travel-images/large/${picture.getPath()}"> </a>
            <ul>
              <li class="work">Three Musicians</li>
              <li class="artist">by Pablo Picasso</li>
            </ul>
          </div>
        </c:forEach>
      </div>
    </div>
  </fieldset>
  <br><br>
  <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
  <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
  <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>

  <style type="text/css">
     .hot-works {
      margin: 10px;
      padding: 10px;
      border: #DDA0DD ridge 10px;
      vertical-align: top;
    }
    .wrap {
      position: relative;
      height: 500px;
      margin: 100px auto;
      overflow: hidden;
      padding: 2px;
      margin: 0;
    }
    .my_container{
      position: absolute;
      left: 0; top: 0;
      width: 250%;
      height: 100%;
      transform: translate(0,0);
      animation: loop 30s linear infinite alternate;
    }
    .my_container:hover{
      animation-play-state: paused;
    }
    .holder{
       display: inline-block;
       position: relative;
      width: 450px;
      height: 450px;
      overflow: hidden;
     }
    @keyframes loop {
      0% {transform: translate(0,0);}
      100% {transform: translate(-33%,0);}
    }
    .hot-works ul{
      color: white;
      vertical-align: middle;
      text-align: left;
      position: absolute;
      top: 35%;
      left: 25%;
      font-family: Lemon;
      opacity: 0;
      width: 100%;
    }
    .hot-works ul:hover{
      opacity: 1;
    }
    .hot-works ul li{
      padding: 10px;
    }
    .hot-works ul li.work{
      font-size: 30px;
    }
    .hot-works ul li.artist{
      font-size:20px;
      font-style: italic;
    }
  </style>
  </body>
</html>
