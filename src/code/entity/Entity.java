package code.entity;

import java.util.List;

/**
 * Created by 胡光辉 on 2019/4/13.
 * desc:
 */
public class Entity {
    /**
     * 实体类名
     */
    private String entityName;
    /**
     * 属性集合
     */
    private List<Attribute> attributeList;
    /**
     * 与实体类对应的表
     */
    private Table table;

    public String getEntityName() {
        return entityName;
    }

    public void setEntityName(String entityName) {
        this.entityName = entityName;
    }

    public List<Attribute> getAttributeList() {
        return attributeList;
    }

    public void setAttributeList(List<Attribute> attributeList) {
        this.attributeList = attributeList;
    }

    public Table getTable() {
        return table;
    }

    public void setTable(Table table) {
        this.table = table;
    }
}
