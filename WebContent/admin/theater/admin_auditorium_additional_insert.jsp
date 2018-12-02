<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>  
<%
	String theater_name = request.getParameter("theater_name");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Additional Auditorium Insert</title>
</head>
<body>
	<h1>Additional Auditorium Insert</h1>
	<form method="post" action="admin_auditorium_additional_insert2.jsp?theater_name=<%=theater_name %>">
		How many auditorium you add :
		<input type="text" name="Auditorium_Number"><br/>
		
		<input type="submit" value="Enter">
	</form>
	
	<a href="admin_theater_modify_page.jsp">Back</a>
</body>
</html>