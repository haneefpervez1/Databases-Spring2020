<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%
    	String answer = request.getParameter("answer");
    	String mid = (String)request.getParameter("mid");
	    Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
		Statement st = con.createStatement();
		int rs;
		rs = st.executeUpdate("update Messages set answer='" + answer + "' where mid=" + mid + ";");
		st.close();
		con.close();
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Send Answer</title>
</head>
<body>
	<a href="respondToCustomerQuestion.jsp">Back to Question Home</a>
	<p>Question has been answered</p>
	<a href="respondToCustomerQuestion.jsp">Back to Customer Questions</a>
</body>
</html>