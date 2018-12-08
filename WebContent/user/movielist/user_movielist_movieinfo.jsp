<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	String id = (String) request.getSession().getAttribute("ID");
	request.getSession().setAttribute("ID", id);
	String Movie_Title = request.getParameter("movie_title");

	Connection conn = null;
	PreparedStatement pstmt = null;

	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		//make counter
		String counter = "select * from movie where Title =?";
		pstmt = conn.prepareStatement(counter);
		pstmt.setString(1, Movie_Title);
		ResultSet movie = pstmt.executeQuery();
		
		movie.next();
		String Director = movie.getString("Director");
		String info = movie.getString("info");
		String actors = movie.getString("actors");
		
		
		
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h2><%=Movie_Title %></h2><br>
	<h3>Director</h3><%=Director %><br><br>
	<h3>Information</h3><%=info %><br>
	<h3>Actors</h3><%=actors %><br>
</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>