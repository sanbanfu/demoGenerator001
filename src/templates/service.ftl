package ${packageName};

import com.wbf.dao.PropertyMapResultTransformer;
import com.wbf.dao.BaseJdbcTemplate;
import com.wbf.dao.CommonEntityDao;
import com.wbf.dao.LocalResultTransformer;
import com.wbf.entity.data.PageList;
import com.wbf.entity.data.UserDetail;
import com.wbf.utils.PageListUtils;
import com.wbf.utils.system.CurrentUserUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
* @author: ${author}
* @date: ${date?string('yyyy/MM/dd hh:mm:ss')}
* @modified by:
**/
@Service
public class ${entity.entityName}Service{
    private static final Logger logger = Logger.getLogger(${entity.entityName}Service.class);
    @Autowired
    private CommonEntityDao dao;

    /**
    * 分页查询记录信息
    **/
    public PageList pageQuery(final int page, final int pageSize, final Map queryParams) throws Exception {
        return dao.getHibernateTemplate().execute(session -> {
            StringBuffer querysql = new StringBuffer();
            Map queryMap = new HashMap(4);
            /*
            String secuCode = (String) queryParams.get("secu_code");
            if (StringUtils.isNotEmpty(secuCode)) {
                querysql.append(" AND I.SECU_CODE LIKE :secuCode ");
                queryMap.put("secuCode", "%" + secuCode + "%");
            }
            String secuName = (String) queryParams.get("secu_name");
            if (StringUtils.isNotEmpty(secuName)) {
                querysql.append(" AND I.SECU_NAME LIKE :secuName ");
                queryMap.put("secuName", "%" + secuName + "%");
            }
            */
            StringBuffer sql = new StringBuffer(""+
            " WHERE 1=1\n " + querysql + "ORDER BY  ");
            return PageListUtils.getPageList(page, pageSize, queryMap, session, sql);
        });
    }

    /**
    * 树查询
    **/
    public List queryForTree(final Map queryParams) throws Exception {
        return dao.getHibernateTemplate().execute(session -> {
            StringBuffer querysql = new StringBuffer();
/*
                String name_code = (String) queryParams.get("name_code");
                if (name_code != null && !"".equals(name_code)) {
                querysql.append(" AND (I.SECU_CODE LIKE '%" + name_code + "%' OR I.SECU_NAME LIKE '%" + name_code + "%') ");
                }
                String data_type_collection = (String) queryParams.get("data_type_collection");
                if (data_type_collection != null && !"".equals(data_type_collection)) {
                querysql.append(" AND I.DATA_TYPE in " + data_type_collection + " ");
                }
                String secu_type_collection = (String) queryParams.get("secu_type_collection");
                if (secu_type_collection != null && !"".equals(secu_type_collection)) {
                querysql.append(" AND I.SECU_TYPE in " + secu_type_collection + " ");
                }
                String data_type = (String) queryParams.get("data_type");
                if (data_type != null && !"".equals(data_type)) {
                querysql.append(" AND I.DATA_TYPE = '" + data_type + "' ");
                }
                String secuType = (String) queryParams.get("secu_type");
                if (secuType != null && !"".equals(secuType)) {
                querysql.append(" AND I.SECU_TYPE = '" + secuType + "' ");
                }
*/
            StringBuffer sql = new StringBuffer("" +
            " WHERE 1=1\n" + querysql + "ORDER BY ");
            SQLQuery query = session.createSQLQuery(sql.toString());
            PropertyMapResultTransformer pmrt = new PropertyMapResultTransformer();
            query.setResultTransformer(pmrt);
            query.setProperties(queryParams);
            return query.list();
        });
    }



    /**
    * save
    *
    * @param ${entity.entityName?uncap_first}
    * @return
    * @throws Exception
    */
    public ${entity.entityName} save${entity.entityName}(${entity.entityName} ${entity.entityName?uncap_first}) throws Exception {
        UserDetail user = CurrentUserUtils.getLocalUser();
        ${entity.entityName?uncap_first}.setStatus(${entity.entityName}.EFFECT);
        ${entity.entityName?uncap_first}.setCreateTime(new Date());
        ${entity.entityName?uncap_first}.setCreateUserid(user.getUserId());
        dao.getHibernateTemplate().save(${entity.entityName?uncap_first});
        return ${entity.entityName?uncap_first};
    }

    /**
    * delete
    *
    * @param ${entity.entityName?uncap_first}
    * @return
    * @throws Exception
    */
    public IamInvestSecu delete${entity.entityName}(${entity.entityName} ${entity.entityName?uncap_first}) throws Exception {
        ${entity.entityName?uncap_first} = dao.getHibernateTemplate().get(${entity.entityName}.class, ${entity.entityName?uncap_first}.getId());
        dao.getHibernateTemplate().delete(${entity.entityName?uncap_first});
        return ${entity.entityName?uncap_first};
    }

    /**
    * update
    *
    * @param ${entity.entityName?uncap_first}
    * @return
    * @throws Exception
    */
    public ${entity.entityName} update${entity.entityName}(${entity.entityName} ${entity.entityName?uncap_first}) throws Exception {
        UserDetail user = CurrentUserUtils.getLocalUser();
        ${entity.entityName} old_data = dao.getHibernateTemplate().get(${entity.entityName}.class,${entity.entityName?uncap_first}.getId());
        ${entity.entityName?uncap_first}.setCreateTime(old_data.getCreateTime());
        ${entity.entityName?uncap_first}.setUpdateTime(new Date());
        ${entity.entityName?uncap_first}.setUpdateUserid(user.getUserId());
        dao.getHibernateTemplate().evict(old_data);
        dao.getHibernateTemplate().update(${entity.entityName?uncap_first});
        return ${entity.entityName?uncap_first};
    }

}
