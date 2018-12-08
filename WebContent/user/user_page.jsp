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
	<a href="">View the Movie List</a><br>
	<a href="./reservation/user_reservation_movie.jsp">Reservation</a><br>
	<a href="">Payment</a><br>
	<a href="user_form_modify.jsp">Info modify</a></br>
	<a href="user_form_delete.jsp">delete</a></br>
	<a href="../login.jsp">Back</a>
</body>
</html>