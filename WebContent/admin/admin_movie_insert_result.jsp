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
	
	Timestamp register = new Timestamp(System.currentTimeMillis());
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		// rating
		String sql = "select * from movie";
			
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		rs.last(); // move to last recode
		number = Integer.toString(Integer.parseInt(rs.getString("Movie_Number")) + 1); // (last recode's num) + 1   
		
		String sql2 = "insert into movie values(?, ?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, number);
		pstmt.setString(2, title);
		pstmt.setString(3, director);
		pstmt.setString(4, rating);
		pstmt.setString(5, info);
		pstmt.setString(6, actors);
		pstmt.executeUpdate();
		
		str = "새로운 영화가 등록되었습니다.";
	}catch(Exception e) {
		e.printStackTrace();
		str = "등록 실패";
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
	<%=str %>
	<a href="admin_movie_page.jsp">돌아가기</a>
</body>
</html>