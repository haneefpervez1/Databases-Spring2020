<%@ page import = "java.sql.*, java.time.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Monthly Sales Report</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
<%
    try {
        int month = Integer.parseInt(request.getParameter("month"));
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
        Statement st = con.createStatement();

        ResultSet rs = st.executeQuery("SELECT SUM(total_fare + booking_fee) FROM Reservations WHERE MONTH(res_date)="+month);
        if (rs.next()) {
            out.println("<h3>" + Month.of(month).name() + "<br>Total Sales: $" + rs.getString(1) + "</h3>");
        }

        con.close();
        st.close();
        out.println("<br><a href='Manage.jsp'>Admin Panel</a>");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
