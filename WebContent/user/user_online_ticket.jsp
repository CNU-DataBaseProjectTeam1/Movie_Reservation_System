<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id = (String) request.getSession().getAttribute("ID");
	request.getSession().setAttribute("ID", id);

	String payment_num=request.getParameter("payment_num");
	System.out.print(payment_num);
	String reservation_num= request.getParameter("res_num");
	String amount = request.getParameter("amount");
	String point= request.getParameter("point");
	String type= request.getParameter("type");
	
	int num = Integer.parseInt(amount)/10000;
	
	for (int i=1; i<num; i++){
		reservation_num +=" "+String.valueOf(Integer.parseInt(reservation_num)+1);
	}

	Connection conn = null;
	PreparedStatement pstmt = null;

	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		String sql = "select * from ticket";

		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		int t_number = 1;

		if (rs.last()) {
			t_number = Integer.parseInt(rs.getString("Ticket_Number")) + 1;
		}
		sql = "insert into ticket values(?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,t_number);
		pstmt.setString(2,payment_num);
		pstmt.executeUpdate();
		
	} catch (Exception e) {
		e.printStackTrace();
	}
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h3>TICKET</h3>
<p>Payment_number : <%=payment_num %></p>
<p>Reservation_number : <%=reservation_num %></p>
<p>Amount of pay : <%=amount %></p>
<p>Use_point : <%=point %></p>
<p>Payment_type : <%=type %></p>

	<a href="./user_page.jsp">Back</a>

</body>
</html>