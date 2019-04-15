/**
* @author: ${author}
* @date: ${date?string('yyyy/MM/dd hh:mm:ss')}
* @modified by:
**/

$(function () {
    $('#main_table').datagrid({
    url: CTX_ROOT + "${access_url_base}page_query.req",
    method: 'GET',
    search: true,
    fit: true,
    pageSize: 20,
    checkOnSelect: false,
    selectOnCheck: false,
    rownumbers: false,
    remoteSort: false,
    singleSelect: true,
    pagination: true,
    striped: true,
    columns: [[
    <#if entity.attributeList?exists>
        <#list entity.attributeList as attribute>
        {field: '${attribute.attributeName}', title: '${attribute.attributeNote}', width: 150, halign: 'center', align: 'left'},
        </#list>
    </#if>

    ]]
    });

});

/**
* 执行查询请求
*/
function executeQuery() {
    var formData = $("#query_form").serializeObject();
    var qp = JSON.stringify(formData);
    $('#main_table').datagrid('load', {condition: qp});
    $("#main_table").datagrid("clearSelections");
}

/**
* 打开创建窗口
*/
function openCreateWindow() {
    $("#action_win_iframe").attr("src", CTX_ROOT + "${access_url_base}page_create.req");
    $("#action_win").dialog({title: "新增${describe_base}", iconCls: 'fa icon-add'});
    $("#aw_button_save").show();
    $("#action_win").dialog("open");
}

/**
* 打开编辑窗口
*/
function openEditWindow() {
    var selectRow = $("#main_table").datagrid("getSelected");
    if (selectRow) {
        if (selectRow.status && (selectRow.status == RECORD_STATUS_INIT)) {
            $("#action_win_iframe").attr("src", CTX_ROOT + "${access_url_base}page_edit.req?id=" + selectRow.id);
            $("#action_win").dialog({title: "编辑${describe_base}", iconCls: 'fa icon-edit'});
            $("#aw_button_save").show();
            $("#action_win").dialog("open");
        } else {
            $.messager.alert({
            title: '操作提醒',
            msg: '您选择的记录不允许编辑操作',
            timeout: 2000,
            showType: 'slide'
            });
        }
    } else {
        $.messager.alert({
        title: '操作提醒',
        msg: '请先选择要操作的记录',
        timeout: 2000,
        showType: 'slide'
        });
    }
}

/**
* 打开复核人选择窗口
*/
function openCheckSelectWindow() {
var selectRow = $("#main_table").datagrid("getSelected");
if (selectRow) {
if (selectRow.status && (selectRow.status == RECORD_STATUS_INIT)) {
$("#checker_select_win").dialog({title: "选择复核人", iconCls: 'fa icon-edit'});
$("#checker_select_win").dialog("open");
$("#checker_select_form").form("reset");
} else {
$.messager.alert({
title: '操作提醒',
msg: '您选择的记录不允许提交操作',
timeout: 2000,
showType: 'slide'
});
}
} else {
$.messager.alert({
title: '操作提醒',
msg: '请先选择要操作的记录',
timeout: 2000,
showType: 'slide'
});
}
}

/**
* 提交记录信息进行复核
*/
function doSubmitRequest() {
var selectRow = $("#main_table").datagrid("getSelected");
if (selectRow && $("#checker_select_form").form("validate")) {
var formData = $("#checker_select_form").serializeObject();
$.messager.progress();
$.ajax({
method: 'POST',
url: CTX_ROOT + '${access_url_base}edit_submit.req',
data: JSON.stringify({record: selectRow, checkUserId: formData.checker}),
contentType: "application/json",
dateType: "json",
success: function (result) {
if (result && result.code == SYS_OK_CODE) {
$("#checker_select_win").dialog("close");
$.messager.show({
title: '提醒信息',
msg: '操作成功',
timeout: 2000,
showType: 'slide'
});
$("#main_table").datagrid("reload");
} else {
$.messager.alert({
title: '提醒信息',
msg: '操作异常',
timeout: 2000,
showType: 'slide'
});
}
},
complete: function () {
$.messager.progress("close");
}
});
}
}

/**
* 作废
*/
function removeInfo() {
    var selectRow = $("#main_table").datagrid("getSelected");
    if (selectRow) {
        if (selectRow.status != RECORD_STATUS_INIT) {
            $.messager.alert({
            title: '操作提醒',
            msg: '您选择的记录不允许删除',
            timeout: 2000,
            showType: 'slide'
            });
            return false;
            }
            $.messager.confirm("操作确认", "您确定要作废该记录?", function (bnt) {
            if (bnt) {
                    $.messager.progress();
                    $.ajax({
                    method: 'POST',
                    url: CTX_ROOT + '${access_url_base}delete_record.req',
                    data: JSON.stringify({"recordId": selectRow.recordId}),
                    contentType: "application/json",
                    dateType: "json",
                    success: function (result) {
                    if (result && result.code == SYS_OK_CODE) {
                    $.messager.show({
                    title: '提醒信息',
                    msg: '操作成功',
                    timeout: 2000,
                    showType: 'slide'
                    });
                    $("#main_table").datagrid("reload");
                } else {
                    $.messager.alert({
                    title: '提醒信息',
                    msg: '操作异常',
                    timeout: 2000,
                    showType: 'slide'
                    });
                }
                },
                complete: function () {
                    $.messager.progress("close");
                }
                });
            }
        });
    } else {
        $.messager.alert({
        title: '操作提醒',
        msg: '请先选择要操作的记录',
        timeout: 2000,
        showType: 'slide'
        });
    }
}

/**
* 执行保存操作，一般为调用iframe中的保存方法
*/
function doActionSave() {
    $(document).contents().find("#action_win_iframe")[0].contentWindow.globalBizAction('save');
}

/**
* 执行提交操作，一般为调用iframe中的保存方法
*/
function doActionSubmit() {
    $(document).contents().find("#action_win_iframe")[0].contentWindow.globalBizAction('submit');
}

/**
* 关闭操作窗口
*/
function CloseCreateWin(result) {
    if (result) {
        var resultCode = result.code;
        if (resultCode == SYS_OK_CODE) {
            $.messager.show({
            title: '提醒信息',
            msg: '操作成功',
            timeout: 2000,
            showType: 'slide'
            });
            $("#main_table").datagrid("reload");
        } else {
            $.messager.show({
            title: '操作提示',
            msg: result.message ? result.message : '操作失败!',
            timeout: 2000,
            showType: 'slide'
            });
            return false;
        }
    }
    $("#action_win").dialog("close");
}

/**
* 关闭操作窗口
*/
function closeDoActionWindow(result) {
    if (result) {
        var resultCode = result.code;
        if (resultCode == SYS_OK_CODE) {
            $.messager.show({
            title: '提醒信息',
            msg: '操作成功',
            timeout: 2000,
            showType: 'slide'
            });
            $("#main_table").datagrid("reload");
        } else {
            $.messager.show({
            title: '操作提示',
            msg: result.message ? result.message : '操作失败!',
            timeout: 2000,
            showType: 'slide'
            });
            return false;
        }
    }
    $("#action_win").dialog("close");
}

/**
* 打开详情页面
*/
function openDetailWindow() {
    var main_table = $("#main_table").datagrid("getSelected");
    if (main_table) {
        var recordId = main_table.recordId;
        $("#show_view_win_iframe").attr("src", CTX_ROOT + "${access_url_base}page_detail.req?id=" + recordId);
        $("#show_view_win").dialog({title: "签章文件详情", iconCls: 'fa icon-search'});
        $("#show_view_win").dialog("open");
    } else {
        $.messager.show({
        title: '操作提示',
        msg: '请选择一条数据！',
        timeout: 2000,
        showType: 'slide'
        });
    }
}