<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import = "java.sql.*" %>
   <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sort Trains</title>
</head>
<body>
	<h3>Sort Trains</h3>
</body>
</html>
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
	int origin = rs.getInt("origin_station");
	int dest = rs.getInt("dest_station");
	float fare_amount = rs.getFloat("fare_amount");
	String fare_type = rs.getString("fare_type");
	%>
		<table>
			<tr><%= schedId %></tr>
			<tr><%= transitlinename %></tr>
			<tr><%= origin %></tr>
			<tr><%= dest %></tr>
			<tr><%= fare_amount %></tr>
			<tr><%= fare_type %></tr>
		</table>
		
	<% 
}
/*
else
	System.out.println("Failed");
*/
%>
