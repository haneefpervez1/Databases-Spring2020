<%@ page import = "java.sql.*" %>

<% 
	String sch_num = (String)request.getParameter("scheduleID");
	int sch = Integer.parseInt(sch_num);
	System.out.println(sch);
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
	Statement st = con.createStatement();
	String query = "delete from Train_Schedule where scheduleID=" + sch + ";";
	int s;
	s = st.executeUpdate(query);
	con.close();
	st.close();
	response.sendRedirect("ViewTrainSchedules.jsp");
%>
</form>
	<h4>Sort</h4>
	<form action="sDeleteTrainSchedule.jsp" method="POST">
		<select id="sort" name="sort">
			<option value="scheduleID">scheduleID</option>

		</select>
		<input type="submit" value="Submit"/>
	</form>
