<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h2>Sign Up</h2>

	<form method="post" action="user_form_insert_result.jsp">
		ID : <input type="text" name="id" maxlength="20"><br/>
		PASSWORD: <input type="password" name="passwd" maxlength="20"><br/>
		NAME : <input type="text" name="name" maxlength="20"><br/> 
		BIRTH : <input type="date" name="date"><br/> 
		ADDRESS : <input type="text" name="address" maxlength="20"><br/> 
		PHONE : <input type="text" name="phone" maxlength="11"><br/> 
		
		
		<input type="submit" value="SIGN UP"> <input type="reset" value="RESET">
		
	</form>
</body>
</html>