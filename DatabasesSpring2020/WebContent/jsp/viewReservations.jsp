<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "java.text.SimpleDateFormat" %>
	<%@ page import = "java.util.Date"%> 
	<%@ page import = "java.util.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>My Reservations</title>
	<link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
	<a href="Welcome.jsp">Back to Home</a>
	<h4>View Reservations</h4>
	<table>
	<tr>
		<th>Reservation Number</th>
		<th>Date Made</th>
		<th>Username</th>
		<th>Total Fare</th>
		<th>Seat</th>
		<th>Customer Representative</th>
		<th>Origin</th>
		<th>Departure Time</th>
		<th>Destination</th>
		<th>Arrival Time</th>
	</tr>
	<%
	String username = (String)session.getAttribute("user");
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
	Statement st = con.createStatement();
	String originquery = "SELECT ts.scheduleID, st.name AS OriginStation FROM Train_Schedule AS ts, Transit_Line AS tl, Stops AS s, Stations AS st WHERE ts.transitlinename=tl.transitlinename AND s.scheduleID=ts.scheduleID AND tl.origin_station=st.sid GROUP BY ts.scheduleID";
	ResultSet originrs = st.executeQuery(originquery);
	HashMap<Integer, String> map = new HashMap();
	while (originrs.next()) {
		map.put(originrs.getInt("scheduleID"), originrs.getString("OriginStation"));
	}
	originrs.close();
	String destquery = "SELECT ts.scheduleID, st.name AS DestStation FROM Train_Schedule AS ts, Transit_Line AS tl, Stops AS s, Stations AS st WHERE ts.transitlinename=tl.transitlinename AND s.scheduleID=ts.scheduleID AND tl.dest_station=st.sid GROUP BY ts.scheduleID";
	ResultSet destrs = st.executeQuery(destquery);
	HashMap<Integer, String> mapDest = new HashMap();
	while (destrs.next()) {
		mapDest.put(destrs.getInt("scheduleID"), destrs.getString("DestStation"));
	}
	destrs.close();
	String query = "SELECT * FROM Reservations AS r, Train_Schedule AS ts WHERE r.scheduleID=ts.scheduleID AND username = \"" + username + "\";";
	ResultSet rs;
	rs = st.executeQuery(query);
	while (rs.next()) {
		int res_num = rs.getInt("res_num");
		java.sql.Date date_made = rs.getDate("res_date");
		java.sql.Timestamp dept_time = rs.getTimestamp("dep_datetime");
		int schedId = rs.getInt("scheduleID");
		int origin = rs.getInt("origin_station");
		int dest = rs.getInt("dest_station");
		String clss = rs.getString("class");
		int seat_num = rs.getInt("seat_num");
		float total_fare = rs.getFloat("total_fare");
		float booking_fee = rs.getFloat("booking_fee");
		String cust_rep = rs.getString("cust_rep");
		String originString = map.get(schedId);
		String destString = mapDest.get(schedId);
		if(cust_rep == null)
		{
			cust_rep = "N/A";
		}
		java.sql.Timestamp ariv_time = rs.getTimestamp("arrival_datetime");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	    Date date = new Date();  
	    int comp = ariv_time.compareTo(date);
	    if (comp < 0) {
	    	boolean delay = true;
	    }
		String tlname = rs.getString("transitlinename");
		int tid = rs.getInt("tid");
		int avail_seat = rs.getInt("avail_seats");
		int totalTravel = rs.getInt("total_travel_time");
		request.setAttribute("res_num", res_num);
		%>
				<tr>
					<td><%= res_num %></td>
					<td><%= date_made %></td>
					<td><%= username %></td>
					<td><%= total_fare %></td>
					<td><%= seat_num %>
					<td><%= cust_rep %></td>
					<td><%= originString %>
					<td><%= dept_time %></td>
					<td><%= destString %></td>
					<%
						if (comp < 0) {
							%>
							<td style="color: red"><%= ariv_time %></td>
							<%
						} else {
							%>
							<td><%= ariv_time %></td>
							<%
						}
					%>
					<td>
						<a href="deleteReservation.jsp?res=${res_num}">Delete</a>
					</td>
				</tr>
<% } %>	
		</table>
		<p>Red = train has been delayed</p>
</body>
</html>
<%
	con.close();
	st.close();
%>
