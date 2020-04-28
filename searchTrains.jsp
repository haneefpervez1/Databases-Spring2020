<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>

<% 
String origin = request.getParameter("origin");
String dest = request.getParameter("destination");
String date = request.getParameter("date");
System.out.println(origin + ", " + dest + ", " + date);
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
Statement st = con.createStatement();
ResultSet rs;
rs = st.executeQuery("SELECT ts.transitlinename, ts.tid, tl.origin_station, tl.dest_station, ts.avail_seats, ts.dep_datetime, ts.arrival_datetime, ts.total_travel_time, tl.fare_amount FROM Train_Schedule AS ts, Transit_Line AS tl WHERE ts.transitlinename=tl.transitlinename AND tl.origin_station=(SELECT sid FROM Stations WHERE name=\""+origin+"\") AND tl.dest_station=(SELECT sid FROM Stations WHERE name=\""+dest+"\") AND ts.dep_datetime=STR_TO_DATE('"+date+"','%m/%d/%Y');");
if (rs.next()){ 
	System.out.println("Test");
}
else
	System.out.println("Failed");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Search Trains</title>
</head>
<body>
	<h3>Search Trains</h3>
</body>
</html>