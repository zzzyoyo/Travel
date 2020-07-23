package servlet;

import dao.FavorDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdatePictureServlet",urlPatterns = {"*.update"})
public class UpdatePictureServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    private void add(HttpServletRequest request, HttpServletResponse response){
//        System.out.println("add");
        int uid = Integer.parseInt(request.getParameter("uid"));
        int imageID = Integer.parseInt(request.getParameter("imageID"));
        FavorDao favorDao = new FavorDao();
        favorDao.addCollection(uid,imageID);
    }

    private void delete(HttpServletRequest request, HttpServletResponse response){
//        System.out.println("delete");
        int uid = Integer.parseInt(request.getParameter("uid"));
        int imageID = Integer.parseInt(request.getParameter("imageID"));
        FavorDao favorDao = new FavorDao();
        favorDao.deleteCollection(uid,imageID);
    }

    private void set(HttpServletRequest request, HttpServletResponse response){

    }
}
