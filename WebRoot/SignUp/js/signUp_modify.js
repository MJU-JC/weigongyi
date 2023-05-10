$(function () {
	$.ajax({
		url : "SignUp/" + $("#signUp_signId_edit").val() + "/update",
		type : "get",
		data : {
			//signId : $("#signUp_signId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (signUp, response, status) {
			$.messager.progress("close");
			if (signUp) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#signUpModifyButton").click(function(){ 
		if ($("#signUpEditForm").form("validate")) {
			$("#signUpEditForm").form({
			    url:"SignUp/" +  $("#signUp_signId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#signUpEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
