var signUp_manage_tool = null; 
$(function () { 
	initSignUpManageTool(); //建立SignUp管理对象
	signUp_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#signUp_manage").datagrid({
		url : 'SignUp/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "signId",
		sortOrder : "desc",
		toolbar : "#signUp_manage_tool",
		columns : [[
			{
				field : "signId",
				title : "报名id",
				width : 70,
			},
			{
				field : "activityObj",
				title : "报名的活动",
				width : 140,
			},
			{
				field : "userObj",
				title : "报名人",
				width : 140,
			},
			{
				field : "signUpVow",
				title : "报名宣誓",
				width : 140,
			},
			{
				field : "signUpTime",
				title : "报名时间",
				width : 140,
			},
		]],
	});

	$("#signUpEditDiv").dialog({
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
				if ($("#signUpEditForm").form("validate")) {
					//验证表单 
					if(!$("#signUpEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#signUpEditForm").form({
						    url:"SignUp/" + $("#signUp_signId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#signUpEditForm").form("validate"))  {
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
			                        $("#signUpEditDiv").dialog("close");
			                        signUp_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#signUpEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#signUpEditDiv").dialog("close");
				$("#signUpEditForm").form("reset"); 
			},
		}],
	});
});

function initSignUpManageTool() {
	signUp_manage_tool = {
		init: function() {
			$.ajax({
				url : "ActivityInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#activityObj_activityId_query").combobox({ 
					    valueField:"activityId",
					    textField:"title",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{activityId:0,title:"不限制"});
					$("#activityObj_activityId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#signUp_manage").datagrid("reload");
		},
		redo : function () {
			$("#signUp_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#signUp_manage").datagrid("options").queryParams;
			queryParams["activityObj.activityId"] = $("#activityObj_activityId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["signUpTime"] = $("#signUpTime").datebox("getValue"); 
			$("#signUp_manage").datagrid("options").queryParams=queryParams; 
			$("#signUp_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#signUpQueryForm").form({
			    url:"SignUp/OutToExcel",
			});
			//提交表单
			$("#signUpQueryForm").submit();
		},
		remove : function () {
			var rows = $("#signUp_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var signIds = [];
						for (var i = 0; i < rows.length; i ++) {
							signIds.push(rows[i].signId);
						}
						$.ajax({
							type : "POST",
							url : "SignUp/deletes",
							data : {
								signIds : signIds.join(","),
							},
							beforeSend : function () {
								$("#signUp_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#signUp_manage").datagrid("loaded");
									$("#signUp_manage").datagrid("load");
									$("#signUp_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#signUp_manage").datagrid("loaded");
									$("#signUp_manage").datagrid("load");
									$("#signUp_manage").datagrid("unselectAll");
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
			var rows = $("#signUp_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "SignUp/" + rows[0].signId +  "/update",
					type : "get",
					data : {
						//signId : rows[0].signId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (signUp, response, status) {
						$.messager.progress("close");
						if (signUp) { 
							$("#signUpEditDiv").dialog("open");
							$("#signUp_signId_edit").val(signUp.signId);
							$("#signUp_signId_edit").validatebox({
								required : true,
								missingMessage : "请输入报名id",
								editable: false
							});
							$("#signUp_activityObj_activityId_edit").combobox({
								url:"ActivityInfo/listAll",
							    valueField:"activityId",
							    textField:"title",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#signUp_activityObj_activityId_edit").combobox("select", signUp.activityObjPri);
									//var data = $("#signUp_activityObj_activityId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#signUp_activityObj_activityId_edit").combobox("select", data[0].activityId);
						            //}
								}
							});
							$("#signUp_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#signUp_userObj_user_name_edit").combobox("select", signUp.userObjPri);
									//var data = $("#signUp_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#signUp_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#signUp_signUpVow_edit").val(signUp.signUpVow);
							$("#signUp_signUpVow_edit").validatebox({
								required : true,
								missingMessage : "请输入报名宣誓",
							});
							$("#signUp_signUpTime_edit").datetimebox({
								value: signUp.signUpTime,
							    required: true,
							    showSeconds: true,
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
