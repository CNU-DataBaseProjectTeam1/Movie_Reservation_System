<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String next_page = "admin_auditorium_delete_result.jsp";
	String prev_page = "admin_theater_modify_page.jsp";
	
	String theater_name = request.getParameter("theater_name");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		String sql = "select * from auditorium where theater_name=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, theater_name);
		
		ResultSet rs = pstmt.executeQuery();
		int cnt = 1;
		str = "Complete";
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>auditorium delete</title>
</head>
<body>
	<h1>auditorium delete</h1>
	<table border="1px" width="50%">
	<tr>
		<th></th>
		<th>Number</th>
		<th>Seat Count</th>
	</tr>
	<form action=<%=next_page %>>
		<%
	while (rs.next()) {
		%>
			<tr>
				<td><input type="checkbox" name="<%=rs.getString("Auditorium_Number") %>"></td>
				<td><%=cnt++ %></td>
				<td><%=rs.getString("SeatCount") %></td>
			</tr>
		<%
	}
	%>
	<input type="submit" value="delete">
	</form>
	</table>
	<br>
	<a href="<%=prev_page %>">Back</a>
</body>
</html>

<%
	}catch(Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>