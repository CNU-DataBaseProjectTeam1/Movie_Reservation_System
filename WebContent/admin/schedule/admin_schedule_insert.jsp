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
			<td><select name="Movie_num">
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
		<br>
					
	
	
	
	<table style="border: 1px solid">
	<tr>
		<td style="border: 1px solid">schedule_number</td>
		<td style="border: 1px solid">Theater_name</td>
		<td style="border: 1px solid">Auditorium_number</td>
		<td style="border: 1px solid">Movie_Name</td>
		<td style="border: 1px solid">Start_time</td>
		<td style="border: 1px solid">End_time</td>
	</tr>

	<%
		String test1 = "select * from schedule";
			pstmt = conn.prepareStatement(test1);
			ResultSet rs3 = pstmt.executeQuery();
			while (rs3.next()) {
				int Schedule_number = rs3.getInt("Schedule_Number");
				int Auditorium_info = rs3.getInt("Auditorium_Number");
				String Movie_info = rs3.getString("Movie_Number");
				String start_info = rs3.getString("StartTime");
				String end_info = rs3.getString("EndTime");
				
				String Theater_sql = "select Theater_Name from auditorium where Auditorium_Number =?";
				pstmt = conn.prepareStatement(Theater_sql);
				pstmt.setInt(1, Auditorium_info);
				ResultSet Theater= pstmt.executeQuery();
				Theater.next();
				String Theater_name = Theater.getString("Theater_Name");
				String Movie_sql = "select Title from movie where Movie_Number = ?";
				pstmt = conn.prepareStatement(Movie_sql);
				pstmt.setString(1, Movie_info);
				ResultSet Movie= pstmt.executeQuery();
				Movie.next();
				String Movie_Title = Movie.getString("Title");
	%>
	<tr>
		<td style="border: 1px solid"><%=Schedule_number%></td>
		<td style="border: 1px solid"><%=Theater_name%></td>
		<td style="border: 1px solid"><%=Auditorium_info%> </td>
		<td style="border: 1px solid"><%=Movie_Title%></td>
		<td style="border: 1px solid"><%=start_info%></td>
		<td style="border: 1px solid"><%=end_info%></td>
	</tr>


	<%
		}
	%>
</table>

	
	
	<a href="../admin_page.jsp">back</a>
</body>
</html>

<%
	} catch (Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>
