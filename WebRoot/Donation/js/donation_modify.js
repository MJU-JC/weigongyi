$(function () {
	$.ajax({
		url : "Donation/" + $("#donation_donationId_edit").val() + "/update",
		type : "get",
		data : {
			//donationId : $("#donation_donationId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (donation, response, status) {
			$.messager.progress("close");
			if (donation) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#donationModifyButton").click(function(){ 
		if ($("#donationEditForm").form("validate")) {
			$("#donationEditForm").form({
			    url:"Donation/" +  $("#donation_donationId_edit").val() + "/update",
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
			$("#donationEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
