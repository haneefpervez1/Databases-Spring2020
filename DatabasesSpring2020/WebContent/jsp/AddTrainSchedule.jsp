  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Add Train Schedule</title>
	<link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
	<h4>Add a train schedule</h4>
	<%
	try{
	Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection c = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
        Statement st = con.createStatement();
	
    String newTransitLineName = (String)request.getParameter("transitlinename");
    String newTrain = (String)request.getParameter("tid");
    String newAvailSeats = (String)request.getParameter("avail_seats");
    String newArrival = (String)request.getParameter("arrival_datetime");
    String newDeparture = (String)request.getParameter("dep_datetime");
    String newTravelTime = (String)request.getParameter("total travel time");

    
    request.setAttribute("transitlinename", transitlinename);
    request.setAttribute("tid", tid);
    request.setAttribute("avail_seats", avail_seats);
    request.setAttribute("arrival_datetime", arrival_datetime);
    request.setAttribute("dep_datetime", dep_datetime);
    request.setAttribute("total travel time", total travel time);
 
    
    String i = "INSERT INTO Train_Schedule(name)" + "VALUES (?)";
    PreparedStatement p = c.prepareStatement(i);
    p.setString(1, transitlinename);
    p.setString(2, tid);
    p.setString(3, availseats);
    p.setString(4, arrival_datetime);
    p.setString(5, dep_datetime);
    p.setString(6, total travel time);
    p.executeUpdate();
    
    c.close();
    } catch (Exception ex) {
		out.print(ex);
	}
%>
</body>
</html>
    
