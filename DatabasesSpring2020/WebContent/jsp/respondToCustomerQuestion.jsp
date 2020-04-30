<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Respond to Customer Question</title>
</head>
<body>
	<h3>Respond to Customer Question</h3>
	<%
		String username = (String)session.getAttribute("user");
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("select mid, question from Messages where customer_rep = '" + username+ "' and answer is null;");
		while (rs.next()) {
			String question = rs.getString("question");
			int mid = rs.getInt("mid");
			request.setAttribute("mid", mid);
			%>
			<p><%= question %></p>
			<form action="sendAnswerDetails.jsp?mid=${mid}" method="POST">
				<input type="text" id="answer" name="answer" placeholder="answer">
				<input type="submit" value="Submit"/>
			</form>
			<%
		}
	%>
	<%
		con.close();
		st.close();
	%>
</body>
</html>