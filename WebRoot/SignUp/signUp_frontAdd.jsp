<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ActivityInfo" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
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
<title>活动报名添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>SignUp/frontlist">活动报名列表</a></li>
			    	<li role="presentation" class="active"><a href="#signUpAdd" aria-controls="signUpAdd" role="tab" data-toggle="tab">添加活动报名</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="signUpList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="signUpAdd"> 
				      	<form class="form-horizontal" name="signUpAddForm" id="signUpAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="signUp_activityObj_activityId" class="col-md-2 text-right">报名的活动:</label>
						  	 <div class="col-md-8">
							    <select id="signUp_activityObj_activityId" name="signUp.activityObj.activityId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="signUp_userObj_user_name" class="col-md-2 text-right">报名人:</label>
						  	 <div class="col-md-8">
							    <select id="signUp_userObj_user_name" name="signUp.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="signUp_signUpVow" class="col-md-2 text-right">报名宣誓:</label>
						  	 <div class="col-md-8">
							    <textarea id="signUp_signUpVow" name="signUp.signUpVow" rows="8" class="form-control" placeholder="请输入报名宣誓"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="signUp_signUpTimeDiv" class="col-md-2 text-right">报名时间:</label>
						  	 <div class="col-md-8">
				                <div id="signUp_signUpTimeDiv" class="input-group date signUp_signUpTime col-md-12" data-link-field="signUp_signUpTime">
				                    <input class="form-control" id="signUp_signUpTime" name="signUp.signUpTime" size="16" type="text" value="" placeholder="请选择报名时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxSignUpAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#signUpAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
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
<script>
var basePath = "<%=basePath%>";
	//提交添加活动报名信息
	function ajaxSignUpAdd() { 
		//提交之前先验证表单
		$("#signUpAddForm").data('bootstrapValidator').validate();
		if(!$("#signUpAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "SignUp/add",
			dataType : "json" , 
			data: new FormData($("#signUpAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#signUpAddForm").find("input").val("");
					$("#signUpAddForm").find("textarea").val("");
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
	//验证活动报名添加表单字段
	$('#signUpAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"signUp.signUpVow": {
				validators: {
					notEmpty: {
						message: "报名宣誓不能为空",
					}
				}
			},
			"signUp.signUpTime": {
				validators: {
					notEmpty: {
						message: "报名时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化报名的活动下拉框值 
	$.ajax({
		url: basePath + "ActivityInfo/listAll",
		type: "get",
		success: function(activityInfos,response,status) { 
			$("#signUp_activityObj_activityId").empty();
			var html="";
    		$(activityInfos).each(function(i,activityInfo){
    			html += "<option value='" + activityInfo.activityId + "'>" + activityInfo.title + "</option>";
    		});
    		$("#signUp_activityObj_activityId").html(html);
    	}
	});
	//初始化报名人下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#signUp_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#signUp_userObj_user_name").html(html);
    	}
	});
	//报名时间组件
	$('#signUp_signUpTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#signUpAddForm').data('bootstrapValidator').updateStatus('signUp.signUpTime', 'NOT_VALIDATED',null).validateField('signUp.signUpTime');
	});
})
</script>
</body>
</html>
