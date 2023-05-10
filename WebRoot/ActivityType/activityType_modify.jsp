<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/activityType.css" />
<div id="activityType_editDiv">
	<form id="activityTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">活动类型id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="activityType_typeId_edit" name="activityType.typeId" value="<%=request.getParameter("typeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">活动类型名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="activityType_typeName_edit" name="activityType.typeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="activityTypeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/ActivityType/js/activityType_modify.js"></script> 
