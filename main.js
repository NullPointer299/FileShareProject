function selectName() {
    var size = document.getElementById("size");
    var name = document.getElementById("name");
    var time = document.getElementById("time");
    name.style.color = "black";
    size.style.color = "transparent";
    time.style.color = "transparent";
}

function selectAsc() {
    var asc = document.getElementById("asc");
    var desc = document.getElementById("desc");
    asc.style.color = "black";
    desc.style.color = "transparent";
}

function selectDesc() {
    var asc = document.getElementById("asc");
    var desc = document.getElementById("desc");
    desc.style.color = "black";
    asc.style.color = "transparent";
}

function check(id) {
    var target = document.getElementById(id);
    if (target.checked) {
        target.checked = false;
    } else {
        target.checked = true;
    }
}

var subWin;

function openUpWindow() {
    closeWindow();
    var w = (screen.width - 640) / 2;
    var h = (screen.height - 480) / 2;
    subWin = window.open('/home/fukui-hiraku/BracketsFile/upload.html', "アップロード", "width=350 height=350　resizable=no left=" + w + ' top=' + h);
}

function closeWindow() {
    if ((subWin != null) && (!subWin.closed)) {
        subWin.close();
    }
    subWin = null;
}

function upload() {
    var parent = window.opener.document;
    window.open('about:blank', '_self').close();
    parent.getElementById("hideForm").submit();
}

function openNewFolderWindow() {
    closeWindow();
    var w = (screen.width - 640) / 2;
    var h = (screen.height - 480) / 2;
    subWin = window.open('/home/fukui-hiraku/BracketsFile/new_folder.html', "アップロード", "width=350 height=270 left=" + w + ' top=' + h);
}

function openDownWindow() {
    var target = document.getElementById("hideForm");
    var array = [];
    var flag;
    for (var v of haveFolders) {
        if (document.getElementById(v.myName).checked) {
            flag = true;
            break;
        }
    }
    if (!flag) {
        for (var v of haveFiles) {
            if (document.getElementById(v.myName).checked) {
                array.push(v.myName);
            }
        }
        if (array.length == 0) {
            alert("ファイルが選択されていません");
        } else {
            alert(array);
        }
    }else{
        alert("フォルダはダウンロードできません");
    }
}

/*-----------------------------------------------------------
右クリック関連
-----------------------------------------------------------*/

var posX;
var posY;

document.addEventListener('contextmenu', function (e) {
    posX = e.clientX;
    posY = e.clientY;
});

document.addEventListener('click', function () {
    var submenu = document.getElementById('submenu');
    if (submenu.classList.contains('show')) {
        submenu.classList.remove('show');
    }
});

function rightclick(clicked) {
    window.setTimeout(function () {
        showSubmenu(clicked);
    }, 100);
}

function showSubmenu(clicked) {
    var submenu = document.getElementById('submenu');
    var name=clicked.myName;
    if(clicked.myName.length > 11) {
        name=clicked.myName.substring(0,10) +"...";
    }
    if(clicked.myType == 0) {
        submenu.innerHTML = "<ul><li class=\"cut\">"+ name + "<li><a href=\"#\">ダウンロード</a></li><li><a href=\"#\">削除</a></li></ul>";
        submenu.style.height = "60px";
    }else{
        submenu.innerHTML = "<ul><li>" + name + "</li><li><a href=\"#\">開く</a></li><li><a href=\"#\">削除</a></li></ul>";
        submenu.style.height = "60px";
    }
    submenu.style.position = 'absolute';
    submenu.style.left = posX + "px";
    submenu.style.top = posY + "px";
    submenu.classList.add("show");
}
