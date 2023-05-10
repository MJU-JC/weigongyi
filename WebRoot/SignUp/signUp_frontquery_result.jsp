<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.SignUp" %>
<%@ page import="com.chengxusheji.po.ActivityInfo" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<SignUp> signUpList = (List<SignUp>)request.getAttribute("signUpList");
    //获取所有的activityObj信息
    List<ActivityInfo> activityInfoList = (List<ActivityInfo>)request.getAttribute("activityInfoList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    ActivityInfo activityObj = (ActivityInfo)request.getAttribute("activityObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String signUpTime = (String)request.getAttribute("signUpTime"); //报名时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>活动报名查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#signUpListPanel" aria-controls="signUpListPanel" role="tab" data-toggle="tab">活动报名列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>SignUp/signUp_frontAdd.jsp" style="display:none;">添加活动报名</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="signUpListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>报名id</td><td>报名的活动</td><td>报名人</td><td>报名宣誓</td><td>报名时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<signUpList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		SignUp signUp = signUpList.get(i); //获取到活动报名对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=signUp.getSignId() %></td>
 											<td><%=signUp.getActivityObj().getTitle() %></td>
 											<td><%=signUp.getUserObj().getName() %></td>
 											<td><%=signUp.getSignUpVow() %></td>
 											<td><%=signUp.getSignUpTime() %></td>
 											<td>
 												<a href="<%=basePath  %>SignUp/<%=signUp.getSignId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="signUpEdit('<%=signUp.getSignId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="signUpDelete('<%=signUp.getSignId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>活动报名查询</h1>
		</div>
		<form name="signUpQueryForm" id="signUpQueryForm" action="<%=basePath %>SignUp/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="activityObj_activityId">报名的活动：</label>
                <select id="activityObj_activityId" name="activityObj.activityId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(ActivityInfo activityInfoTemp:activityInfoList) {
	 					String selected = "";
 					if(activityObj!=null && activityObj.getActivityId()!=null && activityObj.getActivityId().intValue()==activityInfoTemp.getActivityId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=activityInfoTemp.getActivityId() %>" <%=selected %>><%=activityInfoTemp.getTitle() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="userObj_user_name">报名人：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="signUpTime">报名时间:</label>
				<input type="text" id="signUpTime" name="signUpTime" class="form-control"  placeholder="请选择报名时间" value="<%=signUpTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="signUpEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;活动报名信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#signUpEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxSignUpModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.signUpQueryForm.currentPage.value = currentPage;
    document.signUpQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.signUpQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.signUpQueryForm.currentPage.value = pageValue;
    documentsignUpQueryForm.submit();
}

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
				$('#signUpEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除活动报名信息*/
function signUpDelete(signId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "SignUp/deletes",
			data : {
				signIds : signId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#signUpQueryForm").submit();
					//location.href= basePath + "SignUp/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

