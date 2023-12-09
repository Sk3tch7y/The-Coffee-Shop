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
}
catch(SQLException e){
    out.print(e);
}


%>
<h2><a href='salesReport.jsp'>Sales Report</a></h2>
<h2><a href='shipNum.jsp'>Ship an order</a></h2>
<h2><a href='lisCust.jsp'>List customers</a></h2>
<h2><a href='loaddata.jsp'>restore database</a></h2>
<h2><a href='listorderAdmin.jsp'>List orders</a></h2>
</table>
</body>
</html>

