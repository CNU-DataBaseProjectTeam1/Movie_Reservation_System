<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%
	String id = (String) request.getSession().getAttribute("ID");
	request.getSession().setAttribute("ID", id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title>User Drop Out</title>
</head>
<body>
	<h2>User Drop Out</h2>
	
	<form method="post" action="user_form_delete_result.jsp">
		Really Delete?
		<input type="submit" value="Enter">
	</form>
</body>
</html>