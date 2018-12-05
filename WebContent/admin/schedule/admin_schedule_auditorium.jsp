<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String Theater_Name = request.getParameter("Theater_Name");
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		String test = "select * from auditorium where Theater_Name = ?";
		pstmt = conn.prepareStatement(test);
		pstmt.setString(1, Theater_Name);
		ResultSet rs = pstmt.executeQuery();
		
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>schedule_movie_설정</title>
<%
	while (rs.next()) {
		String auditorium_number = rs.getString("Auditorium_Number");
		%>
		<form method="get" action="admin_schedule_result.jsp">
			<input type="hidden" name="<%=Theater_Name%>" value"<%=Theater_Name%>">
			<input type="text" name="<%=auditorium_number%>" value="<%=auditorium_number%>">
			<input type="submit">
		</form>
		<%
	}
	%>
</head>
<body>
	
</body>
</html>

<%
	}catch(Exception e) {
		e.printStackTrace();
	}
%>