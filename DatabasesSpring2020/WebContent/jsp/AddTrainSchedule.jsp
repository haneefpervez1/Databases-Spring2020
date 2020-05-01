  
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
	ApplicationDB d = new ApplicationDB();	
	Connection c = db.getConnection();
	
    String newTransitLineName = (String)request.getParameter("transitlinename");
    String newTrain = (String)request.getParameter("train");
    String newOrigin = (String)request.getParameter("origin");
    String newDestination = (String)request.getParameter("destination");
    String newAvailSeats = (String)request.getParameter("availseats");
    String newStops = (String)request.getParameter("stops");
    String newArrival = (String)request.getParameter("arrival_datetime");
    String newDeparture = (String)request.getParameter("dep_datetime");
    String newTravelTime = (String)request.getParameter("traveltime");
		String newFare = (String)request.getParameter("fare");
    request.setAttribute("transitlinename", transitlinename);
    request.setAttribute("train", train);
    request.setAttribute("origin", origin);
    request.setAttribute("destination", destination);
    request.setAttribute("availseats", availseats);
    request.setAttribute("stops", stops);
    request.setAttribute("arrival_datetime", arrival_datetime);
    request.setAttribute("dep_datetime", dep_datetime);
    request.setAttribute("traveltime", traveltime);
    request.setAttribute("fare", fare);
    
    String i = "INSERT INTO Train_Schedule(name)" + "VALUES (?)";
    PreparedStatement p = c.prepareStatement(i);
    p.setString(1, transitlinename);
    p.setString(2, train);
    p.setString(3, origin);
    p.setString(4, destination);
    p.setString(5, availseats);
    p.setString(6, stops);
    p.setString(7, arrival_datetime);
    p.setString(8, dep_datetime);
    p.setString(9, traveltime);
    p.setString(10, fare);
    p.executeUpdate();
    
    c.close();
    } catch (Exception ex) {
		out.print(ex);
	}
%>
</body>
</html>
    
