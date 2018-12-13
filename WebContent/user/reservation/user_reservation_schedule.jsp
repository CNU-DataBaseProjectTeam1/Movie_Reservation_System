<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<%
	String id = (String) request.getSession().getAttribute("ID");
	String movie_number = request.getParameter("Movie_Number");
	request.getSession().setAttribute("ID", id);

	String str = "";
	Connection conn = null;
	PreparedStatement pstmt = null;
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		String sql = "select * from schedule "
						+ "natural join auditorium "
						+ "where movie_number=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, movie_number);
		
		ResultSet rs = pstmt.executeQuery();
		
		int cnt = 1;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>select movie</title>
</head>
<body>
	<table width="30%">
	<tr>
		<td></td>
		<td>Theater</td>
		<td>Auditorium</td>
		<td>Start</td>
		<td>End</td>
	</tr>
	<%
		while(rs.next()) {
			%>
				<%
					try {
						String sql2 = "select * from auditorium where theater_name=?";
						pstmt = conn.prepareStatement(sql2);
						pstmt.setString(1, rs.getString("theater_name"));
						
						ResultSet rs2 = pstmt.executeQuery();
						int count = 0;
						while (rs2.next()) {
							count++;
							if (rs2.getInt("auditorium_number") == rs.getInt("auditorium_number")) break;
						}
				%>
				
				<tr>
					<td><%=cnt++ %></td>
					<td><%=rs.getString("theater_name") %></td>
					<td><%=count %></td>
					<td><%=rs.getString("starttime") %></td>
					<td><%=rs.getString("endtime") %></td>
					<td><a href="user_reservation_seat_select.jsp?Schedule_Num=<%=rs.getString("schedule_number")%>">select</a></td>
				</tr>
				<%
					} catch(Exception e) { }
				%>
			<%
		}
	%>
	</table>
</body>
</html>
<%
}catch(Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>
