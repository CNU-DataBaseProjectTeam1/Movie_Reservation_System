<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String theater_name = request.getParameter("Theater_Name");
	String address = request.getParameter("Address");
	String phone_number = request.getParameter("Phone_Number");
	String auditorium_number = request.getParameter("Auditorium_Number");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie_reservation";
		String dbId = "root";
		String dbPass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		String sql = "insert into theater values(?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, theater_name);
		pstmt.setString(2, address);
		pstmt.setString(3, phone_number);
		pstmt.setString(4, "0");
		pstmt.executeUpdate();
		
		request.getSession().setAttribute("Theater_Name", theater_name);
		request.getSession().setAttribute("Auditorium_Number", auditorium_number);
		response.sendRedirect("admin_auditorium_insert.jsp");
		
		}catch(Exception e) {
			e.printStackTrace();
		}
%>