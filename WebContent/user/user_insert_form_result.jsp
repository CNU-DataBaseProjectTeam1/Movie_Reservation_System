<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("euc-kr"); %>

<%
	String id = request.getParameter("id");
	String password = request.getParameter("passwd");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String address = request.getParameter("address");
	String phone= request.getParameter("phone");
	String point = "0";
	String vip =" ";
	

	Connection conn = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmtsearch = null;
	String str = "";
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		String searchid = "select id from user where id='"+id+"'";
		pstmtsearch = conn.prepareStatement(searchid);
		ResultSet rs = pstmtsearch.executeQuery();
		ArrayList<String> idlist = new ArrayList<String>();
		while(rs.next()){
			idlist.add(rs.getString("ID"));
		}
		if(idlist.contains(id)){
		str = "Fail";
		}
		else{
		String sql = "insert into user values(?, ?, ?, ?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, password);
		pstmt.setString(3, name);
		pstmt.setString(4, address);
		pstmt.setString(5, birth);
		pstmt.setString(6, phone);
		pstmt.setString(7, point);
		pstmt.setString(8, vip);
		pstmt.executeUpdate();
		
		str = "Complete to register User";}
		
	}catch(Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>
<h1>User insert Result</h1>
	<%=str %><br>
	<a href="login.jsp">Back</a>
</body>
</html>