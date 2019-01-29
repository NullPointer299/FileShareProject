class User {
    constructor(lName, fName, id, favorite) {
        this.fName = fName;
        this.lName = lName;
        this.id = id;
        this.favorite = favorite;
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
    get isFav() {
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
    if (showUsers.length != 0) {
        for (var v of showUsers) {
            temp += "<div class=\"person\" ondblclick=jump(\'Main?req=show_dir&id=" + v.myId + "\',\"post\") oncontextmenu=\"return rightclick(new User(\'" + v.myLName + "\',\'" + v.myFName + "\',\'" + v.myId + "\',\'" + v.isFav + "\'))\"><a style=\"text-decoration:none;color:black;\" href=\"#\"><i class=\"material-icons\">person</i> 名前:" + v.myLName + " " + v.myFName + "   ID:" + v.myId + "</a></div>";
        }
    }else{
        temp += "<div class=\'empty\'><h1 style=\'color:lightgray\'>表示するUserが居ません</h1></div>";
    }
    target.innerHTML = temp;
}

function charFilterOfUser(target) {
    showUsers = haveUsers.filter(user => user.myId.indexOf(target.value) > -1);
    createMainOfUser();
}
