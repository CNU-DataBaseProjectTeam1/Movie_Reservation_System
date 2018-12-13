<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String next_page = "admin_offline_payment_pay_page.jsp";
	String prev_page = "admin_offline_payment_page.jsp";
	
	String user_id = request.getParameter("user_id");
	request.getSession().setAttribute("User_Id", user_id);
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		String sql = "select count(*) as c from reservation "
						+ "natural join seat "
						+ "natural join schedule "
						+ "natural join movie "
						+ "natural join auditorium "
						+ "natural join theater "
						+ "where id=? and payment_check=0";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		
		int count = rs.getInt("c");
		
		sql = "select * from reservation "
						+ "natural join seat "
						+ "natural join schedule "
						+ "natural join movie "
						+ "natural join auditorium "
						+ "natural join theater "
						+ "where id=? and payment_check=0";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		
		rs = pstmt.executeQuery();
		
		
		
		str = "Complete";
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>select reservation</title>
</head>
<body>
	<h1>select reservation</h1>
	<%
		if (count == 0) {
			%>
				<h3>No data</h3>
			<%
		}
		
		else {
			%>
				<table>
				<tr>
					<th></th>
					<th>Movie</th>
					<th>Theater</th>
					<th>Auditorium</th>
					<th>Seat Number</th>
				</tr>
				<form action=<%=next_page %>>
					<%
				while (rs.next()) {
					%>
						<tr>
							<td><input type="checkbox" name="<%=rs.getString("Reservation_Number") %>"></td>
							<td><%=rs.getString("Title") %></td>
							<td><%=rs.getString("Theater_Name") %></td>
							<td><%=rs.getString("Auditorium_Number") %></td>
							<td><%=rs.getString("RealNumber") %></td>
						</tr>
					<%
				}
				%>
				<input type="submit" value="payment">
				</form>
				</table>
			<%
		}
	%>
	
	<a href="<%=prev_page %>">Back</a>
</body>
</html>

<%
	}catch(Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>