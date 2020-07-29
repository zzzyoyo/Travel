package dao;

import domain.Picture;

import java.util.ArrayList;
import java.util.List;

public class PictureDao extends Dao<Picture> {
    public List<Picture> getPicturesByFuzzyContent(String content,String filter,String sort,int page, int pageSize,int similar){
        //去掉空格
        content = content.replaceAll(" +","");
        //高级模糊
        List<String> contents = fuzzyString(content,similar);
        StringBuilder sql = new StringBuilder("SELECT i.ImageID id, i.Title title, i.PATH path, u.UserName author FROM travelimage i, " +
                "traveluser u WHERE i.UID = u.UID AND (i.");
        if(filter.equals("title")){
            sql.append("Title LIKE '");
            sql.append(contents.get(0));
            sql.append("' ");
            int i = 1;
            while (i < contents.size()){
                sql.append("OR i.Title LIKE '");
                sql.append(contents.get(i));
                sql.append("' ");
                i++;
            }
        }
        else{
            sql.append("Content LIKE '");
            sql.append(contents.get(0));
            sql.append("' ");
            int i = 1;
            while (i < contents.size()){
                sql.append("OR i.Content LIKE '");
                sql.append(contents.get(i));
                sql.append("' ");
                i++;
            }
        }
        sql.append(") ");
        sql.append("ORDER BY ");
        if(sort.equals("hot")){
            sql.append("i.Hot ");
        }
        else {
            sql.append("i.RecentUpdate ");
        }
        sql.append("DESC LIMIT ?,?");
//        System.out.println(sql);
        return getAll(sql.toString(),(page - 1)*pageSize,pageSize);
    }

    public long getCountWithFuzzyContent(String content,String filter,int similar){
        //去掉空格
        content = content.replaceAll(" +","");
        //高级模糊
        List<String> contents = fuzzyString(content,similar);
        StringBuilder sql = new StringBuilder("SELECT count(*) FROM travelimage WHERE ");
        if(filter.equals("title")){
            sql.append("Title LIKE '");
            sql.append(contents.get(0));
            sql.append("' ");
            int i = 1;
            while (i < contents.size()){
                sql.append("OR Title LIKE '");
                sql.append(contents.get(i));
                sql.append("' ");
                i++;
            }
        }
        else{
            sql.append("Content LIKE '");
            sql.append(contents.get(0));
            sql.append("' ");
            int i = 1;
            while (i < contents.size()){
                sql.append("OR Content LIKE '");
                sql.append(contents.get(i));
                sql.append("' ");
                i++;
            }
        }
        System.out.println(sql);
        //        System.out.println(count);
        return getForValues(sql.toString());
    }

    /**
     * 从第一个开始的number张图片
     * @param number
     * @param sort
     * @return
     */
    public List<Picture> getSortedPictures(int number,String sort){
        String sql = "SELECT i.ImageID id, i.Title title, i.PATH path, u.UserName author FROM travelimage i, "+
                "traveluser u WHERE i.UID = u.UID ORDER BY "+ sort+" DESC LIMIT 0,?";
        List<Picture> pictures = getAll(sql,number);
//        System.out.println(sort+":"+pictures);
        return pictures;
    }

    public List<Picture> getCollectionsByUid(int uid,int page, int pageSize){
        String sql = "SELECT i.ImageID id, i.Title title, i.PATH path, u.UserName author  FROM travelimage i," +
                "travelimagefavor f, traveluser u WHERE f.UID = ? AND f.ImageID = i.ImageID AND u.UID = i.UID LIMIT ?,?";
        List<Picture> pictures = getAll(sql,uid,(page - 1)*pageSize,pageSize);
//        System.out.println("collections:"+pictures);
        return pictures;
    }

    public long getCollectionCountWithUid(int uid){
        String sql = "SELECT count(*) FROM travelimagefavor WHERE UID = ?";
        long count = getForValues(sql,uid);
        return count;
    }

    public List<Picture> getPhotosByUid(int uid,int page, int pageSize){
        String sql = "SELECT i.ImageID id, i.Title title, i.PATH path, u.UserName author  FROM travelimage i," +
                " traveluser u WHERE i.UID = ? AND u.UID = i.UID LIMIT ?,?";
        List<Picture> pictures = getAll(sql,uid,(page - 1)*pageSize,pageSize);
//        System.out.println("collections:"+pictures);
        return pictures;
    }

    public long getPhotoCountWithUid(int uid){
        String sql = "SELECT count(*) FROM travelimage WHERE UID = ?";
        long count = getForValues(sql,uid);
        return count;
    }

    public boolean deletePictureByImageID(int imageID){
        String sql = "DELETE FROM travelimage WHERE ImageID = ?";
        return update(sql,imageID);
    }

    private List<String> fuzzyString(String initString,int similar){
        List<String> stringList = new ArrayList<>();
        int length = (int)Math.ceil(similar*initString.length()/100.0) ;
        if(length==0){
            stringList.add("%");
        }
        else {
//            System.out.println(length);
            charsCombinationWithLabel(new StringBuilder("%"),stringList,new StringBuilder(initString),length,1,0);
        }
        return stringList;
    }

    private void charsArrangement(StringBuilder readyString, List<String> stringList, StringBuilder leftString, int needNumber,int lengthOfReady){
        if(readyString.length() == lengthOfReady){
            readyString.append(' ');//占位
        }
        if(needNumber == 1){
            for(int i = 0; i < leftString.length();i++){
                readyString.setCharAt(lengthOfReady,leftString.charAt(i));
                stringList.add(String.valueOf(readyString));
            }
        }
        else {
            for(int i = 0;i < leftString.length();i++){
                char toDelete = leftString.charAt(i);
                readyString.setCharAt(lengthOfReady,toDelete);
                charsArrangement(readyString,stringList,leftString.deleteCharAt(i),needNumber-1,lengthOfReady+1);
                leftString.insert(i,toDelete);
            }
        }
    }

    private void charsCombinationWithLabel(StringBuilder readyString, List<String> stringList, StringBuilder leftString, int needNumber,int lengthOfReady,int begin){
        if(readyString.length() <= lengthOfReady+1){
            readyString.append("%%");//占位
        }
        if(needNumber == 1){
            for(int i = begin; i < leftString.length();i++){
                readyString.setCharAt(lengthOfReady,leftString.charAt(i));
                readyString.setCharAt(lengthOfReady+1,'%');
                stringList.add(String.valueOf(readyString));
            }
        }
        else {
            for(int i = begin;i < leftString.length();i++){
                char toDelete = leftString.charAt(i);
                readyString.setCharAt(lengthOfReady,toDelete);
                readyString.setCharAt(lengthOfReady+1,'%');
                charsCombinationWithLabel(readyString,stringList,leftString,needNumber-1,lengthOfReady+2,i+1);
            }
        }
    }
//
//    public static void main(String args[]){
//        PictureDao pictureDao = new PictureDao();
//        List<String> list = new ArrayList<>();
//        pictureDao.charsCombinationWithLabel(new StringBuilder("%"),list,new StringBuilder("agfhl"),3,1,0);
//        System.out.println(list);
////        pictureDao.getPicturesByFuzzyContent("luig","title","hot",1,8);
////        pictureDao.getCountWithFuzzyContent("  lu ig","title");
//    }
}
