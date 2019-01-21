package controller;

import org.apache.commons.io.IOUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@WebServlet(name = "Download", urlPatterns = "/Download")
public class Download extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String path = request.getParameter("path");
        System.out.println("request => name="+name+" : path="+path);
        Path srcPath = Paths.get("/home/nullpo299/IdeaProjects/FileShareService/out/artifacts/FileShareService_war_exploded/WEB-INF/uploaded");
        OutputStream out = response.getOutputStream();
        InputStream in = Files.newInputStream(srcPath.resolve(path).resolve(name));
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
        out.write(in.readAllBytes());
        out.close();
        in.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
