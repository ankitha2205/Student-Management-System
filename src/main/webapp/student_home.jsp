<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession session1 = request.getSession(false);
    if (session == null || !"student".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.html");
        return;
    }
    


    String name = (String) session.getAttribute("studentName");
    String id = (String) session.getAttribute("studentId");
    String email = (String) session.getAttribute("studentEmail");
    String marks = (String) session.getAttribute("studentMarks");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Home</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #e0f7fa, #fce4ec);
            min-height: 100vh;
        }

        .logout-btn {
            position: absolute;
            top: 20px;
            right: 30px;
            background-color: #ff4081;
            color: white;
            padding: 10px 18px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
        }

        .logout-btn:hover {
            background-color: #e91e63;
        }

        .container {
            max-width: 600px;
            margin: 120px auto 40px auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        td {
            padding: 12px 20px;
            border-bottom: 1px solid #ddd;
            font-size: 16px;
        }

        td strong {
            color: #555;
        }
    </style>
</head>
<body>

    <a href="login.html" class="logout-btn">Logout</a>

    <div class="container">
        <h2>Welcome, <%= session.getAttribute("studentName") %>!</h2>
        <table>
            <tr><td><strong>ID:</strong></td><td><%= session.getAttribute("studentId") %></td></tr>
            <tr><td><strong>Email:</strong></td><td><%= session.getAttribute("studentEmail") %></td></tr>
            <tr><td><strong>Marks:</strong></td><td><%= session.getAttribute("studentMarks") %></td></tr>
            
<%
    int totalDays = 0;
    int presentDays = 0;
    double attendancePercentage = 0.0;

    try {
        Class.forName("oracle.jdbc.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "sms1", "sms1");

        PreparedStatement ps = con.prepareStatement(
            "SELECT status FROM attendance WHERE student_id = ?");
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            totalDays++;
            if ("Present".equalsIgnoreCase(rs.getString("status"))) {
                presentDays++;
            }
        }

        if (totalDays > 0) {
            attendancePercentage = (presentDays * 100.0) / totalDays;
        }

        con.close();
    } catch (Exception e) {
        out.println("<tr><td colspan='2' style='color:red;'>Error calculating attendance: " + e.getMessage() + "</td></tr>");
    }
%>

<tr>
    <td><strong>Attendance Percentage:</strong></td>
    <td><%= String.format("%.2f", attendancePercentage) %> %</td>
</tr>

        </table>
    </div>

</body>
</html>
