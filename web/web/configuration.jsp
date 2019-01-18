<%@ page import="model.User" %><%--
  Created by IntelliJ IDEA.
  User: nullpo299
  Date: 18/11/28
  Time: 15:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) session.getAttribute("USER");
    String stat = request.getParameter("stat");
%>

<html>

<head>
    <meta charset="utf-8">
    <title>MyDrive</title>
    <meta name="description" content="ファイル共有サービス">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" href="css/main.css">
</head>

<body>
<header>
    <h1>
        <font class="M">M</font>y<font class="D">D</font>rive
    </h1>
    <hr>
</header>

<div class="wrapper">
    <fieldset>
        <form action="Configuration" method="post">
            名前変更<input type="text" name="lName"><input type="text" name="fName">
            <br>
            パスワード変更<input type="password" name="pass">
            <br>
            ユーザ公開設定
            <input type="radio" name="public" value="true" <%if (user.isPublic())out.print("checked=\"checked\"");%>>公開する<br>
            <input type="radio" name="public" value="false" <%if (!user.isPublic())out.print("checked=\"checked\"");%>>公開しない<br>
            <input type="submit" value="適用">
            <br>
            <a href="#">アカウント削除</a><br>
            <a href="#">TOPに戻る</a>
        </form>
    </fieldset>
</div>

</body>

</html>


<%--<html>--%>
<%--<head>--%>
    <%--<title>MyDrive</title>--%>
<%--</head>--%>
<%--<body>--%>

<%--<h1>MyDrive</h1>--%>
<%--<h2>Configuration</h2>--%>

<%--<h3>ID : <%=user.getId()%>--%>
<%--</h3>--%>

<%--名前 : <%=user.getFullName()%><br>--%>

<%--<form action="Configuration?req=chname" method="post">--%>
    <%--<input type="text" name="last">--%>
    <%--<input type="text" name="first">--%>
    <%--<input type="submit" value="change!">--%>
<%--</form>--%>

<%--<br>--%>

<%--パスワード--%>

<%--<form action="Configuration?req=chpass" method="post">--%>
    <%--<input type="password" name="new">--%>
    <%--<input type="submit" value="change!">--%>
<%--</form>--%>

<%--<br>--%>

<%--アカウントの公開--%>

<%--<form action="Configuration?req=chpub" method="post">--%>
    <%--<input type="radio" name="public" value="1" <%if (user.isPublic())out.print("checked=\"checked\"");%>>公開する<br>--%>
    <%--<input type="radio" name="public" value="0" <%if (!user.isPublic())out.print("checked=\"checked\"");%>>公開しない<br>--%>
    <%--<input type="submit" value="change!">--%>
<%--</form>--%>

<%--<%--%>
    <%--if (stat != null) {--%>
        <%--if (stat.equals("done"))--%>
            <%--out.println("<br>success!!!<br>");--%>
        <%--else--%>
            <%--out.println("<br>failed!!!<br>");--%>
    <%--}--%>
<%--%>--%>

<%--<br>This is configuration.jsp!!!<br>--%>

<%--<br>--%>

<%--<form action="Main?req=home" method="post">--%>
    <%--<input type="submit" value="back">--%>
<%--</form>--%>

<%--</body>--%>
<%--</html>--%>
