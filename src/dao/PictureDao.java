package dao;

import domain.Picture;

import java.util.List;

public class PictureDao extends Dao<Picture> {
    public List<Picture> getPicturesByFuzzyContent(String content,String filter,String sort,int page, int pageSize){
        String sql = "SELECT i.ImageID id, i.Title title, i.PATH path, u.UserName author FROM travelimage i, " +
                "traveluser u WHERE i.UID = u.UID AND i.";
        if(filter.equals("title")){
            sql += "Title LIKE ? ";
        }
        else{
            sql += "Content LIKE ? ";
        }
        sql += "ORDER BY ";
        if(sort.equals("hot")){
            sql += "i.Hot ";
        }
        else {
            sql += "i.RecentUpdate ";
        }
        sql += "DESC LIMIT ?,?";
//        System.out.println(sql);
        List<Picture> pictures = getAll(sql,"%"+content+"%",(page - 1)*pageSize,pageSize);
//        System.out.println(pictures);
        return pictures;
    }

    public long getCountWithFuzzyContent(String content,String filter){
        String sql = "SELECT count(*) FROM travelimage WHERE ";
        if(filter.equals("title")){
            sql += "Title LIKE ?";
        }
        else{
            sql += "Content LIKE ? ";
        }
        System.out.println(sql);
        long count = getForValues(sql,"%"+content+"%");
        System.out.println(count);
        return count;
    }

    public List<Picture> getSortedPictures(int number,String sort){
        String sql = "SELECT i.ImageID id, i.Title title, i.PATH path, u.UserName author FROM travelimage i, "+
                "traveluser u WHERE i.UID = u.UID ORDER BY "+ sort+" DESC LIMIT 0,?";
        List<Picture> pictures = getAll(sql,number);
        System.out.println(sort+":"+pictures);
        return pictures;
    }
}
