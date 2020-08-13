package servlet;

import dao.FavorDao;
import functionPackage.Require;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

@WebServlet(name = "CollectionServlet",urlPatterns = {"*.collect"})
public class CollectionServlet extends HttpServlet {
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
            response.getWriter().println("invalid method");
            System.out.println("no method: "+methodName);
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= Do not support GET method").forward(request,response);
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException ,ServletException{
//        System.out.println("add");
        if(!Require.requireStringNotEmpty(request.getParameter("imageID"),request.getParameter("uid"))){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        int uid = Integer.parseInt(request.getParameter("uid"));
        int imageID = Integer.parseInt(request.getParameter("imageID"));
        FavorDao favorDao = new FavorDao();
        if(favorDao.addCollection(uid,imageID)){
            response.getWriter().println("success");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException ,ServletException{
//        System.out.println("delete");
        if(!Require.requireStringNotEmpty(request.getParameter("imageID"),request.getParameter("uid"))){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        int uid = Integer.parseInt(request.getParameter("uid"));
        int imageID = Integer.parseInt(request.getParameter("imageID"));
        FavorDao favorDao = new FavorDao();
        if(favorDao.deleteCollection(uid,imageID)){
            response.getWriter().println("success");
        }
    }
}
