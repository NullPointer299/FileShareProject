var users;

class User{
    constructor(firstName,lastName,id){
        this.firstName=firstName;
        this.lastName = lastName;
        this.id = id;
    }
    get myFirstName(){
        return this.firstName;
    }
    
    get myLastName() {
        return this.lastName;
    }
    
    get myId() {
        return this.id;
    }
}

function loadUser(array) {
    users=array;
    console.log(array);
    createUser();
}

function createUser(){
    var target = document.getElementById("main");
    var temp ="";
    console.log(users);
    for(var v of users){
        temp += "<div class=\"person\"><a><i class=\"material-icons\">person</i> 名前:" + v.myLastName +" " + v.myFirstName + "   ID:" + v.myId + "</a></div>";
    }
    target.innerHTML=temp;
}