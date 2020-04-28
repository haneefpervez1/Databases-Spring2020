<%@ page import = "java.sql.*" %>
<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	System.out.println("Username: " + username + " Password: " + password);
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("SELECT * FROM Users WHERE username='" + username + "'AND password='" + password + "'");
	if (rs.next()){ 
		System.out.println("User found"); 
		session.setAttribute("user", username);
		String role = rs.getString("role");
		session.setAttribute("role", role);
		response.sendRedirect("Welcome.jsp");
	} else {
		out.println("Invalid password <a href='Login.jsp'>try again</a>");
		System.out.println("User not found");
	}
	con.close();
	st.close();
%>