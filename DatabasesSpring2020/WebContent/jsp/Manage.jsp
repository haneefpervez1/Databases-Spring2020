<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
    <script>
        function userFieldEmpty() {
            if (document.getElementById('username').value === "") {
                alert("Error: Username Missing");
                return true;
            }
            return false;
        }

        function addCustomer() {
            if (userFieldEmpty()) return;
            let form = document.getElementById('manageUserForm');
            form.action = 'addCustomer.jsp';
            form.submit();
        }

        function addRepresentative() {
            if (userFieldEmpty()) return;
            let form = document.getElementById('manageUserForm');
            form.action = 'addRepresentative.jsp';
            form.submit();
        }

        function editUser() {
            if (userFieldEmpty()) return;
            let form = document.getElementById('manageUserForm');
            form.action = 'editUser.jsp';
            form.submit();
        }

        function deleteUser() {
            if (userFieldEmpty()) return;
            let form = document.getElementById('manageUserForm');
            form.action = 'deleteUser.jsp';
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
    <form>
        <label for="monthlySalesReport">Month:</label>
        <select id="monthlySalesReport">
            <option value="april">April</option>
            <option value="march">March</option>
            <option value="february">February</option>
        </select>
        <button>View</button>
    </form>
</div>

<!-- Produce a list of reservations by transit line and train number or by customer name -->
<div class="col">
    <h3>Search Reservations</h3>
    <form>
        <label for="transitLineReservations">Transit Line:</label>
        <select id="transitLineReservations">
            <option>1</option>
            <option>2</option>
            <option>3</option>
        </select>
        <label for="trainNumber">Train Number:</label>
        <select id="trainNumber">
            <option>1</option>
            <option>2</option>
            <option>3</option>
        </select>
        <button>Search</button>
    </form>
    <br>
    <form>
        <label for="customerUsernameReservations">Customer Username:</label>
        <input type="text" id="customerUsernameReservations">
        <button>Search</button>
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