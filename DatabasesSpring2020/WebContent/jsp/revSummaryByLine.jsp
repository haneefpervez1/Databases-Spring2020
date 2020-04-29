<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Revenue Summary</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
<%
    String line = request.getParameter("line");
    out.println("<h3>Transit Line: " + line + "</h3>");

    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
        Statement st = con.createStatement();

        ResultSet rs = st.executeQuery("SELECT SUM(total_fare + booking_fee) FROM Reservations r JOIN Train_Schedule ts ON r.scheduleID=ts.scheduleID WHERE transitlinename='" + line + "'");
        if (rs.next()) {
            out.println("<h3>Total Sales: $" + rs.getString(1) + "</h3>");
        }

        con.close();
        st.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<br>
<a href='Manage.jsp'>Admin Panel</a>
</body>
</html>
