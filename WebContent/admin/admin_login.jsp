<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Admin Login</title>
</head>
<body>
	<h1>Admin Login</h1>
	<form action="admin_login_result.jsp">
		ID : <input type="text" name="id"><br>
		PASSWORD : <input type="password" name="password"><br>
		<input type="submit" value="login">
	</form>
	<a href="../login.jsp">Back</a>
</body>
</html>