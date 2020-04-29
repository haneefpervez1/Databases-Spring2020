<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
    <script>
        function stateFieldIsInvalid() {
            if (document.getElementById('state').value !== "" && document.getElementById('state').value.length !== 2) {
                alert("Error: State must be 2 characters long");
                return true;
            }
            return false;
        }

        function editCustomer() {
            if (stateFieldIsInvalid()) return;
            let form = document.getElementById('editCustomerForm');
            form.action = 'editCustomer.jsp';
            form.submit();
        }

        function editRepresentative() {
            let form = document.getElementById('editRepresentativeForm');
            form.action = 'editRepresentative.jsp';
            form.submit();
        }
    </script>
</head>
<body>
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
        return;
    }

    String last_name = rs.getString("last_name") == null ? "" : rs.getString("last_name");
    String first_name = rs.getString("first_name") == null ? "" : rs.getString("first_name");
    String street_address = rs.getString("street_address") == null ? "" : rs.getString("street_address");
    String city = rs.getString("city") == null ? "" : rs.getString("city");
    String state = rs.getString("state") == null ? "" : rs.getString("state");
    String zipcode = rs.getString("zipcode") == null ? "" : rs.getString("zipcode");
    String phone = rs.getString("phone") == null ? "" : rs.getString("phone");
    String email = rs.getString("email") == null ? "" : rs.getString("email");
    String password = rs.getString("password") == null ? "" : rs.getString("password");

    String role = rs.getString("role");
    if (role.equals("Customer")) { %>
    <form id="editCustomerForm" method="post">
        <label for="lastname">Last Name:</label>
        <input type="text" id="lastname" name="lastname" value="<%=last_name%>">
        <br>
        <label for="firstname">First Name:</label>
        <input type="text" id="firstname" name="firstname" value="<%=first_name%>">
        <br>
        <label for="address">Address:</label>
        <input type="text" id="address" name="address" value="<%=street_address%>">
        <br>
        <label for="city">City:</label>
        <input type="text" id="city" name="city" value="<%=city%>">
        <br>

        <label for="state">State:</label>
        <input type="text" id="state" name="state" value="<%=state%>">

        <br>
        <label for="zipcode">Zip Code:</label>
        <input type="text" id="zipcode" name="zipcode" value="<%=zipcode%>">
        <br>
        <label for="telephone">Telephone:</label>
        <input type="text" id="telephone" name="telephone" value="<%=phone%>">
        <br>
        <label for="email">Email:</label>
        <input type="text" id="email" name="email" value="<%=email%>">
        <br>

        <input style="display:none" type="text" name="old_username" value="<%=username%>">

        <label for="username">Username:</label>
        <input type="text" id="username" name="new_username" value="<%=username%>">
        <br>

        <label for="password">Password:</label>
        <input type="text" id="password" name="password" value="<%=password%>">
        <br>
        <input type="button" onclick="editCustomer()" value="Save">
    </form>
<% }
    String ssn = rs.getString("ssn") == null ? "" : rs.getString("ssn");

    if (role.equals("Customer Representative")) { %>
    <form id="editRepresentativeForm" method="post">
        <label for="ssn">Social Security #:</label>
        <input type="text" id="ssn" name="ssn" value="<%=ssn%>">
        <br>
        <label for="lastname">Last Name:</label>
        <input type="text" id="lastname" name="lastname" value="<%=last_name%>">
        <br>
        <label for="firstname">First Name:</label>
        <input type="text" id="firstname" name="firstname" value="<%=first_name%>">
        <br>

        <input style="display:none" type="text" name="old_username" value="<%=username%>">

        <label for="username">Username:</label>
        <input type="text" id="username" name="new_username" value="<%=username%>">
        <br>

        <label for="password">Password:</label>
        <input type="text" id="password" name="password" value="<%=password%>">
        <br>
        <input type="button" onclick="editRepresentative()" value="Save">
    </form>
<% }
    con.close();
    st.close();
} catch (Exception e) {
        e.printStackTrace();
}%>
<br>
<a href='Manage.jsp'>Admin Panel</a>
</body>
</html>
