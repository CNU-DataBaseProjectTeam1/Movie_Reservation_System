<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String title = request.getParameter("title");
	String director = request.getParameter("director");
	String info = request.getParameter("info");
	String actors = request.getParameter("actors");
	String rating = "0";
	String number;
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		String sql = "select * from movie";
			
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		int last_number = 1;
		
		if (rs.last()) {
			last_number = Integer.parseInt(rs.getString("Movie_Number")) + 1; // (last recode's num) + 1	
		}
		
		String sql2 = "insert into movie values(?, ?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, Integer.toString(last_number));
		pstmt.setString(2, title);
		pstmt.setString(3, director);
		pstmt.setString(4, rating);
		pstmt.setString(5, info);
		pstmt.setString(6, actors);
		pstmt.executeUpdate();
		
		str = "Complete to insert the movie";
	}catch(Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Movie Insert Result</title>
</head>
<body>
	<h1>Movie Insert Result</h1>
	<%=str %><br>
	<a href="admin_movie_page.jsp">Back</a>
</body>
</html>