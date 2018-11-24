<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "qotkddnd1";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		// rating
		String test = "select * from movie";
			
		pstmt = conn.prepareStatement(test);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<String> titles = new ArrayList<String>();
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
	while (rs.next()) {
		String number = rs.getString("Movie_Number");
		System.out.println(number);
		String title = rs.getString("title");
		String director = rs.getString("director");
		String info = rs.getString("info");
		String actors = rs.getString("actors");
		%>
		
		<a href="admin_movie_modify.jsp?number=<%=number %>&title=<%=title %>&director=<%=director %>&info=<%=info %>&actors=<%=actors %>"><%=title %></a>
		<%
	}
	%>
</body>
</html>

<%
	}catch(Exception e) {
		e.printStackTrace();
	}finally{
		if (pstmt != null) try { pstmt.close(); } catch(SQLException sqle) {}
		if (conn != null) try { conn.close(); } catch(SQLException sqle) {}
	}
%>