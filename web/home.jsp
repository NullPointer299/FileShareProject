<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="model.File" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.util.stream.Collectors" %>
<%--
  Created by IntelliJ IDEA.
  User: nullpo299
  Date: 18/11/28
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("USER");
    List<File> files = (List<File>) session.getAttribute("FILES");
    List<File> dirs = files.stream().filter(f -> f.isDirectory()).collect(Collectors.toList());
    List<File> normal = files.stream().filter(f -> !f.isDirectory()).collect(Collectors.toList());
    Path current = (Path) session.getAttribute("CURRENT");
%>

<html>

<head>
    <meta charset="utf-8">
    <title>MyDrive</title>
    <meta name="description" content="ファイル共有サービス">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" href="css/home.css">
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
    <script type="text/javascript" src="../js/main.js"></script>
    <script type="text/javascript" src="../js/sort.js"></script>
    <script type="text/javascript">
        window.onload = function() {
            var dirs = [];
            var files = [];
            loadNowPage("home");
            <%for (File f : dirs) {%>
            dirs.push(new Folder(<%="'"+f.getName()+"'"%>, 0, <%="'"+f.getPath()+"'"%>,<%="'"+f.isPublic()+"'"%>));
            <%}%>
            <%for (File f : normal) {%>
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
    <div id="cover">
        <div id="upload_content">
            <div class="header">
                <h1>
                    <font class="M">M</font>y<font class="D">D</font>rive
                </h1>
                <span class="upload" onclick="closeUploadWindow()">
                    <a href="#">
                        <p class="upload_close_button">×</p>
                    </a>
                </span>
            </div>
            <div class="upload_wrapper">
                <div class="upload_main">
                    <fieldset class="upload_fieldset">
                        <p class="upload_midasi">ファイルをアップロード</p>
                        <hr class="upload_hr">
                        <form id="upload_form" class="form" onsubmit="return false;" enctype="multipart/form-data" action="Upload?path=<%=current%>" method="post">
                            <input id="filePosition" placeholder="未選択です" type="text" readonly>
                            <label for="file" class="fileSelect">参照...</label>
                            <input id="file" name="file" type="file" onchange="fileChange()" required>
                            <br>
                            <div class="upload_text">ファイル名を入力</div>
                            <input oninput="checkFileName(this)" id="upload_filename" type="text" name="fileName" placeholder="200文字以上は登録できません" maxlength="199"><br>
                            <div class="radioButton">
                                <input type="radio" name="public" value="true" checked>公開
                                <input type="radio" name="public" value="false">非公開
                            </div>
                            <input id="newFolder" onclick="submitUpload()" type="submit" value="アップロード">
                        </form>
                    </fieldset>
                </div>
            </div>
        </div>
        <div id="new_folder_content">
            <div class="header">
                <h1>
                    <font class="M">M</font>y<font class="D">D</font>rive
                </h1>
                <span class="new_folder_closeButton" onclick="closeNewFolderWindow()">
                    <a href="#">
                        <p>×</p>
                    </a>
                </span>
            </div>
            <div class="new_folder_wrapper">
                <div class="new_folder_main">
                    <fieldset class="new_folder_fieldset">
                        <p class="new_folder">新規フォルダ作成</p>
                        <hr class="new_folder">
                        <form id="new_folder_form" class="form" onsubmit="return false;" action="Main?req=mkdir&path=<%=current%>" method="post">
                            <div id="new_folder_text">フォルダ名を入力</div>
                            <input oninput="checkFileName(this)" id="foldername" type="text" name="name" placeholder="200文字以上は登録できません" maxlength="199" required><br>
                            <div class="radioButtonOfNewFolder">
                                <input type="radio" name="public" value="true" checked>公開
                                <input type="radio" name="public" value="false">非公開
                            </div>
                            <input class="new_folder" type="submit" onclick="submitNewFolder()" value="作成">
                        </form>
                    </fieldset>
                </div>
            </div>
        </div>
    </div>
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
                        <li><a href="#" onclick="deleteThings()"><i class="material-icons"> delete </i></a>
                            <div class="tooltips">選択を削除</div>
                        </li>
                        <li><a href="#" onclick="exeDownload()"><i class="material-icons"> cloud_download </i></a>
                            <div class="tooltips">ダウンロード</div>
                        </li>
                        <li><a href="#" onclick="openUploadWindow()"><i class="material-icons"> cloud_upload </i></a>
                            <div class="tooltips">アップロード</div>
                        </li>
                        <li><a id="left_con" href="#" onclick="openNewFolderWindow()"><i class="material-icons"> add </i></a>
                            <div class="tooltips">新規フォルダ</div>
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
