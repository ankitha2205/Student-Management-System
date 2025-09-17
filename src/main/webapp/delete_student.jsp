<%@page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Student</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background: #f4f4f4;
        margin: 0;
        padding: 0;
    }
    .container {
        width: 400px;
        margin: 80px auto;
        background: #fff;
        padding: 30px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        border-radius: 8px;
    }
    h1 {
        text-align: center;
        color: #333;
    }
    form {
        display: flex;
        flex-direction: column;
    }
    label {
        margin-bottom: 8px;
        font-weight: bold;
    }
    input[type="number"] {
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    input[type="submit"] {
        background-color: #007BFF;
        color: white;
        padding: 10px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-weight: bold;
    }
    input[type="submit"]:hover {
        background-color: #0056b3;
    }
    .message {
        margin-top: 20px;
        text-align: center;
        font-size: 18px;
        color: #444;
    }
</style>
</head>
<body>
<div class="container">
    <h1>Delete Student</h1>
    <form method="post">
        <label for="id">Student ID:</label>
        <input type="number" name="id" id="id" required>
        <input type="submit" value="Delete Student">
    </form>

    <%
    String id = request.getParameter("id");
    if (id != null && !id.trim().isEmpty()) {
        try {
            Integer student_id = Integer.parseInt(id);

            Class.forName("oracle.jdbc.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "sms1", "sms1");

            String DELETE_STUDENTS = "delete from students where student_id= ?";
            PreparedStatement ps = con.prepareStatement(DELETE_STUDENTS);
            ps.setInt(1, student_id);

            int i = ps.executeUpdate();

            if (i > 0) {
                out.println("<div class='message'>✅ Student deleted successfully.</div>");
            } else {
                out.println("<div class='message'>⚠️ Student deletion failed.</div>");
            }

            ps.close();
            con.close();
        } catch (NumberFormatException e) {
            out.println("<div class='message'>❌ Invalid ID format.</div>");
        } catch (Exception e) {
            out.println("<div class='message'>❌ Error occurred: " + e.getMessage() + "</div>");
        }
    } else if (request.getMethod().equalsIgnoreCase("post")) {
        out.println("<div class='message'>⚠️ Please enter a valid student ID.</div>");
    }
    %>
</div>
</body>
</html>
