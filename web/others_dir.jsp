<%--suppress unchecked --%>
<%@ page import="java.util.List" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="model.LoggedUser" %>
<%@ page import="model.NormalFile" %>
<%--
  Created by IntelliJ IDEA.
  User: nullpo299
  Date: 18/11/28
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    LoggedUser user = (LoggedUser) session.getAttribute("USER");
   String error = (String)request.getParameter("ERROR");
    List<NormalFile> files = (List<NormalFile>) session.getAttribute("FILES");
    List<NormalFile> dirs = files.stream().filter(f -> f.isDirectory()).collect(Collectors.toList());
    List<NormalFile> normal = files.stream().filter(f -> !f.isDirectory()).collect(Collectors.toList());
    Path current = (Path) session.getAttribute("CURRENT");
%>

<html>

<head>
    <meta charset="utf-8">
    <title>MyDrive</title>
    <meta name="description" content="ファイル共有サービス">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" href="css/others_dir.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            $("ul.menu li").mouseenter(function() {
                $(this).siblings().find("ul").hide();
                $(this).children().slideDown(150);
            });
            $('html').click(function() {
                $('ul.menu ul').slideUp(150);
            });
        });

    </script>
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/sort.js"></script>
    <script type="text/javascript">
        window.onload = function() {
            loadNowPage("others_dir"); 
            <%if(error != null) {%>
                error();
            <%}%>
            var dirs = [];
            var files = [];
            <%for (NormalFile f : dirs) {%>
            dirs.push(new Folder(<%="'"+f.getName()+"'"%>, 0, <%="'"+f.getPath()+"'"%>,<%="'"+f.isPublic()+"'"%>));
            <%}%>
            <%for (NormalFile f : normal) {%>
            files.push(new File(<%="'"+f.getName()+"'"%>, 1, <%="'"+f.getPath()+"'"%>,<%="'"+f.isPublic()+"'"%>));
            <%}%>
            sortLoad(dirs, files);
            loadBreadcrumb(<%="'"+current+"'"%>);
                                    
            var box = document.getElementById("content");
            box.addEventListener("contextmenu", function(e){
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
            <input type="submit" class="top_con login_con" value="ログアウト" onclick="jump('Logout','post')"> <input type="submit" class="top_con" value="設定" onclick="jump('Configuration','get')">
            <form action="#">
                <input id="topText" type="text" class="top_con" onkeyup="charFilter()" placeholder="ファイルの検索">
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
                        <li><a id="left_con" href="#" onclick="exeDownload()"><i class="material-icons"> cloud_download </i></a>
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
                <div class="node">
                    <img class="folder" src="picture/folder.png">
                </div>
            </div>
        </div>
    </div>
</body>

</html>
