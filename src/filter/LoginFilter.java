package filter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter extends HttpFilter {
    @Override
    public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws IOException, ServletException {
//        System.out.println("need login");
        HttpSession session = request.getSession();
        String toPath = request.getRequestURI();
        if(session.getAttribute("userDetails") == null){
            System.out.println("没有到"+toPath+"的权限，要先登录");
            session.setAttribute("toPath",toPath);
            response.sendRedirect(request.getContextPath()+"/login.jsp");
        }
        else {
            filterChain.doFilter(request,response);
        }
    }
}
