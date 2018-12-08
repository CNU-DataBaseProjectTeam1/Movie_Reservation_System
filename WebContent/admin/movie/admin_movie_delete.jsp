<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title>Movie delete</title>
</head>
<body>
	<h2>Movie delete</h2>
	
	<form method="post" action="admin_movie_delete_result.jsp">
		영화제목 : <input type="text" name="movie_name" placeholder="really delete?" maxlength="12"><br/>
		<input type="submit" value="입력완료">
	</form>
</body>
</html>