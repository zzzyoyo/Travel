package servlet;

import dao.UserDao;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "LoginServlet",urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String emailOrName = request.getParameter("emailOrName");
        String password = request.getParameter("password");
        System.out.println("login>>"+emailOrName+" "+password);
        UserDao userDao = new UserDao();
        String queryPassword = userDao.getPasswordByNameOrEmail(emailOrName);
        System.out.println("querypassword"+queryPassword);
        if(password.equals(queryPassword)){
            //login success
            User user = userDao.getUserByNameOrEmail(emailOrName);
            request.getSession().setAttribute("userDetails",user);
            response.sendRedirect(request.getContextPath());
        }
        else {
            request.setAttribute("message","用户名/邮箱和密码错误");
            request.getRequestDispatcher("/login.jsp").forward(request,response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath()+"/login.jsp");
    }
}
