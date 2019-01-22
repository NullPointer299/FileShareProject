function deleteAll() {
    jump("Trash?req=deleteAll","post");
}

function deleteThingsAtTrash() {
    var temp = "";
    var files = [];
    var dirs = [];
    var path;
    for (let f of showFiles) {
        if (document.getElementById(f.myName).checked) {
            path=f.myPath;
            files.push(f.myName);
        }
    }
    for (let f of showFolders) {
        if (document.getElementById(f.myName).checked) {
            path=f.myPath;
            dirs.push(f.myName);
        }
    }

    if (files.length != 0) {
        temp += files.join();
        if (dirs.length != 0) {
            temp += "," + dirs.join();
        }
    }else{
        if(dirs.length != 0) {
            temp += dirs.join();
        }else{
            alert("削除対象を選択してください");
            return;
        }
    }
    jump("Trash?req=delete?names=" + temp +"&path=" + path, "post");
}
