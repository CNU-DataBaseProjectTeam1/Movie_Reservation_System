<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("euc-kr");
%>

<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");

	Connection conn = null;
	PreparedStatement pstmt = null;

	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		String sql = "select * from user where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();

		if (rs.next() && password.equals(rs.getString("Password"))) {
			request.getSession().setAttribute("ID", id);
			response.sendRedirect("user_page.jsp");
		}

	} catch (Exception e) {
		e.printStackTrace();
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>user Login Result</title>
</head>
<body>
	<h1>user Login Result</h1>
	login fail
	<br>
	<a href="user_login.jsp">Back</a>
</body>
</html>