<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Customer Representative</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
<a class="admin_back_link" href='Manage.jsp'>Back To Admin Panel</a><br>
<%
    try {
        String username = request.getParameter("username");
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
        Statement st = con.createStatement();
        ResultSet rs;
        rs = st.executeQuery("SELECT * FROM Users WHERE username='" + username + "'");
        if (rs.next()) {
            out.println("Username '" + username + "' Already Exists");
            return;
        }

        st.executeUpdate("INSERT INTO Users (Username, role) VALUES ('" + username + "', 'Customer Representative')");
        con.close();
        st.close();
        out.println("New Customer Representative Successfully Created: '" + username + "' (default password is blank)");
    } catch (DataTruncation trunc) {
        out.println("Error: " + trunc.getMessage());
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
