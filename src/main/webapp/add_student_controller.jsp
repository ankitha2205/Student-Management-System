<%@page import="java.sql.Driver"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Student Controller</title>
</head>
<body>

<%
String INSERT_STUDENT = "insert into students values(?, ?, ?, ?, ?, ?)";
String id=request.getParameter("id");
Integer student_id=Integer.parseInt(id);
String Name=request.getParameter("name");
String email=request.getParameter("email");
String password=request.getParameter("password");
String course=request.getParameter("course");
Integer course_id=Integer.parseInt(course);
String marks=request.getParameter("marks");
Integer student_marks=Integer.parseInt(marks);

try{
	 Class.forName("oracle.jdbc.OracleDriver");
	 Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "sms1", "sms1");
	 PreparedStatement ps = con.prepareStatement(INSERT_STUDENT);
     ps.setInt(1,student_id);
     ps.setString(2,Name);
     ps.setString(3,email);
     ps.setString(4,password);
     ps.setString(5,course);
     ps.setInt(6,student_marks);
    
    int  i = ps.executeUpdate();
    
    if(i>0){%>
    	<h1>Student added successfully.."</h1>
   <% } else {%>
      <h1>Student insertion failed..</h1>
   <% }
}catch(Exception e){e.printStackTrace();}

%>
<a href="add_student.html">click here</a>

</body>
</html>