package servlet;

import com.alibaba.fastjson.JSONObject;
import dao.PictureDao;
import domain.Picture;
import domain.User;
import functionPackage.Require;

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
//        //中文乱码问题
//        request.setCharacterEncoding("UTF-8");
//        response.setCharacterEncoding("UTF-8");
//        response.setHeader("Content-type", "text/html;charset=UTF-8");

        String methodName = request.getServletPath().substring(1,request.getServletPath().indexOf('.'));
        try {
            Method method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
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
        request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message=Do not support get method").forward(request,response);
    }

    private void collections(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if(!Require.requireStringNotEmpty(request.getParameter("page"),request.getParameter("pageSize"),request.getParameter("uid"))){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        JSONObject jsonObject = new JSONObject();
        int page = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("pageSize"));
        int uid = Integer.parseInt(request.getParameter("uid"));

        //权限鉴定
        User currUser = (User)request.getSession().getAttribute("userDetails");
        int realUID = currUser.getUid();
        if(realUID != uid){
            response.getWriter().println("You don't have the authority to get collections of user whose uid = "+uid);
            return;
        }
        PictureDao pictureDao = new PictureDao();
        List<Picture> pictures = pictureDao.getCollectionsByUid(uid,page,pageSize);
        jsonObject.put("pictures",pictures);
//        System.out.println(pictures);
        response.getWriter().println(jsonObject);
    }

    private void collectionCount(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if(!Require.requireStringNotEmpty(request.getParameter("uid"))){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        int uid = Integer.parseInt(request.getParameter("uid"));

        //权限鉴定
        User currUser = (User)request.getSession().getAttribute("userDetails");
        int realUID = currUser.getUid();
        if(realUID != uid){
            response.getWriter().println("You don't have the authority to get collections of user whose uid = "+uid);
            return;
        }
        PictureDao pictureDao = new PictureDao();
        response.getWriter().println(pictureDao.getCollectionCountWithUid(uid));
    }

    private void searchResultCount(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if(!Require.requireStringNotEmpty(request.getParameter("filter"),request.getParameter("similar"))){
            //content可以为空字符串
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        String content = request.getParameter("content");
        String filter = request.getParameter("filter");
        int similar = Integer.parseInt(request.getParameter("similar"));
        PictureDao pictureDao = new PictureDao();
        response.getWriter().println(pictureDao.getCountWithFuzzyContent(content,filter,similar));
    }

    private void searchResults(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if(!Require.requireStringNotEmpty(request.getParameter("filter"),
                request.getParameter("sort"),request.getParameter("page"),request.getParameter("pageSize"),
                request.getParameter("similar"))){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        JSONObject jsonObject = new JSONObject();
        String content = request.getParameter("content");
        String filter = request.getParameter("filter");
        String sort = request.getParameter("sort");
        int page = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("pageSize"));
        int similar = Integer.parseInt(request.getParameter("similar"));
        PictureDao pictureDao = new PictureDao();
        List<Picture> pictures = pictureDao.getPicturesByFuzzyContent(content,filter,sort,page,pageSize,similar);
        jsonObject.put("pictures",pictures);
//        System.out.println(pictures);
        response.getWriter().println(jsonObject);
    }

    private void photoCount(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if(!Require.requireStringNotEmpty(request.getParameter("uid"))){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        int uid = Integer.parseInt(request.getParameter("uid"));

        //权限鉴定
        User currUser = (User)request.getSession().getAttribute("userDetails");
        int realUID = currUser.getUid();
        if(realUID != uid){
            response.getWriter().println("You don't have the authority to get photos of user whose uid = "+uid);
            return;
        }
        PictureDao pictureDao = new PictureDao();
        response.getWriter().println(pictureDao.getPhotoCountWithUid(uid));
    }

    private void photos(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if(!Require.requireStringNotEmpty(request.getParameter("page"),request.getParameter("pageSize"),request.getParameter("uid"))){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        JSONObject jsonObject = new JSONObject();
        int page = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("pageSize"));
        int uid = Integer.parseInt(request.getParameter("uid"));

        //权限鉴定
        User currUser = (User)request.getSession().getAttribute("userDetails");
        int realUID = currUser.getUid();
        if(realUID != uid){
            response.getWriter().println("You don't have the authority to get photos of user whose uid = "+uid);
            return;
        }
        PictureDao pictureDao = new PictureDao();
        List<Picture> pictures = pictureDao.getPhotosByUid(uid,page,pageSize);
        jsonObject.put("pictures",pictures);
//        System.out.println(pictures);
        response.getWriter().println(jsonObject);
    }
}
