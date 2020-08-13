package servlet;

import com.alibaba.fastjson.JSONObject;
import dao.InvitationDao;
import dao.PictureDao;
import dao.UserDao;
import domain.InvitedUser;
import domain.Picture;
import domain.User;
import functionPackage.Require;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "FriendServlet",urlPatterns = {"*.friend"})
public class FriendServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        //中文乱码问题
//        request.setCharacterEncoding("UTF-8");
//        response.setCharacterEncoding("UTF-8");
//        response.setHeader("Content-type", "text/html;charset=UTF-8");

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
//        doPost(request,response);
        request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= Do not support GET method").forward(request,response);
    }

    private void getMyFriends(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if(!Require.requireStringNotEmpty(request.getParameter("uid"))){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        JSONObject jsonObject = new JSONObject();
        int uid = Integer.parseInt(request.getParameter("uid"));

        //权限鉴定
        User user = (User)request.getSession().getAttribute("userDetails");
        int realUID = user.getUid();
        if(realUID != uid){
            response.getWriter().println("You don't have the authority to get friends of user whose uid = "+uid);
            return;
        }
        InvitationDao invitationDao = new InvitationDao();
        List<InvitedUser> friends = invitationDao.getFriendsByUid(uid);
        jsonObject.put("myFriends",friends);
//        System.out.println(friends);
        response.getWriter().println(jsonObject);
    }

    private void getMyInvitation(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if(!Require.requireStringNotEmpty(request.getParameter("uid"))){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        JSONObject jsonObject = new JSONObject();
        int uid = Integer.parseInt(request.getParameter("uid"));

        //权限鉴定
        User user = (User)request.getSession().getAttribute("userDetails");
        int realUID = user.getUid();
        if(realUID != uid){
            response.getWriter().println("You don't have the authority to get invitations sent by user whose uid = "+uid);
            return;
        }
        InvitationDao invitationDao = new InvitationDao();
        List<InvitedUser> invitation = invitationDao.getInvitationByUid(uid);
        jsonObject.put("invitation",invitation);
        response.getWriter().println(jsonObject);
    }

    private void getInviteMe(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if(!Require.requireStringNotEmpty(request.getParameter("uid"))){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        JSONObject jsonObject = new JSONObject();
        int uid = Integer.parseInt(request.getParameter("uid"));

        //权限鉴定
        User user = (User)request.getSession().getAttribute("userDetails");
        int realUID = user.getUid();
        if(realUID != uid){
            response.getWriter().println("You don't have the authority to get invitations sent to user whose uid = "+uid);
            return;
        }
        InvitationDao invitationDao = new InvitationDao();
        List<InvitedUser> inviteMe = invitationDao.getInviteMeByUid(uid);
        jsonObject.put("inviteMe",inviteMe);
        response.getWriter().println(jsonObject);
    }

    private void agreeInvitation(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if(!Require.requireStringNotEmpty(request.getParameter("invitationId"))){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        int invitationId = Integer.parseInt(request.getParameter("invitationId"));
        InvitationDao invitationDao = new InvitationDao();
        if(invitationDao.agreeInvitation(invitationId)){
            response.getWriter().println("success");
        }
        else {
            response.getWriter().println("error");
        }
    }

    private void refuseInvitation(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if(!Require.requireStringNotEmpty(request.getParameter("invitationId"))){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        int invitationId = Integer.parseInt(request.getParameter("invitationId"));
        InvitationDao invitationDao = new InvitationDao();
        if(invitationDao.refuseInvitation(invitationId)){
            response.getWriter().println("success");
        }
        else {
            response.getWriter().println("error");
        }
    }

    private void searchUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if(!Require.requireStringNotEmpty(request.getParameter("fuzzyUsername"),request.getParameter("uid"))){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        String fuzzyUsername = request.getParameter("fuzzyUsername");
        int uid = Integer.parseInt(request.getParameter("uid"));

        //权限鉴定
        User currUser = (User)request.getSession().getAttribute("userDetails");
        int realUID = currUser.getUid();
        if(realUID != uid){
            response.getWriter().println("You don't have the authority to search users as user whose uid = "+uid);
            return;
        }
        UserDao userDao = new UserDao();
        List<User> users = userDao.getUserByFuzzyUsername(fuzzyUsername);
        InvitationDao invitationDao = new InvitationDao();
        List<Integer> friendIds = invitationDao.getFriendIdsWithUid(uid);
//        System.out.println("friendIds:"+friendIds);
        List<Integer> waitingIds = invitationDao.getWaitingIdsWithUid(uid);
//        System.out.println("waitingIds:"+waitingIds);
        List<Integer> states = new ArrayList<>(users.size());
        for(User user:users){
            int userId = user.getUid();
            if(waitingIds.contains(userId)){
                states.add(0);
            }
            else if(friendIds.contains(userId)){
                states.add(1);
            }
            else if(uid == userId){
                states.add(2);
            }
            else {
                states.add(3);//只有3才可以添加好友
            }
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("users",users);
        jsonObject.put("states",states);
        response.getWriter().println(jsonObject);
    }

    public void invite(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if(!Require.requireStringNotEmpty(request.getParameter("inviteeId"),request.getParameter("inviterId"))){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        int inviteeId = Integer.parseInt(request.getParameter("inviteeId"));
        int inviterId = Integer.parseInt(request.getParameter("inviterId"));

        //权限鉴定
        User currUser = (User)request.getSession().getAttribute("userDetails");
        int realUID = currUser.getUid();
        if(realUID != inviterId){
            response.getWriter().println("You don't have the authority to replace user whose uid = "+inviterId+" to invite friend");
            return;
        }
        InvitationDao invitationDao = new InvitationDao();
        if(invitationDao.inviteUser(inviterId,inviteeId)){
            response.getWriter().println("success");
        }
        else {
            response.getWriter().println("error");
        }
    }
}
