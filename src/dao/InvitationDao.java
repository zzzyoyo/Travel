package dao;

import domain.InvitedUser;
import domain.User;
import jdbcUtils.JdbcUtils;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class InvitationDao extends Dao<InvitedUser> {
    public List<InvitedUser> getInvitationByUid(int uid){
        String sql = "SELECT f.inviteeID uid, u.UserName username, u.State state, f.state invitationState, f.friendshipID invitationId  FROM " +
                "traveluserfriendship f, traveluser u WHERE f.inviterID = ? AND u.UID = f.inviteeID AND f.state <> 1;";
        return getAll(sql,uid);
    }

    public List<InvitedUser> getFriendsByUid(int uid){
        String sql = "SELECT u.UID uid, u.UserName username, u.State state, f.friendshipID invitationId " +
                "FROM traveluserfriendship f, traveluser u " +
                "WHERE ((f.inviterID = ? AND u.UID = f.inviteeID) OR (f.inviteeID = ? AND u.UID = f.inviterID)) AND f.state = 1;";
        return getAll(sql,uid,uid);
    }

    public List<InvitedUser> getInviteMeByUid(int uid){
        String sql = "SELECT u.UID uid, u.UserName username, u.State state, f.friendshipID invitationId FROM traveluserfriendship f, traveluser u " +
                "WHERE f.inviteeID = ? AND u.UID = f.inviterID AND f.state = 0;";
        return getAll(sql,uid);
    }

    public List<InvitedUser> getWaitingInvitationByUid(int uid){
        String sql = "SELECT f.inviteeID uid, u.UserName username, u.State state, f.friendshipID invitationId FROM traveluserfriendship f, " +
                "traveluser u WHERE f.inviterID = ? AND u.UID = f.inviteeID AND f.state = 0;";
        return getAll(sql,uid);
    }

    public boolean agreeInvitation(int invitationId){
        String sql = "UPDATE traveluserfriendship SET state = 1 WHERE friendshipID = ?";
        return update(sql,invitationId);
    }

    public boolean refuseInvitation(int invitationId){
        String sql = "UPDATE traveluserfriendship SET state = -1 WHERE friendshipID = ?";
        return update(sql,invitationId);
    }

    public List<Integer> getWaitingIdsWithUid(int uid){
        String sql = "SELECT inviteeID FROM traveluserfriendship WHERE inviterID = ? AND state = 0;";
        return getAllValues(sql,uid);
    }

    public List<Integer> getFriendIdsWithUid(int uid){
        String sql = "SELECT u.UID FROM traveluserfriendship f, traveluser u WHERE " +
                    "((f.inviterID = ? AND u.UID = f.inviteeID) OR (f.inviteeID = ? AND u.UID = f.inviterID)) AND f.state = 1;";
        return getAllValues(sql,uid,uid);
    }

    public boolean inviteUser(int inviterId, int inviteeId){
        String sql = "INSERT INTO traveluserfriendship (inviterID, inviteeID) VALUES (?,?);";
        return update(sql,inviterId,inviteeId);
    }
//
//    public static void main(String args[]){
//        InvitationDao invitationDao = new InvitationDao();
//        System.out.println(invitationDao.getFriendIdsWithUid(1));
//    }
}
