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
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        Map<String, String> info = new HashMap<>();
        info.put("fname", firstName);
        info.put("lname", lastName);
        info.put("id", id);
        info.put("pass", password);
        request.getSession().setAttribute("INFO", info);
        request.getRequestDispatcher("WEB-INF/web/register_confirm.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        HttpSession ses = request.getSession();
        Map<String, String> info = (Map<String, String>) ses.getAttribute("INFO");
        String id = info.get("id");
        String fname = info.get("fname");
        String lname = info.get("lname");
        String pass = info.get("pass");
        if (MyDriveDAO.createUser(id, fname, lname, pass)) {
            User user = MyDriveDAO.login(id, pass);
            ses.setAttribute("USER", user);
            ses.setAttribute("FILES", MyDriveDAO.move(Paths.get(user.getId(), "home"), null));
            ses.setAttribute("CURRENT", Paths.get(user.getId(), "home"));
            ses.setAttribute("SRC", Paths.get("/home/nullpo299/IdeaProjects/FileShareService/out/artifacts/FileShareService_war_exploded/WEB-INF/uploaded/"));
        } else {
            throw new NullPointerException("Into else block!");   //TODO debug code here!
        }
        request.getRequestDispatcher("WEB-INF/web/home.jsp").forward(request, response);
    }
}
