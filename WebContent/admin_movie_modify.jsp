<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	//int number = Integer.parseInt(request.getParameter("Movie_Number"));
	String number = request.getParameter("number");
	System.out.println(number);
	String title = request.getParameter("title");
	String director= request.getParameter("director");
	String info= request.getParameter("info");
	String actors= request.getParameter("actors");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="admin_movie_modify_result.jsp">
		<input type="text" name ="number" value="<%=number %>"/><br>
		title : <input type="text" name ="title" value="<%=title %>"/><br>
		director : <input type="text" name ="director" value="<%=director %>"/><br>
		info : <input type="textarea" name ="info" value="<%=info %>"/><br>
		actors : <input type="text" name="actors"value="<%=actors %>"/><br>
		<input type="submit">
	</form>
</body>
</html>