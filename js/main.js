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

function exeDownload() {
    var array = [];
    var flag;
    for (var v of showFolders) {
        console.log(v.myName);
        if (document.getElementById(v.myName).checked) {
            flag = true;
            break;
        }
    }
    if (!flag) {
        for (var v of showFiles) {
            if (document.getElementById(v.myName).checked) {
                array.push(v);
            }
        }
        if (array.length == 0) {
            alert("ファイルが選択されていません");
        } else {
            for (var f of array) {
                window.setTimeout(jump("Download?name=" + f.myName + "&path=" + f.myPath, "post"), 100);
            }
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

/*----------------------------------------------------------
checkbox関連
------------------------------------------------------------*/

function check(id) {
    var target = document.getElementById(id);
    var check = document.getElementById(id + "_check");
    if (target.checked) {
        check.style.display = "none";
        target.checked = false;
    } else {
        check.style.display = "block";
        target.checked = true;
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
        for (let v of haveFiles) {
            if (v.myName == clicked.myName) {
                document.getElementById(v.myName).checked = true;
                document.getElementById(v.myName + "_check").style.display = "block";
            } else {
                document.getElementById(v.myName).checked = false;
                document.getElementById(v.myName + "_check").style.display = "none";
            }
        }
        for (let v of haveFolders) {
            if (v.myName == clicked.myName) {
                document.getElementById(v.myName).checked = true;
                document.getElementById(v.myName + "_check").style.display = "block";
            } else {
                document.getElementById(v.myName).checked = false;
                document.getElementById(v.myName + "_check").style.display = "none";
            }
        }
        showSubmenu(clicked);
    }, 100);
    return false;
}

function showSubmenu(clicked) {
    console.log("in");
    var submenu = document.getElementById('submenu');
    var name = clicked.myName;
    var path = clicked.myPath;
    var pub;
    if (clicked.isPublic == "true") {
        pub = "<li><a hef=\"#\" onclick=jump(\'Main?path=" + path + "&name=" + name + "&public=" + !clicked.isPublic + "\',\'post\')>非公開にする</a></li>";
    } else {
        s
        pub = "<li><a href=\"#\" onclick=jump(\'Main?path=" + path + "&name=" + name + "&public=" + !clicked.isPublic + "\',\'post\')>公開にする</a></li>";
    }
    if (clicked.myType == 0) {
        submenu.innerHTML = "<ul><li><h6 class=\"cut\">" + name + "</h6><li><a href=\"#\" onclick=exeDownload()>ダウンロード</a></li><li><a href=\"#\" onclick=deleteThings()>削除</a></li>" + pub + "</ul>";
        submenu.style.height = "90px";
    } else {
        submenu.innerHTML = "<ul><li><h6 class=\"cut\">" + name + "</h6></li><li><a href=\"#\" onclick=jump(\'Main?req=cd&src=home&name=" + name + "&path=" + path + "\',\"post\")>開く</a></li><li><a href=\"#\" onclick=deleteThings()>削除</a></li>" + pub + "</ul>";
        submenu.style.height = "90px";
    }
    submenu.style.position = 'absolute';
    submenu.style.left = posX + "px";
    submenu.style.top = posY + "px";
    submenu.classList.add("show");
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

/*function createFolder() {
    window.setTimeout(function () {
        jump("Main?req=home", "post");
    })
}*/

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

function submitNewFolder() {
    console.log("in");
    if (duplicate("foldername")) {
        alert("名前が重複しています");
    } else {
        document.getElementById("new_folder_form").submit();
    }
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

function submitUpload() {
    console.log("in");
    if (duplicate("upload_filename")) {
        alert("名前が重複しています");
    } else {
        document.getElementById("upload_form").submit();
    }
}

/*----------------------------------------------------------
削除
-----------------------------------------------------------*/

function deleteThings() {
    var temp = "";
    var files = [];
    var dirs = [];
    var path;
    for (let f of showFiles) {
        if (document.getElementById(f.myName).checked) {
            path = f.myPath;
            files.push(f.myName);
        }
    }
    for (let f of showFolders) {
        if (document.getElementById(f.myName).checked) {
            path = f.myPath;
            dirs.push(f.myName);
        }
    }

    if (files.length != 0) {
        temp += files.join();
        if (dirs.length != 0) {
            temp += "," + dirs.join();
        }
    } else {
        if (dirs.length != 0) {
            temp += dirs.join();
        } else {
            alert("削除対象を選択してください");
            return;
        }
    }
    jump("Main?req=delete?names=" + temp + "&path=" + path, "post");
}

/*--------------------------------------------------------------
重複
-----------------------------------------------------------------*/
function duplicate(target) {
    var name = document.getElementById(target).value;
    var flag = false;
    for (let f of haveFiles) {
        if (f.myName == name) {
            flag = true;
            break;
        }
    }
    if (!flag) {
        for (let f of haveFolders) {
            if (f.myName == name) {
                flag = true;
                break;
            }
        }
    }
    return flag;
}
/*---------------------------------------------------------------
パンくずリスト
-----------------------------------------------------------------*/

function loadBreadcrumb(path) {
    var target = document.getElementById("breadcrumb");
    var pathArray = path.split("/");
    var temp = "<ul>";
    var parent = pathArray[0];

    for (var i = 1; i < pathArray.length; i++) {
        temp += "<li><a href=\"#\" onclick=jump(\'Main?req=cd&src=home&name=" + pathArray[i] + "&path=" + parent + "\',\"post\")>" + pathArray[i] + "</a></li>";
        parent += "/" + pathArray[i];
    }
    temp += "</ul>";
    target.innerHTML = temp;
}
