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
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

@WebServlet(name = "GetPicturesServlet",urlPatterns = {"*.get"})
public class GetPicturesServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String methodName = request.getServletPath().substring(1,request.getServletPath().indexOf('.'));
        try {
            Method method = getClass().getDeclaredMethod(methodName,HttpServletRequest.class,HttpServletResponse.class);
            method.invoke(this,request,response);
        } catch (NoSuchMethodException e) {
            System.out.println("no method: "+methodName);
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    private void collections(HttpServletRequest request, HttpServletResponse response) throws IOException{
        System.out.println("commections");
        JSONObject jsonObject = new JSONObject();
        int page = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("pageSize"));
        int uid = Integer.parseInt(request.getParameter("uid"));
        PictureDao pictureDao = new PictureDao();
        List<Picture> pictures = pictureDao.getCollectionsByUid(uid);
        jsonObject.put("pictures",pictures);
//        System.out.println(pictures);
        response.getWriter().println(jsonObject);
    }

    private void collectionCount(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println("collectioncount");
        response.getWriter().println(2);
    }
}
