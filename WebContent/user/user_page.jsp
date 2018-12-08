<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>user Page</title>
</head>
<body>
	<%
		String id = (String) request.getSession().getAttribute("ID");
		request.getSession().setAttribute("ID", id);
	%>
	<h1>user Page</h1>
	<a href="">sch</a>
	<br>
	<a href="user_reservation_movie.jsp">reservation</a>
	<br>
	<a href="">pay</a>
	<br>

	<a href="user_form_modify.jsp">modify</a>
	</br>
	<a href="user_form_delete.jsp">delete</a>
	</br>
	<a href="">Back</a>
</body>
</html>