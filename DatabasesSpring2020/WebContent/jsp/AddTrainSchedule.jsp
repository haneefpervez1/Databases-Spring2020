  <%@ page import = "java.sql.*" %>
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
        Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
        Statement st = con.createStatement();
	
    String newTransitLineName = (String)request.getParameter("transitlinename");
    String newOrigin=(String)request.getParameter("origin_station");
    String newDest=(String)request.getParameter("dest_station");
    String newFare=(String)request.getParameter("fare_amount");
    String newFareType=(String)request.getParameter("fare_type");
    String newFareDiscount=(String)request.getParameter("fare_discount");
    String newTrain = (String)request.getParameter("tid");
    String newTrainSeats = (String)request.getParameter("total_seats");
    String newTrainCars = (String)request.getParameter("total_cars");
    String newAvailSeats = (String)request.getParameter("avail_seats");
    String newArrival = (String)request.getParameter("arrival_datetime");
    String newDeparture = (String)request.getParameter("dep_datetime");
    String newTravelTime = (String)request.getParameter("total_travel_time");

    
    request.setAttribute("transitlinename", transitlinename);
    request.setAttribute("origin_station", origin_station);
    request.setAttribute("dest_station", dest_station);
    request.setAttribute("fare_amount", fare_amount);
    request.setAttribute("fare_type", fare_type);
    request.setAttribute("fare_discount", fare_discount);
    request.setAttribute("tid", tid);
    request.setAttribute("total_seats", total_seats);
    request.setAttribute("total_cars", total_cars);
    request.setAttribute("avail_seats", avail_seats);
    request.setAttribute("arrival_datetime", arrival_datetime);
    request.setAttribute("dep_datetime", dep_datetime);
    request.setAttribute("total_travel_time", total_travel_time);
 
    String i = "INSERT INTO Train(name)" + "VALUES (?)";
    PreparedStatement p = c.prepareStatement(i);
    p.setString(1, tid);
    p.setString(2, total_seats);
    p.setString(3, total_cars);
    p.executeUpdate();
    
    String i = "INSERT INTO Transit_Line(name)" + "VALUES (?)";
    PreparedStatement p = c.prepareStatement(i);
    p.setString(1, transitlinename);
    p.setString(2, origin_station);
    p.setString(3, dest_station);
    p.setString(4, fare_amount);
    p.setString(5, fare_type);
    p.setString(6, fare_discount);
    p.executeUpdate();
    
    String i = "INSERT INTO Train_Schedule(name)" + "VALUES (?)";
    PreparedStatement p = c.prepareStatement(i);
    p.setString(1, transitlinename);
    p.setString(2, tid);
    p.setString(3, availseats);
    p.setString(4, arrival_datetime);
    p.setString(5, dep_datetime);
    p.setString(6, total_travel_time);
    p.executeUpdate();
    
    st.close();
    con.close();
    } catch (Exception ex) {
		out.print(ex);
	}
%>
</form>
	<h4>Sort</h4>
	<form action="AddTrainSchedule.jsp" method="POST">
		<select id="sort" name="sort">
		        <option value="transitlinename">Transit Line Name</option>
			<option value="arrival_datetime">Arrival Time</option>
			<option value="dep_datetime">Departure Time</option>
			<option value="origin_station">Origin</option>
			<option value="dest_station">Destination</option>
			<option value="fare_amount">Fare</option>
			<option value="fare_type">Fare Type</option>
			<option value="fare_discount">Fare Discount</option>
			<option value="tid">Train ID</option>
			<option value="total_seats">total_seats</option>
			<option value="total_cars">total_cars</option>
			<option value="avail_seats">avail_seats</option>
			<option value="total_travel_time">total_travel_time</option>
		</select>
		<input type="submit" value="Submit"/>
	</form>
</body>
</html>
    
