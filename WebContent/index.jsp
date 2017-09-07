<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang='ja'>
<head>
<meta charset='utf-8'>
<title>tryXemime</title>
<style>
body {
	margin: 0;
	padding: 0;
}
#source {
	position: absolute;
	top: 10vh;
	left: 5vw;
	width: 40vw;
	height: 80vh;
	background: #FAFAFA;
	font-family: "Source Code Pro", sans-serif;
}
#output {
	position: absolute;
	top: 10vh;
	right: 5vw;
	width: 40vw;
	height: 80vh;
	background: #444444;
	color: white;
	font-family: "Source Code Pro", sans-serif;
}
</style>
</head>
<body>

<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.io.PrintStream" %>
<%@ page import="net.zero918nobita.Xemime.interpreter.Main" %>

<%
String output = "";

if (request.getMethod() == "POST") {
	PrintWriter pw = response.getWriter();
	ByteArrayOutputStream stream = new ByteArrayOutputStream();
	System.setOut(new PrintStream(stream));
	try {
		Main.exec(request.getParameter("source"));
	} catch(Exception e) {
		System.out.println(e.getMessage());
	}
	output = stream.toString();
}
%>

<form id="form" action="./" method="POST">
	<textarea id="source" name="source" spellcheck="false"></textarea>
	<button id="submit">実行</button>
</form>

<textarea id="output"><%= output %></textarea>

<script>
var source = document.getElementById("source");
if (localStorage.getItem("source") != null) source.value = localStorage.getItem("source");

var submit_button = document.getElementById("submit");
var form = document.getElementById("form");

submit_button.addEventListener("click", function(){
	localStorage.setItem("source", source.value);
	form.submit();
});
</script>

</body>
</html>
