<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("euc-kr");
%>

<%
	String name = request.getParameter("movie_name");
	int movie_number = 0;
	int update_number =0;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String str = "";
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		String sql = "select Movie_Number from movie where title=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		rs = pstmt.executeQuery();
		rs.next();
		movie_number = rs.getInt("Movie_number");
		sql = "delete from movie where Movie_Number=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, movie_number);
		pstmt.executeUpdate();
		System.out.println(movie_number);
		if (movie_number!=0) {
			str = name + " 삭제 되었습니다.";
		} else {
			str = "삭제 실패";
		}
		sql = "select count(*) from movie where Movie_Number";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		rs.next();
		update_number = rs.getInt(1);
		while(update_number !=0){
			
			sql="update movie set Movie_Number =? where Movie_Number=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, movie_number);
			pstmt.setInt(2, (movie_number+1));
			pstmt.executeUpdate();
			movie_number++;
			update_number--;

		}
	} catch (Exception e) {
		e.printStackTrace();
		str = "삭제 실패";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset = EUC-KR">
<title>Movie delete</title>
</head>
<body>
	<h1>movie delete Result</h1>
	<%=str%>
	</br>
	<a href="admin_movie_page.jsp">Back</a>
</body>
</html>

