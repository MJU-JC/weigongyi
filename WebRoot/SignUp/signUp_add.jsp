<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/signUp.css" />
<div id="signUpAddDiv">
	<form id="signUpAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">报名的活动:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="signUp_activityObj_activityId" name="signUp.activityObj.activityId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">报名人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="signUp_userObj_user_name" name="signUp.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">报名宣誓:</span>
			<span class="inputControl">
				<textarea id="signUp_signUpVow" name="signUp.signUpVow" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">报名时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="signUp_signUpTime" name="signUp.signUpTime" />

			</span>

		</div>
		<div class="operation">
			<a id="signUpAddButton" class="easyui-linkbutton">添加</a>
			<a id="signUpClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/SignUp/js/signUp_add.js"></script> 
