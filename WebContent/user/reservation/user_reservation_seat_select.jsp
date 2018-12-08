<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String next_page = "user_reservation_result.jsp";
	String prev_page = "";
	
	String user_id = (String) request.getSession().getAttribute("ID");
	
	String schedule_number = request.getParameter("Schedule_Num");
	request.getSession().setAttribute("Schedule_Number", schedule_number);
	request.getSession().setAttribute("User_Id", user_id);
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		// get a seat count (access table : schedule -> auditorium)
		String sql = "select * from schedule where Schedule_Number=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, schedule_number);
		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		String auditorium_number = rs.getString("Auditorium_Number");
		
		sql = "select * from auditorium where Auditorium_Number=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, auditorium_number);
		
		rs = pstmt.executeQuery();
		rs.next();
		
		int seat_count = Integer.parseInt(rs.getString("SeatCount"));
		
		// get a already exist seat number (access table : seat)
		sql = "select * from seat where Schedule_Number=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, schedule_number);
		
		rs = pstmt.executeQuery();
		
		boolean[] seat = new boolean[seat_count];
		
		while (rs.next()) {
			int real_number = Integer.parseInt(rs.getString("RealNumber")) - 1;
			seat[real_number] = true;
		}
%>
		<!DOCTYPE html>
		<html>
		<head>
		<meta charset="EUC-KR">
		<title>seat select</title>
		</head>
		<body>
			<h1>seat select</h1>
			<form action="<%=next_page %>">
				<%
				for (int i = 0; i < seat_count; i++) {
					if (seat[i] == false) { %> <input type="checkbox" name="<%=i+1 %>"><%=i+1 %></option> <% }
					else { %> <a><%=i+1 %></a> <% }
					
					if ((i+1) % 5 == 0) { %><br><% }
				}
			%>
			
			<input type="submit">
			</form>
		</body>
		</html>
<%
		}catch(Exception e) {
			e.printStackTrace();
		}
%>