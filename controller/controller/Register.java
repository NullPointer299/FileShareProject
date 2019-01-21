package controller;

import model.MyDriveDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "Register", urlPatterns = "/Register")
public class Register extends HttpServlet {

    static {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        HttpSession ses = request.getSession();
        String id = request.getParameter("id");
        String fName = request.getParameter("fName");
        String lName = request.getParameter("lName");
        String password = request.getParameter("password");
        if (MyDriveDAO.createUser(id, fName, lName, password)) {
            User user = MyDriveDAO.login(id, password);
            ses.setAttribute("USER", user);
            ses.setAttribute("FILES", MyDriveDAO.move(Paths.get(user.getId(), "home"), null));
            ses.setAttribute("CURRENT", Paths.get(user.getId(), "home"));
            ses.setAttribute("SRC", Paths.get("/home/nullpo299/IdeaProjects/FileShareService/out/artifacts/FileShareService_war_exploded/WEB-INF/uploaded/"));
        } else {
            throw new RuntimeException("Into else block!");   //TODO debug code here!
        }
        request.getRequestDispatcher("WEB-INF/web/home.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
