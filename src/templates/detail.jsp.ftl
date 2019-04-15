<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.wbf.constant.SystemConfig" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
@author: ${author}
@date: ${date?string('yyyy/MM/dd hh:mm:ss')}
@modified by:
--%>
<html>
<head>
    <title>${describe_base}详情</title>
    <meta http-equiv="content-type" content="text/html;charset=utf-8">
    <link rel="stylesheet" type="text/css" href=" ${r'${ctxRoot}'}/res/easyui/themes/bootstrap/easyui.css">
    <link rel="stylesheet" type="text/css" href=" ${r'${ctxRoot}'}/res/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href=" ${r'${ctxRoot}'}/res/plugins/FontAwesome/css/font-awesome.min.css">
    <script type="text/javascript">
        var CTX_ROOT = " ${r'${ctxRoot}'}";
        var EXIST_RECORD_JSON = ' ${r'${data}'}';
    </script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/plugins/jQuery/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/plugins/fileupload/jquery.form.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/plugins/plupload/plupload.full.min.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/local/script/global.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/plugins/way/way.min.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/jslib/fileUpload.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/jslib/bsp.org.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/jslib/bsp.crud.js"></script>
    <script type="text/javascript"
            src=" ${r'${ctxRoot}'}/res/local/script${access_url_base}detail.js?v=${date?string('yyyyMMddhhmmss')}"></script>
</head>
<body style="width: 100%;height: 100%;">
<div id="view_win_tabs" class="easyui-tabs" fit="true" style="padding: 1px" data-options="border:false">
    <div title="基本信息">
        <table style='width: 100%;padding: 3px;font-size: 12px' cellspacing='5px'>
        <#if entity.attributeList?exists>
            <#list entity.attributeList as attribute>
                <#if attribute_index%2=0>
            <tr>
                <td style="min-width: 150px;width:150px;text-align: right;vertical-align: top">
                    <b>${attribute.attributeNote}:</b>
                </td>
                <td style="width: 30%;text-align: left;">
                    <label way-data="record.${attribute.attributeName}"></label>
                </td>
                <#else>
                <td style="min-width: 150px;width:150px;text-align: right;vertical-align: top">
                    <b>${attribute.attributeNote}:</b>
                </td>
                <td style="width: 30%;text-align: left;">
                    <label way-data="record.${attribute.attributeName}"></label>
                </td>
            </tr>
                </#if>
                <#if !attribute_has_next>
            </tr>
                </#if>
            </#list>
        </#if>
        </table>
    </div>
</div>
</body>
</html>