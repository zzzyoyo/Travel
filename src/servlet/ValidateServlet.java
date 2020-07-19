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

@WebServlet(name = "ValidateServlet",urlPatterns = {"/usernameUsed"})
public class ValidateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("POST");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
}
