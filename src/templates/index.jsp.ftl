<%@ taglib prefix="bsp_base" uri="/base-tag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
@author: ${author}
@date: ${date?string('yyyy/MM/dd hh:mm:ss')}
@modified by:
--%>
<html>
<head>
    <title>${describe_base}首页</title>
    <meta http-equiv="content-type" content="text/html;charset=utf-8">
    <link rel="stylesheet" type="text/css" href=" ${r'${ctxRoot}'}/res/easyui/themes/bootstrap/easyui.css">
    <link rel="stylesheet" type="text/css" href=" ${r'${ctxRoot}'}/res/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href=" ${r'${ctxRoot}'}/res/plugins/FontAwesome/css/font-awesome.min.css">
    <script type="text/javascript">
        var CTX_ROOT = " ${r'${ctxRoot}'}";
    </script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/plugins/jQuery/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/plugins/fileupload/jquery.form.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/plugins/way/way.min.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/local/script/global.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/jslib/fileUpload.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/jslib/bsp.org.js"></script>
    <script type="text/javascript" src=" ${r'${ctxRoot}'}/res/jslib/bsp.crud.js"></script>
    <script type="text/javascript"
            src=" ${r'${ctxRoot}'}/res/local/script${access_url_base}index.js?v=${date?string('yyyyMMddhhmmss')}"></script>
</head>
<body style="width: 100%;font-size: 12px" class="easyui-layout">
<div data-options="region:'north',split:false,border:true" style="height:36px;vertical-align: middle">
    <form id="query_form" style="margin: 3px">
        <input name="signReason" class="easyui-textbox" data-options="label:'签章用途',labelWidth:60,labelAlign:'right'"
               style="width:180px;">
        <input id="query_beginDate" class="easyui-datebox" name="query_date_from"
               data-options="valueField:'value',textField:'name',prompt:'请选择',width:160,label:'签章日期',labelWidth:60,labelAlign:'right'"/>
        - <input id="query_endDate" class="easyui-datebox" name="query_date_to"
                 data-options="width:100,prompt:'请选择'"/>
        <input id="status_query" class="easyui-combobox" name="status_query"
               data-options="label:'状态',width:150,prompt:'请选择',labelWidth:60,labelAlign:'right',textField:'name',data:GetDictItemForComboBox('system.paramSign.status')"/>
        <a id="query_btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
           onclick="executeQuery();">查询</a>
    </form>
</div>
<div id="data_toolBar">
    <bsp_base:menu-pri type="view">
        <a href="javascript:void(0);" class="easyui-linkbutton" onclick="openDetailWindow();"
           data-options="iconCls:'icon-search',plain:true">详情</a>
    </bsp_base:menu-pri>
    <bsp_base:menu-pri type="action">
        <a href="javascript:void(0);" class="easyui-linkbutton" onclick="openCreateWindow();"
           data-options="iconCls:'icon-add',plain:true">新增</a>
        <a href="javascript:void(0);" class="easyui-linkbutton" onclick="openEditWindow();"
           data-options="iconCls:'icon-edit',plain:true">编辑</a>
        <a href="javascript:void(0);" class="easyui-linkbutton" onclick="openCheckSelectWindow();"
           data-options="iconCls:'icon-ok',plain:true">提交</a>
    </bsp_base:menu-pri>
    <bsp_base:menu-pri type="remove">
        <a href="javascript:void(0);" class="easyui-linkbutton" onclick="removeInfo();"
           data-options="iconCls:'icon-clear',plain:true">作废</a>
    </bsp_base:menu-pri>
</div>
<div data-options="region:'center',border:false">
    <table id="main_table" data-options="toolbar:'#data_toolBar'"></table>
</div>

<%--操作窗口--%>
<div id="action_win" class="easyui-dialog" title="操作窗口" style="width:900px;height:510px;"
     data-options="iconCls:'fa icon-add',closed:true,resizable:false,maximizable:true,modal:true,buttons:'#action_win_button'">
    <iframe id="action_win_iframe" src="" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>
</div>


<div id="action_win_button">
    <a href="#" id="aw_button_save" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:false"
       onclick="doActionSave();">保存</a>
    <a href="#" id="aw_button_submit" class="easyui-linkbutton" data-options="iconCls:'icon-ok',plain:false"
       onclick="doActionSubmit();">提交</a>
    <a href="#" id="aw_button_close" class="easyui-linkbutton" onclick="closeDoActionWindow()"
       data-options="iconCls:'icon-cancel',plain:false">关闭</a>
</div>

<%--查看窗口--%>
<div id="show_view_win" class="easyui-dialog" title="查看窗口" style="width:900px;height:650px;"
     data-options="iconCls:'fa icon-search',closed:true,resizable:false,modal:true,maximizable:true,
            content:'',
            buttons:[{
				text:'关闭',
				iconCls:'icon-cancel',
				handler:function(){
				    $('#show_view_win').dialog('close');
				}
			}]">
    <iframe id="show_view_win_iframe" src="" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
</div>
</body>
</html>