<%@ page import="model.User" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: nullpo299
  Date: 18/11/28
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) session.getAttribute("USER");
    List<User> users = (List<User>) session.getAttribute("USERS");
%>
<html>
<head>
    <title>MyDrive</title>
</head>
<body>

<h1>MyDrive</h1>
<h2>ユーザ検索</h2>

<form action="Main?req=sear_word" method="post">
    <input type="text" name="keyword">
</form>
<form action="Configuration" method="post">
    <input type="submit" value="config">
</form>
<form action="Logout" method="post">
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

<%
    out.println("Contents<br>");
    if (users == null) {
        out.println("first access<br>");
    } else {
        for (User u : users) {
            out.println("<form action=\"Main?req=show_dir&id="+u.getId()+"\" method=\"post\">");
            out.println("<input type=submit value=\""+u.getFullName()+"\">");
            out.println("</form><br>");
        }
    }
    out.println("This is search_user.jsp!!!<br>");
%>

<br>This is search_user.jsp!!!<br>

</body>
</html>
