<%@ page import = "java.sql.*" %>

<% 
	String res_num = (String)request.getParameter("res");
	int res = Integer.parseInt(res_num);
	System.out.println(res);
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
	Statement st = con.createStatement();
	String query = "delete from Reservations where res_num=" + res + ";";
	int rs;
	rs = st.executeUpdate(query);
	con.close();
	st.close();
	response.sendRedirect("viewReservations.jsp");
%>