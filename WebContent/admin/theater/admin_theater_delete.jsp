<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("euc-kr");
%>

<%
	String name = request.getParameter("theater_name");

	Connection conn = null;
	PreparedStatement pstmt = null;

	String str = "";
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		// delete auditoriums
		String sql = "delete from auditorium where Theater_Name=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.executeUpdate();
		
		// delete theater
		sql = "delete from theater where Theater_Name=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.executeUpdate();
		
		str = "Complete";
		
	} catch (Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset = EUC-KR">
<title>theater delete</title>
</head>
<body>
	<h1>theater delete</h1>
	<%=str%>
	</br>
	<a href="admin_theater_page.jsp">Back</a>
</body>
</html>

