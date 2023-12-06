<%
	// Remove the user from the session to log them out
	session.removeAttribute("authenticatedUser");
	response.sendRedirect("index.jsp");		// Re-direct to main page
%>

