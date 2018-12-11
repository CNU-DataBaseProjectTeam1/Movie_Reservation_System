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
	<a href="user_movielist_main.jsp">movie list</a>
	<br>
	<a href="user_reservation_movie.jsp">reservation</a>
	<br>
	<a href="user_payment.jsp">payment</a>
	<br>

	<a href="user_form_modify.jsp">modify</a>
	</br>
	<a href="user_form_delete.jsp">delete</a>
	</br>
	<a href="user_vip.jsp">Ranking</a>
	<a href="">Back</a>
</body>
</html>