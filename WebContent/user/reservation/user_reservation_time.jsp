<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<%
	String theater_Name= request.getParameter("theater_Name");
 	String auditorium_num = request.getParameter("auditorium_num");
 	String movie_number = request.getParameter("movie_number");
 	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		String find_schedule_name = "select * from schedule where Auditorium_Number=? and Movie_Number=?";
		pstmt = conn.prepareStatement(find_schedule_name);
		pstmt.setInt(1, Integer.parseInt(auditorium_num));
		pstmt.setInt(2, Integer.parseInt(movie_number));
		ResultSet rs1 = pstmt.executeQuery();
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<table>
	<tr>
		<td>schedule_num</td>
		<td>StartTime</td>
		<td>EndTime</td>
		<td></td>
	</tr>
	<%
		while(rs1.next()){
			String Schedule_Number = rs1.getString("Schedule_Number");
			String StartTime = rs1.getString("StartTime");
			String EndTime = rs1.getString("EndTime");			
	%>
		<form action="user_reservation_seat_select.jsp" method="get">
			<td><input type="text" name="Schedule_Num" value="<%=Schedule_Number%>"></td>
			<td><input type="text" name="StartTime" value="<%=StartTime%>"></td>
			<td><input type="text" name="EndTime" value="<%=EndTime%>"></td>
			<td><input type="submit" value="seat booking"></td>
			
		</form>
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
