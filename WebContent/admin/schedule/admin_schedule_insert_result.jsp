<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<% 
	String Movie_number = request.getParameter("Movie_number");
	String Auditorium_number = request.getParameter("theater_info");
	String starttime = request.getParameter("start");
	String endtime = request.getParameter("end");
	int Schedule_no=0;
	String str="";
	Connection conn = null;
	PreparedStatement pstmt = null;
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		String find_number = "select Schedule_Number from schedule";
		pstmt = conn.prepareStatement(find_number);
		ResultSet rs1 = pstmt.executeQuery();
		while(rs1.next()){
			int temp=Schedule_no;
			Schedule_no = rs1.getInt("Schedule_Number");
			if(temp<Schedule_no){
				temp = Schedule_no;
			}
			else{
				Schedule_no = temp;
			}
		}
// 		int Schedule_no = rs1.getInt("Schedule_Number");
		System.out.println("uuuu"+Schedule_no);
		Schedule_no++;
		System.out.println("asf"+Schedule_no);
		
// 		// 예외처림 해야됨 (exception needed)
// 		String test ="select * from schedule";
// 		pstmt = conn.prepareStatement(test);
// 		ResultSet rs2 = pstmt.executeQuery();
// 		while(rs2.next()){
// 			int Auditorium_info = rs2.getInt("Auditorium_Number");
// 			String Movie_info = rs2.getString("Movie_Number");
// 			String start_info = rs2.getString("StartTime");
// 			String end_info = rs2.getString("EndTime");
			
// 			if(Integer.parseInt(Auditorium_number) == Auditorium_info && Movie_info != Movie_number){
// 				System.out.println("error");
// 			}
// 		}
		String sql = "insert into schedule values (?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Schedule_no);
		System.out.println("zxcv"+Schedule_no);
		pstmt.setInt(2, Integer.parseInt(Auditorium_number));
		pstmt.setInt(3, Integer.parseInt(Movie_number));
		pstmt.setString(4, starttime);
		pstmt.setString(5, endtime);
		pstmt.execute();
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
	<table style="border : 1px solid">
		<tr>
		<td style="border : 1px solid">schedule_number</td>
		<td style="border : 1px solid">Auditorium_number</td>
		<td style="border : 1px solid">Movie_number</td>
		<td style="border : 1px solid">Start_time</td>
		<td style="border : 1px solid">End_time</td>
		</tr>

	<% 
		String test1 ="select * from schedule";
		pstmt = conn.prepareStatement(test1);
		ResultSet rs3 = pstmt.executeQuery();
		while(rs3.next()){
			int Schedule_number = rs3.getInt("Schedule_Number");
			int Auditorium_info = rs3.getInt("Auditorium_Number");
			String Movie_info = rs3.getString("Movie_Number");
			String start_info = rs3.getString("StartTime");
			String end_info = rs3.getString("EndTime");
			%>
			<tr>
				<td style="border : 1px solid"><%=Schedule_number %></td>
				<td style="border : 1px solid"><%=Auditorium_info %></td>
				<td style="border : 1px solid"><%=Movie_info %></td>
				<td style="border : 1px solid"><%=start_info %></td>
				<td style="border : 1px solid"><%=end_info %></td>	
			</tr>
			
			
			<%
		}%>
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