<%
    if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="Login.jsp">Please Login</a>
<%} else {
%>
<a href='Logout.jsp'>Log out</a>
<%// Renders different screens based on role askfnkasfkasfk %>
Welcome <%=session.getAttribute("user")%>
<% String role = ((String)session.getAttribute("role")).trim();
	System.out.println(role);
	if (role.equals("Customer")) {
%>
		<a href="viewReservations.jsp">My Reservations</a>
		<a href="ViewTrainSchedules.jsp">View Train Schedules</a>
		<a href="sendQuestion.jsp">Ask a question</a>
		<%
    } else if (role.equals("Customer Representative")){
%>
		<a href="respondToCustomerQuestion.jsp">Respond to Customer Questions</a>
		<a href="AddTrainSchedule.jsp">Add a Train Schedule</a>
		<a href="DeleteTrainSchedule.jsp">Delete a Train Schedule</a>
	        <a href="EditTrainSchedule.jsp">Edit a Train Schedule</a>
		<a href="RepMakeReservation.jsp">Make a Reservation</a>
		<a href="deleteReservation.jsp">Delete a Reservation</a>
		<a href="EditReservation.jsp">Edit a Reservation</a>
		<a href="ListTrainSchedulesOriginDest.jsp">List Train Schedules by Origin and Destination</a>
		<a href="ListTrainSchedulesStation.jsp">List Train Schedules by Station</a>
		<a href="ListCustomers.jsp">List Customers</a>
<%
    } else if (role.equals("Manager")) {
		response.sendRedirect("Manage.jsp");
    }
}
%>
