<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import = "java.sql.*" %>
   <%@ page import = "java.util.*" %>
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
		<th>Number of Stops</th>
		<th>Departure Time</th>
		<th>Arrival Time</th>
		<th>Total Travel Time</th>
		<th>Fare Amount</th>
	</tr>
   <% 
String sort = request.getParameter("sort");
System.out.println("Sort by: "+sort);
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
Statement st = con.createStatement();
String originquery = "SELECT ts.transitlinename, st.name AS OriginStation FROM Train_Schedule AS ts, Transit_Line AS tl, Stops AS s, Stations AS st WHERE ts.transitlinename=tl.transitlinename AND s.scheduleID=ts.scheduleID AND tl.origin_station=st.sid GROUP BY ts.scheduleID";
ResultSet originrs = st.executeQuery(originquery);
HashMap<String, String> map = new HashMap();
while (originrs.next()) {
	map.put(originrs.getString("transitlinename"), originrs.getString("OriginStation"));
}
originrs.close();
String destquery = "SELECT ts.transitlinename, st.name AS DestStation FROM Train_Schedule AS ts, Transit_Line AS tl, Stops AS s, Stations AS st WHERE ts.transitlinename=tl.transitlinename AND s.scheduleID=ts.scheduleID AND tl.dest_station=st.sid GROUP BY ts.scheduleID";
ResultSet destrs = st.executeQuery(destquery);
HashMap<String, String> mapDest = new HashMap();
while (destrs.next()) {
	mapDest.put(destrs.getString("transitlinename"), destrs.getString("DestStation"));
}
destrs.close();
String query = "SELECT *, COUNT(s.sid) AS NumberOfStops FROM Train_Schedule AS ts, Transit_Line AS tl, Stops AS s WHERE ts.transitlinename=tl.transitlinename AND s.scheduleID=ts.scheduleID GROUP BY ts.scheduleID ORDER BY ";

ResultSet rs;
rs = st.executeQuery(query + sort + ";");
while (rs.next()) {
	int schedId = rs.getInt("scheduleID");
	String transitlinename = rs.getString("transitlinename");
	int tid = rs.getInt("tid");
	int avail_seat = rs.getInt("avail_seats");
	String originString = map.get(transitlinename);
	int origin = rs.getInt("origin_station");
	String destString = mapDest.get(transitlinename);
	int dest = rs.getInt("dest_station");
	int numStops = rs.getInt("NumberOfStops"); // changed
	java.sql.Timestamp dept_time = rs.getTimestamp("dep_datetime");
	java.sql.Timestamp ariv_time = rs.getTimestamp("arrival_datetime");
	int totalTravel = rs.getInt("total_travel_time");
	float fare = rs.getFloat("fare_amount");
	String fare_amount = "$" + String.valueOf(rs.getFloat("fare_amount"));
	String fare_type = rs.getString("fare_type");
	request.setAttribute("transitlinename", transitlinename);
	request.setAttribute("origin", origin);
	request.setAttribute("dest", dest);
	request.setAttribute("originString", originString);
	request.setAttribute("destString", destString);
	request.setAttribute("dept_time", dept_time);
	request.setAttribute("schedId", schedId);
	request.setAttribute("fare", fare);
	request.setAttribute("numStops", numStops);
	%>
			<tr>
				<td><%= transitlinename %></td>
				<td><%= tid %></td>
				<td><%= avail_seat %></td>
				<td><%= originString %></td>
				<td><%= destString %></td>
				<td>
					<a href="showStops.jsp?schedId=${schedId}"><%= numStops %></a>
				</td>
				<td><%= dept_time %></td>
				<td><%= ariv_time %></td>
				<td><%= totalTravel %></td>
				<td><%= fare_amount %></td>
				<td>
					<a href="MakeReservation.jsp?line=${transitlinename}&origin=${origin}&dest=${dest}&dept_time=${dept_time}&schedId=${schedId}&fare=${fare}&originString=${originString}&destString=${destString}">Reserve</a>
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
