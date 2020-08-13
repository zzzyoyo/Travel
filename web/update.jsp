<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="functionPackage.Require" %>
<%@ page import="domain.User" %>
<%@ page import="dao.DetailedPictureDao" %>
<%@ page import="domain.DetailedPicture" %><%--
  Created by IntelliJ IDEA.
  User: Zhangyuru
  Date: 2020/7/23
  Time: 13:35
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
<%--
    //该页面需要登录
    if(!Require.requireLogin(request.getContextPath()+"/update.jsp",session,response,request)) return;
--%>
<%
    User user = (User)session.getAttribute("userDetails");
%>
<%
    DetailedPicture detailedPicture = null;
    if(request.getParameter("imageID")!=null){
        try {
            int id = Integer.parseInt(request.getParameter("imageID"));
            DetailedPictureDao detailedPictureDao = new DetailedPictureDao();
            detailedPicture = detailedPictureDao.getDetailedPictureByID(id);
        } catch (NumberFormatException e) {//就是上传界面，什么都不做
            e.printStackTrace();
        }
    }
    pageContext.setAttribute("detailedPicture",detailedPicture);
%>
<body style="background-image: url(${pageContext.request.contextPath}/resources/image/background.jpg)">
<jsp:include page="/WEB-INF/jspFiles/navigation.jsp"></jsp:include>
<p class="text-success" style="text-align: center">${param.successMessage}</p>
<p class="text-danger" style="text-align: center">${param.failureMessage}</p>
<div style="width: 30%;margin: auto">
    <c:choose>
        <c:when test="${detailedPicture==null}">
            <h3>上传图片</h3>
        </c:when>
        <c:otherwise>
            <h3>修改图片</h3>
        </c:otherwise>
    </c:choose>
    <form action="${pageContext.request.contextPath}/${detailedPicture==null?"add":"set"}.update" method="post" enctype="multipart/form-data" onsubmit="return confirm('请确认信息无误，是否要提交?')">
        <input type="hidden" name="uid" value="<%=user.getUid()%>">
        <c:if test="${detailedPicture!=null}">
            <!--修改页面，需要上传旧的文件名和图片的id-->
            <input type="hidden" name="oldFileName" value="${detailedPicture.getPath()}">
            <input type="hidden" name="id" value="${detailedPicture.getId()}">
        </c:if>
        <div class="form-group">
            <label for="exampleInputTtile">标题</label>
            <input type="text" class="form-control" id="exampleInputTtile" placeholder="Title" name="title" value="${detailedPicture.getTitle()}" required>
        </div>
        <div class="form-group">
            <label for="exampleInputTheme">主题</label>
            <input type="text" class="form-control" id="exampleInputTheme" placeholder="Theme" name="theme" value="${detailedPicture.getTheme()}" required>
        </div>
        <div class="form-group">
            <label for="exampleInputDescription">简介</label>
            <textarea class="form-control" id="exampleInputDescription" placeholder="Description" rows="3" name="description" required>${detailedPicture.getDescription()}</textarea>
        </div>
        <div class="form-group">
            <label for="countries">国家</label>
            <select class="form-control" id="countries" name="countryISO" required>
            </select>
        </div>
        <div class="form-group">
            <label for="cities">城市</label>
            <select class="form-control" id="cities" name="cityId" required>
            </select>
        </div>
        <div class="form-group">
            <label for="exampleInputFile">选择图片</label>
            <input type="file" id="exampleInputFile" name="path" ${detailedPicture!=null?"":"required"} accept="image/jpg, image/png, image/jpeg, image/gif" onchange="showSelectedImg(this)">
            <c:choose>
                <c:when test="${detailedPicture==null}">
                    <p class="help-block">请选择一张图片</p>
                </c:when>
                <c:otherwise>
                    <p class="help-block">如不需要修改图片文件可以选择不选</p>
                </c:otherwise>
            </c:choose>
            <img id="photoImg" width="100%">
        </div>
        <button type="submit" class="btn btn-default">${detailedPicture==null?"上传":"修改"}</button>
    </form>
</div>

<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
<!-- 加载自定义alert方法 -->
<script src="${pageContext.request.contextPath}/resources/js/alert.js"></script>
<script>
    let selectedCountry = '${detailedPicture.getCountryISO()}';
    let selectedCity = '${detailedPicture.getCityId()}';

    function loadAllCountries() {
        $.ajax({
            url:'${pageContext.request.contextPath}/allCountries.geo',
            type:'POST',
            dataType:"json",    //数据类型为json格式
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            success(data){
                if(data.hasOwnProperty('countries')){
                    let countries = data.countries;
                    let countrySelector = $('#countries');
                    countries.forEach(function (country) {
                        if(country.id == selectedCountry){
                            countrySelector.append("<option value='"+ country.id +"' selected='selected'>"+ country.name +"</option>");
                        }
                        else {
                            countrySelector.append("<option value='"+ country.id +"'>"+ country.name +"</option>");
                        }
                    })
                }
                // console.log(data);
            }
        })
    }
    function loadCities(countryID) {
        $.ajax({
            url:'${pageContext.request.contextPath}/cities.geo',
            type:'POST',
            data:{
                "countryID":countryID
            },
            dataType:"json",    //数据类型为json格式
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            success(data){
                if(data.hasOwnProperty('cities')){
                    // console.log(data.cities);
                    let cities = data.cities;
                    let citySelector = $('#cities');
                    citySelector.empty();
                    cities.forEach(function (city) {
                        if(city.id == selectedCity){
                            citySelector.append("<option value='"+ city.id +"' selected='selected>"+ city.name +"</option>");
                        }
                        else {
                            citySelector.append("<option value='"+ city.id +"'>"+ city.name +"</option>");}
                    })
                }
            }
        })
    }
    function showSelectedImg(obj) {
        let file = obj.files[0];
        let reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function (e) {    //成功读取文件
            let img = document.getElementById("photoImg");
            img.src = e.target.result;   //或 img.src = this.result / e.target == this
        };
    }
    loadAllCountries();
    //jQuery获取不到动态添加的元素，不能用$('#countries').val()来获取
    loadCities(selectedCountry||'AD');
    //动态改变city的选项
    $('#countries').change(function () {
        // console.log($(this).val());
        loadCities($(this).val());
    })
</script>
</body>
</html>
