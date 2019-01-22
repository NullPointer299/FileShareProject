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
        String url = "WEB-INF/web/configuration.jsp";
        String req = request.getParameter("req");
        if (req == null) {
            String fName = request.getParameter("fName");
            String lName = request.getParameter("lName");
            String pass = request.getParameter("pass");
            boolean isPublic = Boolean.parseBoolean(request.getParameter("public"));
            if (fName != null && lName != null) {
                if (MyDriveDAO.updateName(user.getId(), fName, lName)) {
                    user.setFirstName(fName);
                    user.setLastName(lName);
                } else {
                    System.out.println("updateName failed!!!"); //TODO debug code here!
                }
            }
            if (pass != null) {
                if (!MyDriveDAO.updatePassword(user.getId(), pass)) {
                    System.out.println("updatePassword failed!!!"); //TODO debug code here!
                }
            }
            if (user.isPublic() != isPublic) {
                if (MyDriveDAO.updatePublic(user.getId(), isPublic ? 1 : 0)) {
                    user.setIsPublic(isPublic);
                } else {
                    System.out.println("updatePublic failed!!!");   //TODO debug code here!
                }
            }
        } else {
            if (req.equals("remove")) {
                // アカウント削除
                if(MyDriveDAO.removeUser(user.getId())){
                    url="index.jsp";
                }
            } else {
                System.out.println("unknown request");  //TODO debug code here!
            }
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url;
        url = "WEB-INF/web/configuration.jsp";
        request.getRequestDispatcher(url).forward(request, response);
    }
}
