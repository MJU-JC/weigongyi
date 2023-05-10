var donation_manage_tool = null; 
$(function () { 
	initDonationManageTool(); //建立Donation管理对象
	donation_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#donation_manage").datagrid({
		url : 'Donation/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "donationId",
		sortOrder : "desc",
		toolbar : "#donation_manage_tool",
		columns : [[
			{
				field : "donationId",
				title : "捐款id",
				width : 70,
			},
			{
				field : "userObj",
				title : "捐款人",
				width : 140,
			},
			{
				field : "donationMoney",
				title : "捐款金额",
				width : 70,
			},
			{
				field : "dunationTime",
				title : "捐款时间",
				width : 140,
			},
			{
				field : "sheHeState",
				title : "审核状态",
				width : 140,
			},
		]],
	});

	$("#donationEditDiv").dialog({
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
				if ($("#donationEditForm").form("validate")) {
					//验证表单 
					if(!$("#donationEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#donationEditForm").form({
						    url:"Donation/" + $("#donation_donationId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#donationEditForm").form("validate"))  {
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
			                        $("#donationEditDiv").dialog("close");
			                        donation_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#donationEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#donationEditDiv").dialog("close");
				$("#donationEditForm").form("reset"); 
			},
		}],
	});
});

function initDonationManageTool() {
	donation_manage_tool = {
		init: function() {
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
			$("#donation_manage").datagrid("reload");
		},
		redo : function () {
			$("#donation_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#donation_manage").datagrid("options").queryParams;
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["dunationTime"] = $("#dunationTime").datebox("getValue"); 
			queryParams["sheHeState"] = $("#sheHeState").val();
			$("#donation_manage").datagrid("options").queryParams=queryParams; 
			$("#donation_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#donationQueryForm").form({
			    url:"Donation/OutToExcel",
			});
			//提交表单
			$("#donationQueryForm").submit();
		},
		remove : function () {
			var rows = $("#donation_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var donationIds = [];
						for (var i = 0; i < rows.length; i ++) {
							donationIds.push(rows[i].donationId);
						}
						$.ajax({
							type : "POST",
							url : "Donation/deletes",
							data : {
								donationIds : donationIds.join(","),
							},
							beforeSend : function () {
								$("#donation_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#donation_manage").datagrid("loaded");
									$("#donation_manage").datagrid("load");
									$("#donation_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#donation_manage").datagrid("loaded");
									$("#donation_manage").datagrid("load");
									$("#donation_manage").datagrid("unselectAll");
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
			var rows = $("#donation_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Donation/" + rows[0].donationId +  "/update",
					type : "get",
					data : {
						//donationId : rows[0].donationId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (donation, response, status) {
						$.messager.progress("close");
						if (donation) { 
							$("#donationEditDiv").dialog("open");
							$("#donation_donationId_edit").val(donation.donationId);
							$("#donation_donationId_edit").validatebox({
								required : true,
								missingMessage : "请输入捐款id",
								editable: false
							});
							$("#donation_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#donation_userObj_user_name_edit").combobox("select", donation.userObjPri);
									//var data = $("#donation_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#donation_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#donation_donationMoney_edit").val(donation.donationMoney);
							$("#donation_donationMoney_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入捐款金额",
								invalidMessage : "捐款金额输入不对",
							});
							$("#donation_dunationTime_edit").datetimebox({
								value: donation.dunationTime,
							    required: true,
							    showSeconds: true,
							});
							$("#donation_dunationMemo_edit").val(donation.dunationMemo);
							$("#donation_sheHeState_edit").val(donation.sheHeState);
							$("#donation_sheHeState_edit").validatebox({
								required : true,
								missingMessage : "请输入审核状态",
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
