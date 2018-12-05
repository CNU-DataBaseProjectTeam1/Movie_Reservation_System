<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<% 
	String Movie_number = request.getParameter("Movie_number");
	String Auditorium_number = request.getParameter("theater_info");
	String starttime = request.getParameter("start");
	String endtime = request.getParameter("end");
	
	String str="";
	Connection conn = null;
	PreparedStatement pstmt = null;
	int a=0;
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
			String Schedule_Number = rs1.getString("Schedule_Number");
			a = Integer.parseInt(Schedule_Number);
			if(rs1==null){
				a=0;
			}
		}
		// 예외처림 해야됨 (exception needed)
		String test ="select * from schedule";
		pstmt = conn.prepareStatement(test);
		ResultSet rs2 = pstmt.executeQuery();
		while(rs2.next()){
			String Schedule_Number = rs2.getString("Schedule_Number");
			int Auditorium_info = rs2.getInt("Auditorium_Number");
			String Movie_info = rs2.getString("Movie_Number");
			String start_info = rs2.getString("StartTime");
			String end_info = rs2.getString("EndTime");
			
			if(Integer.parseInt(Auditorium_number) == Auditorium_info && Movie_info != Movie_number){
				System.out.println("error");
			}
		}
		a++;
		String sql = "insert into schedule values (?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, a);
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
	<%=a %>번째에
	Auditorium_number랑 Movie_number,<br>
	Start Time <%=starttime %> <br>
	End Time <%=endtime %> <br>
	스케쥴이 추가 되었습니다.
</body>
</html>

<%
	} catch (Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>