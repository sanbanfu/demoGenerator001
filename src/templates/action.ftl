package ${packageName};

import com.wbf.constant.SystemCodeConstant;
import com.wbf.dao.CommonEntityDao;
import com.wbf.entity.data.PageList;
import com.wbf.entity.db.system.SysDataDict;
import com.wbf.entity.json.JSONResult;
import com.wbf.service.iam.InvestSecuService;
import com.wbf.service.system.DataDictService;
import com.wbf.utils.PageListUtils;
import com.wbf.utils.system.JSONUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;


/**
* @author: ${author}
* @date: ${date?string('yyyy/MM/dd hh:mm:ss')}
* @modified by:
**/
@Controller
@RequestMapping(path = "${access_url_base}", name = "${describe_base}维护")
public class ${entity.entityName}Action{
    private static final Logger logger = Logger.getLogger(${entity.entityName}Action.class);
    @Autowired
    private CommonEntityDao dao;
    @Autowired
    private ${entity.entityName}Service ${entity.entityName?uncap_first}Service;
    @Autowired
    private DataDictService dataDictService;

    /**
    * 资产信息首页
    */
    @RequestMapping(path = "index", name = "资产信息首页")
    public String index() {
        return "${access_url_base}index";
    }

    @RequestMapping(path = "page_query", name = "分页查询记录")
    @ResponseBody
    public PageList pageQuery(@RequestParam(name = "condition", required = false) String paramStr, HttpServletRequest request) {
        PageList pl = new PageList();
        try {
            Map params = PageListUtils.getParamMap(paramStr);
            int page = PageListUtils.getPage(request);
            int pageSize = PageListUtils.getPageSize(request);
            pl = ${entity.entityName?uncap_first}Service.pageQuery(page, pageSize, params);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pl;
    }

    /**
    * 资产信息保存/更新
    *
    * @param secu
    * @return
    */
    @RequestMapping(path = "save_or_update", name = "资产信息保存/更新")
    @ResponseBody
    public JSONResult saveOrUpdate(@RequestBody ${entity.entityName} ${entity.entityName?uncap_first}, HttpServletRequest request) throws Exception {
        JSONResult result = new JSONResult();
        result.setCode(SystemCodeConstant.getSystemCode(SystemCodeConstant.JR_UNKNOWN_ERROR));
        try {
            if (${entity.entityName?uncap_first}.getId() == null) {
                ${entity.entityName?uncap_first}Service.save${entity.entityName?uncap_first}(${entity.entityName?uncap_first});
            } else {
                ${entity.entityName?uncap_first}Service.update${entity.entityName?uncap_first}(${entity.entityName?uncap_first});
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.setMessage(e.getMessage());
            return result;
        }
        result.setCode(SystemCodeConstant.getSystemCode(SystemCodeConstant.JR_OK));
        return result;
    }

    /**
    * 资产删除
    *
    * @param secu 资产
    * @return
    */
    @RequestMapping(path = "delete", name = "资产删除")
    @ResponseBody
    public JSONResult delete(@RequestBody ${entity.entityName} ${entity.entityName?uncap_first}) {
        JSONResult result = new JSONResult();
        try {
            ${entity.entityName?uncap_first}Service.delete${entity.entityName?uncap_first}(${entity.entityName?uncap_first});
            result.setCode(SystemCodeConstant.getSystemCode(SystemCodeConstant.JR_OK));
        } catch (Exception e) {
            result.setCode(SystemCodeConstant.getSystemCode(SystemCodeConstant.JR_UNKNOWN_ERROR));
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping(path = "page_create", name = "投顾资产新增页面")
    public String pageCreate(HttpServletRequest request) throws Exception {
        String URL = "${access_url_base}create";
        return URL;
    }

    @RequestMapping(path = "page_edit", name = "投顾资产编辑页面")
    public String pageEdit(HttpServletRequest request) throws Exception {
        String id = request.getParameter("id");
        ${entity.entityName} ${entity.entityName?uncap_first} = dao.getHibernateTemplate().get(${entity.entityName}.class, Long.valueOf(id));
        request.setAttribute("data", JSONUtils.getJSONString(${entity.entityName?uncap_first}));
        String URL = "${access_url_base}edit";
        return URL;
    }


}
