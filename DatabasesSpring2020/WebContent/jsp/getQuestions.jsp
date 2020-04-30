<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Get Questions</title>
</head>
<body>
	<h3>Get Questions</h3>
	<%
		String search = request.getParameter("search");
	    Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("select question, answer from Messages where answer is not null and (question like '%"+ search + "%' or answer like '%"+ search+ "%');");
		while (rs.next()) {
			String question = rs.getString("question");
			String answer = rs.getString("answer");
			
			%>
				<p>Question: <%= question %> </p>
				<p>Answer:  <%= answer%></p>
			
			<%
		}
    %>
</body>
</html>