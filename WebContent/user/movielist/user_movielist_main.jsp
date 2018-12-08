<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	String id = (String) request.getSession().getAttribute("ID");
	request.getSession().setAttribute("ID", id);

	Connection conn = null;
	PreparedStatement pstmt = null;

	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		//make counter
		String counter = "select * from movie";
		pstmt = conn.prepareStatement(counter);
		ResultSet movie_counter = pstmt.executeQuery();
		movie_counter.last();
		String for_Movie_Number_Count = movie_counter.getString("Movie_Number");
		int[] count = new int[Integer.parseInt(for_Movie_Number_Count) + 1];
		int[] rate = new int[Integer.parseInt(for_Movie_Number_Count) + 1];
		String[] title = new String[Integer.parseInt(for_Movie_Number_Count) + 1];
		
		//1, reservation to print reservation number and seat number
		String sql = "select * from reservation";
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<style>
#customers {
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
	width: 80%;
}

#customers td, #customers th {
	border: 1px solid #ddd;
	padding: 8px;
}

#customers tr:nth-child(even) {
	background-color: #EFFBFB;
}

#customers tr:hover {
	background-color: #ddd;
}

#customers th {
	padding-top: 12px;
	padding-bottom: 12px;
	text-align: left;
	background-color: #4CAF50;
	color: white;
}
input[type=submit] {
  background-color: transparent;
  border: 0;
  border-radius: 5px;
  cursor: pointer;
  color: black;
  font-size:12px;
  font-weight: bold;
  line-height: 1.4;
  padding: 10px;
  width: 180px
}
</style>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		while (rs.next()) {
				//2, seat to print schedule number
				String Seat_Number = rs.getString("Seat_Number");
				String sql1 = "select * from seat where Seat_Number = ?";
				pstmt = conn.prepareStatement(sql1);
				pstmt.setInt(1, Integer.parseInt(Seat_Number));
				ResultSet rs1 = pstmt.executeQuery();
				while (rs1.next()) {
					//3, schedule to print movie_number
					String Schedule_Number = rs1.getString("Schedule_Number");
					String sql2 = "select * from schedule where Schedule_Number = ?";
					pstmt = conn.prepareStatement(sql2);
					pstmt.setInt(1, Integer.parseInt(Schedule_Number));
					ResultSet rs2 = pstmt.executeQuery();

					rs2.next();
					// 4, get movie info
					String Movie_Number = rs2.getString("Movie_Number");
					count[Integer.parseInt(Movie_Number)] = count[Integer.parseInt(Movie_Number)] + 1;
					String sql3 = "select * from movie where Movie_Number =?";
					pstmt = conn.prepareStatement(sql3);
					pstmt.setInt(1, Integer.parseInt(Movie_Number));
					ResultSet rs3 = pstmt.executeQuery();
					rs3.next();
					String Title = rs3.getString("Title");
					
				}
			}
	
	int all_count=0;
	for(int i=0; i<count.length; i++){
		all_count=all_count+count[i];
		
	}
	for(int i=0; i<rate.length; i++){
		rate[i] = count[i]/all_count;
	}

	String movie_title = "select * from movie";
	pstmt = conn.prepareStatement(movie_title);
	ResultSet movietitle = pstmt.executeQuery();
	
	%>
		<table id="customers">
			<tr>
				<td>Title</td>
				<td>Rate</td>
				<td>info</td>
			</tr>
			<% 
				int i=0;
				while(movietitle.next()){
					++i;
					String m_title = movietitle.getString("Title");	
					title[i]=m_title;
				}
				for (int s = 1; s < rate.length; s++) {
			         for(int t = 1; t < rate.length - 1; t++) {
			             if (rate[t] <= rate[t + 1]) {
			                 int temp = rate[t];
			                 String temp2 = title[t];
			                 title[t] = title[t+1];
			                 rate[t] = rate[t+1];
			                 title[t+1] = temp2;
			                 rate[t + 1] = temp;
			             }
			         }
			     }
			%>
			<%for(int j=1; j<title.length; j++){%>
			
				<tr>
					<td><%=title[j] %></td>
					<td><%=rate[j] %></td>
					<td>
					<form action="user_movielist_movieinfo.jsp" method ="get">
					<input type="hidden"  name="movie_title" value="<%=title[j]%>">
					<input type="submit" id="submit" value="show information"></td>
					</form>
				</tr>
			<% }%>
			
		</table>
	

</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>