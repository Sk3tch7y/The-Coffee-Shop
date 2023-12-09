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
	out.println("<form action='verifyChanges.jsp' method='POST'>"+
    "<label for='firstName'>First Name:</label>"+
    "<input type='text' id='firstName' name='firstName' value='"+ rst.getString("firstName")+ "'required><br><br> "+
    
    "<label for='lastName'>Last Name:</label>"+
    "<input type='text' id='lastName' name='lastName' value='"+rst.getString("lastName")+"'required><br><br>"+
    
    "<label for='email'>Email:</label>"+
    "<input type='email' id='email' name='email' value='"+rst.getString("email")+"'required><br><br>"+
    
    "<label for='phonenum'>Phone Number:</label>"+
    "<input type='text' id='phonenum' name='phonenum' value='"+rst.getString("phonenum")+"'required><br><br>"+
    
    "<label for='address'>Address:</label>"+
    "<input type='text' id='address' name='address' value='"+rst.getString("address")+"' required><br><br>"+
    
    "<label for='city'>City:</label>"+
    "<input type='text' id='city' name='city' value='"+rst.getString("city")+"'required><br><br>"+
    
    "<label for='state'>State:</label>"+
    "<input type='text' id='state' name='state' value='"+rst.getString("state")+"'required><br><br>"+
    
    "<label for='postalCode'>Postal Code:</label>"+
    "<input type='text' id='postalCode' name='postalCode' value='"+rst.getString("postalCode")+"'required><br><br>"+
    
    "<label for='country'>Country:</label>"+
    "<input type='text' id='country' name='country' value='"+rst.getString("country")+"'required><br><br>"+
    
    "<label for='userid'>Username:</label>"+
    "<input type='text' id='userid' name='userid' value='"+rst.getString("userId")+"'required><br><br>"+

    "<label for='oldPassword'>Old Password to confirm changes:</label>"+
    "<input type='password' id='oldPassword' name='oldPassword' required><br><br>"+

    "<label for='password'>new Password:</label>"+
    "<input type='password' id='password' value='' name='password'><br><br>"+
    "<label for='passwordCon'>Confirm Password:</label>"+
    "<input type='password' id='conPassword' value='' name='conPassword' ><br><br>"+
    
    "<input type='submit' value='Submit'>"+
"</form>");
}
catch(Exception e){
	out.println(e.getMessage());
}

// Make sure to close connection
%>

</body>
</html>



