<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String theater_name = (String) request.getSession().getAttribute("Theater_Name");
	int auditorium_count = Integer.parseInt((String) request.getSession().getAttribute("Auditorium_Number"));
	String[] seat_count = new String[auditorium_count];
	
	for (int i = 0; i < auditorium_count; i++) {
		String num = Integer.toString(i+1);
		seat_count[i] = request.getParameter("auditorium"+num);
	}
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		String sql = "select * from auditorium";
		
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		int last_number = 1;
		
		if (rs.last()) {
			last_number = Integer.parseInt(rs.getString("Auditorium_Number")) + 1; // (last recode's num) + 1	
		}
		
		for (int i = 0; i < auditorium_count; i++) {
			String num = Integer.toString(last_number + i);
			String sql2 = "insert into auditorium values(?, ?, ?)";
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, num);
			pstmt.setString(2, theater_name);
			pstmt.setString(3, seat_count[i]);
			pstmt.executeUpdate();	
		}
		
		str = "Complete";
		}catch(Exception e) {
			e.printStackTrace();
			str = "Fail";
		}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Theater Insert Result</title>
</head>
<body>
	<h1>Theater Insert Result</h1>
	<%=str %><br>
	<a href="admin_theater_page.jsp">Back</a>
</body>
</html>