<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/activityInfo.css" />
<div id="activityInfo_editDiv">
	<form id="activityInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">活动id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="activityInfo_activityId_edit" name="activityInfo.activityId" value="<%=request.getParameter("activityId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">活动类型:</span>
			<span class="inputControl">
				<input class="textbox"  id="activityInfo_typeObj_typeId_edit" name="activityInfo.typeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">活动主题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="activityInfo_title_edit" name="activityInfo.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">活动图片:</span>
			<span class="inputControl">
				<img id="activityInfo_activityPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="activityInfo_activityPhoto" name="activityInfo.activityPhoto"/>
				<input id="activityPhotoFile" name="activityPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">活动内容:</span>
			<span class="inputControl">
				<script id="activityInfo_content_edit" name="activityInfo.content" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">活动时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="activityInfo_activityTime_edit" name="activityInfo.activityTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="activityInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/ActivityInfo/js/activityInfo_modify.js"></script> 
