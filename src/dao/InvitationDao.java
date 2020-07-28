package dao;

import domain.InvitedUser;

import java.util.List;

public class InvitationDao extends Dao<InvitedUser> {
    public List<InvitedUser> getInvitationByUid(int uid){
        String sql = "SELECT f.inviteeID uid, u.UserName username, u.State state, f.state invitationState, f.friendshipID invitationId  FROM " +
                "traveluserfriendship f, traveluser u WHERE f.inviterID = ? AND u.UID = f.inviteeID AND f.state <> 1;";
        return getAll(sql,uid);
    }

    public List<InvitedUser> getFriendsByUid(int uid){
        String sql = "SELECT f.inviteeID uid, u.UserName username, u.State state, f.friendshipID invitationId " +
                "FROM traveluserfriendship f, traveluser u " +
                "WHERE ((f.inviterID = ? AND u.UID = f.inviteeID) OR (f.inviteeID = ? AND u.UID = f.inviterID)) AND f.state = 1;";
        return getAll(sql,uid,uid);
    }

    public List<InvitedUser> getInviteMeByUid(int uid){
        String sql = "SELECT u.UID uid, u.UserName username, u.State state, f.friendshipID invitationId FROM traveluserfriendship f, traveluser u " +
                "WHERE f.inviteeID = ? AND u.UID = f.inviterID AND f.state = 0;";
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
}
