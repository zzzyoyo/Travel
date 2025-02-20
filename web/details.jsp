<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.DetailedPictureDao" %>
<%@ page import="domain.DetailedPicture" %>
<%@ page import="domain.User" %>
<%@ page import="dao.FavorDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: Zhangyuru
  Date: 2020/7/20
  Time: 21:58
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
<body style="background-image: url(${pageContext.request.contextPath}/resources/image/background.jpg)">
<jsp:include page="/WEB-INF/jspFiles/navigation.jsp"></jsp:include>
<%
    DetailedPicture detailedPicture = null;
    User user = (User) session.getAttribute("userDetails");
    boolean isLogin = (user != null);
    boolean isCollected = false;
    int id = 0;
    try {
        id = Integer.parseInt(request.getParameter("imageID"));
        DetailedPictureDao detailedPictureDao = new DetailedPictureDao();
        detailedPicture = detailedPictureDao.getDetailedPictureByID(id);
        FavorDao favorDao = new FavorDao();
        isCollected = isLogin && favorDao.isCollected(user.getUid(),id);
    } catch (NumberFormatException e) {
        e.printStackTrace();
        request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message=invalid imageID").forward(request,response);
        return;
    }
%>
<!--根据picture是否为null展示页面-->
<c:if test="<%=detailedPicture == null%>">
    <div class="alert alert-danger" role="alert" style="text-align: center">ID为${param.imageID}的图片不存在</div>
</c:if>
<c:if test="<%=detailedPicture != null%>">
    <%
        if(isLogin){
            //加入足迹
            List<DetailedPicture> footprints = (List<DetailedPicture>) session.getAttribute("footprints");
            if(footprints == null){
                footprints = new ArrayList<DetailedPicture>();
                footprints.add(detailedPicture);
                session.setAttribute("footprints",footprints);
            }
            else {
                for(DetailedPicture footprint:footprints){
                    if(detailedPicture.getId() == footprint.getId()){
                        footprints.remove(footprint);
                        break;
                    }
                }
                footprints.add(0,detailedPicture);//insert into the first position
                if(footprints.size() > 10){
                    footprints.remove(footprints.size()-1);//remove the last one
                }
            }
        }
    %>
    <div class="comment">
        <h2>评论区</h2>
        <strong style="margin-left: 60%">排序方式：</strong>
        <input type="radio" name="sort" value="hot" checked="checked">热度
        <input type="radio" name="sort" value="recentUpdate">时间
        <!---评论区------>
        <ul class=" pre-scrollable">
            <!--评论-->
        </ul>
        <!---如果登录则可以写评论------>
        <c:if test="<%=isLogin%>">
            <form onkeypress="return event.keyCode !== 13;">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="写下您的评论...." id="write">
                    <span class="input-group-btn">
                <button class="btn btn-default" type="button" onclick="sendComment()">
                    <span class="glyphicon glyphicon-send" aria-hidden="true"></span>Send!
                </button>
            </span>
                </div>
            </form>
        </c:if>
    </div>
    <div class="information">
        <table style="word-break: break-word">
            <tr>
                <th>标题</th>
                <th><%=detailedPicture.getTitle()%></th>
            </tr>
            <tr>
                <th>作者</th>
                <th><%=detailedPicture.getAuthor()%></th>
            </tr>
            <tr>
                <th>主题</th>
                <td><%=detailedPicture.getTheme()%></td>
            </tr>
            <tr>
                <th>最近更新时间</th>
                <td><%=detailedPicture.getUpdateTime()%></td>
            </tr>
            <tr>
                <th>热度</th>
                <td><%=detailedPicture.getHot()%></td>
            </tr>
            <tr>
                <td>国家</td>
                <td><%=detailedPicture.getCountry()%></td>
            </tr>
            <tr>
                <th>城市</th>
                <td><%=detailedPicture.getCity()%></td>
            </tr>
        </table>
        <c:if test="<%=isLogin%>">
            <c:choose>
                <c:when test="<%=isCollected%>">
                    <button type="button" class="btn btn-primary myButton" onclick="cancelCollect()" id="cancelButton">
                        ★取消收藏
                    </button>
                    <button type="button" class="btn btn-info myButton" onclick="collect()" id="collectButton" style="display: none">
                        ☆收藏
                    </button>
                </c:when>
                <c:otherwise>
                    <button type="button" class="btn btn-info myButton" onclick="collect()" id="collectButton">
                        ☆收藏
                    </button>
                    <button type="button" class="btn btn-primary myButton" onclick="cancelCollect()" id="cancelButton" style="display: none">
                        ★取消收藏
                    </button>
                </c:otherwise>
            </c:choose>
        </c:if>
    </div>
    <div class="image" id="image">
        <div class="small" onmousemove="scale_up()" onmouseout="out()" id="small">
            <img src="${pageContext.request.contextPath}/resources/travel-images/large/<%=detailedPicture.getPath()%>" >
            <p id="description"><strong>简介：</strong><%=detailedPicture.getDescription()==null?"作者暂时没有添加简介~":detailedPicture.getDescription()%></p>
            <div class="mask" id="mask"></div>
        </div>
    </div>
    <div class="big" id="big">
        <div><img src="${pageContext.request.contextPath}/resources/travel-images/large/<%=detailedPicture.getPath()%>" class="big-image" id="big-image"></div>
    </div>
</c:if>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
<!-- 加载自定义alert方法 -->
<script src="${pageContext.request.contextPath}/resources/js/alert.js"></script>
<c:if test="<%=isLogin%>">
    <script>
        function collect() {
            $.ajax({
                url:'${pageContext.request.contextPath}/add.collect',
                type:'POST',
                data:{
                    'imageID':<%=id%>,
                    'uid':<%=user.getUid()%>
                },
                success(data){
                    if(data.indexOf('success') !== -1){
                        $("#cancelButton").css('display','inline-block');
                        $("#collectButton").css('display','none');
                        alertSuccess("收藏成功！")
                    }
                    else {
                        alertError(data);
                    }
                    console.log(data);
                }
            })
        }
        function cancelCollect() {
            $.ajax({
                url:'${pageContext.request.contextPath}/delete.collect',
                type:'POST',
                data:{
                    'imageID':<%=id%>,
                    'uid':<%=user.getUid()%>
                },
                success(data){
                    if(data.indexOf('success') !== -1){
                        $("#cancelButton").css('display','none');
                        $("#collectButton").css('display','inline-block');
                        alertSuccess("取消收藏成功！")
                    }
                    else {
                        alertError(data);
                    }
                    console.log(data);
                }
            })
        }
        function sendComment() {
            $.ajax({
                url:"${pageContext.request.contextPath}/send.comment",
                type:'POST',
                data:{
                    'commenterID':<%=user.getUid()%>,
                    'imageID':<%=id%>,
                    'message':$("#write").val()
                },
                success(data){
                    if(data.indexOf('success') !== -1){
                        //刷新评论区:应该重新从数据库获取还是直接append？
                        loadAllComments();
                        $("#write").val("");
                    }
                    else {
                        alertError(data);
                    }
                }
            })
        }
        $(document).keyup(function(event){
            if(event.keyCode ==13){
                sendComment();
            }
        });
    </script>
</c:if>
<script>
    function loadAllComments() {
        $.ajax({
            url:'${pageContext.request.contextPath}/loadAllComments.comment',
            type:'POST',
            dataType:"json",    //数据类型为json格式
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            data:{
                'sort':$("input[name='sort']:checked").val(),
                'imageID':<%=id%>
            },
            success(data){
                if(data.hasOwnProperty('comments')){
                    console.log(data.comments);
                    renderAllComments(data.comments);
                }
            }
        })
    }
    function addHot(commentID) {
        $.ajax({
            url:"${pageContext.request.contextPath}/addHot.comment",
            data:{
                "commentID":commentID
            },
            type:'POST',
            success(data){
                if(data.indexOf('success')!==-1){
                    alertInfo('评论者非常感谢您的欣赏和点赞！');
                    loadAllComments();
                }
            }
        })
    }
    function renderAllComments(comments) {
        let commentUl = $(".comment ul");
        commentUl.empty();
        comments.forEach(function (comment) {
            commentUl.append('<li>\n' +
                '                <h4>'+ comment.commenter +' <small>'+ comment.commentTime +' </small>' +
                '<span class="badge" onclick="addHot('+ comment.commentID +')">' +
                '<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>'+ comment.hot +'</span></h4>\n' +
                 comment.commentContent +
                '            </li>');
        })
    }
    function scale_up(){
        let mask = document.getElementById("mask");
        let big = document.getElementById("big");
        let small = document.getElementById("small");
        let image = document.getElementById("image");
        let evt = event || window.event;
        let currentMouseX = evt.pageX;
        let currentMouseY = evt.pageY;
        let offsetLeft = small.offsetLeft + image.offsetLeft;
        let offsetTop = small.offsetTop;
        let maskWidth = mask.offsetWidth;
        let maskHeight = mask.offsetHeight;
        let bigImg = document.getElementById("big-image")
        mask.style.display = "block";
        big.style.display = "block";
        let zoomMaskX = currentMouseX - offsetLeft - maskWidth / 2;
        let zoomMaskY = currentMouseY - offsetTop - maskHeight / 2;
        // 限制鼠标上侧与左侧的范围
        if (zoomMaskX <= 0) {
            zoomMaskX = 0
        }
        if (zoomMaskY <= 0) {
            zoomMaskY = 0
        }
        // 限制鼠标右侧与下侧的范围
        let maxScopeX = small.offsetWidth - maskWidth;
        if (zoomMaskX >= maxScopeX) {
            zoomMaskX = maxScopeX;
        }
        let maxkScopeY = small.scrollHeight - maskHeight;
        if (zoomMaskY >= maxkScopeY) {
            zoomMaskY = maxkScopeY;
        }
        mask.style.left = zoomMaskX + 'px';
        mask.style.top = zoomMaskY + 'px';
        let zommProportion = (bigImg.offsetWidth - big.offsetWidth) / (small.offsetWidth - maskWidth);
        bigImg.style.left = -zommProportion * zoomMaskX + 'px';
        bigImg.style.top = -zommProportion * zoomMaskY + 'px';
    }
    function out() {
        let mask = document.getElementById("mask");
        mask.style.display = "none";
        let big = document.getElementById("big");
        big.style.display="none";
    }
    loadAllComments();
    $("input[name='sort']").change(function () {
        loadAllComments();
    });
</script>
<style type="text/css">
    .information{
        float: right;
        border-radius: 20px;
        padding: 0 10px 10px 10px;
        width: 400px;
    }
    .information tr:nth-child(odd){
        background-color: cadetblue;
    }
    .information table{
        font-size: 25px;
    }
    .image{
        vertical-align: middle;
    }
    .image p{
        font:30px Amazing sound;
        text-align: center;
    }
    .image img{
        width: 245px;
        max-height: 266px;
        border: solid 5px black;
        position: absolute;
        top: 0;
        left: 0;
        z-index: 1;
    }
    .image .small{
        position: relative;
        width: 255px;
        margin: 0 593px;
    }
    .image .mask{
        width: 100px;
        height: 100px;
        position: absolute;
        cursor: move;
        top: 0;
        left: 0;
        background: rgba(255,255, 255, 0.4);
        z-index: 10;
        display: none;
    }
    .big{
        display: none;
        width: 400px;
        height: 400px;
        position: absolute;
        top: 70px;
        left: 100px;
        overflow: hidden;
        border: solid 5px black;
        background-color: white;
        z-index: 1000;
    }
    .big div{
        position: relative;
    }
    .big div .big-image{
        position: absolute;
        top: 0;
        left: 0;
        max-width: 1024px;
    }
    #description{
        font-size: 20px;
        position: fixed;
        top: 350px;
        width: 245px;
    }
    .myButton{
        float: right;
        margin-top: 10px
    }
    .comment{
        width: 40%;
        float: left;
        background-color: #1b2838;
        color: #ebebeb;
        margin-left: 20px;
        border-radius: 20px;
    }
    h4 small {
         color: #56707f;
    }
    .comment h2{
        text-align: center;
    }
</style>
</body>
</html>
