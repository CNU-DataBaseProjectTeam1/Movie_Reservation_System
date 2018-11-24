<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String number = request.getParameter("number");
	String title = "";
	String director = "";
	String info = "";
	String actors = "";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		// rating
		String test = "select * from movie where Movie_Number=?";
			
		pstmt = conn.prepareStatement(test);
		pstmt.setInt(1, Integer.parseInt(number));
		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		title = rs.getString("title");
		director = rs.getString("director");
		info = rs.getString("info");
		actors = rs.getString("actors");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Movie Modify</title>
</head>
<body>
	<h1>Modify : <%=title %></h1>
	<form method="post" action="admin_movie_modify_result.jsp?number=<%=number %>">
		title : <input type="text" name ="title" value="<%=title %>"/><br>
		director : <input type="text" name ="director" value="<%=director %>"/><br>
		info : <input type="text" name ="info" value="<%=info %>"/><br>
		actors : <input type="text" name="actors"value="<%=actors %>"/><br>
		<input type="submit" value="Enter">
	</form>
	
	<a href="admin_movie_list.jsp">Back</a>
</body>
</html>

<%	
	}catch(Exception e) {
		e.printStackTrace();
	}
%>