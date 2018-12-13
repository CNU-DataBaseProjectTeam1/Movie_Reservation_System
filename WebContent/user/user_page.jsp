<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>User Page</title>
</head>
<body>
	<%
		String id = (String) request.getSession().getAttribute("ID");
		request.getSession().setAttribute("ID", id);
	%>
	<h1>user Page</h1>
	<a href="./movielist/user_movielist_main.jsp">View Movie List</a>
	<br>
	<a href="./reservation/user_reservation_movie.jsp">Movie Reservation</a>
	<br>
	<a href="./online_payment/user_online_payment_select_reservation.jsp">Reservation Payment</a>
	<br>
	<a href="./reservation_cancel/user_reservation_select.jsp">Reservation Cancel</a>
	<br>
	<a href="./ticket/user_ticketing_select_ticket.jsp">View Ticket</a>
	<br><br>
	<a href="user_form_modify.jsp">User Info Modify</a>
	<br>
	<a href="user_form_delete.jsp">User Drop Out</a>
	<br><br>
	<a href="user_vip.jsp">User Ranking</a>
	<br><br>
	<a href="../login.jsp">Back</a>
</body>
</html>