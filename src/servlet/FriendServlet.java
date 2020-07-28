package servlet;

import com.alibaba.fastjson.JSONObject;
import dao.InvitationDao;
import dao.PictureDao;
import dao.UserDao;
import domain.InvitedUser;
import domain.Picture;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

@WebServlet(name = "FriendServlet",urlPatterns = {"*.friend"})
public class FriendServlet extends HttpServlet {
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
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    private void getMyFriends(HttpServletRequest request, HttpServletResponse response) throws IOException {
        JSONObject jsonObject = new JSONObject();
        int uid = Integer.parseInt(request.getParameter("uid"));
        InvitationDao invitationDao = new InvitationDao();
        List<InvitedUser> friends = invitationDao.getFriendsByUid(uid);
        jsonObject.put("myFriends",friends);
//        System.out.println(friends);
        response.getWriter().println(jsonObject);
    }

    private void getMyInvitation(HttpServletRequest request, HttpServletResponse response) throws IOException {
        JSONObject jsonObject = new JSONObject();
        int uid = Integer.parseInt(request.getParameter("uid"));
        InvitationDao invitationDao = new InvitationDao();
        List<InvitedUser> invitation = invitationDao.getInvitationByUid(uid);
        jsonObject.put("invitation",invitation);
        response.getWriter().println(jsonObject);
    }

    private void getInviteMe(HttpServletRequest request, HttpServletResponse response) throws IOException {
        JSONObject jsonObject = new JSONObject();
        int uid = Integer.parseInt(request.getParameter("uid"));
        InvitationDao invitationDao = new InvitationDao();
        List<InvitedUser> inviteMe = invitationDao.getInviteMeByUid(uid);
        jsonObject.put("inviteMe",inviteMe);
        response.getWriter().println(jsonObject);
    }

    private void agreeInvitation(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int invitationId = Integer.parseInt(request.getParameter("invitationId"));
        InvitationDao invitationDao = new InvitationDao();
        if(invitationDao.agreeInvitation(invitationId)){
            response.getWriter().println("success");
        }
        else {
            response.getWriter().println("error");
        }
    }

    private void refuseInvitation(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int invitationId = Integer.parseInt(request.getParameter("invitationId"));
        InvitationDao invitationDao = new InvitationDao();
        if(invitationDao.refuseInvitation(invitationId)){
            response.getWriter().println("success");
        }
        else {
            response.getWriter().println("error");
        }
    }
}
