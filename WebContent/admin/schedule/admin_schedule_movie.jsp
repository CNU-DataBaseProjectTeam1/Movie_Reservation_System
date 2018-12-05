<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		String test = "select * from movie";
			
		pstmt = conn.prepareStatement(test);
		ResultSet rs = pstmt.executeQuery();
		
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>schedule_movie_설정</title>
<%
	while (rs.next()) {
		String number = rs.getString("Movie_Number");
		String title = rs.getString("title");
		%>
		<form method="get" action="admin_schedule_result.jsp">
			<input type="hidden" name="<%=number%>" value"<%=number%>">
			<input type="text" name="<%=title %>" value="<%=title%>">
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