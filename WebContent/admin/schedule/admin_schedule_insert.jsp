<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("euc-kr");
%>

<%
	String title = request.getParameter("title");
	String Movie_Number = request.getParameter("Movie_Number");
	String auditorium_number = request.getParameter("auditorium_Number");
	String Theater_Name = request.getParameter("Theater_Name");
	int Schedule_Number = 0;
	String str = "";
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		String selcet_movie = "select * from movie";
		pstmt = conn.prepareStatement(selcet_movie);
		ResultSet movie_selection = pstmt.executeQuery();
		
		String select_theater = "select * from Auditorium";
		pstmt = conn.prepareStatement(select_theater);
		ResultSet theater_selection = pstmt.executeQuery();
		
		

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
			<td>Title</td>
			<td>Theater</td>
			<td>StartTime</td>
			<td>EndTime</td>
		</tr>
		<form method="get" action="admin_schedule_insert_result.jsp">
		<tr>
			<td><select name="Movie_number">
					<%
					while(movie_selection.next()){
						String Movie_number = movie_selection.getString("Movie_Number");
						String Movie_name = movie_selection.getString("Title");
					%>
					<option value="<%=Movie_number%>"><%=Movie_name%></option>
					<%
						}
					%>

			</select></td>
			<td><select name="theater_info">
					<%
					while (theater_selection.next()) {
						String Theater_name = theater_selection.getString("Theater_Name");
						int Auditorium_number = theater_selection.getInt("Auditorium_Number");
						int seat = theater_selection.getInt("SeatCount");
					%>
					<option value="<%=Auditorium_number%>"><%=Theater_name%> <%=Auditorium_number%>°ü ÃÑ<%=seat%>¼®
					</option>
					<%
					}
					%>
			</select></td>
			<td><input type="text" name="start" placeholder="10:00"></input>
			</td>
			<td><input type="text" name="end" placeholder="12:00"></input></td>
			<td><input type="submit" value="enter"></input></td>

		</tr>
		</form>
	</table>
</body>
</html>

<%
	} catch (Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>
