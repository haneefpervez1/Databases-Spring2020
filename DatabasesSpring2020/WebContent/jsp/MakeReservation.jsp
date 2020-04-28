<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Make Reservation</title>
	<link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
	<h4>Make a Reservation</h4>
	<%
		String transitline = (String)request.getParameter("line");
		String origin = (String)request.getParameter("origin");
		String dest = (String)request.getParameter("dest");
		String dept_time = (String)request.getParameter("dept_time");
		String schedId = (String)request.getParameter("schedId");
		String fare = (String)request.getParameter("fare");
	%>
	<table>
		<tr>
			<th>Transit Line</th>
			<th>Origin</th>
			<th>Destination</th>
			<th>Departure Time</th>
		</tr>
		<tr>
			<td><%= transitline %></td>
			<td><%= origin %></td>
			<td><%= dest %></td>
			<td><%= dept_time %></td>
		</tr>
	</table>
	<form>
		<select id="fare_type" name="fare_type">
			<option value="one_way">One Way</option>
			<option value="round_trip">Round Trip</option>
		</select>
		<select id="class" name="class">
			<option value="economy">Economy</option>
			<option value="business">Business</option>
			<option value="first">First</option>
		</select>
		<select id="discount" name="discount">
			<option value="child">Child</option>
			<option value="senior">Senior</option>
			<option value="disabled">Disabled</option>
		</select>
		<input type="submit" value="Submit"/>
	</form>
	
</body>
</html>