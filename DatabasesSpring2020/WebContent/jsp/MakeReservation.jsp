<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.util.Random" %>
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
		String avail_seat = request.getParameter("avail_seat");
		System.out.println(avail_seat);
		if(avail_seat.equals("0"))
		{
			out.println("Error: No more seats available!");
			return;
		}
		String transitline = (String)request.getParameter("line");
		String origin = (String)request.getParameter("origin");
		String dest = (String)request.getParameter("dest");
		String dept_time = (String)request.getParameter("dept_time");
		String schedId = (String)request.getParameter("schedId");
		String fare = (String)request.getParameter("fare");
		String originString = (String)request.getParameter("originString");
		String destString = (String)request.getParameter("destString");
		Random rand = new Random();
		int seat = rand.nextInt(50);
		request.setAttribute("transitline", transitline);
		request.setAttribute("origin", origin);
		request.setAttribute("dest", dest);
		request.setAttribute("dept_time", dept_time);
		request.setAttribute("schedId", schedId);
		request.setAttribute("fare", fare);
		request.setAttribute("seat", seat);
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
			<td><%= originString %></td>
			<td><%= destString %></td>
			<td><%= dept_time %></td>
		</tr>
	</table>
	<form action="sendReservationDetails.jsp?line=${transitline}&origin=${origin}&dest=${dest}&dept_time=${dept_time}&schedId=${schedId}&fare=${fare}&seat=${seat}" method="POST">
		<select id="fare_type" name="fare_type">
			<option value="one_way">One Way (<%= "$" + Float.parseFloat(fare) %>)</option>
			<option value="round_trip">Round Trip (<%= "$" + (Float.parseFloat(fare) * 2) %>)</option>
		</select>
		<select id="class" name="class">
			<option value="Economy">Economy</option>
			<option value="Business">Business (2x fare)</option>
			<option value="First">First (3x fare)</option>
		</select>
		<p>Seat: <%= seat %></p>
		<select id="discount" name="discount">
			<option value="none">Discount: None</option>
			<option value="child">Child (50% discount)</option>
			<option value="senior">Senior (20% discount)</option>
			<option value="disabled">Disabled (50% discount)</option>
		</select>
		<input type="submit" value="Submit"/>
	</form>
	
</body>
</html>