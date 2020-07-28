package dao;

import domain.User;

import java.util.List;

public class UserDao extends Dao<User>{

    public String getPasswordByNameOrEmail(String emailOrName){
        String sql = "SELECT Pass FROM traveluser WHERE UserName = ? OR Email = ?";
        String password = getForValues(sql,emailOrName,emailOrName);
        return password;
    }

    public User getUserByNameOrEmail(String emailOrName){
        String sql = "SELECT Pass password, UID uid, UserName username, Email email, State state FROM traveluser WHERE UserName = ? OR Email = ?";
        //System.out.println(user);
        return get(sql,emailOrName,emailOrName);
    }

    public long getCountWithName(String name) {
        String sql = "SELECT count(*) FROM traveluser WHERE UserName = ?";
        return getForValues(sql,name);
    }

    public boolean save(User user){
        String sql = "INSERT INTO traveluser (UserName, Email, Pass) VALUES (?,?,?)";
        return update(sql,user.getUsername(),user.getEmail(),user.getPassword());
    }

    public List<User> getFriendsByUid(int uid){
        String sql = "SELECT f.inviteeID uid, u.UserName username, u.State state FROM traveluserfriendship f, " +
                "traveluser u WHERE f.inviterID = ? AND u.UID = f.inviteeID AND f.state = 1;";
        return getAll(sql,uid);
    }

    public List<User> getWaitingInvitationByUid(int uid){
        String sql = "SELECT f.inviteeID uid, u.UserName username, u.State state FROM traveluserfriendship f, " +
                "traveluser u WHERE f.inviterID = ? AND u.UID = f.inviteeID AND f.state = 0;";
        return getAll(sql,uid);
    }

    public List<User> getRefusedInvitationByUid(int uid){
        String sql = "SELECT f.inviteeID uid, u.UserName username, u.State state FROM traveluserfriendship f, " +
                "traveluser u WHERE f.inviterID = ? AND u.UID = f.inviteeID AND f.state = -1;";
        return getAll(sql,uid);
    }

    public List<User> getInviteMeByUid(int uid){
        String sql = "SELECT u.UID uid, u.UserName username, u.State state FROM traveluserfriendship f, traveluser u " +
                "WHERE f.inviteeID = ? AND u.UID = f.inviterID AND f.state = 0;";
        return getAll(sql,uid);
    }
}
