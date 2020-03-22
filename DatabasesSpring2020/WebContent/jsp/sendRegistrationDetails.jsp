<%@ page import = "java.sql.*" %>
<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "root", "dbpass");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("insert into Users (Username, Password) values (username, password))");
%>