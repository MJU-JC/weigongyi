<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Donation" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Donation donation = (Donation)request.getAttribute("donation");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改捐款信息</TITLE>
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
  		<li class="active">捐款信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="donationEditForm" id="donationEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="donation_donationId_edit" class="col-md-3 text-right">捐款id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="donation_donationId_edit" name="donation.donationId" class="form-control" placeholder="请输入捐款id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="donation_userObj_user_name_edit" class="col-md-3 text-right">捐款人:</label>
		  	 <div class="col-md-9">
			    <select id="donation_userObj_user_name_edit" name="donation.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="donation_donationMoney_edit" class="col-md-3 text-right">捐款金额:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="donation_donationMoney_edit" name="donation.donationMoney" class="form-control" placeholder="请输入捐款金额">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="donation_dunationTime_edit" class="col-md-3 text-right">捐款时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date donation_dunationTime_edit col-md-12" data-link-field="donation_dunationTime_edit">
                    <input class="form-control" id="donation_dunationTime_edit" name="donation.dunationTime" size="16" type="text" value="" placeholder="请选择捐款时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="donation_dunationMemo_edit" class="col-md-3 text-right">捐款备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="donation_dunationMemo_edit" name="donation.dunationMemo" rows="8" class="form-control" placeholder="请输入捐款备注"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="donation_sheHeState_edit" class="col-md-3 text-right">审核状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="donation_sheHeState_edit" name="donation.sheHeState" class="form-control" placeholder="请输入审核状态">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxDonationModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#donationEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改捐款界面并初始化数据*/
function donationEdit(donationId) {
	$.ajax({
		url :  basePath + "Donation/" + donationId + "/update",
		type : "get",
		dataType: "json",
		success : function (donation, response, status) {
			if (donation) {
				$("#donation_donationId_edit").val(donation.donationId);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#donation_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#donation_userObj_user_name_edit").html(html);
		        		$("#donation_userObj_user_name_edit").val(donation.userObjPri);
					}
				});
				$("#donation_donationMoney_edit").val(donation.donationMoney);
				$("#donation_dunationTime_edit").val(donation.dunationTime);
				$("#donation_dunationMemo_edit").val(donation.dunationMemo);
				$("#donation_sheHeState_edit").val(donation.sheHeState);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交捐款信息表单给服务器端修改*/
function ajaxDonationModify() {
	$.ajax({
		url :  basePath + "Donation/" + $("#donation_donationId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#donationEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#donationQueryForm").submit();
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
    /*捐款时间组件*/
    $('.donation_dunationTime_edit').datetimepicker({
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
    donationEdit("<%=request.getParameter("donationId")%>");
 })
 </script> 
</body>
</html>

