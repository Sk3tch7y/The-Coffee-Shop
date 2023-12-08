<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// TODO: Print Customer information

String url = "jdbc:sqlserver://cosc304-sqlserver:1433;databaseName=orders;trustServerCertificate=true";
String uid = "SA";
String pw = "304#sa#pw";

try{
	Connection con  =  DriverManager.getConnection(url, uid, pw);
	PreparedStatement pstmt = con.prepareStatement("SELECT * FROM customer WHERE userid = ?");
	pstmt.setString(1, userName);
	ResultSet rst = pstmt.executeQuery();
	rst.next();
	String custId = rst.getString("customerId");
	out.println("<table class = 'customerinfo'><tr><td><h1 class = 'title'>Customer Info</h1></td></tr>"+
	"<tr><td><h2>Personal Info</h2><table class = 'personalInfo'>"+
	"<tr><td><h3> Name: " + rst.getString("firstName") + ", " + rst.getString("lastName") +"</h3><td></tr>" +
	"<tr><td><h3> Email: " + rst.getString("email")+"</h3><td></tr>" +
	"<tr><td><h3> Phone Number: " + rst.getString("phonenum")+"</h3><td></tr>" +
	"</table></td></tr>"+ 
	"<tr><td><h2>Address</h2></td></tr>"+
	"<tr><td><table class = 'address'>"+
	"<tr><td><h3> Address:" + rst.getString("address") + " " +rst.getString("city") + " " + rst.getString("state") + " " + 
	rst.getString("postalCode")+ " " + rst.getString("country") + "</h3><td></tr>" +
	"</table></td></tr>"+
	"</table>");
	out.println("<h2><a href = 'editCustomer.jsp?custId="+ custId +"''>Edit Profile</a></h2>");
}
catch(Exception e){
	out.println(e.getMessage());
}



// Make sure to close connection
%>

</body>
</html>

