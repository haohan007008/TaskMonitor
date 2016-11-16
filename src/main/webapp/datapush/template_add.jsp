<%@page import="java.io.File"%>
<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ page contentType="text/html;charset=utf-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!--[if lt IE 9]>
<script type="text/javascript" src="../lib/html5.js"></script>
<script type="text/javascript" src="../lib/respond.min.js"></script>
<script type="text/javascript" src="../lib/PIE_IE678.js"></script>
<![endif]-->
<link href="../css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="../css/H-ui.admin.css" rel="stylesheet" type="text/css" />
<link href="../lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
<link href="../lib/Hui-iconfont/1.0.6/iconfont.css" rel="stylesheet" type="text/css" />
<link href="../lib/webuploader/0.1.5/webuploader.css" rel="stylesheet" type="text/css" />
<!--[if IE 6]>
<script type="text/javascript" src="../lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>新增模板</title>
</head>
<body>
<div class="pd-20">
	<form action="" method="post" class="form form-horizontal" id="form-article-add">
		<div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>模板名称：</label>
			<div class="formControls col-9">
				<input type="hidden" value="${template.tempId}" placeholder="" id="tempId" name="tempId">
				<input type="text" class="input-text" value="${template.templateName}" placeholder="" id="templateName" name="templateName">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-2">系统：</label>
			<div class="formControls col-4">
				<input type="text" name="sysName" id="sysName" placeholder="CC?CRM?EC?DS?" value="${template.sysName}" class="input-text" style="width:90%">
				</div>
			<label class="form-label col-2">数据源：</label>
			<div class="formControls col-3">
				<span class="select-box">
				  <select class="select" size="1" name="status">
				    <option value="1" selected>主动推送</option>
				    <option value="3">被动请求</option>
				    <option value="9">公募组合</option>
				    <option value="-1">未知</option>
				  </select>
				</span></div>
		</div>
		<div class="row cl">
			<label class="form-label col-2">目标队列名称：</label>
			<div class="formControls col-4">
				<input type="text" name="queueName" id="queueName" placeholder="Q_EC_01" value="${template.queueName}" class="input-text" style="width:90%">
				</div>
			<label class="form-label col-2">类型：</label>
			<div class="formControls col-3">
				<span class="select-box">
				  <select class="select" size="1" name="srcConn">
				  	<c:forEach items="${dslist}" var="p">
				     	<option value="${p.dsName}" <c:if test="${template.srcConn == p.dsName}">selected</c:if>>${p.dsName}</option>
				  	</c:forEach>
				  </select>
				</span>
				</div>
		</div>
		<div class="row cl">
			<label class="form-label col-2">增量偏移ID：</label>
			<div class="formControls col-4">
				<input type="text" name="maxzlID" id="maxzlID" placeholder="" value="${template.maxzlID}" class="input-text" style="width:100%">
				
				</div>
			<div class="formControls col-4">
				<button id="cfg_btn" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 脚本配置</button>
				</div>
		</div>
		<div class="row cl">
			<label class="form-label col-2">脚本：</label>
			<div class="formControls col-9">
				<textarea name="templateSql" cols="" rows="20" class="textarea" style="height:250px"  placeholder="说点什么...最少输入10个字符" datatype="*10-100" dragonfly="true" nullmsg="备注不能为空！" onKeyUp="textarealength(this,2048)">${template.templateSql}</textarea>
				<p class="textarea-numberbar"><em class="textarea-length">0</em>/2048</p>
			</div>
		</div>
		
		<div class="row cl">
			<label class="form-label col-2">备注：</label>
			<div class="formControls col-9">
				<textarea name="description" cols="" rows="" class="textarea"  placeholder="说点什么...最少输入10个字符" datatype="*10-100" dragonfly="true" nullmsg="备注不能为空！" onKeyUp="textarealength(this,200)"></textarea>
				<p class="textarea-numberbar"><em class="textarea-length">0</em>/200</p>
			</div>
		</div>
		
		<div class="row cl">
			<div class="col-10 col-offset-2">
				<button id="save_submit" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存并提交审核</button>
				<button onClick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
			</div>
		</div>
	</form>
</div>
</div>
<script type="text/javascript" src="../lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="../lib/layer/2.1/layer.js"></script> 
<script type="text/javascript" src="../lib/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript" src="../lib/icheck/jquery.icheck.min.js"></script> 
<script type="text/javascript" src="../lib/Validform/5.3.2/Validform.min.js"></script> 
<script type="text/javascript" src="../lib/webuploader/0.1.5/webuploader.min.js"></script> 
<script type="text/javascript" src="../lib/ueditor/1.4.3/ueditor.config.js"></script>
<script type="text/javascript" src="../lib/ueditor/1.4.3/ueditor.all.min.js"> </script>
<script type="text/javascript" src="../lib/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="../js/H-ui.js"></script> 
<script type="text/javascript" src="../js/H-ui.admin.js"></script> 
<script type="text/javascript">

$(function(){
	$('#save_submit').on('click', function() {
			//a = $('#form-article-add').serialize());
			//$('#save_submit').attr('disabled',"true");
			$.ajax({
			    type:'post',
			    url:'${pageContext.request.contextPath}/datapush/addtemplate.html',
			    dataType: 'json',
			    data: $('#form-article-add').serialize(),
			    success:function(result){
			    	if(result.success){
				    	layer.msg('添加数据库连接成功！',{icon: 1,time:3000});
				    	parent.location.reload();
				    	layer_close();
				    	
			    	}
			    }
			});
	});
	
	$('#cfg_btn').on('click', function() {
		var index = layer.open({
			type: 2,
			title: '脚本配置',
			content: 'http://www.baidu.com'
		});
		layer.full(index);
	});
	
});
</script>
</body>
</html>