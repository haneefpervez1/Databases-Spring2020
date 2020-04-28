<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%
    	float fare = Float.parseFloat(request.getParameter("fare"));
    	String fare_type = (String)request.getParameter("fare_type");
    	System.out.println(fare_type);
    	if (fare_type.equals("round_trip")) {
    		fare *= 2;
    	}
    	String ticket_class = request.getParameter("class");
    	if (!ticket_class.equals("Economy")) {
    		if (ticket_class.equals("Business")) {
    			fare *= 2;
    		} else if (ticket_class.equals("First")) {
    			fare *= 3;
    		}
    	}
    	String discount = request.getParameter("discount");
    	if (!discount.equals("none")) {
    		if (discount.equals("child") || discount.equals("disabled")) {
    			fare = fare/2;
    		} else if (discount.equals("senior")) {
    			fare = fare * 0.80f;
    		}
    	}
    	int aux = (int)(fare*100);
    	double result = aux/100d;
		String username = (String)session.getAttribute("user");
		String dep_datetime = request.getParameter("dept_time");
		String schedId = request.getParameter("schedId");
		String origin = request.getParameter("origin");
		String dest = request.getParameter("dest");
		double booking_fee = result * 0.5;
		//System.out.println("INSERT INTO Reservations(username, res_date, dep_datetime, scheduleID, origin_station, dest_station, class, total_fare, book_fare) values ('" + username + "', GETDATE(), '" + dep_datetime + "', " + schedId + ", " + origin + ", " + dest + ", '" + ticket_class + "', " + result + ", " + booking_fee + ")");
		Class.forName("com.mysql.jdbc.Driver").newInstance();
    	Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
    	Statement st = con.createStatement();
    	int rs;
    	rs = st.executeUpdate("INSERT INTO Reservations(username, res_date, dep_datetime, scheduleID, origin_station, dest_station, class, seat_num, total_fare, booking_fee) values ('" + username + "', CURRENT_TIMESTAMP(), '" + dep_datetime + "', " + schedId + ", " + origin + ", " + dest + ", '" + ticket_class + "', 1, " + result + ", " + booking_fee + ")");
    	con.close();
    	st.close();
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Your Reservation</title>
</head>
<body>
	<h4>Your Total Fare is <%= "$" + result %></h4>
	<a href="viewReservations.jsp">View Your Reservations here</a>
</body>
</html>