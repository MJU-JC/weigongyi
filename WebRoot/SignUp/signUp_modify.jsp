<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/signUp.css" />
<div id="signUp_editDiv">
	<form id="signUpEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">报名id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="signUp_signId_edit" name="signUp.signId" value="<%=request.getParameter("signId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">报名的活动:</span>
			<span class="inputControl">
				<input class="textbox"  id="signUp_activityObj_activityId_edit" name="signUp.activityObj.activityId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">报名人:</span>
			<span class="inputControl">
				<input class="textbox"  id="signUp_userObj_user_name_edit" name="signUp.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">报名宣誓:</span>
			<span class="inputControl">
				<textarea id="signUp_signUpVow_edit" name="signUp.signUpVow" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">报名时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="signUp_signUpTime_edit" name="signUp.signUpTime" />

			</span>

		</div>
		<div class="operation">
			<a id="signUpModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/SignUp/js/signUp_modify.js"></script> 
