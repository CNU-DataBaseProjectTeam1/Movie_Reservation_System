<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*" %>

<%@ page import="java.util.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String next_page = "admin_offline_payment_result.jsp";
	String prev_page = "admin_offline_payment_select_reservation.jsp";
	
	String user_id = (String) request.getSession().getAttribute("User_Id");
	
	ArrayList<String> reservation_number_list = (ArrayList<String>) request.getSession().getAttribute("reservation_list");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		int count = reservation_number_list.size();
		System.out.println(count);
		// get a user point
// 		String sql = "select * from user where id=?";
// 		pstmt = conn.prepareStatement(sql);
// 		pstmt.setString(1, user_id);
// 		ResultSet rs = pstmt.executeQuery();
// 		rs.next();
		
// 		int point = rs.getInt("Point");
		
		str = "Complete";
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>payment result</title>
</head>
<body>
	<h1>payment result</h1>
	
	<a href="<%=prev_page %>">Back</a>
</body>
</html>

<%
	}catch(Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>