<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
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

        .dashboard-container {
            max-width: 600px;
            margin: 120px auto;
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 30px;
        }

        .dashboard-container a {
            display: block;
            margin: 12px auto;
            padding: 12px 20px;
            width: 70%;
            background-color: #00bcd4;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .dashboard-container a:hover {
            background-color: #0097a7;
        }
    </style>
</head>
<body>

    <a href="login.html" class="logout-btn">Logout</a>

    <div class="dashboard-container">
        <h2>Admin Dashboard</h2>
        <a href="addStudents.html">Add Student</a>
        <a href="viewStudent.jsp">View Students</a>
        <a href="addCourses.html">Add Course</a>
        <a href="viewCourse.jsp">View Courses</a>
        <a href="delete_student.jsp">Delete Student</a>
    </div>

</body>
</html>
