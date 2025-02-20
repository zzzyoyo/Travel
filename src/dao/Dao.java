package dao;

import domain.Picture;
import jdbcUtils.JdbcUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Dao<T> {
    private QueryRunner queryRunner = new QueryRunner();
    private Class<T> clazz;

    public Dao(){
        Type superClass = getClass().getGenericSuperclass();

        if(superClass instanceof ParameterizedType){
            ParameterizedType parameterizedType = (ParameterizedType)superClass;

            Type[] types = parameterizedType.getActualTypeArguments();
            if(types != null && types.length > 0){
                if(types[0] instanceof Class){
                    clazz = (Class<T>) types[0];
                }
            }
        }
    }

    public <E> E getForValues(String sql, Object ... args){
        Connection connection = null;
        try {
            connection =  JdbcUtils.getConnection();
            return (E)queryRunner.query(connection,sql,new ScalarHandler(),args);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.release(connection,null,null);
        }
        return null;
    }

    public <E> List<E> getAllValues(String sql, Object ... args){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        List<Object> entities = new ArrayList<>();
        try {
            connection =  JdbcUtils.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            for(int i = 1; i <= args.length; i++){
                preparedStatement.setObject(i,args[i-1]);
            }
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()){
                entities.add(resultSet.getObject(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.release(connection,preparedStatement,resultSet);
        }
        return (List<E>) entities;
    }

    /**
     *
     * @param sql
     * @param args
     * @return true: success ,false:failure
     */
    public boolean update(String sql, Object ... args){
        Connection connection = null;
        try {
            connection = JdbcUtils.getConnection();
            queryRunner.update(connection,sql,args);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            JdbcUtils.release(connection,null,null);
        }
    }

    public T get(String sql, Object ... args){
        Connection connection = null;
        try {
            connection =  JdbcUtils.getConnection();
            return queryRunner.query(connection,sql,new BeanHandler<>(clazz),args);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.release(connection,null,null);
        }
        return null;
    }

    public List<T> getAll(String sql, Object ... args){
        Connection connection = null;
        try {
            connection =  JdbcUtils.getConnection();
            return queryRunner.query(connection,sql,new BeanListHandler<>(clazz),args);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.release(connection,null,null);
        }
        return null;
    }
}
