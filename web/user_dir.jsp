<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="model.File" %>
<%@ page import="java.nio.file.Files" %>
<%--
  Created by IntelliJ IDEA.
  User: nullpo299
  Date: 18/11/29
  Time: 15:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) session.getAttribute("USER");
    User target = (User) session.getAttribute("TARGET");
    List<File> files = (List<File>) session.getAttribute("FILES");
%>
<html>
<head>
    <title>MyDrive</title>
</head>
<body>

<h1>MyDrive</h1>
<h2><%=target.getFullName()%>のディレクトリ</h2>

<form action="Configuration" method="post">
    <input type="submit" value="config">
</form>
<form action="Logout" method="post">
    <input type="submit" value="logout">
</form>
<form action="Main?req=home" method="post">
    <input type="submit" value="home">
</form>
<form action="Main?req=sear_user" method="post">
    <input type="submit" value="sear_user">
</form>
<form action="Main?req=fav" method="post">
    <input type="submit" value="fav">
</form>
<form action="Main?req=trash" method="post">
    <input type="submit" value="trash">
</form>

<%
    out.println("Contents<br><br>");

    for (File f : files) {
        if (Files.isDirectory(f.getPath())) {
            out.println("<form action=\"Main?cd=move&src=user_dir&name=" +
                    f.getName() + "&path=" + f.getPath() + "&id=" + target.getId() + "\" method=\"post\">");
            out.println("<input type=\"submit\" value=\"" + f.getName() + "\">");
            out.println("</form>");
        } else {
            out.println(f.getName() + "<br>");
        }
    }

    out.println("<br>This is user_dir.jsp!!!<br>");
%>

</body>
</html>
