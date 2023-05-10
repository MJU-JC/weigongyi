<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/activityInfo.css" /> 

<div id="activityInfo_manage"></div>
<div id="activityInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="activityInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="activityInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="activityInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="activityInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="activityInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="activityInfoQueryForm" method="post">
			活动类型：<input class="textbox" type="text" id="typeObj_typeId_query" name="typeObj.typeId" style="width: auto"/>
			活动主题：<input type="text" class="textbox" id="title" name="title" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="activityInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="activityInfoEditDiv">
	<form id="activityInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">活动id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="activityInfo_activityId_edit" name="activityInfo.activityId" style="width:200px" />
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
				<script name="activityInfo.content" id="activityInfo_content_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">活动时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="activityInfo_activityTime_edit" name="activityInfo.activityTime" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var activityInfo_content_editor = UE.getEditor('activityInfo_content_edit'); //活动内容编辑器
</script>
<script type="text/javascript" src="ActivityInfo/js/activityInfo_manage.js"></script> 
