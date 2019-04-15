package code.entity;

/**
 * Created by 胡光辉 on 2019/4/13.
 * desc:
 */
public class Attribute {
    /**
     * 属性名称
     */
    private String attributeName;
    /**
     * 属性类型
     */
    private String attributeType;
    /**
     * 属性注释
     */
    private String attributeNote;
    /**
     * 与之对应的列
     */
    private Column column;

    public String getAttributeName() {
        return attributeName;
    }

    public void setAttributeName(String attributeName) {
        this.attributeName = attributeName;
    }

    public String getAttributeType() {
        return attributeType;
    }

    public void setAttributeType(String attributeType) {
        this.attributeType = attributeType;
    }

    public String getAttributeNote() {
        return attributeNote;
    }

    public void setAttributeNote(String attributeNote) {
        this.attributeNote = attributeNote;
    }

    public Column getColumn() {
        return column;
    }

    public void setColumn(Column column) {
        this.column = column;
    }
}
