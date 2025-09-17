<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession session1 = request.getSession(false);
    if (session == null || !"faculty".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.html");
        return;
    }

    String courseId = request.getParameter("course_id");
    List<Map<String, String>> students = new ArrayList<>();

    try {
        Class.forName("oracle.jdbc.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "sms1", "sms1");

        PreparedStatement ps = con.prepareStatement("SELECT student_id, name FROM enrollments WHERE course_id = ?");
        ps.setString(1, courseId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, String> student = new HashMap<>();
            student.put("id", rs.getString("student_id"));
            student.put("name", rs.getString("name"));
            students.add(student);
        }

        con.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>

<html>
<head>
<title>Mark Attendance</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>Mark Attendance for Course ID: <%= courseId %></h2>
    <form action="submit_attendance.jsp" method="post">
        <input type="hidden" name="course_id" value="<%= courseId %>">
        <table border="1">
            <tr>
                <th>Student ID</th>
                <th>Name</th>
                <th>Present</th>
            </tr>
            <%
                for (Map<String, String> student : students) {
            %>
            <tr>
                <td><%= student.get("id") %></td>
                <td><%= student.get("name") %></td>
                <td>
                   <input type="checkbox" name="present" value="<%= student.get("id") %>" checked>

                </td>
            </tr>
            <% } %>
        </table>
        <br>
        <input type="submit" value="Submit Attendance">
    </form>
    <a href="faculty_home.jsp">Back to home</a>
</body>
</html>
