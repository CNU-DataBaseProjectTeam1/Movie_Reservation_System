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
		
		String sql = "select * from theater";
			
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Theater List</title>
</head>
<body>
	<h1>Theater List</h1>
	<%
	while (rs.next()) {
		String theater_name = rs.getString("Theater_Name");
		%>
			<a href="admin_theater_modify_page.jsp?theater_name=<%=theater_name %>"><%=theater_name %></a><br>
		<%
	}
	%>
	
	<a href="admin_theater_page.jsp">Back</a>
</body>
</html>

<%
	}catch(Exception e) {
		e.printStackTrace();
	}
%>