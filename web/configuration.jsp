<%@ page import="model.LoggedUser" %>
<%--
  Created by IntelliJ IDEA.
  User: nullpo299
  Date: 18/11/28
  Time: 15:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    LoggedUser user = (LoggedUser) session.getAttribute("USER");
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
                <h1 style="display: inline"><i class="material-icons">
                        settings
                    </i>アカウント設定<i class="material-icons">
                        settings
                    </i></h1>
                <input type="submit" onclick="checkPassword()" value="適用">
                <hr>
                <h3>名前変更</h3>
                <div class="formNode">
                    姓：<input id="lName" type="text" name="lName">
                </div>
                <div class="formNode">
                    名：<input id="fName" type="text" name=fName>
                </div>
                <hr class="in">
                <h3>パスワード変更</h3>

                <div class="formNode">
                    新規パスワード：<input id="password" oninput="checkForm(this)" type="password" name="password">
                </div>
                <div class="formNode">
                    パスワード確認：<input id="passwordCheck" oninput="checkForm(this)" type="password">
                </div>
                <hr>
                <h3>ユーザ公開設定</h3>
                <div class="formNode">
                    <input type="radio" name="public" id="public" value="true">公開
                    <input type="radio" name="public" id="unPublic" value="false">非公開
                </div>
                <hr>
            </form>
            <a href="#" class="remove" onclick="deleteAccount()">アカウント削除</a>
            <a href="#" class="home" onclick="home()">ホームに戻る</a>
        </fieldset>
    </div>
</body>


</html>
