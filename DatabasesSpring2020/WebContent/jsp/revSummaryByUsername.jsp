<%@ page import = "java.sql.*" %>

<%
    if ((session.getAttribute("user") == null) || !(session.getAttribute("role").equals("Manager"))) {
        response.sendRedirect("../index.html");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Revenue Summary</title>
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
        if (!rs.next()){
            out.println("Error: User '" + username + "' Not Found");
            con.close();
            st.close();
            return;
        } else if (!rs.getString("role").equals("Customer")) {
            out.println("Error: '" + username + "' Is Not A Customer");
            con.close();
            st.close();
            return;
        } else {
            out.println("<h3>Customer Username: " + username + "</h3>");

            rs = st.executeQuery("SELECT IFNULL(SUM(total_fare + booking_fee), '0.00') FROM Reservations WHERE username='" + username + "'");
            if (rs.next()) {
                out.println("<h3>Total Revenue: $" + rs.getString(1) + "</h3>");
            }
        }
        con.close();
        st.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
