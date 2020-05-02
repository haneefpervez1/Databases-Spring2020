<%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Edit Reservation</title>
	<link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
	<h4>Edit Reservation</h4>
	<%
	try{
	Class.forName("com.mysql.jdbc.Driver").newInstance();
  Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
  Statement st = con.createStatement();
  String res_num= (String)request.getParameter("res_num");
  String username= (String)request.getParameter("username");
  String res_date= (String)request.getParameter("res_date");
  String dep_datetime= (String)request.getParameter("dep_datetime");
  String scheduleID= (String)request.getParameter("scheduleID");
  String origin_station= (String)request.getParameter("origin_station");
  String dest_station= (String)request.getParameter("dest_station");
  String class= (String)request.getParameter("class");
  String seat_num= (String)request.getParameter("seat_num");
  String total_fare= (String)request.getParameter("total_fare");
  String booking_fee= (String)request.getParameter("booking_fee");
  String cust_rep= (String)request.getParameter("cust_rep");
  
  st.executeUpdate("UPDATE Reservations SET username ='" + username
                + "', res_date ='" + res_date
                + "', dep_datetime ='" + dep_datetime
                + "', scheduleID ='" + scheduleID
                + "', origin_station ='" + origin_station
                + "', dest_station ='" + dest_station
                + "', class ='" + class
                + "', seat_num ='" + seat_num
                + "', total_fare ='" + total_fare
                + "', booking_fee ='" + booking_fee
                + "', cust_rep ='" + cust_rep
                + "' WHERE res_num = '" + res_num + "'");
        con.close();
        st.close();
  } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
