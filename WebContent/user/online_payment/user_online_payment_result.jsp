<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*" %>

<%@ page import="java.util.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String prev_page = "../user_page.jsp";
	
	String user_id = (String) request.getSession().getAttribute("User_Id");
	
	int point = 0;
	
	boolean flag = false;
	
	if (request.getParameter("point") != null) {
		point = Integer.parseInt(request.getParameter("point"));
	}
	else {
		flag = true;
	}
	
	ArrayList<String> reservation_number_list = (ArrayList<String>) request.getSession().getAttribute("reservation_list");
	
	int count = reservation_number_list.size();
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		// get user point
		String sql = "select * from user where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		int user_point = rs.getInt("point");
		
		if (flag == false) {
			// minus user point
			sql = "update user set point=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_point - point);
			pstmt.setString(2, user_id);
			pstmt.executeUpdate();	
		}
		else {
			sql = "update user set point=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_point + 100*count);
			pstmt.setString(2, user_id);
			pstmt.executeUpdate();
		}
		
		// reservation payment convert to true		
		for (int i = 0; i < count; i++) {
			sql = "update reservation set payment_check=1 where reservation_number=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reservation_number_list.get(i));
			pstmt.executeUpdate();
		}
		
		// make payment record
		sql = "select * from payment";
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		int last_number = 1;
		
		if (rs.last()) {
			last_number = Integer.parseInt(rs.getString("Payment_Number")) + 1; // (last recode's num) + 1	
		}
		

		for (int i = 0; i < count; i++) {
			sql = "insert into payment values(?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, last_number);
			pstmt.setString(2, reservation_number_list.get(i));
			pstmt.setString(3, "0");
			pstmt.setInt(4, count*10000 - point);
			pstmt.setInt(5, point);
			pstmt.executeUpdate();
		}
		
		// make a ticket
		sql = "select * from ticket";
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		int last_ticket_number = 1;
		
		if (rs.last()) {
			last_ticket_number = Integer.parseInt(rs.getString("ticket_number")) + 1; // (last recode's num) + 1	
		}
		
		sql = "insert into ticket values(?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, last_ticket_number);
		pstmt.setInt(2, last_number);
		pstmt.executeUpdate();
		
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
	<%=str %>
	<a href="<%=prev_page %>">Back</a>
</body>
</html>

<%
	}catch(Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>