<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Student Controller</title>
</head>
<body>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if(email != null && password != null && !email.trim().isEmpty() && !password.trim().isEmpty()){
        String role = null;

        try {
            Class.forName("oracle.jdbc.OracleDriver");
            Connection con = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "sms1", "sms1");

            // Check admin table
            PreparedStatement psAdmin = con.prepareStatement(
                "SELECT * FROM admin WHERE email=? AND password=?");
            psAdmin.setString(1, email);
            psAdmin.setString(2, password);
            ResultSet rsAdmin = psAdmin.executeQuery();

            if(rsAdmin.next()){
                role = "admin";
            } else {
                // Check students table
                PreparedStatement psStudent = con.prepareStatement(
                    "SELECT * FROM students WHERE email=? AND password=?");
                psStudent.setString(1, email);
                psStudent.setString(2, password);
                ResultSet rsStudent = psStudent.executeQuery();

                if(rsStudent.next()){
                    role = "student";
                    session.setAttribute("studentName", rsStudent.getString("name"));
                    session.setAttribute("studentId", rsStudent.getString("student_id"));
                    session.setAttribute("studentEmail", rsStudent.getString("email"));
                    session.setAttribute("studentMarks", rsStudent.getString("marks"));
                } else {
                    // Check faculty table
                    PreparedStatement psFaculty = con.prepareStatement(
                        "SELECT * FROM faculty WHERE email=? AND password=?");
                    psFaculty.setString(1, email);
                    psFaculty.setString(2, password);
                    ResultSet rsFaculty = psFaculty.executeQuery();

                    if(rsFaculty.next()){
                        role = "faculty";
                        session.setAttribute("facultyName", rsFaculty.getString("name"));
                        session.setAttribute("facultyId", rsFaculty.getString("faculty_id"));
                    }

                    rsFaculty.close();
                    psFaculty.close();
                }

                rsStudent.close();
                psStudent.close();
            }

            rsAdmin.close();
            psAdmin.close();
            con.close();

            if(role != null){
                session.setAttribute("email", email);
                session.setAttribute("role", role);
                session.setMaxInactiveInterval(30 * 60); // Optional timeout

                if("admin".equals(role)){
                    response.sendRedirect("admin_home.jsp");
                } else if("student".equals(role)){
                    response.sendRedirect("student_home.jsp");
                } else if("faculty".equals(role)){
                    response.sendRedirect("faculty_home.jsp");
                }
            } else {
                out.println("<p style='color:red;'>Invalid email or password.</p>");
                out.println("<a href='login.html'>Back to Login</a>");
            }

        } catch(Exception e){
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }

    } else {
        response.sendRedirect("login.html");
    }
 
%>

</body>
</html>