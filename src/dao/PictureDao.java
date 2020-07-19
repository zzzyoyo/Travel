package dao;

import domain.Picture;

import java.util.List;

public class PictureDao extends Dao<Picture> {
    public List<Picture> getPicturesByFuzzyContent(String content,String filter,String sort){
        String sql = "SELECT i.ImageID id, i.Title title, i.PATH path, u.UserName author FROM travelimage i, " +
                "traveluser u WHERE i.UID = u.UID AND i.";
        if(filter.equals("title")){
            sql += "Title LIKE ?";
        }
        else{
            sql += "Content LIKE ?";
        }
        sql += "ORDER BY i.UID";
//        System.out.println(sql);
        List<Picture> pictures = getAll(sql,"%"+content+"%");
//        System.out.println(pictures);
        return pictures;
    }
}
