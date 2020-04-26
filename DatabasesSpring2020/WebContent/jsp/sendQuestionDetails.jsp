<%@ page import = "java.sql.*" %>
<%
	String username = (String)session.getAttribute("user");
	System.out.println(username);
	String question = request.getParameter("question");
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
	Statement st = con.createStatement();
	int rs;
	rs = st.executeUpdate("INSERT INTO Messages (sender, message) VALUES ('" + username + "', '" + question + "')");
	response.sendRedirect("sendQuestion.jsp");
%>