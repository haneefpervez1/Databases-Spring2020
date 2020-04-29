<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Customer</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
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
                out.println("Error: User '" + new_username + "' Already Exists <br><a href='Manage.jsp'>Admin Panel</a>");
                return;
            }
        }

        String last_name = request.getParameter("lastname");
        String first_name = request.getParameter("firstname");
        String street_address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipcode = request.getParameter("zipcode");
        String phone = request.getParameter("telephone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        st.executeUpdate("UPDATE Users SET last_name ='" + last_name
                + "', first_name ='" + first_name
                + "', street_address ='" + street_address
                + "', city ='" + city
                + "', state ='" + state
                + "', zipcode ='" + zipcode
                + "', phone ='" + phone
                + "', email ='" + email
                + "', username ='" + new_username
                + "', password ='" + password
                + "' WHERE username = '" + old_username + "'");
        con.close();
        st.close();

        if (usernameChanged) {
            out.println("Customer Successfully Modified: '" + old_username + "'<br> New Username: '" + new_username + "'");
        } else {
            out.println("Customer Successfully Modified: '" + old_username + "'");
        }

        out.println("<br><a href='Manage.jsp'>Admin Panel</a>");

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
