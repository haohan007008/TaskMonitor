<%@page import="java.io.File"%>
<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	String path = request.getParameter("f");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>Tomcat WebSocket Chat</title>
<script>
	var path = '<%=path %>';
	var ws = new WebSocket("ws://localhost:8080/TaskMonitor/wsServlet?f="+path);
	ws.onopen = function() {
	};
	ws.onmessage = function(message) {
		var log = document.getElementById("chatlog");
		log.innerText += message.data +'\n';
		//log.scrollTop = log.scrollHeight;
		document.getElementById("msg_end").scrollIntoView();
	};
	function postToServer() {
		ws.send(document.getElementById("msg").value);
		document.getElementById("msg").value = "";
	}
	function closeConnect() {
		ws.close();
	}
</script>

</head>
<body>
	<pre id="chatlog" style="font-family:tahoma,Arial;font-size:12px;"></pre>
	<div id="msg_end" style="height:0px; overflow:hidden"></div>
</body>
</html>
