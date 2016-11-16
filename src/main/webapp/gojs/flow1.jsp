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
			      "undoManager.isEnabled": true, // enable Ctrl-Z to undo and Ctrl-Y to redo
			      allowDrop: true
			    });
		
		myDiagram.nodeTemplate =
		    $(go.Node, "Auto",
		      $(go.Shape, "RoundedRectangle",
		        { fill: "white" },
		        new go.Binding("fill", "color"), 
		        { portId: "", fromLinkable: true, toLinkable: true, cursor: "pointer" }),
		      $(go.TextBlock, { margin: 5 }, new go.Binding("text", "type"))
		    );
		
		var myPalette =
			$(go.Palette, "myPaletteDiv",  // create a new Palette in the HTML DIV element "palette"
		        {
		          // share the template map with the Palette
		          //nodeTemplateMap: myDiagram.nodeTemplateMap,
		           layout: $(go.GridLayout,
                    { comparer: go.GridLayout.smartComparer }),
                    initialContentAlignment: go.Spot.LeftCenter,
		           autoScale: go.Diagram.Uniform  // everything always fits in viewport
		        });
		
		myPalette.nodeTemplate =
		    $(go.Node, "Vertical",
		      $(go.Picture, 
		    	{ width: 40, height: 40, margin: 2, background: "chartreuse",
		    	  imageStretch: go.GraphObject.UniformToFill,source:"../images/log.png" },
			        new go.Binding("source", "images")),
		      $(go.TextBlock,{ margin: 2,width: 50,wrap: go.TextBlock.WrapFit },
		        new go.Binding("text", "type"))
		    );
		myPalette.model.nodeDataArray = [
		    { key: "Start", color: "blue",type:"Start",images:"../images/50x40.png" },
		    { key: "A", color: "green",type:"Proc",images:"../images/50x40.png"},
		    { key: "T", color: "gray",type:"Shell" ,images:"../images/50x40.png"},
		    { key: "PB", color: "orange",type:"Dubbo" ,images:"../images/50x40.png"},
		    { key: "LB", color: "lightblue",type:"Kettle",images:"../images/logo.png" }
		];
	}
</script>
</head>
<body onload="init()"> 
 <div style="width:100%; white-space:nowrap;">
  <div id="myPaletteDiv" style="border: solid 1px gray; height: 60px;margin-bottom:2px;"></div>
  <div id="myDiagramDiv" style="border: solid 1px gray; height: 500px"></div>
   </div>
</body>
</html>