package code;

import code.entity.Column;
import code.entity.Entity;
import code.entity.Table;
import code.utils.FreeMarkerTemplateUtils;
import code.utils.JDBCUtils;
import code.utils.TransforUtils;
import freemarker.template.Template;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import java.io.*;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 * Created by 胡光辉 on 2019/4/14.
 * desc:
 */
public class DemoGenerator {
    private static final Logger logger = Logger.getLogger(DemoGenerator.class);
    private static final Properties BASE_PROP = new Properties();
    private static Connection conn = null;
    private static ResultSet rs = null;
    private static FileOutputStream fos = null;

    static {
        try {
            BASE_PROP.load(DemoGenerator.class.getClassLoader().getResourceAsStream("base.properties"));
        } catch (IOException e) {
            logger.error(e);
        }
    }

    public static void generator() {
        try {
            Entity entity = getEntity();
            String[] templateNames = getTemplateNames();
            Map dataMap = new HashMap<>();
            dataMap.put("entity", entity);
            dataMap.put("date", new Date());
            dataMap.put("author", BASE_PROP.getProperty("author"));
            dataMap.put("access_url_base", BASE_PROP.getProperty("access_url_base"));
            dataMap.put("describe_base", BASE_PROP.getProperty("describe_base"));
            Template template;
            File file;
            Properties TEMP_PROP = new Properties();
            for (int i = 0; i < templateNames.length; i++) {
                final String templateName = templateNames[i];
                if (templateName.endsWith(".js.ftl")) {
                    TEMP_PROP.load(DemoGenerator.class.getClassLoader().getResourceAsStream("temp_prop\\js.properties"));
                    file = new File(TEMP_PROP.getProperty("base_contents") + BASE_PROP.getProperty("modular") +"\\" +templateName.replace(".ftl", ""));
                } else if(templateName.endsWith(".jsp.ftl")){
                    TEMP_PROP.load(DemoGenerator.class.getClassLoader().getResourceAsStream("temp_prop\\jsp.properties"));
                    file = new File(TEMP_PROP.getProperty("base_contents") + BASE_PROP.getProperty("modular") +"\\" +templateName.replace(".ftl", ""));
                } else {
                    TEMP_PROP.load(DemoGenerator.class.getClassLoader().getResourceAsStream("temp_prop\\"+templateName.replace("ftl", "properties")));
                    file = new File(TEMP_PROP.getProperty("base_contents") + BASE_PROP.getProperty("modular") +"\\" +StringUtils.capitalize(entity.getEntityName()) + TEMP_PROP.getProperty("file_name_suffer"));
                }
                dataMap.put("packageName", BASE_PROP.getProperty("prefix_package") + TEMP_PROP.getProperty("main_package") + BASE_PROP.getProperty("suffix_package"));
                template = FreeMarkerTemplateUtils.getTemplate(templateName);
                if (!file.getParentFile().exists()) {
                    file.getParentFile().mkdirs();
                }
                fos = new FileOutputStream(file);
                template.process(dataMap, new BufferedWriter(new OutputStreamWriter(fos, "utf-8"), 10240));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.closeConnection(conn);
            JDBCUtils.closeResultSet(rs);
            closeFileOutputStream(fos);
        }
    }

    private static Entity getEntity() throws SQLException, ClassNotFoundException {
        conn = JDBCUtils.getConnection();
        DatabaseMetaData metaData = conn.getMetaData();
        String tableName = BASE_PROP.getProperty("table_name");
        rs = metaData.getColumns(null, "%", tableName, "%");
        Table tableInfo = new Table();
        List<Column> columnList = new ArrayList<>();
        while (rs.next()) {
            Column column = new Column();
            column.setColumnName(rs.getString("COLUMN_NAME"));
            column.setColumnType(rs.getString("TYPE_NAME"));
            column.setColumnNotes(rs.getString("REMARKS"));
            columnList.add(column);
        }
        tableInfo.setTableName(tableName);
        tableInfo.setColumnList(columnList);
        return TransforUtils.transforToEntity(tableInfo);
    }

    private static String[] getTemplateNames() {
        String templatesNames = BASE_PROP.getProperty("templates_names");
        if (StringUtils.isNotEmpty(templatesNames)) {
            return templatesNames.split(",");
        } else {
            logger.error("templates_names is null");
            return null;
        }
    }

    private static void closeFileOutputStream(FileOutputStream fos) {
        if (fos != null) {
            try {
                fos.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
