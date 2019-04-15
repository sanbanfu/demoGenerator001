package code.entity;

import java.util.List;

/**
 * Created by 胡光辉 on 2019/4/13.
 * desc:
 */
public class Table {
    /**
     * 表名
     */
    private String tableName;
    /**
     * 字段集合
     */
    private List<Column> columnList;

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public List<Column> getColumnList() {
        return columnList;
    }

    public void setColumnList(List<Column> columnList) {
        this.columnList = columnList;
    }
}
