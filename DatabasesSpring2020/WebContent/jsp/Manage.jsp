<%@ page import = "java.sql.*, java.time.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage</title>
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
    </script>
</head>
<body>

<!-- Add, Edit and Delete information for an employee/customer -->
<div class="col">
    <h3>Manage User</h3>
    <form id="manageUserForm" method="post">
        <label for="username">Username:</label><br>
        <input type="text" id="username" name="username" required="required">
        <input type="button" onclick="addCustomer()" value="Add As Customer">
        <input type="button" onclick="addRepresentative()" value="Add As Representative">
        <input type="button" onclick="editUser()" value="Edit">
        <input type="button" onclick="deleteUser()" value="Delete">
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
        <select id="transitLineReservations">
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
                Statement st = con.createStatement();
                ResultSet rs;
                rs = st.executeQuery("SELECT transitlinename FROM Transit_Line");
                while (rs.next()) {%>
                    <option><%=rs.getString(1)%></option>
                <% }
                con.close();
                st.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
                %>
        </select>

        <label for="trainNumber">Train Number:</label>
        <select id="trainNumber">
            <%
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
                    Statement st = con.createStatement();
                    ResultSet rs;
                    rs = st.executeQuery("SELECT tid FROM Trains");
                    while (rs.next()) {%>
            <option><%=rs.getString(1)%></option>
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
    <form>
        <label for="transitLineRevenue">Transit Line:</label>
        <select id="transitLineRevenue">
            <option>1</option>
            <option>2</option>
            <option>3</option>
        </select>
        <button>Search</button>
    </form>
    <br>
    <form>
        <label for="destinationCity">Destination City:</label>
        <select id="destinationCity">
            <option>1</option>
            <option>2</option>
            <option>3</option>
        </select>
        <button>Search</button>
    </form>
    <br>
    <form>
        <label for="customerUsernameRevenue">Customer Username:</label>
        <input type="text" id="customerUsernameRevenue">
        <button>Search</button>
    </form>
</div>

<!-- Determine which customer generated most total revenue -->
<div class="col">
Customer Who Generated Most Revenue:
</div>

<!-- Produce a list of the 5 most active transit lines (most reservations per month) -->
<div class="col">
5 Most Active Transit Lines:
</div>

</body>
</html>
