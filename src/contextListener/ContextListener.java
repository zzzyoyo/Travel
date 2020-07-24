package contextListener;

import com.mchange.v2.c3p0.DataSources;
import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;
import jdbcUtils.JdbcUtils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

public class ContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        System.out.println("init");
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        System.out.println("end");
        //手动取消c3p0数据库连接池
        try {
            DataSources.destroy(JdbcUtils.getDataSource());//getDataSource方法获取c3p0数据源
            System.out.println("关闭数据库连接池成功!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        /*
        自6.0.24版以来，Tomcat附带了内存泄漏检测特性，当Webapp的驱动程序中有一个兼容JDBC4.0的驱动程序时，这会导致这种警告消息。
        /WEB-INF/lib哪辆车-寄存器在webapp启动时使用ServiceLoaderAPI但这不是自动的-注销在webapp关机期间。
        这个消息纯粹是非正式的，Tomcat已经相应地采取了防止内存泄漏的行动。你能做什么？无视那些警告。
        托姆凯特做的很好。实际的bug在其他人的代码中(有问题的JDBC驱动程序)，而不是在您的代码中。
        很高兴Tomcat正确地完成了它的工作，并等待JDBC驱动程序供应商修复它，以便您可以升级驱动程序。
        另一方面，您不应该将JDBC驱动程序放在webapp中/WEB-INF/lib，但仅限于服务器的/lib..如果你还把它放在webapp里/WEB-INF/lib，
        然后您应该手动注册并使用ServletContextListener.降级到Tomcat 6.0.23或更高版本，这样您就不会被这些警告所困扰。
        但它会悄无声息地漏掉记忆。不知道这到底是不是好消息。这种类型的内存泄漏是背后的主要原因之一。
        OutOfMemoryError问题在Tomcat热部署期间。将JDBC驱动程序移动到Tomcat/lib文件夹，并有一个连接池数据源来管理驱动程序。
        请注意，Tomcat的内置DBCP在关闭时没有正确地取消注册驱动程序。
        参见bugDBCP-322作为WONTFIX关闭。您希望将DBCP替换为另一个连接池，它比DBCP做得更好。例如HikariCP,&nbsp;BoneCP，或者也许TomcatJDBC池.
         */
        //手动取消驱动程序的注册：
        Enumeration drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = (Driver) drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
                System.out.println("deregistering jdbc driver: "+driver);
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("Error deregistering driver"+driver);
            }
        }
        //手动停止名为[mysql-cj-abandoned-connection-cleanup]的线程
        AbandonedConnectionCleanupThread.uncheckedShutdown();
    }
}
