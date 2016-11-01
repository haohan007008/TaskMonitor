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
<title>新增图片</title>
</head>
<body>
<div class="pd-20">
	<form action="" method="post" class="form form-horizontal" id="form-article-add">
		<div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>连接名称：</label>
			<div class="formControls col-10">
				<input type="hidden" value="${dsconf.dsId}" placeholder="" id="dsId" name="dsId">
				<input type="text" class="input-text" value="${dsconf.dsName}" placeholder="" id="dsName" name="dsName">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-2">驱动类名称：</label>
			<div class="formControls col-10">
				<input type="text" class="input-text" value="${dsconf.driverClaz}" placeholder="" id="driverClaz" name="driverClaz">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-2">数据库连接地址：</label>
			<div class="formControls col-10">
				<input type="text" class="input-text" value="${dsconf.jdbcUrl}" placeholder="" id="jdbcUrl" name="jdbcUrl">
			</div>
		</div>
		
		<div class="row cl">
			<label class="form-label col-2">用户名：</label>
			<div class="formControls col-4">
				<input type="text" name="userName" id="userName" placeholder="" value="${dsconf.userName}" class="input-text" style="width:90%">
				</div>
			<label class="form-label col-2">密码：</label>
			<div class="formControls col-4">
				<input type="text" name="passwd" id="passwd" placeholder="" value="${dsconf.passwd}" class="input-text" style="width:90%">
				</div>
		</div>
		<div class="row cl">
			<label class="form-label col-2">连接池初始大小：</label>
			<div class="formControls col-4">
				<input type="text" name="poolInitSize" id="poolInitSize" placeholder="" value="${dsconf.poolInitSize}" class="input-text" style="width:90%">
				个</div>
			<label class="form-label col-2">连接池最大连接数：</label>
			<div class="formControls col-4">
				<input type="text" name="poolMaxSize" id="poolMaxSize" placeholder="" value="${dsconf.poolMaxSize}" class="input-text" style="width:90%">
				个</div>
		</div>
		
		
		<div class="row cl">
			<label class="form-label col-2">备注：</label>
			<div class="formControls col-10">
				<textarea name="" cols="" rows="" class="textarea"  placeholder="说点什么...最少输入10个字符" datatype="*10-100" dragonfly="true" nullmsg="备注不能为空！" onKeyUp="textarealength(this,200)"></textarea>
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
			    url:'${pageContext.request.contextPath}/datapush/addds.html',
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

});
</script>
</body>
</html>