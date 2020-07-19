package servlet;

import com.alibaba.fastjson.JSONObject;
import dao.PictureDao;
import domain.Picture;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchServlet",urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        JSONObject jsonObject = new JSONObject();
        String content = request.getParameter("content");
        String filter = request.getParameter("filter");
        String sort = request.getParameter("sort");
        System.out.println("content:"+content);
        PictureDao pictureDao = new PictureDao();
        List<Picture> pictures = pictureDao.getPicturesByFuzzyContent(content,filter,sort);
        jsonObject.put("pictures",pictures);
//        System.out.println(pictures);
        response.getWriter().println(jsonObject);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
