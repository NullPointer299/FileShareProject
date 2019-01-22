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
    <meta charset="utf-8">
    <title>MyDrive</title>
    <meta name="description" content="ファイル共有サービス">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" href=css/search_user.css>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $("ul.menu li").mouseenter(function () {
                $(this).siblings().find("ul").hide();
                $(this).children().slideDown(150);
            });
            $('html').click(function () {
                $('ul.menu ul').slideUp(150);
            });
        });

        window.onload = function () {
            loadUser();
        }
    </script>
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/sort.js"></script>
    <script type="text/javascript" src="js/favoriteAndSerach.js"></script>
</head>

<body>
<header>
    <h1>
        <a href="https://auth.cyber-u.ac.jp/openam/UI/Login">
            <font class="M">M</font>y<font class="D">D</font>rive
        </a>
    </h1>

    <hr>
</header>

<div class="submenu" id="submenu">
</div>

<div class="wrapper">
    <div class="top_bar">
        <input type="submit" class="top_con login_con" value="ログアウト">
        <input type="submit" class="top_con" value="設定">
        <form action="#">
            <input id="topText" type="text" class="top_con" onkeyup="charFilter()" placeholder="ユーザの検索">
        </form>
    </div>
    <div class="side_bar">
        <ul>
            <li id="myFolder"><a href="#" onclick="jump('Main?req=home','post')">ホーム</a></li>
            <li id="searchUser"><a href="#" onclick="jump('Main?req=sear_user','post')">ユーザ検索</a></li>
            <li id="favorite"><a href="#" onclick="jump('Main?req=fav','post')">お気に入り</a></li>
            <li id="trash"><a href="#" onclick="jump('Main?req=trash','post')">ゴミ箱</a></li>
        </ul>
    </div>
    <div class="content" id="content">
        <div class="content_top_bar">
            <div class="content_top_bar_right">
                <ul class="menu">
                    <li><a id="right_con" href="#">ソート</a>
                        <ul id="ddmenu">
                            <li><a href="#" onclick="selectName();sortByName()"><span id="name">✓</span>名前順</a></li>
                            <li><a href="#" onclick="selectAsc()"><span id="asc">✓</span>昇順</a></li>
                            <li><a href="#" onclick="selectDesc()"><span id="desc">✓</span>降順</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>

        <div id="main">
        </div>
        <div>
            <form id="hideForm" action="/home/fukui-hiraku/BracketsFile/login.html">
            </form>
        </div>
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
<%--<h2>ユーザ検索</h2>--%>

<%--<form action="Main?req=sear_word" method="post">--%>
<%--<input type="text" name="keyword">--%>
<%--</form>--%>
<%--<form action="Configuration" method="post">--%>
<%--<input type="submit" value="config">--%>
<%--</form>--%>
<%--<form action="Logout" method="post">--%>
<%--<input type="submit" value="logout">--%>
<%--</form>--%>
<%--<form action="Main?req=home" method="post">--%>
<%--<input type="submit" value="home">--%>
<%--</form>--%>
<%--<form action="Main?req=sear_user" method="post">--%>
<%--<input type="submit" value="sear_user">--%>
<%--</form>--%>
<%--<form action="Main?req=fav" method="post">--%>
<%--<input type="submit" value="fav">--%>
<%--</form>--%>
<%--<form action="Main?req=trash" method="post">--%>
<%--<input type="submit" value="trash">--%>
<%--</form>--%>

<%--<%--%>
<%--out.println("Contents<br>");--%>
<%--if (users == null) {--%>
<%--out.println("first access<br>");--%>
<%--} else {--%>
<%--for (User u : users) {--%>
<%--out.println("<form action=\"Main?req=show_dir&id="+u.getId()+"\" method=\"post\">");--%>
<%--out.println("<input type=submit value=\""+u.getFullName()+"\">");--%>
<%--out.println("</form><br>");--%>
<%--}--%>
<%--}--%>
<%--out.println("This is search_user.jsp!!!<br>");--%>
<%--%>--%>

<%--<br>This is search_user.jsp!!!<br>--%>

<%--</body>--%>
<%--</html>--%>
