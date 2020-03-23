<%
    if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="Login.jsp">Please Login</a>
<%} else {
%>
<a href='Logout.jsp'>Log out</a>
Welcome <%=session.getAttribute("user")%>
<%
    }
%>