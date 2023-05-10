$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('activityInfo_content_edit');
	var activityInfo_content_edit = UE.getEditor('activityInfo_content_edit'); //活动内容编辑器
	activityInfo_content_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "ActivityInfo/" + $("#activityInfo_activityId_edit").val() + "/update",
		type : "get",
		data : {
			//activityId : $("#activityInfo_activityId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (activityInfo, response, status) {
			$.messager.progress("close");
			if (activityInfo) { 
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
				activityInfo_content_edit.setContent(activityInfo.content);
				$("#activityInfo_activityTime_edit").val(activityInfo.activityTime);
				$("#activityInfo_activityTime_edit").validatebox({
					required : true,
					missingMessage : "请输入活动时间",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#activityInfoModifyButton").click(function(){ 
		if ($("#activityInfoEditForm").form("validate")) {
			$("#activityInfoEditForm").form({
			    url:"ActivityInfo/" +  $("#activityInfo_activityId_edit").val() + "/update",
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
			$("#activityInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
