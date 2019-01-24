<%@ page import="model.User" %>
<%--
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
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="css/main.css">
    <script type="text/javascript" src="js/configuration.js"></script>
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript">
        window.onload = function() {
            loadConfig(<%="'"+user.getLastName()+"'"%>, <%="'"+user.getFirstName()+"'"%>, <%="'"+user.isPublic() +"'"%>);
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
            <form id="configForm" action="Configuration" onsubmit="return false;" method="post">
                <h2>名前変更</h2>
                <br>
                <div class="formNode">
                    姓<input id="lName" type="text" name="lName">
                </div>
                <div class="formNode">
                    名<input id="fName" type="text" name=fName>
                </div>

                <br>
                <div class="formNode">
                    パスワード変更<input id="password" type="password" name="password">
                </div>
                <br>
                <div class="formNode">
                    パスワード確認<input id="passwordCheck" type="password">
                </div>
                <br>
                ユーザ公開設定
                <div class="formNode">
                    <select name="public" id="public">
                        <option value="true">公開</option>
                        <option value="false">非公開</option>
                    </select>
                </div>
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
