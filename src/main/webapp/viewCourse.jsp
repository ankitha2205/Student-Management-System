<%@ page import="java.sql.*" %>
<%@page import="java.sql.Driver"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Courses</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="top-bar">

<form action="search_course.jsp" method="get" class="search-form">
    <input type="text" name="course_id" class="search-input" placeholder="🔍 Search Course by ID or Name" required />
    <button type="submit" class="search-button">Search</button>
</form>
</div>
    <h2>All Courses</h2>
    <table>
        <tr>
            <th>ID</th><th>Name</th><th>Description</th>
        </tr>
<%
    try {
    	 Class.forName("oracle.jdbc.OracleDriver");
    	 Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "sms1", "sms1");
       
    	PreparedStatement ps = con.prepareStatement("SELECT * FROM courses");
    	 ResultSet rs = ps.executeQuery();
        while(rs.next()){
%>
        <tr>
            <td><%= rs.getInt("course_id") %></td>
            <td><%= rs.getString("course_name") %></td>
            <td><%= rs.getString("description") %></td>
        </tr>
<%
        }
    } catch(Exception e){ e.printStackTrace(); }

%>
    </table>
    <a href="admin_home.jsp">Back to Admin Dashboard</a>
</body>
</html>