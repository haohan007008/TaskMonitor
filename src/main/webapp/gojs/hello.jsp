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
<script src="../js/go.js"></script>

<link href="../css/goSamples.css" rel="stylesheet" type="text/css" />  <!-- you don't need to use this -->

<script id="code">
	function init(){
		var $ = go.GraphObject.make;
		var myDiagram =
			  $(go.Diagram, "myDiagramDiv",
			    {
			      initialContentAlignment: go.Spot.Center, // center Diagram contents
			      "undoManager.isEnabled": true // enable Ctrl-Z to undo and Ctrl-Y to redo
			    });
		
		var node = new go.Node(go.Panel.Auto);
		var shape = new go.Shape();
		shape.figure = "RoundedRectangle";
		shape.fill = "lightblue";
		node.add(shape);
		var textblock = new go.TextBlock();
		textblock.text = "Hello!";
		textblock.margin = 5;
		node.add(textblock);
		
		myDiagram.add(
				    $(go.Part,
				      $(go.TextBlock,
				        { text: "select and then click to edit",
				          background: "lightblue",
				          editable: true, isMultiline: false })
				    ));
	   myDiagram.add(
				    $(go.Part,
				      $(go.TextBlock,
				        { text: "this one allows embedded newlines",
				          background: "lightblue",
				          editable: true })
				    ));
		
		myDiagram.add(node);
		
	}
</script>
</head>
<body onload="init()"> 
<div id="myDiagramDiv"
     style="width:1350px; height:615px; background-color: #DAE4E4;"></div>
</body>
</html>