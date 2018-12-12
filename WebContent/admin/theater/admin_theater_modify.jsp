<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String theater_name = request.getParameter("theater_name");
	String address = "";
	String phone_number = "";
	String seat_number = "";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		String sql = "select * from theater where Theater_Name=?";
			
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, theater_name);
		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		address = rs.getString("Address");
		phone_number = rs.getString("PhoneNumber");
		
		String sql2 = "select * from auditorium where Theater_Name=?";
		
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, theater_name);
		
		rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Theater Modify</title>
</head>
<body>
	<h1>Theater : <%=theater_name %></h1>
	<form method="post" action="admin_theater_modify_result.jsp?theater_name=<%=theater_name %>">
		Address : <input type="text" name ="address" value="<%=address %>"/><br>
		Phone Number: <input type="text" name ="phone_number" value="<%=phone_number %>"/><br>
		<input type="submit" value="Enter">
	</form>
	
	<a href="admin_theater_modify_page.jsp">Back</a>
</body>
</html>

<%	
	}catch(Exception e) {
		e.printStackTrace();
	}
%>