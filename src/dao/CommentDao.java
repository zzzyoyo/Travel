package dao;

import domain.Comment;

import java.util.List;

public class CommentDao extends Dao<Comment> {
    public List<Comment> getSortedCommentsByImageID(int imageID, String sort){
        String sql = "SELECT c.CommentID commentID, c.commentContent commentContent, u.UserName commenter, c.commentTime" +
                " commentTime, c.hot hot FROM travelimagecomment c, traveluser u WHERE c.ImageID = ? AND c.UID = u.UID ORDER BY c.";
        if(sort.equals("hot")){
            sql += "hot";
        }
        else {
            sql += "commentTime";
        }
//        System.out.println(sql);
        return getAll(sql,imageID);
    }

    public boolean saveComment(String commentContent, int uid, int imageID){
        String sql = "INSERT INTO travelimagecomment (commentContent, UID, ImageID) VALUES (?, ?, ?);";
        return update(sql,commentContent,uid,imageID);
    }

    public boolean addHotByCommentID(int commentID){
        String sql = "UPDATE travelimagecomment SET hot = hot + 1 WHERE commentID = ?";
        return update(sql,commentID);
    }
}
