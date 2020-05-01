<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Train Schedule Stops</title>
	<link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
	<a href="ViewTrainSchedules.jsp">Back to Train Schedules</a>
	<h3>Train Stops</h3>
	<table>
	<tr>
		<th>Station</th>
		<th>Stop Number</th>
		<th>Departure Time</th>
		<th>Arrival Time</th>
	</tr>
	
	<%
	int schedID = Integer.parseInt(request.getParameter("schedId"));
	System.out.println("SchedID: "+schedID);
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
	Statement st = con.createStatement();
	String query = "SELECT tl.transitlinename, st.name, s.stop_number, s.depart_time, s.arrival_time FROM Stops AS s, Stations AS st, Train_Schedule AS ts, Trains AS t, stop_at AS sa, Transit_Line AS tl WHERE ts.tid = t.tid AND t.tid = sa.tid AND sa.sid=st.sid AND s.sid=st.sid AND s.scheduleID=ts.scheduleID AND tl.transitlinename=ts.transitlinename AND ts.scheduleID=";
	ResultSet rs;
	rs = st.executeQuery(query+schedID+" ORDER BY s.stop_number;");
	while(rs.next())
	{
		String tlname = rs.getString("transitlinename");
		String station = rs.getString("name");
		int stop_num = rs.getInt("stop_number");
		java.sql.Timestamp dept_time = rs.getTimestamp("depart_time");
		java.sql.Timestamp ariv_time = rs.getTimestamp("arrival_time");
	%>
			<tr>
				<td><%= station %></td>
				<td><%= stop_num %></td>
				<td><%= dept_time %></td>
				<td><%= ariv_time %></td>
			</tr>
<% } %>
	</table>	
</body>
</html>
<%
	con.close();
	st.close();
%>
