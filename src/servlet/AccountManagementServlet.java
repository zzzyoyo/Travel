package servlet;

import dao.UserDao;
import domain.User;
import functionPackage.CryptUtils;
import functionPackage.Require;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

@WebServlet(name = "AccountManagementServlet",urlPatterns = {"/register","/login","/logout"})
public class AccountManagementServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //中文乱码问题
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-type", "text/html;charset=UTF-8");

        String methodName = request.getServletPath().substring(1);
        try {
            Method method = getClass().getDeclaredMethod(methodName,HttpServletRequest.class,HttpServletResponse.class);
            method.invoke(this,request,response);
        } catch (NoSuchMethodException e) {
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message="+methodName+" dose not exist").forward(request,response);
            e.printStackTrace();
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String emailOrName = request.getParameter("emailOrName");
        String password = request.getParameter("password");
        if(!Require.requireStringNotEmpty(emailOrName,password)){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        UserDao userDao = new UserDao();
        String queryPassword = userDao.getPasswordByNameOrEmail(emailOrName);
        String md5Password = CryptUtils.GetMD5Code(userDao.getPasswordByNameOrEmail(emailOrName));//为了让之前的账号也能登陆
        if(password.equals(queryPassword)||password.equals(md5Password)){
            //login success
            User user = userDao.getUserByNameOrEmail(emailOrName);
            HttpSession session= request.getSession();
            session.setAttribute("userDetails",user);
            String toPath = (String) session.getAttribute("toPath");
            session.removeAttribute("toPath");
            //持久化session
            Cookie cookie = new Cookie("JSESSIONID",session.getId());
            cookie.setMaxAge(60*30);//30min
            response.addCookie(cookie);
            response.sendRedirect(toPath == null?request.getContextPath():toPath);
        }
        else {
            request.setAttribute("message","用户名/邮箱和密码错误，请重试");
            request.getRequestDispatcher("/login.jsp").forward(request,response);
        }
    }

    private void register(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        String username = request.getParameter("username");
        String password = request.getParameter("md5Password");
        String email = request.getParameter("email");
        if(!Require.requireStringNotEmpty(username,password,email)){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        UserDao userDao = new UserDao();
        User user = new User(username,password,email);
        if(userDao.save(user)){
            //save user successfully
            HttpSession session= request.getSession();
            session.setAttribute("userDetails",user);
            String toPath = (String) session.getAttribute("toPath");
            session.removeAttribute("toPath");
            response.sendRedirect(toPath == null?request.getContextPath():toPath);
        }
        else {
            request.setAttribute("message","出现了一些错误，注册失败，请重试");
            request.getRequestDispatcher("/register.jsp").forward(request,response);
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        request.getSession().invalidate();
        response.sendRedirect(request.getContextPath());
    }
}
