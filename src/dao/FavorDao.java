package dao;

import jdbcUtils.JdbcUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.Connection;
import java.sql.SQLException;

public class FavorDao {
    private QueryRunner queryRunner = new QueryRunner();

    public boolean isCollected(int uid, int imageID){
        long count = 0;
        Connection connection = null;
        try {
            connection = JdbcUtils.getConnection();
            String sql = "SELECT count(*) FROM travelimagefavor WHERE UID = ? AND ImageID = ?";
            count = (long)queryRunner.query(connection,sql,new ScalarHandler(),uid,imageID);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.release(connection,null,null);
        }
        if(count > 0) return true;
        else return false;
    }

    public boolean addCollection(int uid, int imageID){
//        System.out.println("addCollection");
        Connection connection = null;
        try {
            connection = JdbcUtils.getConnection();
            connection.setAutoCommit(false);
            String sql = "INSERT INTO travelimagefavor (UID,ImageID) VALUES (?,?)";
            queryRunner.update(connection,sql,uid,imageID);
            sql = "UPDATE travelimage SET Hot = Hot + 1 WHERE ImageID = ?";
            queryRunner.update(connection,sql,imageID);
            connection.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            JdbcUtils.release(connection,null,null);
        }
    }

    public boolean deleteCollection(int uid, int imageID){
//        System.out.println("deleteCollection");
        Connection connection = null;
        try {
            connection = JdbcUtils.getConnection();
            connection.setAutoCommit(false);
            //favor record
            String sql = "DELETE FROM travelimagefavor WHERE ImageID = ? AND UID = ?";
            queryRunner.update(connection,sql,imageID,uid);
            //image's hot
            sql = "UPDATE travelimage SET Hot = Hot - 1 WHERE ImageID = ?";
            queryRunner.update(connection,sql,imageID);
            connection.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            JdbcUtils.release(connection,null,null);
        }
    }
}
