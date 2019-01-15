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

@WebServlet(name = "Configuration", urlPatterns = "/Configuration")
public class Configuration extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        HttpSession ses = request.getSession();
        User user = (User) ses.getAttribute("USER");
        String req = request.getParameter("req");
        String url = "WEB-INF/web/configuration.jsp";
        switch (req) {
            case "chname":
                String firstName = request.getParameter("first");
                String lastName = request.getParameter("last");
                if (MyDriveDAO.updateName(user.getId(), firstName, lastName)) {
                    user.setFirstName(firstName);
                    user.setLastName(lastName);
                    url += "?stat=done";
                } else {
                    System.out.println("[Configuration]Change name is Failed!!!");
                    url += "?stat=failed";
                }
                break;
            case "chpass":
                String pass = request.getParameter("new");
                if (MyDriveDAO.updatePassword(user.getId(), pass)) {
                    url += "?stat=done";
                } else {
                    System.out.println("[Configuration]Change password is Failed!!!");
                    url += "?stat=failed";
                }
                break;
            case "chpub":
                int pub = Integer.parseInt(request.getParameter("public"));
                if (MyDriveDAO.updatePublic(user.getId(), pub)) {
                    user.setIsPublic(pub > 0);
                    url += "?stat=done";
                } else {
                    System.out.println("[Configuration]Change public is Failed!!!");
                    url += "?stat=failed";
                }
                break;
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url;
        url = "WEB-INF/web/configuration.jsp";
        request.getRequestDispatcher(url).forward(request, response);
    }
}
