<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: nullpo299
  Date: 18/11/19
  Time: 14:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Map<String, String>info=(Map<String, String>) session.getAttribute("INFO");
%>
<html>
<head>
    <title>MyDrive</title>
</head>
<body>

<h1>MyDrive</h1>
<h2>登録確認</h2>

First name : <%=info.get("fname")%><br>
Last name : <%=info.get("lname")%><br>
ID : <%=info.get("id")%><br>

これでいい？<br>
<br>

<form action="Register">
    <input type="submit" value="いいよ"><br>
</form>
<br>
<a href="register.jsp">やだよ</a>

<br>This is register_confirm.jsp!!!<br>

</body>
</html>
