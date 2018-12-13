<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String user_id = (String) request.getSession().getAttribute("ID");
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
		
		String sql = "select *, count(Payment_Number) as count from ticket "
				+ "natural join payment "
				+ "natural join reservation "
				+ "natural join seat "
				+ "natural join schedule "
				+ "natural join movie "
				+ "natural join auditorium "
				+ "natural join theater "
				+ "where id=? "
				+ "group by payment_number";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		
		ResultSet rs = pstmt.executeQuery();
		
		boolean flag = false;
		if (rs.next()) {
			flag = true;
			rs.previous();
		}
		
		str = "Complete";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>select ticket</title>
</head>
<body>
	<h1>select ticket</h1>
	<%
		if (flag == true) {
			%>
				<table border="1px" width="50%">
				<tr>
					<td>Title</td>
					<td>Theater</td>
					<td>count</td>
					<td></td>
				</tr>
				<%
				while (rs.next()) {
					%>
						<tr>
							<td><%=rs.getString("Title") %></td>
							<td><%=rs.getString("Theater_Name") %></td>
							<td><%=rs.getString("count") %></td>
							<td><a href="user_ticketing_result.jsp?payment_number=<%=rs.getString("payment_number") %>">view</a></td>
						</tr>
					<%
				}
				%>
				</table>
			<%
		}
		else {
			%> <h3>No data</h3> <%
		}
	
	%>
	<a href="../user_page.jsp">Back</a>
</body>
</html>

<%
	}catch(Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>