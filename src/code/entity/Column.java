package code.entity;

/**
 * Created by 胡光辉 on 2019/4/13.
 * desc:
 */
public class Column {
    /**
     * 字段名称
     */
    private String columnName;
    /**
     * 字段类型
     */
    private String columnType;
    /**
     * 字段描述
     */
    private String columnNotes;

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getColumnType() {
        return columnType;
    }

    public void setColumnType(String columnType) {
        this.columnType = columnType;
    }

    public String getColumnNotes() {
        return columnNotes;
    }

    public void setColumnNotes(String columnNotes) {
        this.columnNotes = columnNotes;
    }
}
