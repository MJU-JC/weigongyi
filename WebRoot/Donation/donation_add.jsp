<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/donation.css" />
<div id="donationAddDiv">
	<form id="donationAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">捐款人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="donation_userObj_user_name" name="donation.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">捐款金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="donation_donationMoney" name="donation.donationMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">捐款时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="donation_dunationTime" name="donation.dunationTime" />

			</span>

		</div>
		<div>
			<span class="label">捐款备注:</span>
			<span class="inputControl">
				<textarea id="donation_dunationMemo" name="donation.dunationMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="donation_sheHeState" name="donation.sheHeState" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="donationAddButton" class="easyui-linkbutton">添加</a>
			<a id="donationClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Donation/js/donation_add.js"></script> 
