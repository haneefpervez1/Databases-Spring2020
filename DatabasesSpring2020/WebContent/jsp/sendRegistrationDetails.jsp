<%@ page import = "java.sql.*" %>
<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String role = request.getParameter("role");
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
	Statement st = con.createStatement();
	int rs;
	rs = st.executeUpdate("INSERT INTO Users (Username, Password, role) VALUES ('" + username + "', '" + password + "', '" + role + "')");
	session.setAttribute("user", username);
	session.setAttribute("role", role);
	response.sendRedirect("Welcome.jsp");
	con.close();
	st.close();
%>