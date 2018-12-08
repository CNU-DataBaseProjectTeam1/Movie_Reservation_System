<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<%
	String id = (String) request.getSession().getAttribute("ID");
	request.getSession().setAttribute("ID", id);
	
	String Movie_Title= request.getParameter("Movie_title");
 	String Movie_Number = request.getParameter("Movie_Number1");
 	ArrayList auditorium_num = new ArrayList();
 	ArrayList theater_Name = new ArrayList();
	String str = "";
	Connection conn = null;
	PreparedStatement pstmt = null;
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		String find_schedule_name = "select * from schedule where Movie_Number=?";
		pstmt = conn.prepareStatement(find_schedule_name);
		pstmt.setInt(1, Integer.parseInt(Movie_Number));
		ResultSet rs1 = pstmt.executeQuery();
		
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h2><%=Movie_Title %></h2> is selected
<%

	while(rs1.next()){
		int Auditorium_Number = rs1.getInt("Auditorium_Number");
		System.out.print(Auditorium_Number);
		auditorium_num.add(Auditorium_Number);
	}
	// auditorium을 통해서 theater 이름 가져오기
	for(int i=0; i<auditorium_num.size(); i++){
		String find_auditorium = "select * from auditorium where Auditorium_Number =?";
		pstmt = conn.prepareStatement(find_auditorium);
		pstmt.setInt(1, (int)auditorium_num.get(i));
		ResultSet rs2 = pstmt.executeQuery();
		rs2.next();
		String Theater_Name_ = rs2.getString("Theater_Name");
		theater_Name.add(Theater_Name_);
	}
	%>
	<form action="user_reservation_time.jsp" method="get">
	<input type="hidden" name="movie_number" value="<%=Movie_Number%>">
	<select name="theater_Name">
	<%
		int j=0;
		for(int i=0; i<theater_Name.size();i++){
			%>	
				<option><%=(String)theater_Name.get(i) %></option>
				j=i;
			<%
		}
		
	%>
	<input type="hidden" name="auditorium_num" value="<%=(int)auditorium_num.get(j) %>">
				
	</select>
	<input type="submit" value="time book">
	</form>
</body>
</html>
<%
}catch(Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>
