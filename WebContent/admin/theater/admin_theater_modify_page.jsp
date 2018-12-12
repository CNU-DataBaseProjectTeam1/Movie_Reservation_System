<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String theater_name = request.getParameter("theater_name");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Theater Modify Page</title>
</head>
<body>
	<h1>Theater Modify Page</h1>
	<a href="admin_theater_modify.jsp?theater_name=<%=theater_name %>">Theater Info Modify</a><br>
	<a href="admin_theater_delete.jsp?theater_name=<%=theater_name %>">Theater Delete</a><br>
	<a href="admin_auditorium_additional_insert.jsp?theater_name=<%=theater_name %>">Auditorium Add</a><br>
	<a href="admin_auditorium_delete.jsp?theater_name=<%=theater_name %>">Auditorium Delete</a><br><br>
	
	<a href="admin_theater_list.jsp">Back</a>
</body>
</html>