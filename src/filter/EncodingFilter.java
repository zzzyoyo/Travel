package filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class EncodingFilter extends HttpFilter {
    private String encoding;

    protected void init(){
        this.encoding = getFilterConfig().getServletContext().getInitParameter("encoding");
    }

    @Override
    public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws IOException, ServletException {
//        System.out.println("encoding filter...");
//        System.out.println(request.getServletPath());
//        System.out.println(this.encoding);
        //中文乱码问题
        request.setCharacterEncoding(this.encoding);
        response.setCharacterEncoding(this.encoding);
        response.setHeader("Content-type", "text/html;charset="+this.encoding);

        filterChain.doFilter(request,response);
    }
}
