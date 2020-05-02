<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>List of Train Schedules</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
        Statement st = con.createStatement();
        String tline=request.getParameter("transitlinename");
        String trn=request.getParameter("train");
        String str = select * from Users AS u, Reservations AS r, Train_Schedule AS ts where u.username=r.username AND r.scheduleID=ts.scheduleID AND ts.transitlinename="tline" AND ts.tid="trn"
        ResultSet result = stmt.executeQuery(str);
        %>
        <h3>Customers:</h3>
        <table>
            <tr>
                <th>username</th>
                <th>password</th>
                <th>ssn</th>
                <th>role</th>
                <th>first_name</th>
                <th>last_name</th>
                <th>phone</th>
                <th>email</th>
                <th>street_address</th>
                <th>city</th>
                <th>state</th>
                <th>zipcode</th>
            </tr>
                <% while (rs.next()) { %>
            <tr>
                <td><%=rs.getString("username")%></td>
                <td><%=rs.getString("password")%></td>
                <td><%=rs.getString("ssn")%></td>
                <td><%=rs.getString("role")%></td>
                <td><%=rs.getString("first_name")%></td>
                <td><%=rs.getString("last_name")%></td>
                <td><%=rs.getString("phone")%></td>
                <td><%=rs.getString("email")%></td>
                <td><%=rs.getString("street_address")%></td>
                <td><%=rs.getString("city")%></td>
                <td><%=rs.getString("state")%></td>
                <td><%=rs.getString("zipcode")%></td>
            </tr>
        <% }
          
        con.close();
        st.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<form action="ListCustomers.jsp" method="POST">
		<select id="sort" name="sort">
			<option value="transitlinename">transitlinename</option>
			<option value="train">train</option>
		</select>
		<input type="submit" value="Submit"/>
	</form>
</body>
</html>
