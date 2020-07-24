package jdbcUtils;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JdbcUtils {
    private static DataSource dataSource;

    static {
        dataSource = new ComboPooledDataSource("travelSource");
    }

    public static DataSource getDataSource() {
        return dataSource;
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    public static void release(Connection connection, Statement statement, ResultSet resultSet){
        if(connection != null){
            try {
                connection.close();
            }
            catch (Exception e){
                e.printStackTrace();
            }
        }
        if(statement != null){
            try {
                statement.close();
            }
            catch (Exception e){
                e.printStackTrace();
            }
        }
        if(resultSet != null){
            try {
                resultSet.close();
            }
            catch (Exception e){
                e.printStackTrace();
            }
        }
    }
}
