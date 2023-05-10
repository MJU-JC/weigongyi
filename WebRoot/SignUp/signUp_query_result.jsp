<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/signUp.css" /> 

<div id="signUp_manage"></div>
<div id="signUp_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="signUp_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="signUp_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="signUp_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="signUp_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="signUp_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="signUpQueryForm" method="post">
			报名的活动：<input class="textbox" type="text" id="activityObj_activityId_query" name="activityObj.activityId" style="width: auto"/>
			报名人：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			报名时间：<input type="text" id="signUpTime" name="signUpTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="signUp_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="signUpEditDiv">
	<form id="signUpEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">报名id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="signUp_signId_edit" name="signUp.signId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="SignUp/js/signUp_manage.js"></script> 
