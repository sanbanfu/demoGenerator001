<%--
@author: ${author}
@date: ${date?string('yyyy/MM/dd hh:mm:ss')}
@modified by:
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.wbf.constant.SystemConfig" %>
<html>
<head>
    <title>创建${describe_base}页面</title>
    <meta http-equiv="content-type" content="text/html;charset=utf-8">
    <link rel="stylesheet" type="text/css" href=" ${r'${ctxRoot}'}/res/easyui/themes/bootstrap/easyui.css">
    <link rel="stylesheet" type="text/css" href=" ${r'${ctxRoot}'}/res/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href=" ${r'${ctxRoot}'}/res/plugins/FontAwesome/css/font-awesome.min.css">
    <script type="text/javascript">
        var CTX_ROOT = " ${r'${ctxRoot}'}";
        var TODAY_DATE = '<%=SystemConfig.getCurrentFormatDate()%>';
        var DEFAULT_INVALID_DATE = '<%=SystemConfig.DEFAULT_INVALID_DATE%>';
    </script>
    <script type="text/javascript" src=" ${r' ${r'${ctxRoot}'}'}/res/plugins/jQuery/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src=" ${r' ${r'${ctxRoot}'}'}/res/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/plugins/fileupload/jquery.form.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/plugins/plupload/plupload.full.min.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/local/script/global.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/jslib/fileUpload.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/jslib/bsp.org.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/jslib/bsp.crud.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/local/script${access_url_base}create.js?v=${date?string('yyyyMMddhhmmss')}"></script>
</head>
<body>
<div id="create_win_tabs" class="easyui-panel" style="width:95%;height:95%;" data-options="border:false">
    <form id="create_form" method="post">
        <table style='width: 100%;padding: 5px;font-size: 12px' cellspacing='5px'>
<#if entity.attributeList?exists>
    <#list entity.attributeList as attribute>
        <#if attribute_index%2=0>
            <tr>
                <td colspan="2" width="50%">
                    <input class="easyui-textbox" name="${attribute.attributeName}" id="${attribute.attributeName}"
                           data-options="required:true,label:'${attribute.attributeNote}',textField:'name',labelWidth:150,labelAlign:'right'"
                           style="width: 340px">
                </td>
        <#else>
            <td colspan="2" width="50%">
                    <input class="easyui-textbox" name="${attribute.attributeName}" id="${attribute.attributeName}"
                           data-options="required:true,label:'${attribute.attributeNote}',textField:'name',labelWidth:150,labelAlign:'right'"
                           style="width: 360px">
                </td>
            </tr>
        </#if>
        <#if !attribute_has_next>
            </tr>
        </#if>
    </#list>
</#if>
        </table>
    </form>
</div>
</body>
</html>
