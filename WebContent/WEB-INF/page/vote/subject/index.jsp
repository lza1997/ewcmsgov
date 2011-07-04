<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %> 
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<title>调查投票明细</title>	
		<link rel="stylesheet" type="text/css" href='<s:url value="/source/theme/default/easyui.css"/>'>
		<link rel="stylesheet" type="text/css" href='<s:url value="/source/theme/icon.css"/>'>
		<link rel="stylesheet" type="text/css" href="<s:url value="/source/css/ewcms.css"/>"/>
		<script type="text/javascript" src='<s:url value="/source/js/jquery-1.4.2.min.js"/>'></script>
		<script type="text/javascript" src='<s:url value="/source/js/jquery.easyui.min.js"/>'></script>
		<script type="text/javascript" src='<s:url value="/source/js/easyui-lang-zh_CN.js"/>'></script>
		<script type="text/javascript" src='<s:url value="/source/js/ewcms.js"/>'></script>
		<script>
			$(function(){
				//基本变量初始
				setGlobaVariable({
					singleSelect:true,
					tableid:'#tt_detail',
					inputURL:'<s:url namespace="/vote/subject" action="input"/>?questionnaireId=' + $('#questionnaireId').val() + '',
					queryURL:'<s:url namespace="/vote/subject" action="query"/>?questionnaireId=' + $('#questionnaireId').val() + '',
					deleteURL:'<s:url namespace="/vote/subject" action="delete"/>?questionnaireId=' + $('#questionnaireId').val() + '',
					editwidth:500,
					editheight:200,
					querywidth:500,
					queryheight:100
				});
				//数据表格定义 						
                openDataGrid({
                	singleSelect:true,
                    columns:[[
                                {field:'id',title:'编号',width:60},
                                {field:'title',title:'主题',width:500,
                                	formatter:function(val,rec){
                                		return '<a href="#" onclick="showDetailItem(' + rec.id + ',\'' + val +  '\',\'' + rec.subjectStatusDescription + '\');">' + val + '</a>';
                                	}
                                },
                                {field:'subjectStatusDescription',title:'选项方式',width:100}
                        ]],
        				toolbar:[
      							{text:'新增',iconCls:'icon-add',handler:addOperateBack},'-',
      							{text:'修改',iconCls:'icon-edit',handler:updOperateBack},'-',
      							{text:'删除',iconCls:'icon-remove', handler:delOperateBack},'-',
      							{text:'上移',iconCls:'icon-up',handler:upOperate},'-',
    							{text:'下移',iconCls:'icon-down',handler:downOperate},'-',
      							{text:'查询',iconCls:'icon-search', handler:queryOperateBack},'-',
      							{text:'缺省查询',iconCls:'icon-back', handler:initOperateQueryBack},'-'
      						]                       
				});
				$('#detaildiv').attr('title',parent.$('#questionnaireTitle').val());
			});
			function showDetailItem(subjectId, subjectTitle, optionDescription){
				var detailTitle = subjectTitle + ' - 调查投票明细列表';
				var url = "";
				if (optionDescription == '录入'){
					url = '<s:url namespace="/vote/subjectitem" action="inputopt"/>?subjectId=' + subjectId + '&questionnaireId=' + $('#questionnaireId').val() + '';
				}else{
					url = '<s:url namespace="/vote/subjectitem" action="index"/>?subjectId=' + subjectId + '&questionnaireId=' + $('#questionnaireId').val() + '';
				}
				$('#editifr').attr('src',url);
				openWindow('#edit-window',{width:858,height:374,title:detailTitle});
			}
			function upOperate(){
				var rows = $('#tt_detail').datagrid('getSelections');
				if(rows.length == 0){
	            	$.messager.alert('提示','请选择调查投票明细记录','info');
	                return;
	            }
	            if (rows.length > 1){
					$.messager.alert('提示','只能选择一个调查投票明细记录','info');
					return;
		        }
		        var url = '<s:url namespace="/vote/subject" action="up"/>';
		        var parameter = 'questionnaireId=' + $('#questionnaireId').val() + '&selections=' + rows[0].id + '';
	            $.post(url,parameter,function(data){
					if (data == "false"){
						$.messager.alert("提示","上移失败","info");
						return;
					}else if (data == "false-system"){
						$.messager.alert("提示","系统错误","info");
						return;
					}
					$("#tt_detail").datagrid('reload');
	            });
	            return false;
			}
			function downOperate(){
				var rows = $('#tt_detail').datagrid('getSelections');
				if(rows.length == 0){
	            	$.messager.alert('提示','请选择调查投票明细记录','info');
	                return;
	            }
	            if (rows.length > 1){
					$.messager.alert('提示','只能选择一个调查投票明细记录','info');
					return;
		        }
		        var url = '<s:url namespace="/vote/subject" action="down"/>';
		        var parameter = 'questionnaireId=' + $('#questionnaireId').val() + '&selections=' + rows[0].id + '';
	            $.post(url,parameter,function(data){
					if (data == "false"){
						$.messager.alert("提示","下移失败","info");
						return;
					}else if (data == "false-system"){
						$.messager.alert("提示","系统错误","info");
						return;
					}
					$("#tt_detail").datagrid('reload');
	            });
	            return false;
			}
		</script>
	</head>
	<body class="easyui-layout">
		<div id="detaildiv" region="center" style="padding:2px;" title="编号: <s:property value='questionnaireId'/> - 调查投票明细" split="true">
			<table id="tt_detail" fit="true" split="true"></table>
	 	</div>
        <div id="edit-window" class="easyui-window" closed="true" icon="icon-winedit" title="&nbsp;调查投票" style="display:none;">
            <div class="easyui-layout" fit="true">
                <div region="center" border="false">
                   <iframe id="editifr"  name="editifr" class="editifr" frameborder="0" onload="iframeFitHeight(this);" scrolling="no"></iframe>
                </div>
                <div region="south" border="false" style="text-align:center;height:28px;line-height:28px;background-color:#f6f6f6">
                    <a class="easyui-linkbutton" icon="icon-save" href="javascript:void(0)" onclick="saveOperator()">保存</a>
                    <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)" onclick="javascript:$('#editifr').attr('src','');$('#edit-window').window('close');">取消</a>
                </div>
            </div>
        </div>
        <div id="query-window" class="easyui-window" closed="true" icon='icon-search' title="查询"  style="display:none;">
            <div class="easyui-layout" fit="true"  >
                <div region="center" border="false" >
                <form id="queryform">
                	<table class="formtable">
                        <tr>
                            <td class="tdtitle">编号：</td>
                            <td class="tdinput">
                                <input type="text" id="id" name="id" class="inputtext"/>
                            </td>
                            <td class="tdtitle">标题：</td>
                            <td class="tdinput">
                                <input type="text" id="title" name="title" class="inputtext"/>
                            </td>
                        </tr>
               		</table>
               	</form>
                </div>
                <div region="south" border="false" style="text-align:center;height:28px;line-height:28px;background-color:#f6f6f6">
                    <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="querySearch_Article();">查询</a>
                    <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)" onclick="javascript:$('#query-window').window('close');">取消</a>
                </div>
            </div>
        </div>
        <s:hidden id="questionnaireId" name="questionnaireId"/>
	</body>
</html>