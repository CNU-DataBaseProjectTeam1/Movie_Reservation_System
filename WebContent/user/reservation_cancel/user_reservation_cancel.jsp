<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*" %>

<%@ page import="java.util.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String user_id = (String) request.getSession().getAttribute("User_Id");
	
	Enumeration<String> params = request.getParameterNames();
	
	ArrayList<String> reservation_number_list = new ArrayList<String>();
	
	while (params.hasMoreElements()) {
		String reservation_num = params.nextElement();
		reservation_number_list.add(reservation_num);
	}
	
	request.getSession().setAttribute("reservation_list", reservation_number_list);
	request.getSession().setAttribute("User_Id", user_id);
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		for (String n : reservation_number_list) {
			String sql = "delete from reservation where reservation_number=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, n);
			pstmt.executeUpdate();
		}
		
		str = "Complete";
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Cancel page</title>
</head>
<body>
	<h1>Cancel page</h1>
	<%=str %><br>
	<a href="../user_page.jsp">Back</a>
</body>
</html>

<%
	}catch(Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>