<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang='ja'>
<head>
<meta charset='utf-8'>
<meta name="viewport" content="width=device-width,initial-scale=1">
<link href="./favicon.ico" rel="icon" type="image/x-icon">
<title>tryXemime</title>
<style>
@media (min-width:751px) {
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
		background-color: #FAFAFA;
		font-family: "Source Code Pro", sans-serif;
	}
	#output {
		position: absolute;
		top: 10vh;
		right: 5vw;
		width: 40vw;
		height: 80vh;
		background-color: #444444;
		color: white;
		font-family: "Source Code Pro", sans-serif;
	}

	#submit {
		margin: auto;
		width: 200px;
		text-align: center;
		background-color: #772F6D;
		color: white;
		cursor: pointer;
	}
}
@media (max-width:750px) {
	body {
		margin: 0;
		padding: 0;
	}
	#source {
		position: absolute;
		top: 2em;
		left: 4vw;
		width: 90vw;
		height: 18em;
		background-color: #FAFAFA;
		font-family: "Source Code Pro", sans-serif;
		resize: none;
	}
	#output {
		position: absolute;
		top: 21em;
		left: 4vw;
		width: 90vw;
		height: 18em;
		background-color: #444444;
		color: white;
	}
	#submit {
		position: absolute;
		top: 0;
		left: 25vw;
		width: 50vw;
		height: 2em;
		background-color: #772F60;
		text-align: center;
		color: white;
		cursor: pointer;
	}
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
	<div id="submit">実行</div>
</form>

<textarea id="output" readonly spellcheck="false"><%= output %></textarea>

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
