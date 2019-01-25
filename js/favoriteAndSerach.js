class User {
    constructor(fName,lName,id,favorite) {
        this.fName = fName;
        this.lName=lName;
        this.id = id;
        this.favorite=favorite;
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
    get isFav(){
        return this.favorite;
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
    var target = document.getElementById("main");
    var temp = "";
    for (var v of showUsers) {
        temp += "<div class=\"person\" onclick=jump(\'\',\"post\") oncontextmenu=\"return rightclick(new User(\'" + v.myLName + "\',\'" + v.FName + "\',\'" + v.myId + "\',\'" + v.isFav + "\'))\"><a href=\"#\"><i class=\"material-icons\">person</i> 名前:" + v.myLName + " " + v.myFName + "   ID:" + v.myId + "</a></div>";
    }
    target.innerHTML = temp;
}

function charFilterOfUser() {
    showUsers = haveUsers.filter(user => user.myName.indexOf(s) > -1);
    createMainAtFavorite();
}
