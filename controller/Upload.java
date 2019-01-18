package controller;

import model.MyDriveDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

@WebServlet(name = "Upload", urlPatterns = "/Upload")
@MultipartConfig
public class Upload extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession ses = request.getSession();
        boolean isPublic = request.getParameter("public") != null;
        User user = (User) ses.getAttribute("USER");
        Part part = request.getPart("file");
        String name = getFileName(part);
        String path = request.getParameter("path");
        part.write(getServletContext().getRealPath("WEB-INF/uploaded") + "/" + path + "/" + name);
        ses.setAttribute("FILES", user.setHome(MyDriveDAO.move(Paths.get(path), null)));

        if (isPublic)
            MyDriveDAO.writeBlacklist(path.replace(name, ""), name, user.getId());

        request.getRequestDispatcher("WEB-INF/web/home.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    private String getFileName(Part part) {
        String name = null;
        for (String dispotion : part.getHeader("Content-Disposition").split(";")) {
            if (dispotion.trim().startsWith("filename")) {
                name = dispotion.substring(dispotion.indexOf("=") + 1).replace("\"", "").trim();
                name.substring(name.lastIndexOf("\\") + 1);
            }
        }
        return name;
    }
}
