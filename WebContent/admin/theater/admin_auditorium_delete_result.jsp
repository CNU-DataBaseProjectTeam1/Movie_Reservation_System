<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*" %>

<%@ page import="java.util.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	Enumeration<String> params = request.getParameterNames();
	
	ArrayList<String> auditorium_number_list = new ArrayList<String>();
	
	while (params.hasMoreElements()) {
		String auditorium_num = params.nextElement();
		auditorium_number_list.add(auditorium_num);
	}
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		int count = auditorium_number_list.size();
		
		for (int i = 0; i < count; i++) {
			String sql = "delete from auditorium where auditorium_number=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, auditorium_number_list.get(i));
			pstmt.executeUpdate();
		}

		str = "Complete";
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>auditorium delete result</title>
</head>
<body>
	<h1>auditorium delete result</h1>
	<%=str %>
	<br><br>
	<a href="admin_theater_page.jsp">Back</a>
</body>
</html>

<%
	}catch(Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>