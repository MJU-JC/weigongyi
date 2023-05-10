$(function () {
	$("#donation_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#donation_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#donation_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#donation_donationMoney").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入捐款金额',
		invalidMessage : '捐款金额输入不对',
	});

	$("#donation_dunationTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#donation_sheHeState").validatebox({
		required : true, 
		missingMessage : '请输入审核状态',
	});

	//单击添加按钮
	$("#donationAddButton").click(function () {
		//验证表单 
		if(!$("#donationAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#donationAddForm").form({
			    url:"Donation/add",
			    onSubmit: function(){
					if($("#donationAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#donationAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#donationAddForm").submit();
		}
	});

	//单击清空按钮
	$("#donationClearButton").click(function () { 
		$("#donationAddForm").form("clear"); 
	});
});
