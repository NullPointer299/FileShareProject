<%--
  Created by IntelliJ IDEA.
  User: nullpo299
  Date: 18/11/28
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String stat = request.getParameter("stat");
%>

<html>

<head>
    <meta charset="utf-8">
    <title>MyDrive</title>
    <meta name="description" content="ファイル共有サービス">
    <link rel="stylesheet" href="css/index.css">
</head>

<body>
    <div class="wrapper">
        <div class="empty"></div>
        <div class="content">
            <form action="Login" method="post">
                <fieldset class="login">
                    <h1>
                        <font class="M">M</font>y<font class="D">D</font>rive
                    </h1>
                    <h2 class="title">サインイン</h2>

                    <div class="info">
                        <div class="form">
                            <label for="id" class="form">ID</label><input id="id" min="5" maxlength="20" type="text" placeholder=" ユーザIDを入力してください" required name="id" oninput="checkId(this)">
                        </div>

                        <div class="form">
                            <label for="password" class="form">パスワード</label><input id="password" type="password" placeholder="パスワードを入力してください" maxlength="20" required name="pass" oninput="checkId(this)">
                        </div>
                    </div>
                    <%=stat != null && stat.equals("failed") ? "<div class=\"error\" color=\"red\">ログイン失敗</div>" : ""%>
                    <div class="submit form">
                        <input type="submit" value="サインイン">
                    </div>
                </fieldset>
            </form>
            <fieldset class="registerbox">
                <div class="register_text">
                    <p>アカウント未登録の方</p>
                </div>
                <div class="register_button">
                    <form action="register.jsp">
                        <input type="submit" name="register_button" value="新規登録">
                    </form>
                </div>
            </fieldset>
        </div>

    </div>
</body>

</html>

<%--<html>--%>
<%--<head>--%>
<%--<title>MyDrive</title>--%>
<%--</head>--%>
<%--<body>--%>

<%--<h1>MyDrive</h1>--%>
<%--<h2>ログイン</h2>--%>

<%--<form action="Login" method="post">--%>
<%--ID：<input type="text" name="id"><br>--%>
<%--パスワード：<input type="password" name="pass"><br>--%>
<%--<input type="submit" value="サインイン"><br>--%>
<%--</form>--%>

<%--<br><%=stat != null && stat.equals("failed") ? "ログイン失敗" : ""%><br>--%>

<%--<form action="register.jsp">--%>
<%--<input type="submit" value="新規登録"><br>--%>
<%--</form>--%>

<%--</body>--%>
<%--</html>--%>
