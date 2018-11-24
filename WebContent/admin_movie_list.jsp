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
		
		// rating
		String test = "select * from movie";
			
		pstmt = conn.prepareStatement(test);
		ResultSet rs = pstmt.executeQuery();
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Movie List</title>
</head>
<body>
	<h1>Movie List</h1>
	<%
	while (rs.next()) {
		String number = rs.getString("Movie_Number");
		String title = rs.getString("title");
		%>
			<a href="admin_movie_modify.jsp?number=<%=number %>"><%=title %></a><br>
		<%
	}
	%>
	
	<a href="admin_movie_page.jsp">Back</a>
</body>
</html>

<%
	}catch(Exception e) {
		e.printStackTrace();
	}
%>