<%@ page import="java.sql.*" %>
<%@page import="java.sql.Driver"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%
    HttpSession session1 = request.getSession(false);
    if (session == null || !"faculty".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.html");
        return;
    }
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Faculty Dashboard</title>
<style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #f3f4f6, #e0f7fa);
            min-height: 100vh;
        }

        .logout-btn {
            position: absolute;
            top: 20px;
            right: 30px;
            background-color: #ff5252;
            color: white;
            padding: 10px 18px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
        }

        .logout-btn:hover {
            background-color: #e53935;
        }
         h2 {
            text-align: center;
        }
        h3 {
            text-align: center;
        }

     
        table {
            border-collapse: collapse;
            width: 80%;
            margin-top: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        td strong {
            color: #555;
        }
        th {
            background-color: #007acc;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        a {
            color: #007acc;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        </style>
   <body>
    <h2>Welcome, <%= session.getAttribute("facultyName") %></h2>
    <h3>Available Courses</h3>
    <a href="login.html" class="logout-btn">Logout</a>
    

<%
    try {
    	Class.forName("oracle.jdbc.OracleDriver");
   	    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "sms1", "sms1");
        PreparedStatement ps = con.prepareStatement( "SELECT course_id, course_name FROM courses");
        ResultSet rs = ps.executeQuery();

       %> <table>
        <tr>
            <th>Course ID</th>
            <th>Course Name</th>
            <th>Action</th>
        </tr>
<%
    while(rs.next()){
        int course_id = rs.getInt("COURSE_ID");
        String course_name = rs.getString("COURSE_NAME");
%>
        <tr>
            <td><%= course_id %></td>
            <td><%= course_name %></td>
            <td><a href="mark_attendance.jsp?course_id=<%= course_id %>">Take Attendance</a></td>
        </tr>
<%
        }
    } catch(Exception e){
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>
</body>
</html>
