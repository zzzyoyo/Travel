package servlet;

import com.alibaba.fastjson.JSONObject;
import dao.CommentDao;
import domain.Comment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

@WebServlet(name = "CommentServlet",urlPatterns = {"*.comment"})
public class CommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    private void loadAllComments(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sort = request.getParameter("sort");
        int imageID = Integer.parseInt(request.getParameter("imageID"));
        JSONObject jsonObject = new JSONObject();
        CommentDao commentDao = new CommentDao();
        List<Comment> commentList = commentDao.getSortedCommentsByImageID(imageID,sort);
//        System.out.println(commentList);
        jsonObject.put("comments",commentList);
        response.getWriter().println(jsonObject);
    }

    private void send(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message = request.getParameter("message");
        int uid = Integer.parseInt(request.getParameter("commenterID"));
        int imageID = Integer.parseInt(request.getParameter("imageID"));
        CommentDao commentDao = new CommentDao();
        if(commentDao.saveComment(message,uid,imageID)){
            response.getWriter().println("success");
        }
        else {
            response.getWriter().println("error");
        }
    }

    private void addHot(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int commentID = Integer.parseInt(request.getParameter("commentID"));
        CommentDao commentDao = new CommentDao();
        if(commentDao.addHotByCommentID(commentID)){
            response.getWriter().println("success");
        }
        else {
            response.getWriter().println("error");
        }
    }
}
