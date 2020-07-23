<%--
  Created by IntelliJ IDEA.
  User: Zhangyuru
  Date: 2020/7/20
  Time: 22:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
</head>
<body>
<!-- 此处的 message 是放在request的param里面的，即？后面的参数，不是attribute,放在error.jsp后面也是request里面的参数-->
<p style="color: red">错误信息：${param.message}</p>
</body>
</html>
