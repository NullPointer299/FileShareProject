class User {
    constructor(fName,lName,id) {
        this.fName = fName;
        this.lName=lName;
        this.id = id;
    }
    get myFName() {
        return this.fName;
    }
    get myLName() {
        return this.lName;
    }
    get myId() {
        return this.id;
    }
}

var haveUsers;
var showUsers;

function loadUser(u) {
    haveUsers = u;
    showUsers = u;
    sortByName();
}

function createMainOfUser() {
    console.log("in");
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
