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

function exeDownload() {
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
            jump("Download?" + array, "post");
        }
    } else {
        alert("フォルダはダウンロードできません");
    }
}

function fileChange() {
    var s = document.getElementById("file").value.split("\\");
    var st = s[s.length - 1];
    var target = document.getElementById("filePosition").value = st;
    document.getElementById("upload_filename").value = st;
}

function duplicate() {
    var box = document.getElementById("upload_filename").value;
    if (haveFiles.indexOf(box) <= -1 && haveFolders.indexOf(box) <= -1) {
        return true;
    } else {
        alert("名前が重複しています")
        return false;
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
        for (let v of showFiles) {
            if (v.myName.equals(clicked.myName)) {
                document.getElementById(v.myName).checked = true;
            }else{
                document.getElementById(v.myName).checked=false;
            }
        }
        for (let v of showFolders) {
            if (v.myName.equals(clicked.myName)) {
                document.getElementById(v.myName).checked = true;
            }else{
                document.getElementById(v.myName).checked=false;
            }
        }
    }, 100);
}

function showSubmenu(clicked) {
    var submenu = document.getElementById('submenu');
    var name = clicked.myName;
    if (clicked.myName.length > 6) {
        name = clicked.myName.substring(0, 6) + "...";
    }
    if (clicked.myType == 0) {
        submenu.innerHTML = "<ul><li class=\"cut\">" + name + "<li><a href=\"#\" onclick=rightDownload(\"" + name + "\")>ダウンロード</a></li><li><a href=\"#\" onclick=deleteThing(\"" + name + "\")>削除</a></li></ul>";
        submenu.style.height = "60px";
    } else {
        submenu.innerHTML = "<ul><li>" + name + "</li><li><a href=\"#\" onclick=jump(\'Main?req=move&src=home&name=" + name + "\',\"post\")>開く</a></li><li><a href=\"#\" onclick=deleteThing(\"" + name + "\")>削除</a></li></ul>";
        submenu.style.height = "60px";
    }
    submenu.style.position = 'absolute';
    submenu.style.left = posX + "px";
    submenu.style.top = posY + "px";
    submenu.classList.add("show");
}

function rightDownload(name) {
    jump("Download?" + name, "post");
}

function deleteThing(name) {
    console.log(name);
    jump("Main?req=delete?" + name, "post");
}

/*-----------------------------------------------------------
submit
-----------------------------------------------------------*/

function jump(dis, method) {
    var form = document.createElement("form");
    form.setAttribute("action", dis);
    form.setAttribute("method", method);
    form.style.display = "none";
    document.body.appendChild(form);
    form.submit();
}

function createFolder() {
    window.setTimeout(function () {
        jump("Main?req=home", "post");
    })
}

/*--------------------------------------------------
new_folder
---------------------------------------------------*/
function openNewFolderWindow() {
    document.getElementById("cover").style.display = "block";
    document.getElementById("new_folder_content").style.display = "block";
}

function closeNewFolderWindow() {
    document.getElementById("cover").style.display = "none";
    document.getElementById("new_folder_content").style.display = "none";
}

/*-----------------------------------------------------
upload
------------------------------------------------------*/

function openUploadWindow() {
    document.getElementById("cover").style.display = "block";
    document.getElementById("upload_content").style.display = "block";
}

function closeUploadWindow() {
    document.getElementById("cover").style.display = "none";
    document.getElementById("upload_content").style.display = "none";
}
