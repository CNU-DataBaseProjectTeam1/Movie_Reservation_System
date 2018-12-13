<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 
<%@ page import="java.sql.*" %>

<%@ page import="java.util.*" %>

<%
	String payment_number = request.getParameter("payment_number");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		String movie, theater, auditorium, start, end;
		ArrayList<String> seat = new ArrayList<String>();
		
		// movie, theater, start, end, seat
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		String sql = "select * from payment "
				+ "natural join reservation "
				+ "natural join seat "
				+ "natural join schedule "
				+ "natural join movie "
				+ "natural join auditorium "
				+ "natural join theater "
				+ "where payment_number=? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, payment_number);
		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		movie = rs.getString("Title");
		theater = rs.getString("Theater_Name");
		auditorium = rs.getString("Auditorium_Number");
		start = rs.getString("StartTime");
		end = rs.getString("EndTime");
		seat.add(rs.getString("RealNumber"));
		
		while (rs.next()) {
			seat.add(rs.getString("RealNumber"));
		}
		
		sql = "select * from auditorium where theater_name=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, theater);
		rs = pstmt.executeQuery();
		
		int auditorium_count = 0;
		
		while (rs.next()) {
			auditorium_count++;
			if (rs.getString("Auditorium_Number").equals(auditorium)) break;
		}
		
		str = "Complete";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Ticket</title>
</head>
<body>
	<h1>Ticket</h1>
	
	<h2>Movie : <%=movie %></h2>
	<h2>Theater : <%=theater %></h2>
	<h2>Auditorium <%=auditorium_count %></h2>
	<h2>Start : <%=start %></h2>
	<h2>End : <%=end %></h2>
	
	<h3>Seat Number : 
	<%
		for (String num : seat) {
			%>
				<span><%=num %> </span>
			<%
		}
	%>
	</h3>
	<a href="admin_ticketing_page.jsp">Back</a>
</body>
</html>

<%
	}catch(Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>