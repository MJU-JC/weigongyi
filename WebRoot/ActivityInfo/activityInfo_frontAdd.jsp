<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ActivityType" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>公益活动添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>ActivityInfo/frontlist">公益活动管理</a></li>
  			<li class="active">添加公益活动</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="activityInfoAddForm" id="activityInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="activityInfo_typeObj_typeId" class="col-md-2 text-right">活动类型:</label>
				  	 <div class="col-md-8">
					    <select id="activityInfo_typeObj_typeId" name="activityInfo.typeObj.typeId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="activityInfo_title" class="col-md-2 text-right">活动主题:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="activityInfo_title" name="activityInfo.title" class="form-control" placeholder="请输入活动主题">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="activityInfo_activityPhoto" class="col-md-2 text-right">活动图片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="activityInfo_activityPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="activityInfo_activityPhoto" name="activityInfo.activityPhoto"/>
					    <input id="activityPhotoFile" name="activityPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="activityInfo_content" class="col-md-2 text-right">活动内容:</label>
				  	 <div class="col-md-8">
							    <textarea name="activityInfo.content" id="activityInfo_content" style="width:100%;height:500px;"></textarea>
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="activityInfo_activityTime" class="col-md-2 text-right">活动时间:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="activityInfo_activityTime" name="activityInfo.activityTime" class="form-control" placeholder="请输入活动时间">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxActivityInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#activityInfoAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var activityInfo_content_editor = UE.getEditor('activityInfo_content'); //活动内容编辑器
var basePath = "<%=basePath%>";
	//提交添加公益活动信息
	function ajaxActivityInfoAdd() { 
		//提交之前先验证表单
		$("#activityInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#activityInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(activityInfo_content_editor.getContent() == "") {
			alert('活动内容不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "ActivityInfo/add",
			dataType : "json" , 
			data: new FormData($("#activityInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#activityInfoAddForm").find("input").val("");
					$("#activityInfoAddForm").find("textarea").val("");
					activityInfo_content_editor.setContent("");
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();
	//验证公益活动添加表单字段
	$('#activityInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"activityInfo.title": {
				validators: {
					notEmpty: {
						message: "活动主题不能为空",
					}
				}
			},
			"activityInfo.activityTime": {
				validators: {
					notEmpty: {
						message: "活动时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化活动类型下拉框值 
	$.ajax({
		url: basePath + "ActivityType/listAll",
		type: "get",
		success: function(activityTypes,response,status) { 
			$("#activityInfo_typeObj_typeId").empty();
			var html="";
    		$(activityTypes).each(function(i,activityType){
    			html += "<option value='" + activityType.typeId + "'>" + activityType.typeName + "</option>";
    		});
    		$("#activityInfo_typeObj_typeId").html(html);
    	}
	});
})
</script>
</body>
</html>
