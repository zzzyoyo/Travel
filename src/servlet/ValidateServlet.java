package servlet;

import com.alibaba.fastjson.JSON;
import dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "ValidateServlet",urlPatterns = {"*.validate"})
public class ValidateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println(" validate POST!!");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //中文乱码问题
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-type", "text/html;charset=UTF-8");

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


    private void usernameUsed(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        UserDao userDao = new UserDao();
        Map<String,String> map = new HashMap<>();
        if(userDao.getCountWithName(username)>0){
            map.put("valid","false");
        }
        else {
            map.put("valid","true");
        }
        String isValid = JSON.toJSONString(map);
        response.getWriter().println(isValid);
    }

    private void checkCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String captcha = request.getParameter("captcha");
        String checkCode = (String) request.getSession().getAttribute("checkCode");//从服务器端的session中取出验证码
//        System.out.println("captcha:"+captcha+"  checkCode:"+checkCode);
        Map<String,String> map = new HashMap<>();
        if(captcha.equalsIgnoreCase(checkCode)){
            map.put("valid","true");
        }
        else {
            map.put("valid","false");
        }
        String isValid = JSON.toJSONString(map);
        response.getWriter().println(isValid);
    }
}
