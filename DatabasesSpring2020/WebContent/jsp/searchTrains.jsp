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

String query = "SELECT * FROM Train_Schedule AS ts, Transit_Line AS tl WHERE ts.transitlinename=tl.transitlinename";
String use_origin = " AND tl.origin_station=(SELECT sid FROM Stations WHERE name=\""+origin+"\")";
String use_dest = " AND tl.dest_station=(SELECT sid FROM Stations WHERE name=\""+dest+"\")";
String use_date = " AND ts.dep_datetime=STR_TO_DATE('"+date+"','%m/%d/%Y')";
String final_query = "";

if(!origin.isEmpty() && !dest.isEmpty() && !date.isEmpty())			// All 3 are searched
{
	final_query += query + use_origin + use_dest + use_date + ";";
	System.out.println(final_query);
}
else if(!origin.isEmpty() && !dest.isEmpty() && date.isEmpty())		// Origin and dest are searched
{
	final_query += query + use_origin + use_dest + ";";
	System.out.println(final_query);
}
else if(!origin.isEmpty() && dest.isEmpty() && !date.isEmpty())		// Origin and date are searched
{
	final_query += query + use_origin + use_date + ";";
	System.out.println(final_query);
}
else if(origin.isEmpty() && !dest.isEmpty() && !date.isEmpty())		// Dest and date are searched
{
	final_query += query + use_dest + use_date + ";";
	System.out.println(final_query);
}
else if(!origin.isEmpty() && dest.isEmpty() && date.isEmpty())		// Just origin searched
{
	final_query += query + use_origin + ";";
	System.out.println(final_query);
}
else if(origin.isEmpty() && !dest.isEmpty() && date.isEmpty())		// Just dest searched
{
	final_query += query + use_dest + ";";
	System.out.println(final_query);
}
else if(origin.isEmpty() && dest.isEmpty() && !date.isEmpty())		// Just date searched
{
	final_query += query + use_date + ";";
	System.out.println(final_query);
}
else																// No filters; show all train schedules
{
	final_query += query + ";";
	System.out.println(final_query);
}

ResultSet rs;
rs = st.executeQuery(final_query);
if (rs.next()) {
	System.out.println("Test");
}
else
	System.out.println("Failed");

con.close();
st.close();
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