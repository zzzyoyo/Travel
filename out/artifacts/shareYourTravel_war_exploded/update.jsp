<%--
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
</head>
<body style="background-image: url(${pageContext.request.contextPath}/resources/image/background.jpg)">
<div style="width: 70%">
    <h3>上传你的图片</h3>
    <form>
        <div class="form-group">
            <label for="exampleInputTtile">标题</label>
            <input type="text" class="form-control" id="exampleInputTtile" placeholder="Password">
        </div>
        <div class="form-group">
            <label for="exampleInputTheme">主题</label>
            <input type="text" class="form-control" id="exampleInputTheme" placeholder="Password">
        </div>
        <div class="form-group">
            <label for="exampleInputDescription">简介</label>
            <textarea class="form-control" id="exampleInputDescription" placeholder="Password" rows="3"></textarea>
        </div>
        <div class="form-group">
            <label for="countries">国家</label>
            <select class="form-control" id="countries">
            </select>
        </div>
        <div class="form-group">
            <label for="cities">城市</label>
            <select class="form-control" id="cities">
            </select>
        </div>
        <div class="form-group">
            <label for="exampleInputFile">File input</label>
            <input type="file" id="exampleInputFile">
            <p class="help-block">Example block-level help text here.</p>
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
    </form>
</div>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
<script>
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
                        countrySelector.append("<option value='"+ country.id +"'>"+ country.name +"</option>");
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
                    cities.forEach(function (country) {
                        citySelector.append("<option value='"+ country.id +"'>"+ country.name +"</option>");
                    })
                }
            }
        })
    }
</script>
<script>
    loadAllCountries();
    loadCities('AD')
    //动态改变city的选项
    $('#countries').change(function () {
        // console.log($(this).val());
        loadCities($(this).val());
    })
</script>
</body>
</html>
