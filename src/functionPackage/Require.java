package functionPackage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class Require {
    /**
     *
     * @param toPath
     * @param session
     * @param response
     * @param request
     * @return true:in false: out
     * @throws IOException
     */
    public static boolean requireLogin(String toPath, HttpSession session, HttpServletResponse response, HttpServletRequest request) throws IOException {
        if(session.getAttribute("userDetails") == null){
            System.out.println("没有到"+toPath+"的权限，要先登录");
            session.setAttribute("toPath",toPath);
            response.sendRedirect(request.getContextPath()+"/login.jsp");
            return false;
        }
        else return true;
    }

    public static boolean requireStringNotEmpty(String ... strings){
        for(String string :strings){
            if(string == null || string.length() == 0) return false;
        }
        return true;
    }
}
