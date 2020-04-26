<%
    if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="Login.jsp">Please Login</a>
<%} else {
%>
<a href='Logout.jsp'>Log out</a>
<%// Renders different screens based on role %>
Welcome <%=session.getAttribute("user")%>
<% String role = ((String)session.getAttribute("role")).trim();
	System.out.println(role);
	if (role.equals("Customer")) {
%>
		<a>My Reservations</a>
		<a>View Train Schedules</a>
		<a href="sendQuestion.jsp">Ask a question</a>
		<%
    } else if (role.equals("Customer Representative")){
%>
		<p>Customer Rep screen</p>
<%
    } else if (role.equals("Manager")) {
%>
		<p>Manager Screen</p>
<%    	
    }
}
%>