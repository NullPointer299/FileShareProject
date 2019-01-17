<%@ page import="model.User" %><%--
  Created by IntelliJ IDEA.
  User: nullpo299
  Date: 18/11/28
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user=(User)session.getAttribute("USER");
%>
<html>
<head>
    <title>MyDrive</title>
</head>
<body>

<h1>MyDrive</h1>
<h2>Favorite</h2>

<form action="Configuration" method="post">
    <input type="submit" value="config">
</form>
<form action="Main?req=user_info" method="post">
    <input type="submit" value="logout">
</form>
<form action="Main?req=home" method="post">
    <input type="submit" value="home">
</form>
<form action="Main?req=sear_user" method="post">
    <input type="submit" value="sear_user">
</form>
<form action="Main?req=fav" method="post">
    <input type="submit" value="fav">
</form>
<form action="Main?req=trash" method="post">
    <input type="submit" value="trash">
</form>

<br>This is favorite.jsp!!!<br>

</body>
</html>
