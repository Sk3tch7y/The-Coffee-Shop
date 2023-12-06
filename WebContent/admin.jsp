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


String sql = "SELECT orderDate, SUM(totalAmount) AS dayTotal from ordersummary GROUP BY orderDate";
String url = "jdbc:sqlserver://cosc304-sqlserver:1433;databaseName=orders;trustServerCertificate=true";
String uid = "SA";
String pw = "304#sa#pw";
try{
    Connection con  =  DriverManager.getConnection(url, uid, pw);
PreparedStatement pstmt = con.prepareStatement(sql);
ResultSet rst = pstmt.executeQuery();
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
while(rst.next()){
    String orderdate = rst.getString("orderDate");
    String money = currFormat.format(rst.getDouble("dayTotal"));
    out.print("<tr><td>"+ orderdate +"</td><td>" + money +"</td></tr>");
}
}
catch(SQLException e){
    out.print(e);
}


%>
</table>
</body>
</html>

