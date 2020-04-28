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
		request.setAttribute("transitline", transitline);
		request.setAttribute("origin", origin);
		request.setAttribute("dest", dest);
		request.setAttribute("dept_time", dept_time);
		request.setAttribute("schedId", schedId);
		request.setAttribute("fare", fare);
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
	<form action="sendReservationDetails.jsp?line=${transitline}&origin=${origin}&dest=${dest}&dept_time=${dept_time}&schedId=${schedId}&fare=${fare}" method="POST">
		<select id="fare_type" name="fare_type">
			<option value="one_way">One Way (<%= "$" + Float.parseFloat(fare) %>)</option>
			<option value="round_trip">Round Trip (<%= "$" + (Float.parseFloat(fare) * 2) %>)</option>
		</select>
		<select id="class" name="class">
			<option value="Economy">Economy</option>
			<option value="Business">Business (2x fare)</option>
			<option value="First">First (3x fare)</option>
		</select>
		<select id="discount" name="discount">
			<option value="none">None</option>
			<option value="child">Child (50% discount)</option>
			<option value="senior">Senior (20% discount)</option>
			<option value="disabled">Disabled (50% discount)</option>
		</select>
		<input type="submit" value="Submit"/>
	</form>
	
</body>
</html>