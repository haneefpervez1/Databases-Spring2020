<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Revenue Summary</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
<a href='Manage.jsp'>Back To Admin Panel</a><br>
<%
    String destCity = request.getParameter("destCity");
    out.println("<h3>Destination City: " + destCity + "</h3>");

    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
        Statement st = con.createStatement();

        ResultSet rs = st.executeQuery("SELECT SUM(total_fare + booking_fee) FROM Reservations r JOIN Stations s ON r.dest_station=s.sid WHERE city='"+ destCity + "'");
        if (rs.next()) {
            out.println("<h3>Total Revenue: $" + rs.getString(1) + "</h3>");
        }

        con.close();
        st.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
