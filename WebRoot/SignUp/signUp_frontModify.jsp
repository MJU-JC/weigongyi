<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.SignUp" %>
<%@ page import="com.chengxusheji.po.ActivityInfo" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的activityObj信息
    List<ActivityInfo> activityInfoList = (List<ActivityInfo>)request.getAttribute("activityInfoList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    SignUp signUp = (SignUp)request.getAttribute("signUp");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改活动报名信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">活动报名信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="signUpEditForm" id="signUpEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="signUp_signId_edit" class="col-md-3 text-right">报名id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="signUp_signId_edit" name="signUp.signId" class="form-control" placeholder="请输入报名id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="signUp_activityObj_activityId_edit" class="col-md-3 text-right">报名的活动:</label>
		  	 <div class="col-md-9">
			    <select id="signUp_activityObj_activityId_edit" name="signUp.activityObj.activityId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="signUp_userObj_user_name_edit" class="col-md-3 text-right">报名人:</label>
		  	 <div class="col-md-9">
			    <select id="signUp_userObj_user_name_edit" name="signUp.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="signUp_signUpVow_edit" class="col-md-3 text-right">报名宣誓:</label>
		  	 <div class="col-md-9">
			    <textarea id="signUp_signUpVow_edit" name="signUp.signUpVow" rows="8" class="form-control" placeholder="请输入报名宣誓"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="signUp_signUpTime_edit" class="col-md-3 text-right">报名时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date signUp_signUpTime_edit col-md-12" data-link-field="signUp_signUpTime_edit">
                    <input class="form-control" id="signUp_signUpTime_edit" name="signUp.signUpTime" size="16" type="text" value="" placeholder="请选择报名时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxSignUpModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#signUpEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改活动报名界面并初始化数据*/
function signUpEdit(signId) {
	$.ajax({
		url :  basePath + "SignUp/" + signId + "/update",
		type : "get",
		dataType: "json",
		success : function (signUp, response, status) {
			if (signUp) {
				$("#signUp_signId_edit").val(signUp.signId);
				$.ajax({
					url: basePath + "ActivityInfo/listAll",
					type: "get",
					success: function(activityInfos,response,status) { 
						$("#signUp_activityObj_activityId_edit").empty();
						var html="";
		        		$(activityInfos).each(function(i,activityInfo){
		        			html += "<option value='" + activityInfo.activityId + "'>" + activityInfo.title + "</option>";
		        		});
		        		$("#signUp_activityObj_activityId_edit").html(html);
		        		$("#signUp_activityObj_activityId_edit").val(signUp.activityObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#signUp_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#signUp_userObj_user_name_edit").html(html);
		        		$("#signUp_userObj_user_name_edit").val(signUp.userObjPri);
					}
				});
				$("#signUp_signUpVow_edit").val(signUp.signUpVow);
				$("#signUp_signUpTime_edit").val(signUp.signUpTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交活动报名信息表单给服务器端修改*/
function ajaxSignUpModify() {
	$.ajax({
		url :  basePath + "SignUp/" + $("#signUp_signId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#signUpEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#signUpQueryForm").submit();
            }else{
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
    /*报名时间组件*/
    $('.signUp_signUpTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    signUpEdit("<%=request.getParameter("signId")%>");
 })
 </script> 
</body>
</html>

