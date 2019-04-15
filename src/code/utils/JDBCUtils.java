package code.utils;

import org.apache.log4j.Logger;

import java.io.IOException;
import java.sql.*;
import java.util.Properties;

/**
 * Created by 胡光辉 on 2019/4/14.
 * desc:
 */
public class JDBCUtils {
    private static final Logger logger = Logger.getLogger(JDBCUtils.class);
    private static Properties prop = new Properties();
    private static Connection connection = null;

    static {
        try {
            prop.load(JDBCUtils.class.getClassLoader().getResourceAsStream("dbinfo.properties"));
        } catch (IOException e) {
            logger.error("数据库连接配置文件加载异常" + e);
        }
    }

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName(prop.getProperty("driver"));
        Properties prop4Remarks = new Properties();
        prop4Remarks.put("remarksReporting", prop.getProperty("remarks_reporting"));
        connection = DriverManager.getConnection(prop.getProperty("url"), prop4Remarks);
        return connection;
    }

    public static void closeResultSet(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}
