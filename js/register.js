function printConfirm() {
    var target = document.getElementById("confirm");
    var lastName = document.getElementById("lastName").value;
    var firstName = document.getElementById("firstName").value;
    var id = document.getElementById("id").value;
    var password = document.getElementById("password").value;
    var passwordCheck = document.getElementById("passwordCheck").value;
    if (lastName != "" && firstName !="" &&id !="" && password !=""&&passwordCheck !="" && (password == passwordCheck)) {
        target.style.display = "block";
        document.getElementById("confirm_lName").innerHTML=lastName;
        document.getElementById("confirm_fName").innerHTML=firstName;
        document.getElementById("confirm_id").innerHTML=id;
    }
}

function closeConfirm() {
    document.getElementById("confirm").style.display="none";
}

function submitConfirm() {
    console.log("in");
    document.getElementById("registerForm").submit();
}