<%@ page import="java.nio.file.Path" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.util.List" %>
<%@ page import="model.LoggedUser" %>
<%@ page import="model.TrashFile" %>
<%--
  Created by IntelliJ IDEA.
  User: nullpo299
  Date: 18/11/28
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    LoggedUser user = (LoggedUser) session.getAttribute("USER");
    String error = request.getParameter("ERROR");
    List<TrashFile> files = (List<TrashFile>) session.getAttribute("FILES");
    List<TrashFile> dirs = files.stream().filter(f -> f.isDirectory()).collect(Collectors.toList());
    List<TrashFile> normal = files.stream().filter(f -> !f.isDirectory()).collect(Collectors.toList());
    Path current = (Path) session.getAttribute("CURRENT");
%>

<html>

<head>
    <meta charset="utf-8">
    <title>MyDrive</title>
    <meta name="description" content="ファイル共有サービス">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" href="css/trash.css">
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

    </script>
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/sort.js"></script>
    <script type="text/javascript" src="js/trash.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            loadNowPage("trash");
            <%if(error != null) {%>
            error();
            <%}%>
            var dirs = [];
            var files = [];
            <%for (TrashFile f : dirs) {%>
            dirs.push(new trashFolder(<%="'"+f.getName()+"'"%>, 0, <%="'"+f.getPath()+"'"%>, <%="'"+f.isRestore() +"'"%>, <%="'"+f.getDispName() +"'"%>));
            <%}%>
            <%for (TrashFile f : normal) {%>
            files.push(new trashFolder(<%="'"+f.getName()+"'"%>, 0, <%="'"+f.getPath()+"'"%>, <%="'"+f.isRestore() +"'"%>, <%="'"+f.getDispName() +"'"%>));
            <%}%>
            sortLoad(dirs, files);
            loadBreadcrumb(<%="'" +current+"'"%>);

            var box = document.getElementById("content");
            box.addEventListener("contextmenu", function (e) {
                e.preventDefault();
            }, false);
        }

    </script>
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

<div class="submenu" id="submenu"></div>

<div class="wrapper">
    <div class="top_bar">
        <input type="submit" class="top_con login_con" value="ログアウト" onclick="jump('Logout','post')"> <input
            type="submit" class="top_con" value="設定" onclick="jump('Configuration','get')">
        <form action="#" onsubmit="return false">
            <input id="topText" type="text" class="top_con" oninput="checkFileName(this)" onkeyup="charFilter()" placeholder="ファイルを絞り込む">
        </form>
    </div>
    <div class="side_bar">
        <ul>
            <li id="myFolder"><a href="#" onclick="jump('Main?req=home','post')">ホーム</a></li>
            <li id="searchUser"><a href="#" onclick="jump('Main?req=sear_user','post')">ユーザ検索</a></li>
            <li id="favorite"><a href="#" onclick="jump('Main?req=fav','post')">お気に入り</a></li>
            <li id="trash"><a href="#" onclick="jump('Trash?req=show','post')">ゴミ箱</a></li>
        </ul>
    </div>
    <div class="content" id="content">
        <div class="content_top_bar">
            <div class="content_top_bar_left">
                <ul class="menu">
                    <li><a href="#" onclick="deleteAll()"><i class="material-icons">
                        delete_forever
                    </i></a>
                        <div class="tooltips">空にする</div>
                    </li>
                    <li><a href="#" onclick="deleteThingsAtTrash()"><i class="material-icons">
                        delete
                    </i></a>
                        <div class="tooltips">選択済み削除</div>
                    </li>
                    <li><a href="#" onclick="exeDownload()"><i class="material-icons">
                        cloud_download
                    </i></a>
                        <div class="tooltips">ダウンロード</div>
                    </li>
                </ul>
            </div>
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
        <div class="breadcrumb" id="breadcrumb">
        </div>
        <div id="main">
        </div>
    </div>
</div>
</body>

</html>
