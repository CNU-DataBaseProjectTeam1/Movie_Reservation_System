<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h2>회원가입폼</h2>

	<form method="post" action="user_insert_form_result.jsp">
		아이디 : <input type="text" name="id" maxlength="20"><br/>
		패스워드: <input type="password" name="passwd" maxlength="20"><br/>
		이름 : <input type="text" name="name" maxlength="20"><br/> 
		생일 : <input type="date" name="date"><br/> 
		주소 : <input type="text" name="address" maxlength="20"><br/> 
		휴대전화 : <input type="text" name="phone" maxlength="11"><br/> 
		
		
		<input type="submit" value="회원가입"> <input type="reset" value="다시입력">
		
	</form>
</body>
</html>