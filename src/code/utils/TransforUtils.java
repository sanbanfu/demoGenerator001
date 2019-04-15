package code.utils;

import code.entity.Attribute;
import code.entity.Column;
import code.entity.Entity;
import code.entity.Table;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 由 胡光辉 创建于 2019/4/1.
 * 把实体数据转换为符合驼峰命名规则的Map
 */
public class TransforUtils {
    private static final Logger logger = Logger.getLogger(TransforUtils.class);

    public static Entity transforToEntity(Table table) {
        Entity entity = new Entity();
        List<Attribute> attributeList = new ArrayList<>();
        if (table.getColumnList() != null) {
            for (Column column : table.getColumnList()) {
                Attribute attribute = new Attribute();
                attribute.setColumn(column);
                attribute.setAttributeName(convertColumnToProperty(column.getColumnName()));
                attribute.setAttributeType(convertColumnTypeToPropertyType(column.getColumnType()));
                attribute.setAttributeNote(column.getColumnNotes());
                attributeList.add(attribute);
            }
        }
        entity.setTable(table);
        entity.setAttributeList(attributeList);
        entity.setEntityName(convertTableNameToEntityName(table.getTableName()));
        return entity;
    }

    /**
     * 字段类型与属性类型映射（Oracle数据库）
     *
     * @param columnType
     * @return
     */
    public static String convertColumnTypeToPropertyType(String columnType) {
        if (StringUtils.isNotEmpty(columnType)) {
            switch (columnType) {
                case "NUMBER":
                    return "Long";
                //return "Date";
                case "TIMESTAMP(6)":
                case "VARCHAR2":
                case "CHAR":
                case "CLOB":
                    return "String";
                default:
                    return "UnknowType";
            }
        } else {
            return "UnknowType";
        }
    }

    /**
     * 输入字段名，输出属性名
     * 例如：输入"some_String", 输出："someString"
     *
     * @param columnName
     * @return
     */
    public static String convertColumnToProperty(String columnName) {
        if (StringUtils.isEmpty(columnName)) {
            return "";
        }
        columnName = columnName.toLowerCase();
        StringBuffer buff = new StringBuffer(columnName.length());
        StringTokenizer st = new StringTokenizer(columnName, "_");
        while (st.hasMoreTokens()) {
            buff.append(StringUtils.capitalize(st.nextToken()));
        }
        buff.setCharAt(0, Character.toLowerCase(buff.charAt(0)));
        return buff.toString();
    }

    /**
     * 输入表名，输出实体类名
     * 例如：输入"TABLE_NAME", 输出："TableName"
     *
     * @param tableName
     * @return
     */
    public static String convertTableNameToEntityName(String tableName) {
        if (StringUtils.isEmpty(tableName)) {
            return "";
        }
        tableName = tableName.toLowerCase();
        StringBuffer buff = new StringBuffer(tableName.length());
        StringTokenizer st = new StringTokenizer(tableName, "_");
        while (st.hasMoreTokens()) {
            buff.append(StringUtils.capitalize(st.nextToken()));
        }
        return buff.toString();
    }

    /**
     * 输入属性名，输出字段名
     * 例如：输入"someString", 输出："some_String"
     *
     * @param propName
     * @return
     */
    public static String convertPropertyToColumn(String propName) {
        final String patternString = "[A-Z]";
        Pattern pattern = Pattern.compile(patternString);
        Matcher matcher = pattern.matcher(propName);
        StringBuffer buf = new StringBuffer();
        int end = 0;
        while (matcher.find()) {
            int start = matcher.start();
            end = matcher.end();
            buf.append(propName.substring(0, start)).append("_").append(propName.substring(start, end).toLowerCase());
        }
        if (end < propName.length()) {
            buf.append(propName.substring(end));
        }
        return buf.toString();
    }
}
