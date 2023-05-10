<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/activityInfo.css" />
<div id="activityInfoAddDiv">
	<form id="activityInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">活动类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="activityInfo_typeObj_typeId" name="activityInfo.typeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">活动主题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="activityInfo_title" name="activityInfo.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">活动图片:</span>
			<span class="inputControl">
				<input id="activityPhotoFile" name="activityPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">活动内容:</span>
			<span class="inputControl">
				<script name="activityInfo.content" id="activityInfo_content" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">活动时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="activityInfo_activityTime" name="activityInfo.activityTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="activityInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="activityInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/ActivityInfo/js/activityInfo_add.js"></script> 
