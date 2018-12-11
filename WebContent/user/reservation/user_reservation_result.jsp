<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql.*" %>

<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	Date today = new Date();
	SimpleDateFormat month = new SimpleDateFormat("MM");

	String next_page = "";
	String prev_page = "user_reservation_seat_select.jsp";
	
	String schedule_number = (String) request.getSession().getAttribute("Schedule_Number");
	String user_id = (String) request.getSession().getAttribute("User_Id");
	
	Enumeration<String> params = request.getParameterNames();
	
	ArrayList<String> real_number_list = new ArrayList<String>();
	
	while (params.hasMoreElements()) {
		String real_num = params.nextElement();
		real_number_list.add(real_num);
	}
	
	String str = "";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	for (String real_number : real_number_list) {
		try {
			String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
			String dbId = "root";
			String dbPass = "1234";
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			
			// get a seat last number
			String sql = "select * from seat";
			pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
			
			int last_number = 1;
			
			if (rs.last()) {
				last_number = Integer.parseInt(rs.getString("Seat_Number")) + 1; // (last recode's num) + 1	
			}
			
			// make a seat record
			sql = "insert into seat values(?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, last_number);
			pstmt.setString(2, schedule_number);
			pstmt.setInt(3,  Integer.parseInt(real_number));
			pstmt.executeUpdate();	
			
			
			// get a reservation last number
			int seat_number = last_number;
			sql = "select * from reservation";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			last_number = 1;
			
			if (rs.last()) {
				last_number = Integer.parseInt(rs.getString("Reservation_Number")) + 1; // (last recode's num) + 1	
			}
			
			// make a reservation record
			sql = "insert into reservation values(?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, last_number);
			pstmt.setString(2, user_id);
			pstmt.setInt(3, seat_number);
			pstmt.setString(4, month.format(today));
			pstmt.setBoolean(5, false);
			pstmt.executeUpdate();	
			
			str = "success the reservation";
			}catch(Exception e) {
				e.printStackTrace();
				str = "fail";
			}
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Reservation Result</title>
</head>
<body>
	<%=str %>
	
	<a href="../user_page.jsp">back</a>
	<a href="../user_payment_online.jsp">online check</a>
</body>
</html>