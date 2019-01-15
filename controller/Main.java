package controller;

import model.File;
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
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "Main", urlPatterns = "/Main")
public class Main extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String req = request.getParameter("req");
        StringBuilder url;
        if (req == null) {
            url = new StringBuilder("index.jsp");
        } else {
            url = new StringBuilder("WEB-INF/web/");
            HttpSession ses = request.getSession();
            User user = (User) ses.getAttribute("USER");
            String name;
            String path;
            String id;
            switch (req) {
                case "sear_word":
                    System.out.println("[Main]sear_word");
                    String userKeyword = request.getParameter("keyword");
                    if (userKeyword != null) {
                        ses.setAttribute("USERS", MyDriveDAO.searchUser(userKeyword));
                    }
                    url.append("search_user.jsp");
                    break;
                case "home":
                    System.out.println("[Main]home");
                    List<File> userDir = user.getHome();
                    ses.setAttribute("FILES", userDir == null ? user.setHome(MyDriveDAO.move(Paths.get(user.getId(), "home"), null)) : userDir);
                    ses.setAttribute("CURRENT", Paths.get(user.getId(), "home"));
                    url.append("home.jsp");
                    break;
                case "sear_user":
                    System.out.println("[Main]sear_user");
                    ses.removeAttribute("USERS");
                    url.append("search_user.jsp");
                    break;
                case "fav":
                    System.out.println("[Main]fav");
                    List<User> fav = user.getFav();
                    ses.setAttribute("FAV", fav == null ? user.setFav(MyDriveDAO.getFav(user.getId())) : fav);
                    url.append("favorite.jsp");
                    break;
                case "trash":
                    System.out.println("[Main]trash");
                    List<File> trash = user.getTrash();
                    ses.setAttribute("FILES", trash == null ? user.setTrash(MyDriveDAO.move(Paths.get(user.getId(), "trash"), null)) : trash);
                    ses.setAttribute("CURRENT", Paths.get(user.getId(), "trash"));
                    url.append("trash.jsp");
                    break;
                case "show_dir":
                    System.out.println("[Main]show_dir");
                    id = request.getParameter("id");
                    User target = ((List<User>) ses.getAttribute("USERS")).stream().filter(u -> u.getId().equals(id)).findFirst().orElse(null);
                    ses.setAttribute("FILES", MyDriveDAO.move(Paths.get(target.getId(), "home"), target.getId()));
                    ses.setAttribute("TARGET", target);
                    ses.setAttribute("CURRENT", Paths.get(id, "home"));
                    url.append("user_dir.jsp");
                    break;
                case "move":
                    System.out.println("[Main]move");
                    name = request.getParameter("name");
                    String src = request.getParameter("src");
                    path = request.getParameter("path");
                    id = request.getParameter("id");
                    ses.setAttribute("FILES", MyDriveDAO.move(Paths.get(path, name), id));
                    ses.setAttribute("CURRENT", Paths.get(path , name));
                    url.append(src).append(".jsp");
                    break;
                case "mkdir":
                    System.out.println("[Main]mkdir");
                    name = request.getParameter("name");
                    path = request.getParameter("path");
                    MyDriveDAO.mkdir(Paths.get(path, name));
                    user.setHome(null);
                    ses.setAttribute("FILES", MyDriveDAO.move(Paths.get(path), null));
                    url.append("home.jsp");
                    break;
                case "delete":
                    System.out.println("[Main]delete");
                    String check=request.getParameter("check");
                    String[] split=check.split(",");
                    System.out.println(Arrays.asList());
                    url.append("home.jsp");
                    break;
            }
        }
        request.getRequestDispatcher(url.toString()).forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
