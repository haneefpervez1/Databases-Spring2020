<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "java.util.*" %>
   <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Search Trains</title>
	<link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
	<h3>Search Trains</h3>
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
String origin = request.getParameter("origin");
String dest = request.getParameter("destination");
String date = request.getParameter("date");
System.out.println(origin + ", " + dest + ", " + date);

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
String query = "SELECT *, COUNT(s.sid) AS NumberOfStops FROM Train_Schedule AS ts, Transit_Line AS tl, Stops AS s WHERE ts.transitlinename=tl.transitlinename AND s.scheduleID=ts.scheduleID";
String use_origin = " AND tl.origin_station=(SELECT sid FROM Stations WHERE name=\""+origin+"\")";
String use_dest = " AND tl.dest_station=(SELECT sid FROM Stations WHERE name=\""+dest+"\")";
String use_date = " AND ts.dep_datetime>=STR_TO_DATE('"+date+"','%m/%d/%Y') AND ts.dep_datetime<ADDDATE(STR_TO_DATE('"+date+"','%m/%d/%Y'), 1)";
String final_query = "";

if(!origin.isEmpty() && !dest.isEmpty() && !date.isEmpty())			// All 3 are searched
{
	final_query += query + use_origin + use_dest + use_date + " GROUP BY ts.scheduleID;";
	System.out.println(final_query);
}
else if(!origin.isEmpty() && !dest.isEmpty() && date.isEmpty())		// Origin and dest are searched
{
	final_query += query + use_origin + use_dest + " GROUP BY ts.scheduleID;";
	System.out.println(final_query);
}
else if(!origin.isEmpty() && dest.isEmpty() && !date.isEmpty())		// Origin and date are searched
{
	final_query += query + use_origin + use_date + " GROUP BY ts.scheduleID;";
	System.out.println(final_query);
}
else if(origin.isEmpty() && !dest.isEmpty() && !date.isEmpty())		// Dest and date are searched
{
	final_query += query + use_dest + use_date + " GROUP BY ts.scheduleID;";
	System.out.println(final_query);
}
else if(!origin.isEmpty() && dest.isEmpty() && date.isEmpty())		// Just origin searched
{
	final_query += query + use_origin + " GROUP BY ts.scheduleID;";
	System.out.println(final_query);
}
else if(origin.isEmpty() && !dest.isEmpty() && date.isEmpty())		// Just dest searched
{
	final_query += query + use_dest + " GROUP BY ts.scheduleID;";
	System.out.println(final_query);
}
else if(origin.isEmpty() && dest.isEmpty() && !date.isEmpty())		// Just date searched
{
	final_query += query + use_date + " GROUP BY ts.scheduleID;";
	System.out.println(final_query);
}
else																// No filters; show all train schedules
{
	final_query += query + " GROUP BY ts.scheduleID;";
	System.out.println(final_query);
}

ResultSet rs;
rs = st.executeQuery(final_query);

while (rs.next()) {
	int schedId = rs.getInt("scheduleID");
	String transitlinename = rs.getString("transitlinename");
	String originString = map.get(transitlinename);
	int tid = rs.getInt("tid");
	int avail_seat = rs.getInt("avail_seats");
	int orgn = rs.getInt("origin_station");
	int dst = rs.getInt("dest_station");
	String destString = mapDest.get(transitlinename);
	int numStops = rs.getInt("NumberOfStops"); // changed
	java.sql.Timestamp dept_time = rs.getTimestamp("dep_datetime");
	java.sql.Timestamp ariv_time = rs.getTimestamp("arrival_datetime");
	int totalTravel = rs.getInt("total_travel_time");
	float fare = rs.getFloat("fare_amount");
	String fare_amount = "$" + String.valueOf(rs.getFloat("fare_amount"));
	String fare_type = rs.getString("fare_type");
	request.setAttribute("transitlinename", transitlinename);
	request.setAttribute("orgn", orgn);
	request.setAttribute("dst", dst);
	request.setAttribute("originString", originString);
	request.setAttribute("destString", destString);
	request.setAttribute("dept_time", dept_time);
	request.setAttribute("schedId", schedId);
	request.setAttribute("fare", fare);
	request.setAttribute("numStops", numStops);
	request.setAttribute("avail_seat", avail_seat);
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
					<a href="MakeReservation.jsp?line=${transitlinename}&origin=${orgn}&dest=${dst}&dept_time=${dept_time}&schedId=${schedId}&fare=${fare}&originString=${originString}&destString=${destString}&avail_seat=${avail_seat}">Reserve</a>
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
