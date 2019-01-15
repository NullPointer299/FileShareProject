function printConfirm() {
    var target = document.getElementById("confirm");
    var lastName = document.getElementById("lastName").value;
    var firstName = document.getElementById("firstName").value;
    var id = document.getElementById("id").value;
    var password = document.getElementById("password").value;
    var passwordCheck = document.getElementById("passwordCheck").value;
    if (lastName != "" && firstName !="" &&id !="" && password !=""&&passwordCheck !="") {
        target.innerHTML = "姓：" + lastName + "<br>名：" + firstName + "<br>ID:" + id + "<br>パスワード：" + password + "<br><input type=\"submit\" value=\"戻る\" onclick=\"closeConfirm()\"><input type=\"submit\" value=\"登録\"onclick=\"submitConfirm()\">";
        target.style.display = "block";
    }
}

function submitConfirm() {
    document.getElementById("registerForm").submit;
}
