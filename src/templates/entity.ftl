package ${packageName};

import org.hibernate.annotations.Type;
import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
* @author: ${author}
* @date: ${date?string('yyyy/MM/dd hh:mm:ss')}
* @modified by:
**/
@Entity
@Table(name = "${entity.table.tableName}")
public class ${entity.entityName} implements Serializable{

<#if entity.attributeList?exists>
    <#list entity.attributeList as attribute>
    /**
    *${attribute.attributeNote}
    */
    private ${attribute.attributeType} ${attribute.attributeName};

    </#list>
</#if>

<#if entity.attributeList?exists>
    <#list entity.attributeList as attribute>
    @Basic
    @Column(name = "${attribute.column.columnName}")
    public ${attribute.attributeType} get${attribute.attributeName?cap_first}() {
        return this.${attribute.attributeName};
    }

    public void set${attribute.attributeName?cap_first} (${attribute.attributeType} ${attribute.attributeName}) {
        this.${attribute.attributeName} = ${attribute.attributeName};
    }

    </#list>
</#if>
}
