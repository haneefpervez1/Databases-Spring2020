<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Customer Representative</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
        Statement st = con.createStatement();

        String ssn = request.getParameter("ssn");
        String last_name = request.getParameter("lastname");
        String first_name = request.getParameter("firstname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        st.executeUpdate("UPDATE Users SET ssn ='" + ssn
                + "', last_name ='" + last_name
                + "', first_name ='" + first_name
                + "', password ='" + password
                + "' WHERE username = '" + username + "'");

        out.println("Customer Representative Successfully Modified: '" + username + "'<br><a href='Manage.jsp'>Admin Panel</a>");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
