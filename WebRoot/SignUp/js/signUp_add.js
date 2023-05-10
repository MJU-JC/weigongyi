$(function () {
	$("#signUp_activityObj_activityId").combobox({
	    url:'ActivityInfo/listAll',
	    valueField: "activityId",
	    textField: "title",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#signUp_activityObj_activityId").combobox("getData"); 
            if (data.length > 0) {
                $("#signUp_activityObj_activityId").combobox("select", data[0].activityId);
            }
        }
	});
	$("#signUp_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#signUp_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#signUp_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#signUp_signUpVow").validatebox({
		required : true, 
		missingMessage : '请输入报名宣誓',
	});

	$("#signUp_signUpTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#signUpAddButton").click(function () {
		//验证表单 
		if(!$("#signUpAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#signUpAddForm").form({
			    url:"SignUp/add",
			    onSubmit: function(){
					if($("#signUpAddForm").form("validate"))  { 
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
                        $("#signUpAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#signUpAddForm").submit();
		}
	});

	//单击清空按钮
	$("#signUpClearButton").click(function () { 
		$("#signUpAddForm").form("clear"); 
	});
});
