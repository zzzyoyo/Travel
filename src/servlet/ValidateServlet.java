package servlet;

import com.alibaba.fastjson.JSON;
import dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "ValidateServlet",urlPatterns = {"/usernameUsed","/checkCode"})
public class ValidateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("POST");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        switch (request.getServletPath()){
            case "/usernameUsed":{
                usernameUsed(request,response);
                break;
            }
            case "/checkCode":{
                checkCode(request,response);
                break;
            }
            default:{
                break;
            }
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
