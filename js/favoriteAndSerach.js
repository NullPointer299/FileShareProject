class User {
    constructor(fName,lName id) {
        this.fName = fName;
        this.lName=lName;
        this.id = id;
    }
    get myFName() {
        return this.fname;
    }
    get myLName() {
        return this.lName
    }
    get myId() {
        return this.id;
    }
}

var haveUsers;
var showUsers;
var favoriteUsers;

function loadUser(u,fu) {
    haveUsers = u;
    showUsers = u;
    favoriteUsers=fu;
    sortByNameOfUser();
}

function sortByNameOfUser() {
    if (order == 0) {
        showUsers.sort(function (a, b) {
            if (a.myName < b.myName) return -1;
            if (a.myName > b.myName) return 1;
        });
    } else {
        showUsers.sort(function (a, b) {
            if (a.myName < b.myName) return 1;
            if (a.myName > b.myName) return -1;
        });
    }
    createMainOfUser();
}

function createMainOfUser() {
    var target = document.getElementById("main");
    var temp = "";
    for (var v of showUsers) {
        temp += "<div class=\"person\" onclick=jump(---------------------------パラメータとか----------------------,\"post\")><a href=\"#\"><i class=\"material-icons\">person</i> 名前:" + v.myLName + " " + v.myFName + "   ID:" + v.myId + "</a></div>";
    }
    target.innerHTML = temp;

}

function charFilterOfUser() {
    showUsers = haveUsers.filter(user => user.myName.indexOf(s) > -1);
    createMainAtFavorite();
}
