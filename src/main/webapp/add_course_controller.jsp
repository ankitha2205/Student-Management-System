<%@page import="java.sql.Driver"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Course Controller</title>
</head>
<body>
<%

String INSERT_COURSES= "insert into students values(?, ?, ?)";
String id=request.getParameter("id");
Integer course_id=Integer.parseInt(id);
String Name=request.getParameter("name");
String description=request.getParameter("description");

try{
	 Class.forName("oracle.jdbc.OracleDriver");
	 Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "sms1", "sms1");
	 PreparedStatement ps = con.prepareStatement(INSERT_COURSES);
    ps.setInt(1,course_id);
    ps.setString(2,Name);
    ps.setString(3,description);
   
    int  i = ps.executeUpdate();
   
   if(i>0){%>
   	<h1>Course added successfully.."</h1>
  <% } else {%>
     <h1>Course insertion failed..</h1>
  <% }
}catch(Exception e){e.printStackTrace();}%>
</body>
</html>