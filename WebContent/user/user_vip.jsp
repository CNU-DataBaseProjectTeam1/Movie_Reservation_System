<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	String id = (String) request.getSession().getAttribute("ID");
	request.getSession().setAttribute("ID", id);
	Date today = new Date();
	 
	Connection conn = null;
	PreparedStatement pstmt = null;
	SimpleDateFormat month = new SimpleDateFormat("MM");

	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		ArrayList<String> user_id = new ArrayList<String>();
		String user_counter = "select ID, COUNT(*) as count from reservation where reservation_time=? group by ID order by count desc;";
		pstmt = conn.prepareStatement(user_counter);
		pstmt.setString(1, month.format(today));
		ResultSet user_ = pstmt.executeQuery();	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>User Management</title>
<style>
#customers {
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
	width: 100%;
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
</style>
</head>
<body>
<h2>Ranking</h2>
<table id="customers">
<tr>
	<td>Rank</td>
	<td>User</td>
	<td>total</td>
	<td>type</td>
</tr>
<%
	int i=1;
	while(user_.next()){
		String ID = user_.getString("ID");
		String count= user_.getString("count");
		
		%>
		<tr>
		<td><%=i %></td>
		<td><%=ID %></td>
		<td><%=count %></td>
		<td><%
		if(i<11){
			out.print("VIP");
		}
		else{
			out.print("User");
		}
		%>
		</tr>
		<%
		i++;
	}
%>
</table>
</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>