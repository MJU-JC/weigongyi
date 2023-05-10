var activityType_manage_tool = null; 
$(function () { 
	initActivityTypeManageTool(); //建立ActivityType管理对象
	activityType_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#activityType_manage").datagrid({
		url : 'ActivityType/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "typeId",
		sortOrder : "desc",
		toolbar : "#activityType_manage_tool",
		columns : [[
			{
				field : "typeId",
				title : "活动类型id",
				width : 70,
			},
			{
				field : "typeName",
				title : "活动类型名称",
				width : 140,
			},
		]],
	});

	$("#activityTypeEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#activityTypeEditForm").form("validate")) {
					//验证表单 
					if(!$("#activityTypeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#activityTypeEditForm").form({
						    url:"ActivityType/" + $("#activityType_typeId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#activityTypeEditForm").form("validate"))  {
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
			                        $("#activityTypeEditDiv").dialog("close");
			                        activityType_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#activityTypeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#activityTypeEditDiv").dialog("close");
				$("#activityTypeEditForm").form("reset"); 
			},
		}],
	});
});

function initActivityTypeManageTool() {
	activityType_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#activityType_manage").datagrid("reload");
		},
		redo : function () {
			$("#activityType_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#activityType_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#activityTypeQueryForm").form({
			    url:"ActivityType/OutToExcel",
			});
			//提交表单
			$("#activityTypeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#activityType_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var typeIds = [];
						for (var i = 0; i < rows.length; i ++) {
							typeIds.push(rows[i].typeId);
						}
						$.ajax({
							type : "POST",
							url : "ActivityType/deletes",
							data : {
								typeIds : typeIds.join(","),
							},
							beforeSend : function () {
								$("#activityType_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#activityType_manage").datagrid("loaded");
									$("#activityType_manage").datagrid("load");
									$("#activityType_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#activityType_manage").datagrid("loaded");
									$("#activityType_manage").datagrid("load");
									$("#activityType_manage").datagrid("unselectAll");
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
			var rows = $("#activityType_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "ActivityType/" + rows[0].typeId +  "/update",
					type : "get",
					data : {
						//typeId : rows[0].typeId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (activityType, response, status) {
						$.messager.progress("close");
						if (activityType) { 
							$("#activityTypeEditDiv").dialog("open");
							$("#activityType_typeId_edit").val(activityType.typeId);
							$("#activityType_typeId_edit").validatebox({
								required : true,
								missingMessage : "请输入活动类型id",
								editable: false
							});
							$("#activityType_typeName_edit").val(activityType.typeName);
							$("#activityType_typeName_edit").validatebox({
								required : true,
								missingMessage : "请输入活动类型名称",
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
