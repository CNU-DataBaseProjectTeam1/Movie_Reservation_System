<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Theater Insert</title>
</head>
<body>
	<h1>Theater Insert</h1>
	<form method="post" action="admin_theater_insert_result.jsp">
		Theater Name :
		<input type="text" name="Theater_Name"><br/>
		Address :
		<input type="text" name="Address"><br/>
		Phone Number :
		<input type="text" name="Phone_Number"><br/>
		Auditorium Number :
		<input type="text" name="Auditorium_Number"><br/>
		
		<input type="submit" value="Enter">
	</form>
	
	<br>
	<a href="admin_theater_page.jsp">Back</a>
</body>
</html>