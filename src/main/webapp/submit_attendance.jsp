<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Home</title>
    <style>
    
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
    </style>
    <body>
     <a href="login.html" class="logout-btn">Logout</a>
<%
    String courseId = request.getParameter("course_id");
    String[] presentStudents = request.getParameterValues("present");

    Set<String> presentSet = new HashSet<>();
    if (presentStudents != null) {
        presentSet.addAll(Arrays.asList(presentStudents));
    }

    try {
        Class.forName("oracle.jdbc.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "sms1", "sms1");

        // Get all enrolled students with names
        PreparedStatement ps = con.prepareStatement("SELECT student_id, name FROM enrollments WHERE course_id = ?");
        ps.setString(1, courseId);
        ResultSet rs = ps.executeQuery();

        PreparedStatement insert = con.prepareStatement(
            "INSERT INTO attendance (course_id, student_id, name, date_attended, status) VALUES (?, ?, ?, SYSDATE, ?)");

        while (rs.next()) {
            String studentId = rs.getString("student_id");
            String studentName = rs.getString("name");
            String status = presentSet.contains(studentId) ? "Present" : "Absent";

            insert.setString(1, courseId);
            insert.setString(2, studentId);
            insert.setString(3, studentName);
            insert.setString(4, status);
            insert.executeUpdate();
        }

        con.close();
        out.println("<p style='color:green;'>Attendance saved successfully!</p>");
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>
</body>
</html>
