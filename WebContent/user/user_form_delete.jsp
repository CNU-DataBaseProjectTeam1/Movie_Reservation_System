<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title>회원탈퇴</title>
</head>
<body>
	<h2>회원탈퇴</h2>
	
	<form method="post" action="user_form_delete_result.jsp">
		아이디 : <input type="text" name="id" placeholder="really delete?" maxlength="12"><br/>
		<input type="submit" value="입력완료">
	</form>
</body>
</html>