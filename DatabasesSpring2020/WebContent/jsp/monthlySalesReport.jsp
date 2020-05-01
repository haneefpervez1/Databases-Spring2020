<%@ page import = "java.sql.*, java.time.*" %>

<%
    if ((session.getAttribute("user") == null) || !(session.getAttribute("role").equals("Manager"))) {
        response.sendRedirect("../index.html");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Monthly Sales Report</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
<a class="admin_back_link" href='Manage.jsp'>Back To Admin Panel</a><br>
<%
    String[] month_year = request.getParameter("month_year").split(",");
    int month = Integer.parseInt(month_year[0]);
    int year = Integer.parseInt(month_year[1]);
    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
        Statement st = con.createStatement();

        ResultSet rs = st.executeQuery("SELECT IFNULL(SUM(total_fare + booking_fee), '0.00') FROM Reservations WHERE MONTH(res_date)=" + month + " AND YEAR(res_date)=" + year);
        if (rs.next()) {
            out.println("<h3>" + Month.of(month).name() + " " + year + "</h3>");
            out.println("<h3>Total Sales: $" + rs.getString(1) + "</h3>");
        }

        rs = st.executeQuery("SELECT * FROM Reservations WHERE MONTH(res_date)=" + month + " AND YEAR(res_date)=" + year);
        if (!rs.next()) {
            out.println("No reservations found for " + month + year);
        } else { %>
            <h3>Reservations:</h3>
            <table>
                <tr>
                    <th>Reservation Number</th>
                    <th>Date Created</th>
                    <th>Passenger Username</th>
                    <th>Departure Date/Time</th>
                    <th>Class</th>
                    <th>Seat Number</th>
                    <th>Total Fare</th>
                    <th>Booking Fee</th>
                    <th>Customer Representative</th>
                </tr>
                    <% do { %>
                <tr>
                    <td><%=rs.getString("res_num")%></td>
                    <td><%=rs.getString("res_date")%></td>
                    <td><%=rs.getString("username")%></td>
                    <td><%=rs.getString("dep_datetime")%></td>
                    <td><%=rs.getString("class")%></td>
                    <td><%=rs.getString("seat_num")%></td>
                    <td><%=rs.getString("total_fare")%></td>
                    <td><%=rs.getString("booking_fee")%></td>
                    <td><%=rs.getString("cust_rep")%></td>
                </tr>
                    <% } while (rs.next());
        }
        con.close();
        st.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
