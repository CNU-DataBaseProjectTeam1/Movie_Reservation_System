<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Select payment type</title>
</head>
<body>
	<%
		String id = (String) request.getSession().getAttribute("ID");
		request.getSession().setAttribute("ID", id);
		String res = "";
		String notres ="";
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
			String dbId = "root";
			String dbPass = "1234";

			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

			String sql = "select ID from reservation where ID=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs= pstmt.executeQuery();
			if(!rs.next()){
				res="hidden";
				notres = "display:block";
			}else{
				res="";
				notres="display:none";
			}
			}catch(Exception e){
			e.printStackTrace();
		}
	%>
<h2>SELECT PAYMETNT TYPE</h2>
<a href="./user_payment_online.jsp"<%= res %>>Online</a></br>
<a href="./user_payment_offline.jsp"<%= res %>>Offline</a></br>
<div style="<%= notres%>">There are no movies reservation</div>
<a href="./user_page.jsp">BACK</a>
</body>
</html>