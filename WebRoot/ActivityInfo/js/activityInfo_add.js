$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('activityInfo_content');
	var activityInfo_content_editor = UE.getEditor('activityInfo_content'); //活动内容编辑框
	$("#activityInfo_typeObj_typeId").combobox({
	    url:'ActivityType/listAll',
	    valueField: "typeId",
	    textField: "typeName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#activityInfo_typeObj_typeId").combobox("getData"); 
            if (data.length > 0) {
                $("#activityInfo_typeObj_typeId").combobox("select", data[0].typeId);
            }
        }
	});
	$("#activityInfo_title").validatebox({
		required : true, 
		missingMessage : '请输入活动主题',
	});

	$("#activityInfo_activityTime").validatebox({
		required : true, 
		missingMessage : '请输入活动时间',
	});

	//单击添加按钮
	$("#activityInfoAddButton").click(function () {
		if(activityInfo_content_editor.getContent() == "") {
			alert("请输入活动内容");
			return;
		}
		//验证表单 
		if(!$("#activityInfoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#activityInfoAddForm").form({
			    url:"ActivityInfo/add",
			    onSubmit: function(){
					if($("#activityInfoAddForm").form("validate"))  { 
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
                        $("#activityInfoAddForm").form("clear");
                        activityInfo_content_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#activityInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#activityInfoClearButton").click(function () { 
		$("#activityInfoAddForm").form("clear"); 
	});
});
