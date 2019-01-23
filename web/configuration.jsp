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
    <link rel="stylesheet" href="../css/main.css">
    <script type="text/javascript" src="../js/configuration.js"></script>
    <script type="text/javascript" src="../js/main.js"></script>
    <script type="text/javascript">
        window.onload = function() {
            loadConfig(<%=user.getLastName()%>,<%=user.getFirstName()%>,<%=user.isPublic() +""%>);
        }
    </script>
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
            <form id="configForm" action="Configuration" onsubmit="return false;">
                名前変更
                <br>
                姓<input id="lName" type="text" name="lName">
                名<input id="fName" type="text" name=fName>
                <br>
                パスワード変更<input id="password" type="password" name="password">
                <br>
                パスワード確認<input id="passwordCheck" type="password">
                <br>
                ユーザ公開設定
                <select name="public" id="public">
                    <option value="true">公開</option>
                    <option value="false">非公開</option>
                </select>
                <br>
                <input type="submit" onclick="checkPassword()" value="適用">
                <br>
            </form>
            <a href="#" onclick="deleteAccount()">アカウント削除</a>
            <a href="#" onclick="home()">ホームに戻る</a>
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
