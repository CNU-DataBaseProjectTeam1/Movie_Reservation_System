<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id = (String) request.getSession().getAttribute("ID");
	request.getSession().setAttribute("ID", id);

	int price = 10000;
	int reservation_num = 0;
	String point_type = "";
	String point_type2 = "";
	int point = 0;
	int saleprice =10000;
	int real_price =0;
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		String sql = "select Point from user where ID=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		point = rs.getInt(1);
		
		sql = "select count(*) from reservation where payment_check=0";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		rs.next();
		reservation_num = rs.getInt(1);
		saleprice= saleprice*reservation_num;
		price = price * reservation_num;
		real_price= price;	
		
		if (point >= 1000) {
			point_type = "hidden disabled";
			point_type2 ="";
		} else {
			point_type="";
			point_type2 = "hidden disabled";
		}
		

	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<%!public int cal(int price, int point) {
		price -= point;
		return price;
	}%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Online Payment</title>
</head>
<body>
	<h2>Online Payment</h2>

	<form method="post" action="user_payment_result.jsp">
		<h5>현재 보유 보인트 : <%= point %></h5>
		결제 금액 : <input type="number" name="price" maxlength="20"placeholder=<%=price%> min="<%=real_price %>" max="<%=real_price %>" <%=point_type%>>
		<input type="text" name="typecheck" value="0" style="display:none">
		<input type="text" name="point" value="<%=point%>" style="display:none">
		<input type="text" name="r_p" value="<%=real_price%>" style="display:none">	
		<input type="text" name="resnum" value="<%=reservation_num%>" style="display:none">	
		<input type="number" name="sale_price" placeholder="possible price = <%=price=cal(price, point)%>"min="<%=price%>" max="<%=real_price %>" <%=point_type2%>><br/></br>
		<input type="submit"value="Payment"> <input type="reset" value="다시입력">

	</form>
</body>

</html>