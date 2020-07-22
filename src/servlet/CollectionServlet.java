package servlet;

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
        String methodName = request.getServletPath().substring(1,request.getServletPath().indexOf('.'));
        try {
            Method method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            method.invoke(this,request,response);
            response.getWriter().println("success");
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
        doPost(request,response);
    }

    private void add(HttpServletRequest request, HttpServletResponse response){
        System.out.println("add");
    }

    private void delete(HttpServletRequest request, HttpServletResponse response){
        System.out.println("delete");
    }
}
