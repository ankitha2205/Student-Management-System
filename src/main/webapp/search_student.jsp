<%@page import="java.sql.Driver"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <title>Search Student</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
         .top-bar {
  position: absolute;
  top: 20px;
  right: 20px;
  z-index: 100;
}

.search-form {
  display: flex;
}

.search-input {
  padding: 8px 12px;
  font-size: 14px;
  border: 2px solid #007bff;
  border-radius: 5px 0 0 5px;
  outline: none;
}

.search-button {
  padding: 8px 16px;
  background-color: #007bff;
  color: white;
  font-size: 14px;
  border: 2px solid #007bff;
  border-left: none;
  border-radius: 0 5px 5px 0;
  cursor: pointer;
}

.search-button:hover {
  background-color: #0056b3;
}

        h2 {
            text-align: center;
        }

        table {
            margin: auto;
            border-collapse: collapse;
            width: 70%;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        .message {
            text-align: center;
            margin-top: 20px;
            font-size: 18px;
            color: #555;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 30px;
        }
    </style>
</head>
<body>

<h2>🔍 Student Search Results</h2>

<%
String sql = "SELECT student_id,Name, email, course_id, marks FROM students WHERE student_id = ?";
String student_id = request.getParameter("student_id");
Integer id=Integer.parseInt(student_id);
try{
	 Class.forName("oracle.jdbc.OracleDriver");
	 Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "sms1", "sms1");
	 PreparedStatement ps = con.prepareStatement(sql);
      ps.setInt(1,id);
       ResultSet rs = ps.executeQuery();
    if (!rs.isBeforeFirst()) {
%>
    <h3>No student found for "<%= id %>"</h3>
<%
    } else {
%>
    <table>
        <tr>
            <th>Student Id</th>
            <th>Name</th>
            <th>Email</th>
            <th>Course_Id</th>
            <th>Marks</th>
            
        </tr>
<%
        while (rs.next()) {
%>
        <tr>
           <td><%= rs.getInt("student_id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getInt("course_id") %></td>
            <td><%= rs.getInt("marks") %></td>
        </tr>
<%
        }
    }
} catch (Exception e) {
%>
    <div class="message">Error: <%= e.getMessage() %></div>
    <%} %>

</table>

<a href="viewStudent.jsp" class="back-link">Back to Student Page</a>

</body>
</html>
