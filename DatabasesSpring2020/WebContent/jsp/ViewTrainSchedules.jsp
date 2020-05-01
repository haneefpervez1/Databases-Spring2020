<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import= "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Train Schedules</title>
</head>
<body>
	<a href="Welcome.jsp">Back to Home</a>
	<h3>Train Schedules</h3>
	<h4>Search</h4>
	<form action="searchTrains.jsp" method="POST">
		<select id="origin" name="origin">
			<option value=""></option>
			<%
			    Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection con1 = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
				Statement st1 = con1.createStatement();
				String originquery = "SELECT DISTINCT st.name AS OriginStation FROM Train_Schedule AS ts, Transit_Line AS tl, Stops AS s, Stations AS st WHERE ts.transitlinename=tl.transitlinename AND s.scheduleID=ts.scheduleID AND tl.origin_station=st.sid GROUP BY ts.scheduleID";
				ResultSet rs = st1.executeQuery(originquery);
				while (rs.next()) {
					String station = rs.getString("OriginStation");
					System.out.println(station);
					%>
						<option value="<%= station%>"><%= station %></option>
					<% 
				}
				con1.close();
				st1.close();
				rs.close();
    		%>
		</select>
		<select id="destination" name="destination">
			<option value=""></option>
			<%
			    Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
				Statement st = con.createStatement();
				String destquery = "SELECT DISTINCT st.name AS DestStation FROM Train_Schedule AS ts, Transit_Line AS tl, Stops AS s, Stations AS st WHERE ts.transitlinename=tl.transitlinename AND s.scheduleID=ts.scheduleID AND tl.dest_station=st.sid GROUP BY ts.scheduleID";
				ResultSet rs2 = st.executeQuery(destquery);
				while (rs2.next()) {
					String station = rs2.getString("DestStation");
					%>
						<option value="<%= station%>"><%= station %></option>
					<% 
				}
				con.close();
				st.close();
				rs2.close();
    		%>
		</select>
		<input type="text" id="date" name=date placeholder="date (mm/dd/yyyy)">
		<input type="submit" value="Submit"/>
	</form>
	<h4>Sort</h4>
	<form action="sortTrains.jsp" method="POST">
		<select id="sort" name="sort">
			<option value="arrival_datetime">Arrival Time</option>
			<option value="dep_datetime">Departure Time</option>
			<option value="origin_station">Origin</option>
			<option value="dest_station">Destination</option>
			<option value="fare_amount">Fare</option>
		</select>
		<input type="submit" value="Submit"/>
	</form>
</body>
</html>