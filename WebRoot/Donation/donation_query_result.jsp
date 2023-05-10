<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/donation.css" /> 

<div id="donation_manage"></div>
<div id="donation_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="donation_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="donation_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="donation_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="donation_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="donation_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="donationQueryForm" method="post">
			捐款人：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			捐款时间：<input type="text" id="dunationTime" name="dunationTime" class="easyui-datebox" editable="false" style="width:100px">
			审核状态：<input type="text" class="textbox" id="sheHeState" name="sheHeState" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="donation_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="donationEditDiv">
	<form id="donationEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">捐款id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="donation_donationId_edit" name="donation.donationId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">捐款人:</span>
			<span class="inputControl">
				<input class="textbox"  id="donation_userObj_user_name_edit" name="donation.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">捐款金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="donation_donationMoney_edit" name="donation.donationMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">捐款时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="donation_dunationTime_edit" name="donation.dunationTime" />

			</span>

		</div>
		<div>
			<span class="label">捐款备注:</span>
			<span class="inputControl">
				<textarea id="donation_dunationMemo_edit" name="donation.dunationMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="donation_sheHeState_edit" name="donation.sheHeState" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Donation/js/donation_manage.js"></script> 
