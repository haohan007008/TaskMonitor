<%@page import="java.io.File"%>
<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ page contentType="text/html;charset=utf-8"%>
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
<link href="../css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="../css/H-ui.admin.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<link href="../lib/Hui-iconfont/1.0.6/iconfont.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<!--[if IE 6]>
<script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>FP-MetaData</title>
</head>
<body>
<aside class="fp-aside">
<nav class="breadcrumb1" role="navigation"> <i class="Hui-iconfont">&#xe67f;</i> 日志导航树 
		</nav>
	<div class="btn-group">
		<ul id="treeDemo" class="ztree"></ul>
	</div>	
</aside>
<div class="dislpayArrow"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="fp-article-box">
	<div id="Hui-tabNav" class="Hui-tabNav">
		<div class="Hui-tabNav-wp">
			<ul id="min_title_list" class="acrossTab cl">
			</ul>
		</div>
		<div class="Hui-tabNav-more btn-group"><a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a><a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a></div>
	</div>
	<div id="iframe_box" class="Hui-article">
	</div>
</section>
<script type="text/javascript" src="../lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="../lib/layer/2.1/layer.js"></script> 
<script type="text/javascript" src="../lib/zTree/v3/js/jquery.ztree.all-3.5.min.js"></script> 
<script type="text/javascript" src="../js/H-ui.js"></script> 
<script type="text/javascript" src="../js/H-ui.admin.js"></script> 
<script type="text/javascript">
var setting = {
	view: {
		dblClickExpand: false,
		showLine: false,
		selectedMulti: false
	},
	async: {
				enable: true,
				url:"http://localhost:8080/TaskMonitor/logs.html?",
				autoParam:["id=pid","name=nm","nodeType=nt","notes=pt"]
				//asyncParam: ["id","pid","name","nodeType"]
				//otherParam:{"otherParam":"zTreeAsyncTest"}
			},
	callback: {
		onAsyncSuccess: onAsyncSuccess,
		beforeClick: function(treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("tree");
			if (treeNode.isParent) {
				zTree.expandNode(treeNode);
				return false;
			} else {
				//alert("log.jsp?f="+ treeNode.notes.replace("\\", '\\\\'));
				Hui_admin_tab1({
					"_href":"log.jsp?f="+encodeURI(treeNode.notes.replace("\\", '\\\\')) ,
					"data-title":treeNode.name
				});
				return true;
			}
		}
	}
};

function onAsyncSuccess(event, treeId, treeNode, msg) {  
	var zTree = $.fn.zTree.getZTreeObj("treeDemo"); 
	var nodes = zTree.getNodes();
	zTree.expandNode(nodes[0], true, false, false);
}

var zTree;
$(document).ready(function(){
	var t = $("#treeDemo");
	t = $.fn.zTree.init(t, setting);
	zTree = $.fn.zTree.getZTreeObj("tree");
	var nodes = zTree.getNodes();  
    zTree.expandNode(nodes[0], true); 
});
</script>
</body>
</html>