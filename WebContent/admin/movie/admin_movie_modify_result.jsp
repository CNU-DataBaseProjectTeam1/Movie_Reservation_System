<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	int number = Integer.parseInt(request.getParameter("number"));
	String title = request.getParameter("title");
	String director = request.getParameter("director");
	String info = request.getParameter("info");
	String actors = request.getParameter("actors");

	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);   
		
		String sql = "update movie set title=?, director=?, info=?, actors=? where Movie_Number=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, director);
		pstmt.setString(3, info);
		pstmt.setString(4, actors);
		pstmt.setInt(5, number);
		pstmt.executeUpdate();

		str = "영화가 수정 되었습니다.";
	} catch (Exception e) {
		e.printStackTrace();
		str = "등록 실패";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Movie Modify Result</title>
</head>
<body>
	<h1>Movie Modify Result</h1>
	<%=str %>
	<a href="admin_movie_page.jsp">Back</a>
</body>
</html>