<%@ page import = "java.sql.*, java.time.*" %>

<%
    if ((session.getAttribute("user") == null) || !(session.getAttribute("role").equals("Manager"))) {
        response.sendRedirect("../index.html");
    } else {
        out.println("<a href='Logout.jsp'>Log Out</a><br>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
    <script>
        function manageUserFieldEmpty() {
            if (document.getElementById('username').value === "") {
                alert("Error: Username Missing");
                return true;
            }
            return false;
        }

        function addCustomer() {
            if (manageUserFieldEmpty()) return;
            let form = document.getElementById('manageUserForm');
            form.action = 'addCustomer.jsp';
            form.submit();
        }

        function addRepresentative() {
            if (manageUserFieldEmpty()) return;
            let form = document.getElementById('manageUserForm');
            form.action = 'addRepresentative.jsp';
            form.submit();
        }

        function editUser() {
            if (manageUserFieldEmpty()) return;
            let form = document.getElementById('manageUserForm');
            form.action = 'editUser.jsp';
            form.submit();
        }

        function deleteUser() {
            if (manageUserFieldEmpty()) return;
            let form = document.getElementById('manageUserForm');
            form.action = 'deleteUser.jsp';
            form.submit();
        }

        function searchResUserFieldEmpty() {
            if (document.getElementById('searchResUsername').value === "") {
                alert("Error: Username Missing");
                return true;
            }
            return false;
        }

        function searchResByUsername() {
            if (searchResUserFieldEmpty()) return;
            let form = document.getElementById('searchResByUsernameForm');
            form.action = 'searchResByUsername.jsp';
            form.submit();
        }

        function revSummaryByUsernameFieldEmpty() {
            if (document.getElementById('revSummaryUsername').value === "") {
                alert("Error: Username Missing");
                return true;
            }
            return false;
        }

        function revSummaryByUsername() {
            if (revSummaryByUsernameFieldEmpty()) return;
            let form = document.getElementById('revSummaryByUsernameForm');
            form.action = 'revSummaryByUsername.jsp';
            form.submit();
        }
    </script>
</head>
<body>

<!-- Add, Edit and Delete information for an employee/customer -->
<div class="col">
    <h3>Manage User</h3>
    <form id="manageUserForm" method="post">
        <label for="username">Username:</label><br>
        <input type="text" id="username" name="username">
        <input type="button" onclick="addCustomer()" value="New Customer">
        <input type="button" onclick="addRepresentative()" value="New Representative">
        <input type="button" onclick="editUser()" value="Edit User">
        <input type="button" onclick="deleteUser()" value="Delete User">
    </form>
</div>

<!-- Obtain a sales report for a particular month (total revenue per month) -->
<div class="col">
    <h3>Monthly Sales Report</h3>
    <form action="monthlySalesReport.jsp" method="post">
        <label for="month">Month:</label>
        <select id="month" name="month">
            <%
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
                Statement st = con.createStatement();
                ResultSet rs;
                rs = st.executeQuery("SELECT DISTINCT MONTH(res_date) FROM Reservations");
                while (rs.next()) { %>
                    <option value="<%=rs.getString(1)%>"><%=Month.of(Integer.parseInt(rs.getString(1))).name()%></option>
                <% }
                con.close();
                st.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
        </select>
        <input type="submit" value="View">
    </form>
</div>

<!-- Produce a list of reservations by transit line and train number or by customer name -->
<div class="col">
    <h3>Search Reservations</h3>
    <form action="searchResByLineAndNumber.jsp" method="post">
        <label for="transitLineReservations">Transit Line:</label>
        <select id="transitLineReservations" name="line">
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
                Statement st = con.createStatement();
                ResultSet rs;
                rs = st.executeQuery("SELECT DISTINCT transitlinename FROM Reservations JOIN Train_Schedule USING (scheduleID)");
                while (rs.next()) {%>
                    <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
                <% }
                con.close();
                st.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
                %>
        </select>

        <label for="trainNumber">Train Number:</label>
        <select id="trainNumber" name="train">
            <%
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
                    Statement st = con.createStatement();
                    ResultSet rs;
                    rs = st.executeQuery("SELECT DISTINCT tid FROM Reservations JOIN Train_Schedule USING (scheduleID) ORDER BY CAST(tid as SIGNED) ");
                    while (rs.next()) {%>
            <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
            <% }
                con.close();
                st.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
        </select>
        <input type="submit" value="Search">
    </form>
    <br>
    <form id="searchResByUsernameForm" method="post">
        <label for="searchResUsername">Customer Username:</label>
        <input type="text" id="searchResUsername" name="username">
        <input type="button" onclick="searchResByUsername()" value="Search">
    </form>
</div>

<!-- Produce a summary listing of revenue generated by a particular transit line, destination city, or customer -->
<div class="col">
    <h3>Revenue Summary</h3>
    <form action="revSummaryByLine.jsp" method="post">
        <label for="transitLineRevenue">Transit Line:</label>
        <select id="transitLineRevenue" name="line">
            <%
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
                    Statement st = con.createStatement();
                    ResultSet rs;
                    rs = st.executeQuery("SELECT DISTINCT transitlinename FROM Reservations JOIN Train_Schedule USING (scheduleID)");
                    while (rs.next()) {%>
            <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
            <% }
                con.close();
                st.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
        </select>
        <input type="submit" value="View">
    </form>
    <br>
    <form action="revSummaryByDestCity.jsp" method="post">
        <label for="destinationCity">Destination City:</label>
        <select id="destinationCity" name="destCity">
            <%
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
                    Statement st = con.createStatement();
                    ResultSet rs;
                    rs = st.executeQuery("SELECT DISTINCT city FROM Reservations r JOIN Stations s ON r.dest_station=s.sid");
                    while (rs.next()) {%>
            <option value="<%=rs.getString("city")%>"><%=rs.getString("city")%></option>
            <% }
                con.close();
                st.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
        </select>
        <input type="submit" value="View">
    </form>
    <br>
    <form id="revSummaryByUsernameForm" method="post">
        <label for="revSummaryUsername">Customer Username:</label>
        <input type="text" id="revSummaryUsername" name="username">
        <input type="button" onclick="revSummaryByUsername()" value="View">
    </form>
</div>

<!-- Determine which customer generated most total revenue -->
<div class="col">
    <%! String bestCustomer = ""; %>
    <%
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT username, MAX(rev) FROM (SELECT username, SUM(total_fare + booking_fee) rev FROM Reservations GROUP BY username) t1");

            if (rs.next()) {
                bestCustomer = rs.getString("username");
            }

            con.close();
            st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

Customer Who Generated Most Revenue: <%=bestCustomer%>
</div>

<!-- Produce a list of the 5 most active transit lines (most reservations per month) -->
<div class="col">
5 Most Active Transit Lines:<br>
    <%
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT transitlinename, COUNT(transitlinename) resCount FROM Reservations r JOIN Train_Schedule ts ON r.scheduleID=ts.scheduleID GROUP BY transitlinename ORDER BY resCount DESC LIMIT 5");

            while (rs.next()) {
                out.println(rs.getString("transitlinename") + "<br>");
            }

            con.close();
            st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</div>

</body>
</html>
