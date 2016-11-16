<%@page import="java.io.File"%>
<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ page contentType="text/html;charset=utf-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <!DOCTYPE html>
<html>
<head>
<title>Kanban Board</title>
<meta name="description" content="" />
<meta charset="UTF-8">
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
<script src="../js/go.js"></script>

<script id="code">
	function init(){
		
		var $ = go.GraphObject.make;
		var yellowgrad = $(go.Brush, "Linear", { 0: "rgb(254, 201, 0)", 1: "rgb(254, 162, 0)" });
		var greengrad = $(go.Brush, "Linear", { 0: "#98FB98", 1: "#9ACD32" });
		var bluegrad = $(go.Brush, "Linear", { 0: "#B0E0E6", 1: "#87CEEB" });
		var redgrad = $(go.Brush, "Linear", { 0: "#C45245", 1: "#7D180C" });
		var whitegrad = $(go.Brush, "Linear", { 0: "#F0F8FF", 1: "#E6E6FA" });

		var bigfont = "bold 12px Helvetica, Arial, sans-serif";
		var smallfont = "bold 10px Helvetica, Arial, sans-serif";
		
		function textStyle() {
		      return {
		        margin: 5,
		        wrap: go.TextBlock.WrapFit,
		        textAlign: "center",
		        editable: true,
		        font: bigfont,
		        cursor: "move"
		      }
		    }
		function linkStyle() {
		      return {
		        margin: 5,
		        wrap: go.TextBlock.WrapFit,
		        textAlign: "center",
		        //editable: true,
		        stroke:'red',
		        font: smallfont,
		        segmentOffset: new go.Point(0, -10)
		      }
		    }
		myDiagram =
			  $(go.Diagram, "myDiagramDiv",
			    {
			      initialContentAlignment: go.Spot.Center, // center Diagram contents
			      "undoManager.isEnabled": true, // enable Ctrl-Z to undo and Ctrl-Y to redo
			      allowDrop: true
			    });
		/*
		myDiagram.nodeTemplate =
		    $(go.Node, "Auto",
		      $(go.Shape, "RoundedRectangle",
		        { fill: "white" },
		        new go.Binding("fill", "color"),
		        { portId: "", fromLinkable: true, toLinkable: true, cursor: "pointer" }),
		      $(go.TextBlock, { margin: 5 }, new go.Binding("text", "type"))
		    );*/
		myDiagram.nodeTemplate =
			$(go.Node, "Vertical",{
						doubleClick:function(e, obj){showCfg(obj);}
	        			},
	        		  new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify),
				      $(go.Picture, 
				    	{ width: 40, height: 40, margin: 2, background: "white",
				    	  imageStretch: go.GraphObject.UniformToFill,source:"../images/log.png",
				    	  portId: "",fromLinkable: true,toLinkable: true, cursor: "pointer", fromEndSegmentLength: 40},
					        new go.Binding("source", "images")),
					        $(go.TextBlock, "Start", textStyle(),
							          new go.Binding("text", "name").makeTwoWay())
						);
		
		myDiagram.nodeTemplateMap.add("Start",
			      $(go.Node, "Vertical",{
			    	  doubleClick:function(e, obj){showCfg(obj);}
			        },
			        new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify),
			        $(go.Picture,
			          { width: 40, height: 40, margin: 2, background: "white",source:"../images/start.png",
				    	  imageStretch: go.GraphObject.UniformToFill,portId: "", 
				    	  fromLinkable: true, cursor: "pointer", fromEndSegmentLength: 40
				    	  }),
			        $(go.TextBlock, "Start", textStyle(),
			          new go.Binding("text", "name").makeTwoWay())
			        ));
		
		
		
		myDiagram.nodeTemplateMap.add("Tips",
			      $(go.Node, "Auto",
			        new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify),
			        $(go.Shape, "Rectangle",
			          { portId: "", fill: whitegrad, fromLinkable: false }),
			        $(go.TextBlock, "A comment",
			          { margin: 9,
			            maxSize: new go.Size(200, NaN),
			            wrap: go.TextBlock.WrapFit,
			            editable: true,
			            font: smallfont },
			          new go.Binding("text", "text").makeTwoWay())
			        // no ports, because no links are allowed to connect with a comment
			        ));
		
		myDiagram.linkTemplate =
		    $(go.Link,{
		    	  doubleClick:function(e, obj){show_link_cfg(obj);}
	        	},
		      $(go.Shape),                           // this is the link shape (the line)
		      $(go.Shape, { toArrow: "Standard" }),  // this is an arrowhead
		      $(go.TextBlock,"", linkStyle(),                       // this is a Link label
		        new go.Binding("text", "text"))
		    );

		
		var myPalette =
		    $(go.Palette, "myPaletteDiv");
		
		myPalette.nodeTemplate =
		    $(go.Node, "Vertical",
		      $(go.Picture, 
		    	{ width: 40, height: 40, margin: 2, background: "white",
		    	  imageStretch: go.GraphObject.UniformToFill,source:"" },
			        new go.Binding("source", "images")),
		      $(go.TextBlock,{ margin: 2,width: 50,wrap: go.TextBlock.WrapFit },
		        new go.Binding("text", "category"))
		    );
		
		myPalette.model.nodeDataArray = [
		    { name:"Start",category:"Start",images:"../images/start.png" },
		    { name: "Proc",category:"Proc",images:"../images/proc.png",text:"procdure"},
		    {  name: "Shell",category:"Shell" ,images:"../images/command.png"},
		    {  name: "Dubbo",category:"Dubbo" ,images:"../images/dubbo.png"},
		    { key: "LB", name: "Kettle",category:"Kettle",images:"../images/kettle.png" },
		    { key: "CC", name: "Tips",category:"Tips",images:"../images/tips.png" }
		];
		myDiagram.model.makeUniqueKeyFunction = function(model, data) {
		      if (data.key === undefined || model.findNodeDataForKey(data.key) !== null) {
			        var k = 1000000 + model.nodeDataArray.length;
			        while (model.findNodeDataForKey(k) !== null) k++;
			        return k;
			      }
			};
		
		myDiagram.addModelChangedListener(function(evt) {
		    if (!evt.isTransactionFinished) return;
		    var txn = evt.object;  // a Transaction
		    if (txn === null) return;
		    txn.changes.each(function(e) {
		      if (e.change === go.ChangedEvent.Insert && e.modelChange === "nodeDataArray") {
		        	console.log(" e.modelChange: " + e.modelChange);
		        	if(e.newValue){
		        		//alert(e.newValue.category);
		        		return ;
		        	}
		      } else if (e.change === go.ChangedEvent.Remove && e.modelChange === "nodeDataArray") {
		        	console.log(evt.propertyName + " removed link: " + e.oldValue);
		      }
		    });
		  });
	}
	function save(){
		alert(myDiagram.model.toJson());
	}
	function load(){
		myDiagram.model = go.Model.fromJson(jsonStr);
	}
	

</script>
</head>
<body onload="init()"> 
<button id="SaveButton" onclick="save()">getGraph</button>
<button id="SaveButton" onclick="load()">loadTemplate</button>
 <div style="width:100%; white-space:nowrap;">
    <span style="display: inline-block; vertical-align: top; margin: 2px; width:60px">
      <div id="myPaletteDiv" style="border: solid 1px gray; height: 620px"></div>
    </span>
    <span style="display: inline-block; vertical-align: top; margin: 2px; width:90%">
      <div id="myDiagramDiv" style="border: solid 1px gray; height: 620px"></div>
    </span>
  </div>
  
  <div class="pd-20" id="node_cfg" style="display:none;">
  <form action="" method="post" class="form form-horizontal" id="form-article-add">
		<div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>名称：</label>
			<div class="formControls col-10">
				<input type="text" class="input-text" value="" placeholder="" id="ndName" name="ndName">
			</div>
		</div>
		<div class="row cl" id="dv_catalogName">
			<label class="form-label col-2">类型：</label>
			<div class="formControls col-4">
				<input type="text" name="catalogName" id="catalogName" placeholder="CC?CRM?EC?DS?" value="" class="input-text" style="width:90%" readonly>
				</div>
			<label class="form-label col-2">数据源：</label>
			<div class="formControls col-4">
				<span class="select-box">
				  <select class="select" size="1" name="dbsrc">
				    <option value="1" selected>主动推送</option>
				    <option value="3">被动请求</option>
				    <option value="9">公募组合</option>
				    <option value="-1">未知</option>
				  </select>
				</span></div>
		</div>
		<div class="row cl" id="dv_zkAddress" style="display:none;">
			<label class="form-label col-2"><span class="c-red">*</span>ZK地址：</label>
			<div class="formControls col-10">
				<input type="text" class="input-text" value="" placeholder="" id="zkAddress" name="zkAddress">
			</div>
		</div>
		<div class="row cl" id="dv_appName"  style="display:none;">
			<label class="form-label col-2">应用名称：</label>
			<div class="formControls col-4">
				<input type="text" name="appName" id="appName" placeholder="" value="" class="input-text"  >
				</div>
			<label class="form-label col-2">接口名：</label>
			<div class="formControls col-4">
				<input type="text" name="interfaceName" id="interfaceName" placeholder="" value="" class="input-text" >
				</span></div>
		</div>
		<div class="row cl" id="dv_methodName">
			<label class="form-label col-2">方法名：</label>
			<div class="formControls col-4">
				<input type="text" name="methodName" id="methodName" placeholder="" value="" class="input-text" >
				</div>
			<label class="form-label col-2">参数：</label>
			<div class="formControls col-4">
				<input type="text" name="argsName" id="argsName" placeholder="" value="" class="input-text"  >
				</span></div>
		</div>
		<div class="row cl" id="dv_callType">
			<label class="form-label col-2">调用类型：</label>
			<div class="formControls col-4">
				<span class="select-box">
				  <select class="select" size="1" name="callType">
				    <option value="SYNC" selected>SYNC</option>
				    <option value="ASYNC">ASYNC</option>
				  </select>
				</span>
				</div>
			<label class="form-label col-2">超时时间：</label>
			<div class="formControls col-4">
				<input type="text" name="timeout" id="timeout" placeholder="" value="" class="input-text">
				</span></div>
		</div>
		<div class="row cl" id="dv_spName">
			<label class="form-label col-2">存储过程名称：</label>
			<div class="formControls col-10">
				<input type="text" name="spName" id="spName" placeholder="" value="" class="input-text">
			</div>
		</div>
		<div class="row cl" id="dv_cmdLine">
			<label class="form-label col-2">执行命令：</label>
			<div class="formControls col-10">
				<input type="text" name="cmdLine" id="cmdLine" placeholder="" value="" class="input-text">
			</div>
		</div>
		<div class="row cl" id="dv_path">
			<label class="form-label col-2">存储目录：</label>
			<div class="formControls col-10">
				<input type="text" name="path" id="path" placeholder="" value="" class="input-text">
			</div>
		</div>
		<div class="row cl" id="dv_jobName">
			<label class="form-label col-2">job名称：</label>
			<div class="formControls col-10">
				<input type="text" name="jobName" id="jobName" placeholder="" value="" class="input-text">
			</div>
		</div>
		<div class="row cl">
			<div class="col-10 col-offset-2">
				<button id="save_submit" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
			</div>
		</div>
</div>
</form>
</div>


<div class="pd-20" id="link_cfg" style="display:none;">
  <form action="" method="post" class="form form-horizontal" id="form-article">
		<div class="row cl" id="dv_fromto">
			<label class="form-label col-2">Form：</label>
			<div class="formControls col-4">
				<input type="text" name="from" id="from" placeholder="" value="" class="input-text"  >
				</div>
			<label class="form-label col-2">To：</label>
			<div class="formControls col-4">
				<input type="text" name="to" id="to" placeholder="" value="" class="input-text" >
				</span></div>
		</div>
		<div class="row cl" id="dv_cmdLine">
			<label class="form-label col-2">条件：</label>
			<div class="formControls col-10">
				<input type="text" name="condition" id="condition" placeholder="" value="" class="input-text">
			</div>
		</div>
		<div class="row cl">
			<div class="col-10 col-offset-2">
				<button id="save_link" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
			</div>
		</div>
</div>
</form>
</div>
  
</body>
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
<script>
	var layerid,curNode,curLink;
	var jsonStr = '{ "class": "go.GraphLinksModel",  "nodeDataArray": [ {"key":"Start", "name":"Start", "category":"Start", "images":"../images/start.png", "loc":"-462 -242"},{"key":"A", "name":"Proc1", "category":"Proc", "images":"../images/proc.png", "text":"sp_test", "loc":"-355 -69"},{"key":"T", "name":"Shell1", "category":"Shell", "images":"../images/command.png", "text":"cat my.log", "loc":"55.000000000000014 -111"} ],  "linkDataArray": [ {"from":"Start", "to":"A"},{"from":"A", "to":"T"} ]}';
	function form_view_control(obj){
		var catalog = obj.data.category;
		$('#ndName').val(obj.data.name);
		$('#catalogName').val(obj.data.category);
		if(catalog == 'Proc'){
			$('#dv_catalogName').css('display','block'); 
			$('#dv_methodName').css('display','none'); 
			$('#dv_zkAddress').css('display','none');
			$('#dv_appName').css('display','none'); 
			$('#dv_callType').css('display','none'); 
			$('#dv_spName').css('display','block'); 
			$('#dv_cmdLine').css('display','none'); 
			$('#dv_path').css('display','none'); 
			$('#dv_jobName').css('display','none'); 
			if(obj.data.text)
				$('#spName').val(obj.data.text);
		}else if(catalog == 'Shell'){
			$('#dv_catalogName').css('display','block'); 
			$('#dv_zkAddress').css('display','none'); 
			$('#dv_methodName').css('display','none');
			$('#dv_appName').css('display','none'); 
			$('#dv_callType').css('display','none'); 
			$('#dv_spName').css('display','none'); 
			$('#dv_cmdLine').css('display','block'); 
			$('#dv_path').css('display','none'); 
			$('#dv_jobName').css('display','none'); 
			if(obj.data.text)
				$('#cmdLine').val(obj.data.text);
		}else if(catalog == 'Dubbo'){
			$('#dv_catalogName').css('display','block'); 
			$('#dv_zkAddress').css('display','block'); 
			$('#dv_methodName').css('display','block');
			$('#dv_appName').css('display','block'); 
			$('#dv_callType').css('display','block'); 
			$('#dv_spName').css('display','none'); 
			$('#dv_cmdLine').css('display','none'); 
			$('#dv_path').css('display','none'); 
			$('#dv_jobName').css('display','none'); 
			if(obj.data.cfg){
				if(obj.data.cfg.methodName)
					$('#methodName').val(obj.data.cfg.methodName);
				if(obj.data.cfg.argsName)
					$('#argsName').val(obj.data.cfg.argsName);
				if(obj.data.cfg.appName)
					$('#appName').val(obj.data.cfg.appName);
				if(obj.data.cfg.interfaceName)
					$('#interfaceName').val(obj.data.cfg.interfaceName);
				if(obj.data.cfg.methodName)
					$('#methodName').val(obj.data.cfg.methodName);
				if(obj.data.cfg.callType)
					$('#callType').val(obj.data.cfg.callType);
				if(obj.data.cfg.timeout)
					$('#timeout').val(obj.data.cfg.timeout);
			}
		}else if(catalog == 'Kettle'){
			$('#dv_catalogName').css('display','block'); 
			$('#dv_methodName').css('display','none');
			$('#dv_zkAddress').css('display','none'); 
			$('#dv_appName').css('display','none'); 
			$('#dv_callType').css('display','none'); 
			$('#dv_spName').css('display','none'); 
			$('#dv_cmdLine').css('display','none'); 
			$('#dv_path').css('display','block'); 
			$('#dv_jobName').css('display','block'); 
			if(obj.data.cfg){
				if(obj.data.cfg.path)
					$('#path').val(obj.data.cfg.path);
				if(obj.data.cfg.jobName)
					$('#jobName').val(obj.data.cfg.jobName);
			}
		}else return false;
		return true;
	}
	
	function override_data(obj){
		var catalog = obj.data.category;
		//obj.data.name = $('#ndName').val();
		if(catalog == 'Proc'){
			obj.data.text = $('#spName').val();
		}else if(catalog == 'Shell'){
			obj.data.text = $('#cmdLine').val();
		}else if(catalog == 'Dubbo'){
			obj.data.cfg = {
					methodName : $('#methodName').val(),
					argsName   : $('#argsName').val(),
					appName    : $('#appName').val(),
					interfaceName : $('#interfaceName').val(),
					callType   : $('#callType').val(),
					timeout    : $('#timeout').val(),
					zkAddress  : $('#zkAddress').val()
			}
		}else if(catalog == 'Kettle'){
			obj.data.cfg = {
					path      : $('#path').val(),
					jobName   : $('#jobName').val()
			}
		}
	}
	
	function show_link_cfg(obj){
		$('#from').val(obj.data.from);
		$('#to').val(obj.data.to);
		$('#condition').val(obj.data.text);
		curLink = obj;
		$('#save_link').on('click', function() {
			var model = myDiagram.model;
			model.startTransaction("update_link");
			curLink.data.from = $('#from').val();
			curLink.data.to = $('#to').val();
			//curLink.data.condition = $('#condition').val();
			model.setDataProperty(curLink.data, "text", $('#condition').val());
			model.commitTransaction("update_link");
			layer.close(layerid);
			curLink = null;
		});
		layerid = layer.open({
			  type: 1,
			  skin: 'layui-layer-rim', //加上边框
			  fixed: false, //不固定
			  title:"编辑连接",
			  maxmin: true,
			  area: ['700px', '530px'], //宽高
			  content: $('#link_cfg')
			});
	}
	
	function showCfg(obj){
		if(obj && form_view_control(obj)){
			curNode = obj;
			$('#save_submit').on('click', function() {
				var model = myDiagram.model;
				model.startTransaction("update_node");
				//alert(layerid.node);
				override_data(curNode);
				model.setDataProperty(curNode.data, "name", $('#ndName').val());
				model.commitTransaction("update_node");
				layer.close(layerid);
				curNode = null;
			});
			
			layerid = layer.open({
				  type: 1,
				  skin: 'layui-layer-rim', //加上边框
				  fixed: false, //不固定
				  title:"编辑任务："+obj.data.name,
				  maxmin: true,
				  area: ['700px', '530px'], //宽高
				  content: $('#node_cfg')
				});
		}
	}
	
	function callback(obj){
		alert(obj);
	}
</script>
</html>