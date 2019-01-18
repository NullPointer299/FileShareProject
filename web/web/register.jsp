<%--
  Created by IntelliJ IDEA.
  User: nullpo299
  Date: 18/11/19
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>
    <meta charset="utf-8">
    <title>MyDrive</title>
    <meta name="description" content="ファイル共有サービス">
    <link rel="stylesheet" href="css/register.css">
    <script>
        function CheckPassword(confirm) {
            var input1 = password.value;
            var input2 = passwordCheck.value;

            if (input1 != input2) {
                confirm.setCustomValidity("入力値が一致しません");
            } else {
                confirm.setCustomValidity('');
            }
        }
    </script>
    <script type="text/javascript" src="js/register.js"></script>
</head>

<body>
    <div class="wrapper">
        <div class="content">
            <fieldset class="register">
                <h1>
                    <font class="M">M</font>y<font class="D">D</font>rive
                </h1>

                <h2 class="title">新規登録</h2>

                <form id="registerForm" action="Register" onsubmit="return false;" method="post">
                    <div class="form"><label for="lastName" class="form">姓</label><input id="lastName" type="text" name="lName" placeholder=" (例)山田" autofocus required></div>

                    <div class="form"><label for="firstName" class="form">名</label><input id="firstName" type="text" name="fName" placeholder=" (例)太郎" required></div>

                    <div class="form"><label for="id" class="form">ID</label><input id="id" type="text" name="id" placeholder=" (例)tarou" required></div>

                    <div class="form"><label for="password" class="form">パスワード</label><input name="password" id="password" type="password" required></div>

                    <div class="form"><label for="passwordCheck" class="form">パス確認</label><input name="passwordCheck" id="passwordCheck" type="password" oninput="CheckPassword(this)" required></div>

                    <div class="submit form">
                        <input type="submit" value="登録" onclick="printConfirm()">
                    </div>
                </form>
            </fieldset>
            <div id="confirm">
            </div>
        </div>
    </div>
</body>


</html>
