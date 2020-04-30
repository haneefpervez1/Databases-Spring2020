<%@ page import = "java.sql.*" %>
<%
	String username = (String)session.getAttribute("user");
	System.out.println(username);
	String question = request.getParameter("question");
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select username from Users where role = 'Customer Representative' order by rand() limit 1;");
	rs.next();
	String rep = rs.getString("username");
	rs.close();
	int rs2;
	rs2 = st.executeUpdate("INSERT INTO Messages (customer, customer_rep, question) VALUES ('" + username + "', '" + rep + "', '" + question + "')");
	response.sendRedirect("sendQuestion.jsp");
	con.close();
	st.close();
%>