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
        String sname=request.getParameter("name");
        String str = select * from Train_Schedule AS ts, Transit_Line AS tl where ts.transitlinename=tl.transitlinename AND (tl.origin_station=(select sid from Stations where name="sname") OR tl.dest_station=(select sid from Stations where name="sname"));
        ResultSet result = stmt.executeQuery(str);
        %>
        <h3>Train Schedule:</h3>
        <table>
            <tr>
                <th>scheduleID</th>
                <th>transitlinename</th>
                <th>tid</th>
                <th>Arrival Date/Time</th>
                <th>Departure Date/Time</th>
                <th>avail_seats</th>
                <th>total_travel_time</th>
            </tr>
                <% while (rs.next()) { %>
            <tr>
                <td><%=rs.getString("scheduleID")%></td>
                <td><%=rs.getString("transitlinename")%></td>
                <td><%=rs.getString("tid")%></td>
                <td><%=rs.getString("arrival_datetime")%></td>
                <td><%=rs.getString("dep_datetime")%></td>
                <td><%=rs.getString("avail_seats")%></td>
                <td><%=rs.getString("total_travel_time")%></td>
            </tr>
        <% }
          
        con.close();
        st.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<form action="ListTrainSchedules.jsp" method="POST">
		<select id="sort" name="sort">
			<option value="name">Station Name</option>
		</select>
		<input type="submit" value="Submit"/>
	</form>
</body>
</html>
