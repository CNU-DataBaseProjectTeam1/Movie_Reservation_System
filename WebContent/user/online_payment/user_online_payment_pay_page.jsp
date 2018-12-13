<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*" %>

<%@ page import="java.util.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String next_page = "user_online_payment_result.jsp";
	String prev_page = "user_online_payment_select_reservation.jsp";
	
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
		
		int count = reservation_number_list.size();
		
		// get a user point
		String sql = "select * from user where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		int point = rs.getInt("Point");
		
		str = "Complete";
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>pay page</title>
</head>
<body>
	<h1>pay page</h1>
	<p>total cost : <%=count * 10000 %></p>
	<p>user point : <%=point %></p>
	<%
	if (point >= 10000) {
		%>
			<form action="<%=next_page %>">
				use point : 
				<input type="text" name="point">
				<input type="submit" value="pay">
			</form>		
		<%
	}
	else {
		%>
			<button type="button" onclick="location.href='<%=next_page %>' ">pay</button>
		<%
	}
	%>
	<br><br>
	<a href="<%=prev_page %>">Back</a>
</body>
</html>

<%
	}catch(Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>