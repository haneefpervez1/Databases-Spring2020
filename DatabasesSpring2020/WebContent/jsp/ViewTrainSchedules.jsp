<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Train Schedules</title>
</head>
<body>
	<h3>Train Schedules</h3>
	<h4>Search</h4>
	<form action="searchTrains.jsp" method="POST">
		<input type="text" id="origin" name="origin" placeholder="origin">
		<input type="text" id="destination" name="destination" placeholder="destination">
		<input type="text" id="date" name=date placeholder="date">
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