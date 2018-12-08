<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<% request.setCharacterEncoding("euc-kr"); %>

<%
   String id = request.getParameter("id");
   
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   String str = "";
   try{
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
      String dbId = "root";
      String dbPass = "1234";
      
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
      
      String sql = "delete from user where id=?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, id);
      pstmt.executeUpdate();
      str = id+"삭제 되었습니다.";
   }catch(Exception e){
	   e.printStackTrace();
	   str ="삭제 실패";
   }
      
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset = EUC-KR">
<title>User delete</title>
</head>
<body>
	<h1>user delete Result</h1>
	<%=str%>
	</br>
	<a href="WebConetent/login.jsp">Back</a>
</body>
</html>

