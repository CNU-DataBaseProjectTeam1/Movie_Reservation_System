<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
	String title = request.getParameter("title");
	String Movie_Number = request.getParameter("Movie_Number");
	String auditorium_number = request.getParameter("auditorium_Number");
	String Theater_Name = request.getParameter("Theater_Name");
	int Schedule_Number=0;
	String str = "";
	Connection conn = null;
	PreparedStatement pstmt = null;
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		String find_movie_name = "select Title from movie where Movie_Number = ?";
		pstmt = conn.prepareStatement(find_movie_name);
		pstmt.setInt(1, Integer.parseInt(Movie_Number));
		ResultSet rs1 = pstmt.executeQuery();
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<table>
	<tr>
		<td>구분</td>
		<td>영화제목</td>
		<td>영화관</td>
		<td>상영관</td>
		<td>시작시간</td>
		<td>끝시간</td>
	</tr>
	<tr>
		
	</tr>
</table>
</body>
</html>
<% 
		String sql = "insert into schedule values (?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Schedule_Number);
		pstmt.setInt(2, Integer.parseInt(auditorium_number));
		pstmt.setInt(3, Integer.parseInt(Movie_Number));
		
		
		ResultSet rs = pstmt.executeQuery();

	}catch(Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>
