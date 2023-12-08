<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Login Screen</title>
</head>
<body>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Please Login to System</h3>

<%
// Print prior error login message if present
String veri = "SELECT * FROM customer WHERE userId = ?";
String url = "jdbc:sqlserver://cosc304-sqlserver:1433;databaseName=orders;trustServerCertificate=true";
String uid = "SA";
String pw = "304#sa#pw";
try{
    Connection con  =  DriverManager.getConnection(url, uid, pw);
    PreparedStatement Verify = con.prepareStatement(veri);
    Verify.setString(1, session.getAttribute("authenticatedUser").toString());
    ResultSet rs = Verify.executeQuery();
    if(!rs.next()){
        response.sendRedirect("login.jsp");
    }
}
catch(SQLException e){
    out.print(e);
}
%>

<br>
<form name="MyForm" method=post action="ship.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Order Id For shipping:</font></div></td>
	<td><input type="text" name="orderId"  size=10 maxlength=10></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>

</div>
<a href="admin.jsp">back</a>
</body>
</html>

