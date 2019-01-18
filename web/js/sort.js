var haveFiles;
var showFiles;
var haveFolders;
var showFolders;
var sortBy ="name";
var order = 0;

function sortLoad(folders,files) { //ロード時
    haveFolders=folders
    showFolders=folders
    haveFiles=files;
    showFiles=files;
    sortBy ="name";
    order = 0;
    sortByName();
}

function setHaveFiles(array) {//現階層のファイルをセット
    haveFiles = array;
}

function setShowFiles(array) {//いま表示しているものを格納
    showFiles = array;
}

class File {
    constructor(name,type) {
        this.name = name;
        this.type = type;
    }
    get myName() {
        return this.name;
    }
    get myType() {
        return this.type;
    }
}

class Folder{
    constructor(name,type) {
        this.name = name;
        this.type = type;
    }
    get myName() {
        return this.name;
    }
    get myType() {
        return this.type;
    }
}

function sortByName() {
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
}

function createMain() {
    var target = document.getElementById("main");
    var temp = "<form action =\"#\">";
    temp += createMainFolder() + createMainFile();
    target.innerHTML = temp;
}
function createMainFile() {
    var temp="";
    for (var v of showFiles) {
        temp += "<div class=\"node\"><a href=\"#\"><img class=\"file\" src=\"picture/file.png\" onclick=\"check(\'" + v.myName + "\')\" oncontextmenu=\"rightclick(new File(\'" + v.myName + "\',0))\"></a><input type=\"checkbox\" name=\'" + v.myName + "\' id=\'" + v.myName + "\'><label for=\'" + v.myName + "\' class=\"check_css\"></label><div class=\"filename\">" + v.myName + " </div></div>";
    }
    return temp;
}

function createMainFolder() {
    var temp="";
    for(var v of showFolders) {
        temp += "<div class=\"node\"><a href=\"#\"><img class=\"folder\" src=\"picture/folder.png\" ondblclick=jump(\'Main?req=move&src=home&name=" + v.myName + "\',\"post\") onclick=\"check(\'" + v.myName + "\')\" oncontextmenu=\"rightclick(new Folder(\'" + v.myName + "\',1))\"></a><input type=\"checkbox\" name=\'" + v.myName + "\' id=\'" + v.myName + "\'><label for=\'" + v.myName + "\' class=\"check_css\"></label><div class=\"filename\">" + v.myName + " </div></div>";
    }
    return temp;
}

function selectName() {
    sortBy="name";
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
    if(sortBy == "name") {
        sortByName();
    }else if(sortBy == "size") {
        sortBySize();
    }
}

function selectDesc() {
    order = 1;
    var asc = document.getElementById("asc");
    var desc = document.getElementById("desc");
    desc.style.color = "black";
    asc.style.color = "transparent";
    if(sortBy == "name") {
        sortByName();
    }else if(sortBy == "size") {
        sortBySize();
    }
}

function charFilter(){//フィルタ
    var s = document.getElementById("topText").value;
    showFiles = haveFiles.filter(file => file.myName.indexOf(s) > -1);
    showFolders = haveFolders.filter(folder => folder.myName.indexOf(s) > -1);
    sortByName();
}