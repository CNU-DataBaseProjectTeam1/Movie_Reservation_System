<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="admin_movie_insert_result.jsp">
		Title : <input type="text" name="title" maxlength="10"><br/>
		Director : <input type="text" name="director" maxlength="10"><br/>
		Info : <input type="text" name="info" maxlength="50"><br/>
		Actors : <input type="text" name="actors" maxlength="50"><br/>
		<input type="submit" value="입력완료"">
	</form>
</body>
</html>