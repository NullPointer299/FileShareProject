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

@WebServlet(name = "Login", urlPatterns = "/Login")
public class Login extends HttpServlet {

    static {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url;
        String id = request.getParameter("id");
        String pass = request.getParameter("pass");
        User user = MyDriveDAO.login(id, pass);
        if (user == null) {
            url = "index.jsp?stat=failed";
        } else {
            url = "WEB-INF/web/home.jsp";
            HttpSession ses = request.getSession();
            ses.setAttribute("USER", user);
            ses.setAttribute("FILES", MyDriveDAO.move(Paths.get(user.getId(), "home"), null));
            ses.setAttribute("CURRENT", Paths.get(user.getId(), "home"));
            ses.setAttribute("SRC", Paths.get("/home/nullpo299/IdeaProjects/FileShareService/out/artifacts/FileShareService_war_exploded/WEB-INF/uploaded/"));
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
