<%@page import="java.sql.Driver"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Course</title>
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

<h2>🔍 Course Search Results</h2>

<%
String sql = "SELECT course_id, course_name, description FROM courses WHERE course_id = ?";
String course_id = request.getParameter("course_id");
Integer id=Integer.parseInt(course_id);
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "sms1", "sms1");
    Statement st = con.createStatement();
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, course_id);
   
    ResultSet rs = ps.executeQuery();
    if (!rs.isBeforeFirst()) {
%>
    <h3>No student found for "<%= id %>"</h3>
<%
    } else {
%>
    <table>
        <tr>
            <th>Course Id</th>
            <th>Name</th>
            <th>Description</th>
        </tr>
<%
        while (rs.next()) {
%>
        <tr>
            <td><%= rs.getInt("course_id") %></td>
            <td><%= rs.getString("course_name") %></td>
            <td><%= rs.getString("description") %></td>
        </tr>
<%
        }
    }
} catch (Exception e) {
%>
    <div class="message">Error: <%= e.getMessage() %></div>
    <%} %>

</table>

<a href="viewCourse.jsp" class="back-link">Back to Course Page</a>

</body>
</html>
