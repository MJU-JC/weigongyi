var activityInfo_manage_tool = null; 
$(function () { 
	initActivityInfoManageTool(); //建立ActivityInfo管理对象
	activityInfo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#activityInfo_manage").datagrid({
		url : 'ActivityInfo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "activityId",
		sortOrder : "desc",
		toolbar : "#activityInfo_manage_tool",
		columns : [[
			{
				field : "activityId",
				title : "活动id",
				width : 70,
			},
			{
				field : "typeObj",
				title : "活动类型",
				width : 140,
			},
			{
				field : "title",
				title : "活动主题",
				width : 140,
			},
			{
				field : "activityPhoto",
				title : "活动图片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "activityTime",
				title : "活动时间",
				width : 140,
			},
		]],
	});

	$("#activityInfoEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#activityInfoEditForm").form("validate")) {
					//验证表单 
					if(!$("#activityInfoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#activityInfoEditForm").form({
						    url:"ActivityInfo/" + $("#activityInfo_activityId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#activityInfoEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#activityInfoEditDiv").dialog("close");
			                        activityInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#activityInfoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#activityInfoEditDiv").dialog("close");
				$("#activityInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initActivityInfoManageTool() {
	activityInfo_manage_tool = {
		init: function() {
			$.ajax({
				url : "ActivityType/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#typeObj_typeId_query").combobox({ 
					    valueField:"typeId",
					    textField:"typeName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{typeId:0,typeName:"不限制"});
					$("#typeObj_typeId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#activityInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#activityInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#activityInfo_manage").datagrid("options").queryParams;
			queryParams["typeObj.typeId"] = $("#typeObj_typeId_query").combobox("getValue");
			queryParams["title"] = $("#title").val();
			$("#activityInfo_manage").datagrid("options").queryParams=queryParams; 
			$("#activityInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#activityInfoQueryForm").form({
			    url:"ActivityInfo/OutToExcel",
			});
			//提交表单
			$("#activityInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#activityInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var activityIds = [];
						for (var i = 0; i < rows.length; i ++) {
							activityIds.push(rows[i].activityId);
						}
						$.ajax({
							type : "POST",
							url : "ActivityInfo/deletes",
							data : {
								activityIds : activityIds.join(","),
							},
							beforeSend : function () {
								$("#activityInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#activityInfo_manage").datagrid("loaded");
									$("#activityInfo_manage").datagrid("load");
									$("#activityInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#activityInfo_manage").datagrid("loaded");
									$("#activityInfo_manage").datagrid("load");
									$("#activityInfo_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#activityInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "ActivityInfo/" + rows[0].activityId +  "/update",
					type : "get",
					data : {
						//activityId : rows[0].activityId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (activityInfo, response, status) {
						$.messager.progress("close");
						if (activityInfo) { 
							$("#activityInfoEditDiv").dialog("open");
							$("#activityInfo_activityId_edit").val(activityInfo.activityId);
							$("#activityInfo_activityId_edit").validatebox({
								required : true,
								missingMessage : "请输入活动id",
								editable: false
							});
							$("#activityInfo_typeObj_typeId_edit").combobox({
								url:"ActivityType/listAll",
							    valueField:"typeId",
							    textField:"typeName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#activityInfo_typeObj_typeId_edit").combobox("select", activityInfo.typeObjPri);
									//var data = $("#activityInfo_typeObj_typeId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#activityInfo_typeObj_typeId_edit").combobox("select", data[0].typeId);
						            //}
								}
							});
							$("#activityInfo_title_edit").val(activityInfo.title);
							$("#activityInfo_title_edit").validatebox({
								required : true,
								missingMessage : "请输入活动主题",
							});
							$("#activityInfo_activityPhoto").val(activityInfo.activityPhoto);
							$("#activityInfo_activityPhotoImg").attr("src", activityInfo.activityPhoto);
							activityInfo_content_editor.setContent(activityInfo.content, false);
							$("#activityInfo_activityTime_edit").val(activityInfo.activityTime);
							$("#activityInfo_activityTime_edit").validatebox({
								required : true,
								missingMessage : "请输入活动时间",
							});
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
