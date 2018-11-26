<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
	String theater_name = (String) request.getSession().getAttribute("Theater_Name");
	String auditorium_number = (String) request.getSession().getAttribute("Auditorium_Number");
	int auditorium_count = Integer.parseInt(auditorium_number);
	
	request.getSession().setAttribute("Theater_Name", theater_name);
	request.getSession().setAttribute("Auditorium_Number", auditorium_number);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Auditorium Insert</title>
</head>
<body>
	<h1><%=theater_name %> : Auditorium Insert</h1>
	<form action="admin_auditorium_insert_result.jsp">
	<%
		for (int i = 0; i < auditorium_count; i++) {
			%>
				Auditorium<%=i+1 %>'s seat count : 
				<input type="number" name="auditorium<%=i+1 %>"><br>	
			<%
		}
	%>
		<input type="submit" value="Enter">
	</form>
</body>
</html>