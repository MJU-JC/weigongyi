<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>捐款添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Donation/frontlist">捐款列表</a></li>
			    	<li role="presentation" class="active"><a href="#donationAdd" aria-controls="donationAdd" role="tab" data-toggle="tab">添加捐款</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="donationList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="donationAdd"> 
				      	<form class="form-horizontal" name="donationAddForm" id="donationAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="donation_userObj_user_name" class="col-md-2 text-right">捐款人:</label>
						  	 <div class="col-md-8">
							    <select id="donation_userObj_user_name" name="donation.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="donation_donationMoney" class="col-md-2 text-right">捐款金额:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="donation_donationMoney" name="donation.donationMoney" class="form-control" placeholder="请输入捐款金额">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="donation_dunationTimeDiv" class="col-md-2 text-right">捐款时间:</label>
						  	 <div class="col-md-8">
				                <div id="donation_dunationTimeDiv" class="input-group date donation_dunationTime col-md-12" data-link-field="donation_dunationTime">
				                    <input class="form-control" id="donation_dunationTime" name="donation.dunationTime" size="16" type="text" value="" placeholder="请选择捐款时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="donation_dunationMemo" class="col-md-2 text-right">捐款备注:</label>
						  	 <div class="col-md-8">
							    <textarea id="donation_dunationMemo" name="donation.dunationMemo" rows="8" class="form-control" placeholder="请输入捐款备注"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="donation_sheHeState" class="col-md-2 text-right">审核状态:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="donation_sheHeState" name="donation.sheHeState" class="form-control" placeholder="请输入审核状态">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxDonationAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#donationAddForm .form-group {margin:10px;}  </style>
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
	//提交添加捐款信息
	function ajaxDonationAdd() { 
		//提交之前先验证表单
		$("#donationAddForm").data('bootstrapValidator').validate();
		if(!$("#donationAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Donation/add",
			dataType : "json" , 
			data: new FormData($("#donationAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#donationAddForm").find("input").val("");
					$("#donationAddForm").find("textarea").val("");
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
	//验证捐款添加表单字段
	$('#donationAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"donation.donationMoney": {
				validators: {
					notEmpty: {
						message: "捐款金额不能为空",
					},
					numeric: {
						message: "捐款金额不正确"
					}
				}
			},
			"donation.dunationTime": {
				validators: {
					notEmpty: {
						message: "捐款时间不能为空",
					}
				}
			},
			"donation.sheHeState": {
				validators: {
					notEmpty: {
						message: "审核状态不能为空",
					}
				}
			},
		}
	}); 
	//初始化捐款人下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#donation_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#donation_userObj_user_name").html(html);
    	}
	});
	//捐款时间组件
	$('#donation_dunationTimeDiv').datetimepicker({
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
		$('#donationAddForm').data('bootstrapValidator').updateStatus('donation.dunationTime', 'NOT_VALIDATED',null).validateField('donation.dunationTime');
	});
})
</script>
</body>
</html>
