<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
	Enumeration<String> params = request.getParameterNames();

	String theater_name = request.getParameter(params.nextElement());
	String address = request.getParameter(params.nextElement());
	String phone_number = request.getParameter(params.nextElement());

	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);   
		
		String sql = "update theater set Address=?, PhoneNumber=? where Theater_Name=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, address);
		pstmt.setString(2, phone_number);
		pstmt.setString(3, theater_name);
		pstmt.executeUpdate();
		
		str = "Complete to modify";
	} catch (Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Theater Modify Result</title>
</head>
<body>
	<h1>Theater Modify Result</h1>
	<%=str %>
	<a href="admin_theater_page.jsp">Back</a>
</body>
</html>