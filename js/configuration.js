function deleteAccount() {
    jump("Configuration?req=remove", "post");
}

function home() {
    jump('Main?req=home', 'post');
}

function checkPassword(confirm) {
    var input1 = document.getElementById("password").value;
    var input2 = document.getElementById("passwordCheck").value;

    if (input1 != input2) {
        document.getElementById("passwordCheck").setCustomValidity("入力値が一致しません");
    } else {
        document.getElementById("passwordCheck").setCustomValidity('');
        document.getElementById("configForm").submit();
    }
}

function loadConfig(l, f, p) {
    var lName = document.getElementById("lName");
    var fName = document.getElementById("fName");
    var select = document.getElementById("public");
    lName.placeholder = l;
    fName.placeholder = f;

    select.value = p;
}
