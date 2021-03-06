var haveFiles;
var showFiles;
var haveFolders;
var showFolders;
var sortBy = "name";
var order = 0;
let usersId;

function sortLoad(folders, files) { //ロード時
    haveFolders = folders
    showFolders = folders
    haveFiles = files;
    showFiles = files;
    sortBy = "name";
    order = 0;
    sortByName();
}

function sortLoadAtOthers_dir(folders,files,id){
     haveFolders = folders
    showFolders = folders
    haveFiles = files;
    showFiles = files;
    sortBy = "name";
    order = 0;
    usersId=id;
    sortByName();
}

function setHaveFiles(array) { //現階層のファイルをセット
    haveFiles = array;
}

function setShowFiles(array) { //いま表示しているものを格納
    showFiles = array;
}

class File {
    constructor(name, type, path, pub) {
        this.name = name;
        this.type = type;
        this.path = path
        this.pub = pub;
    }
    get myName() {
        return this.name;
    }
    get myType() {
        return this.type;
    }
    get myPath() {
        return this.path;
    }
    get isPublic() {
        return this.pub;
    }
}

class Folder {
    constructor(name, type, path, pub) {
        this.name = name;
        this.type = type;
        this.path = path;
        this.pub = pub;
    }
    get myName() {
        return this.name;
    }
    get myType() {
        return this.type;
    }
    get myPath() {
        return this.path;
    }
    get isPublic() {
        return this.pub;
    }
}

function sortByName() {
    if (nowPage == "home" || nowPage == "trash" || nowPage == "others_dir") {
        if (order == 0) {
            showFolders.sort(function (a, b) {
                if (a.myName < b.myName) return -1;
                if (a.myName > b.myName) return 1;
            });
        } else {
            showFolders.sort(function (a, b) {
                if (a.myName < b.myName) return 1;
                if (a.myName > b.myName) return -1;
            });
        }
        if (order == 0) {
            showFiles.sort(function (a, b) {
                if (a.myName < b.myName) return -1;
                if (a.myName > b.myName) return 1;
            });
        } else {
            showFiles.sort(function (a, b) {
                if (a.myName < b.myName) return 1;
                if (a.myName > b.myName) return -1;
            });
        }
        createMain();
    } else if (nowPage == "favorite" || nowPage == "search_user") {
        if (order == 0) {
            showUsers.sort(function (a, b) {
                if (a.myLName < b.myLName) return -1;
                if (a.myLName > b.myLName) return 1;
            });
        } else {
            showUsers.sort(function (a, b) {
                if (a.myLName < b.myLName) return 1;
                if (a.myLName > b.myLName) return -1;
            });
        }
        createMainOfUser();
    }
}

function createMain() {
    var target = document.getElementById("main");
    var temp = "<form action =\"#\">";
    temp += createMainFolder() + createMainFile();
    target.innerHTML = temp;
}

function createMainFile() {
    var temp = "";
    if (nowPage != "trash") {
        for (var v of showFiles) {
            temp += "<div class=\"node\" onclick=\"check(\'" + v.myName + "\')\" oncontextmenu=\"return rightclick(new File(\'" + v.myName + "\',0,\'" + v.myPath + "\',\'" + v.isPublic + "\'))\"><a href=\"#\"><input type=\"checkbox\" name=\"" + v.myName + "\" id=\"" + v.myName + "\"><img class=\"file\" src=\"../picture/file.png\"><div class=\"check_box\"></div><div class=\"check\" id=\"" + v.myName + "_check\"></div><div class=\"filename\">" + v.myName + "</div></div>";
        }
    } else {
        for (var v of showFiles) {
            temp += "<div class=\"node\" onclick=\"check(\'" + v.myName + "\')\" oncontextmenu=\"return rightclick(new trashFile(\'" + v.myName + "\',0,\'" + v.myPath + "\',\'" + v.isRestore + "\',\'" + v.myDispName + "\'))\"><a href=\"#\"><input type=\"checkbox\" name=\"" + v.myName + "\" id=\"" + v.myName + "\"><img class=\"file\" src=\"../picture/file.png\"><div class=\"check_box\"></div><div class=\"check\" id=\"" + v.myName + "_check\"></div><div class=\"filename\">" + v.myDispName + "</div></div>";
        }
    }
    return temp;
}

function createMainFolder() {
    var temp = "";
    if(nowPage == "others_dir"){
        for (var v of showFolders) {
            temp += "<div class=\"node\" ondblclick=jump(\'Main?req=cd&name=" + v.myName + "&path=" + v.myPath + "&id=" + usersId +"\',\"post\") onclick=\"check(\'" + v.myName + "\')\" oncontextmenu=\"return rightclick(new Folder(\'" + v.myName + "\',1,\'" + v.myPath + "\',\'" + v.isPublic + "\'))\"><img class=\"folder\" src=\"../picture/folder.png\"><a href=\"#\"></a><div class=\"check_box\"></div><div class=\"check\" id=\"" + v.myName + "_check\"></div><input type=\"checkbox\" name=\'" + v.myName + "\' id=\'" + v.myName + "\'><div class=\"filename\">" + v.myName + "</div></div>";
        }
    }else if (nowPage != "trash") {
        for (var v of showFolders) {
            temp += "<div class=\"node\" ondblclick=jump(\'Main?req=cd&name=" + v.myName + "&path=" + v.myPath + "\',\"post\") onclick=\"check(\'" + v.myName + "\')\" oncontextmenu=\"return rightclick(new Folder(\'" + v.myName + "\',1,\'" + v.myPath + "\',\'" + v.isPublic + "\'))\"><img class=\"folder\" src=\"../picture/folder.png\"><a href=\"#\"></a><div class=\"check_box\"></div><div class=\"check\" id=\"" + v.myName + "_check\"></div><input type=\"checkbox\" name=\'" + v.myName + "\' id=\'" + v.myName + "\'><div class=\"filename\">" + v.myName + "</div></div>";
        }
    } else {
        for (var v of showFolders) {
            temp += "<div class=\"node\" ondblclick=jump(\'Trash?req=cd&name=" + v.myName + "&path=" + v.myPath + "\',\"post\") onclick=\"check(\'" + v.myName + "\')\" oncontextmenu=\"return rightclick(new trashFolder(\'" + v.myName + "\',1,\'" + v.myPath + "\',\'" + v.isRestore + "\',\'" + v.myDispName +"\'))\"><img class=\"folder\" src=\"../picture/folder.png\"><a href=\"#\"></a><div class=\"check_box\"></div><div class=\"check\" id=\"" + v.myName + "_check\"></div><input type=\"checkbox\" name=\'" + v.myName + "\' id=\'" + v.myName + "\'><div class=\"filename\">" + v.myDispName + "</div></div>";
        }
    }
    return temp;
}

function selectName() {
    sortBy = "name";
    var size = document.getElementById("size");
    var name = document.getElementById("name");
    name.style.color = "black";
    size.style.color = "transparent";
}

function selectAsc() {
    order = 0;
    var asc = document.getElementById("asc");
    var desc = document.getElementById("desc");
    asc.style.color = "black";
    desc.style.color = "transparent";
    if (sortBy == "name") {
        sortByName();
    } else if (sortBy == "size") {
        sortBySize();
    }
}

function selectDesc() {
    order = 1;
    var asc = document.getElementById("asc");
    var desc = document.getElementById("desc");
    desc.style.color = "black";
    asc.style.color = "transparent";
    if (sortBy == "name") {
        sortByName();
    } else if (sortBy == "size") {
        sortBySize();
    }
}

function charFilter() { //フィルタ
    var s = document.getElementById("topText").value;
    showFiles = haveFiles.filter(file => file.myName.indexOf(s) > -1);
    showFolders = haveFolders.filter(folder => folder.myName.indexOf(s) > -1);
    sortByName();
}
