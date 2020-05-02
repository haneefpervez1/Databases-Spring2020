<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Train Schedule</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
<a class="admin_back_link" href='Manage.jsp'>Back To Admin Panel</a><br>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
        Statement st = con.createStatement();
        String scheduleID = (String)request.getParameter("scheduleID");
        String transitlinename = (String)request.getParameter("transitlinename");
        String tid = (String)request.getParameter("tid");
        String avail_seats = (String)request.getParameter("avail_seats");
        String arrival_datetime = (String)request.getParameter("arrival_datetime");
        String dep_datetime = (String)request.getParameter("dep_datetime");
        String total_travel_time = (String)request.getParameter("total_travel_time");
        st.executeUpdate("UPDATE Users SET transitlinename='" + transitlinename
                + "', tid ='" + tid
                + "', avail_seats ='" + avail_seats
                + "', arrival_datetime ='" + arrival_datetime
                + "', dep_datetime ='" + dep_datetime
                + "', total_travel_time='" + total_travel_time
                + "' WHERE scheduleID = '" + scheduleID + "'");
        con.close();
        st.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

	<form action="EditTrainSchedule.jsp" method="POST">
		<select id="sort" name="sort">
            <option value="tid">Train Id</option>
            <option value="transitlinename">transitlinename</option>
			<option value="arrival_datetime">Arrival Time</option>
			<option value="dep_datetime">Departure Time</option>
            <option value="avail_seats">avail_seats</option>
			<option value="total_travel_time">total_travel_time</option>
            <option value="scheduleID">scheduleID</option>
			<option value="fare_amount">Fare</option>
		</select>
		<input type="submit" value="Submit"/>
	</form>
</body>
</html>
