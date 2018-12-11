<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id = (String) request.getSession().getAttribute("ID");
	request.getSession().setAttribute("ID", id);

	String amount = request.getParameter("price");
	String s_amount = request.getParameter("sale_price");
	int resnum = Integer.parseInt(request.getParameter("resnum"));

	String r_amount = null;

	String type = request.getParameter("typecheck");
	int point = Integer.parseInt(request.getParameter("point"));
	int price = Integer.parseInt(request.getParameter("r_p"));
	int use_point = 0;
	int res_num = 0;
	int p_number = 1;

	String str = "";
	if (amount == null && s_amount != null) {
		r_amount = s_amount;
		use_point = price - Integer.parseInt(r_amount);
		point -= use_point;
	} else if (amount != null && s_amount == null) {
		r_amount = amount;
	}

	Connection conn = null;
	PreparedStatement pstmt = null;

	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		String sql = "select * from payment";

		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();


		if (rs.last()) {
			p_number = Integer.parseInt(rs.getString("Payment_Number")) + 1;
		}
		sql = "select Reservation_Number  from reservation where payment_check=0 and ID =? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		rs.next();
		res_num = rs.getInt(1);
		sql = "insert into payment values (?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, p_number);
		pstmt.setInt(2, res_num);
		pstmt.setString(3, type);
		pstmt.setString(4, r_amount);
		pstmt.setInt(5, use_point);
		pstmt.executeUpdate();
		if (use_point > 0) {
			sql = "update user set Point=? where ID=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, point);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} else if (use_point == 0) {
			sql = "update user set Point=? where ID=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, point + 100 * resnum);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		}

		sql = "update reservation set payment_check =1 where payment_check=0";
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();

		str = "success payment";
	} catch (Exception e) {
		str = "failed";
		e.printStackTrace();
	}
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Online Payment</title>
</head>
<body>
	<h2>Online Payment</h2>
	<p><%=str%></p>
	<form action="user_online_ticket.jsp">
			<input type="number" name="payment_num" value="<%=p_number%>" style="display: none">		
			<input type="text" name="res_num" value="<%=res_num%>" style="display:none">
			<input type="text" name="type" value="online" style="display:none">
			<input type="text" name="amount" value="<%=r_amount%>" style="display:none">
			<input type="text" name="point" value="<%=use_point%>" style="display:none">
			 <input type="submit" value="Ticket">
	</form>
	<a href="./user_page.jsp">Back</a>

</body>

</html>