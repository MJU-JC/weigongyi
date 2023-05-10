<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/donation.css" />
<div id="donation_editDiv">
	<form id="donationEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">捐款id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="donation_donationId_edit" name="donation.donationId" value="<%=request.getParameter("donationId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="donationModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Donation/js/donation_modify.js"></script> 
