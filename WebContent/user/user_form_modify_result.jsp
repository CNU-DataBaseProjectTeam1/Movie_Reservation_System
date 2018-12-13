<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("euc-kr");
%>

<%
	String id = (String) request.getSession().getAttribute("ID");
	String password = request.getParameter("passwd");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String address = request.getParameter("address");
	String phone = request.getParameter("phone");
	System.out.println(id);

	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		String sql = "update user set Password=?, Name =?, Address =?, Birth =?, PhoneNumber =? where ID=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, password);
		pstmt.setString(2, name);
		pstmt.setString(3, address);
		pstmt.setString(4, birth);
		pstmt.setString(5, phone);
		pstmt.setString(6, id);

		pstmt.executeUpdate();

		str = "Complete";
	} catch (Exception e) {
		e.printStackTrace();
		str = "Fail";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>User Modify Result</title>
</head>
<body>
	<h1>User Modify Result</h1>
	<%=str%>
	</br>
	<a href="user_page.jsp">Back</a>
</body>
</html>