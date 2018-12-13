<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("euc-kr");
%>

<%
	String id = (String) request.getSession().getAttribute("ID");
	String passwd = "";
	String name = "";
	String address = "";
	String birth = "";
	String phone = "";

	Connection conn = null;
	PreparedStatement pstmt = null;

	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		// rating
		String test = "select * from user where id=?";

		pstmt = conn.prepareStatement(test);
		pstmt.setString(1, id);

		ResultSet rs = pstmt.executeQuery();
		rs.next();

		passwd = rs.getString("Password");
		name = rs.getString("Name");
		address = rs.getString("Address");
		birth = rs.getString("Birth");
		phone = rs.getString("PhoneNumber");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>User Modify</title>
</head>
<body>
	<h1>
		Modify :
		<%=name%>
		information
	</h1>
	<form method="post" action="user_form_modify_result.jsp?ID=<%=id%>">
		password : <input type="password" name="passwd" value="<%=passwd%>" /><br>
		name : <input type="text" name="name" value="<%=name%>" /><br>
		address : <input type="text" name="address" value="<%=address%>"/><br>
		birth : <input type="text" name="birth" value="<%=birth%>" /><br>
		phone : <input type="text" name="phone" value="<%=phone%>" /><br>
		<input type="submit" value="Enter">
	</form>

	<a href="user_page.jsp">Back</a>
</body>
</html>

<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>