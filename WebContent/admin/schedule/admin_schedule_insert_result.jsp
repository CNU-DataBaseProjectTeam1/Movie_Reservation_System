<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	String Movie_number = request.getParameter("Movie_num");
	
	String Auditorium_number = request.getParameter("theater_info");
	String starttime = request.getParameter("start");
	String endtime = request.getParameter("end");
	int Schedule_no = 1;
	String str = "";
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	ResultSet rs2 = null;
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		// get last number
		String find_number = "select * from schedule ";
		pstmt = conn.prepareStatement(find_number);
		ResultSet rs1 = pstmt.executeQuery();
		if (rs1.last()) {
			Schedule_no = Integer.parseInt(rs1.getString("Schedule_Number"))+1;	
		}
		
		
		boolean flag = false;
		
		// get same auditorium schedule
		String sql = "select * from Schedule where auditorium_number=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, Auditorium_number);
		rs1 = pstmt.executeQuery();
		
		while (rs1.next()) {
			String movie_number2 = rs1.getString("Movie_Number");
			int start2 = Integer.parseInt(rs1.getString("StartTime").split(":")[0]);
			int end2 = Integer.parseInt(rs1.getString("EndTime").split(":")[0]);
			if (Integer.parseInt(movie_number2)!=Integer.parseInt(Movie_number)) {
				flag = true;
				out.print("Movie Numbers are not same");
				break;
			}
			if(Integer.parseInt(starttime.split(":")[0])<start2 && start2 < Integer.parseInt(endtime.split(":")[0]) || Integer.parseInt(starttime.split(":")[0])<end2 && 2 < Integer.parseInt(endtime.split(":")[0])){
					flag = true;
					out.print("Time crush");
					break;
			}
		}
		
		if (flag == false) {
			sql = "insert into schedule values (?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Schedule_no);
				pstmt.setInt(2, Integer.parseInt(Auditorium_number));
				pstmt.setInt(3, Integer.parseInt(Movie_number));
				pstmt.setString(4, starttime);
				pstmt.setString(5, endtime);
				pstmt.executeUpdate();
		}

		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<!--스케쥴 전체 목록 -->
	<h2>Schedule List</h2>
	<table style="border: 1px solid">
		<tr>
			<td style="border: 1px solid">schedule_number</td>
			<td style="border: 1px solid">Auditorium_number</td>
			<td style="border: 1px solid">Movie_number</td>
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
		%>
		<tr>
			<td style="border: 1px solid"><%=Schedule_number%></td>
			<td style="border: 1px solid"><%=Auditorium_info%></td>
			<td style="border: 1px solid"><%=Movie_info%></td>
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
	} catch (

	Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>