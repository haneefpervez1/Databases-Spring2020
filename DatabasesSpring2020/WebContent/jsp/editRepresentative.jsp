<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Customer Representative</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
<a href='Manage.jsp'>Back To Admin Panel</a><br>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
        Statement st = con.createStatement();

        String old_username = request.getParameter("old_username");
        String new_username = request.getParameter("new_username");
        boolean usernameChanged = false;

        if (!new_username.equals(old_username)) {
            usernameChanged = true;
            ResultSet rs;
            rs = st.executeQuery("SELECT * FROM Users WHERE username='" + new_username + "'");
            if (rs.next()) {
                out.println("Error: User '" + new_username + "' Already Exists");
                return;
            }
        }

        String ssn = request.getParameter("ssn");
        String last_name = request.getParameter("lastname");
        String first_name = request.getParameter("firstname");
        String password = request.getParameter("password");

        st.executeUpdate("UPDATE Users SET ssn ='" + ssn
                + "', last_name ='" + last_name
                + "', first_name ='" + first_name
                + "', username ='" + new_username
                + "', password ='" + password
                + "' WHERE username = '" + old_username + "'");
        con.close();
        st.close();

        if (usernameChanged) {
            out.println("Customer Representative Successfully Modified: '" + old_username + "'<br> New Username: '" + new_username + "'");
        } else {
            out.println("Customer Representative Successfully Modified: '" + old_username + "'");
        }
    } catch (DataTruncation trunc) {
        out.println("Error: " + trunc.getMessage());
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
