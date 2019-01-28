class trashFile {
    constructor(name, type, path, restore, dispName) {
        this.name = name;
        this.type = type;
        this.path = path;
        this.restore = restore;
        this.dispName = dispName;
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
    get isRestore() {
        return this.restore;
    }
    get myDispName() {
        return this.dispName;
    }
}
class trashFolder {
    constructor(name, type, path, restore, dispName) {
        this.name = name;
        this.type = type;
        this.path = path;
        this.restore = restore;
        this.dispName = dispName;
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
    get isRestore() {
        return this.restore;
    }
    get myDispName() {
        return this.dispName;
    }
}

function deleteThingsAtTrash() {
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
    if (confirm("選択済みを削除しますがよろしいですか？")) {
        jump("Trash?req=delete&names=" + temp + "&path=" + path, "post");
    }
}

function deleteAll(){
    var temp = "";
    var files = [];
    var dirs = [];
    var path;
    for (let f of showFiles) {
            path = f.myPath;
            files.push(f.myName);
    }
    for (let f of showFolders) {
            path = f.myPath;
            dirs.push(f.myName);
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
            alert("ファイルまたはディレクトリがありません");
            return;
        }
    }
    if (confirm("すべてを削除しますがよろしいですか？")) {
        jump("Trash?req=delete&names=" + temp + "&path=" + path, "post");
    }
}
