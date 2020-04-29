<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete User</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
<a href='Manage.jsp'>Back To Admin Panel</a><br>
<%
    try {
        String username = request.getParameter("username");
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
        Statement st = con.createStatement();
        ResultSet rs;
        rs = st.executeQuery("SELECT * FROM Users WHERE username='" + username + "'");
        if (!rs.next()){
            out.println("Error: User '" + username + "' Not Found");
            return;
        }

        st.executeUpdate("DELETE FROM Users WHERE username='" + username + "'");
        con.close();
        st.close();
        out.println("User Successfully Deleted: " + username);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
