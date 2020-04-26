<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ask a question</title>
</head>
<body>
	<a href="Welcome.jsp">Back to Home</a>
	<h3>Ask a question to a customer rep</h3>
	<form action="sendQuestionDetails.jsp" method="POST">
		<input class="field" type="text" id="question" name="question" placeholder="Enter question here...">
		<input type="submit" value="Submit"/>
	</form>
</body>
</html>