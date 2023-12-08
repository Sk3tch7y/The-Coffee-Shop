<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>
<h1>Administrator Page</h1>
<table class = "dailySummary">
<%


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
    rs.close();
    Verify.close();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM customer;");
    ResultSet customers = ps.executeQuery();
    while(customers.next()){
        out.print("<tr><td>"+customers.getString("userId")+"</td><td>"+
        customers.getString("firstName")+customers.getString("lastName") +"</td><td>"+
        customers.getString("address")+"</td><td>"+
        customers.getString("phonenum")+"</td><td>"+
        customers.getString("email")+"</td></tr>");
    }
}
catch(SQLException e){
    out.print(e);
}


%>

<h2><a href='admin.jsp'>Back</a></h2>
</table>
</body>
</html>

