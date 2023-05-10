<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ActivityInfo" %>
<%@ page import="com.chengxusheji.po.ActivityType" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的typeObj信息
    List<ActivityType> activityTypeList = (List<ActivityType>)request.getAttribute("activityTypeList");
    ActivityInfo activityInfo = (ActivityInfo)request.getAttribute("activityInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改公益活动信息</TITLE>
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
  		<li class="active">公益活动信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="activityInfoEditForm" id="activityInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="activityInfo_activityId_edit" class="col-md-3 text-right">活动id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="activityInfo_activityId_edit" name="activityInfo.activityId" class="form-control" placeholder="请输入活动id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="activityInfo_typeObj_typeId_edit" class="col-md-3 text-right">活动类型:</label>
		  	 <div class="col-md-9">
			    <select id="activityInfo_typeObj_typeId_edit" name="activityInfo.typeObj.typeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="activityInfo_title_edit" class="col-md-3 text-right">活动主题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="activityInfo_title_edit" name="activityInfo.title" class="form-control" placeholder="请输入活动主题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="activityInfo_activityPhoto_edit" class="col-md-3 text-right">活动图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="activityInfo_activityPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="activityInfo_activityPhoto" name="activityInfo.activityPhoto"/>
			    <input id="activityPhotoFile" name="activityPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="activityInfo_content_edit" class="col-md-3 text-right">活动内容:</label>
		  	 <div class="col-md-9">
			    <script name="activityInfo.content" id="activityInfo_content_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="activityInfo_activityTime_edit" class="col-md-3 text-right">活动时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="activityInfo_activityTime_edit" name="activityInfo.activityTime" class="form-control" placeholder="请输入活动时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxActivityInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#activityInfoEditForm .form-group {margin-bottom:5px;}  </style>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var activityInfo_content_editor = UE.getEditor('activityInfo_content_edit'); //活动内容编辑框
var basePath = "<%=basePath%>";
/*弹出修改公益活动界面并初始化数据*/
function activityInfoEdit(activityId) {
  activityInfo_content_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(activityId);
  });
}
 function ajaxModifyQuery(activityId) {
	$.ajax({
		url :  basePath + "ActivityInfo/" + activityId + "/update",
		type : "get",
		dataType: "json",
		success : function (activityInfo, response, status) {
			if (activityInfo) {
				$("#activityInfo_activityId_edit").val(activityInfo.activityId);
				$.ajax({
					url: basePath + "ActivityType/listAll",
					type: "get",
					success: function(activityTypes,response,status) { 
						$("#activityInfo_typeObj_typeId_edit").empty();
						var html="";
		        		$(activityTypes).each(function(i,activityType){
		        			html += "<option value='" + activityType.typeId + "'>" + activityType.typeName + "</option>";
		        		});
		        		$("#activityInfo_typeObj_typeId_edit").html(html);
		        		$("#activityInfo_typeObj_typeId_edit").val(activityInfo.typeObjPri);
					}
				});
				$("#activityInfo_title_edit").val(activityInfo.title);
				$("#activityInfo_activityPhoto").val(activityInfo.activityPhoto);
				$("#activityInfo_activityPhotoImg").attr("src", basePath +　activityInfo.activityPhoto);
				activityInfo_content_editor.setContent(activityInfo.content, false);
				$("#activityInfo_activityTime_edit").val(activityInfo.activityTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交公益活动信息表单给服务器端修改*/
function ajaxActivityInfoModify() {
	$.ajax({
		url :  basePath + "ActivityInfo/" + $("#activityInfo_activityId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#activityInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#activityInfoQueryForm").submit();
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
    activityInfoEdit("<%=request.getParameter("activityId")%>");
 })
 </script> 
</body>
</html>

