<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import = "java.sql.*" %>
   <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Sort Trains</title>
	<link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
	<h3>Sort Trains</h3>
	<table>
	<tr>
		<th>Transit Line Name</th>
		<th>TrainID</th>
		<th>Available Seats</th>
		<th>Origin</th>
		<th>Destination</th>
		<th>Departure Time</th>
		<th>Arrival Time</th>
		<th>Total Travel Time</th>
		<th>Fare Amount</th>
	</tr>
   <% 
String sort = request.getParameter("sort");
System.out.println(sort);
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
Statement st = con.createStatement();
ResultSet rs;
rs = st.executeQuery("SELECT * FROM Train_Schedule, Transit_Line WHERE Train_Schedule.transitlinename = Transit_Line.transitlinename ORDER BY "+ sort+ ";");
while (rs.next()){ 
	int schedId = rs.getInt("scheduleID");
	String transitlinename = rs.getString("transitlinename");
	int tid = rs.getInt("tid");
	int avail_seat = rs.getInt("avail_seats");
	int origin = rs.getInt("origin_station");
	int dest = rs.getInt("dest_station");
	java.sql.Timestamp dept_time = rs.getTimestamp("dep_datetime");
	java.sql.Timestamp ariv_time = rs.getTimestamp("arrival_datetime");
	int totalTravel = rs.getInt("total_travel_time");
	float fare = rs.getFloat("fare_amount");
	String fare_amount = "$" + String.valueOf(rs.getFloat("fare_amount"));
	String fare_type = rs.getString("fare_type");
	request.setAttribute("transitlinename", transitlinename);
	request.setAttribute("origin", origin);
	request.setAttribute("dest", dest);
	request.setAttribute("dept_time", dept_time);
	request.setAttribute("schedId", schedId);
	request.setAttribute("fare", fare);
	%>
			<tr>
				<td><%= transitlinename %></td>
				<td><%= tid %></td>
				<td><%= avail_seat %></td>
				<td><%= origin %></td>
				<td><%= dest %></td>
				<td><%= dept_time %></td>
				<td><%= ariv_time %></td>
				<td><%= totalTravel %></td>
				<td><%= fare_amount %></td>
				<td>
					<a href="MakeReservation.jsp?line=${transitlinename}&origin=${origin}&dest=${dest}&dept_time=${dept_time}&schedId=${schedId}&fare=${fare}">Reserve</a>
				</td>
			</tr>
<% } %>	
	</table>	
</body>
</html>
<%
	con.close();
	st.close();
%>

