<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!--//stylesheet-->


<html>
<head>
<title>The Coffee Shop - Product reviews</title>
<link href="css/standardStyle.css" rel="stylesheet">

</head>
<body>

<div class="container">
<%@ include file="header.jsp" %>

<%
String url = "jdbc:sqlserver://cosc304-sqlserver:1433;databaseName=orders;trustServerCertificate=true";
    String uid = "SA";
    String pw = "304#sa#pw";
    String id = request.getParameter("prodId");
	try{
        Connection con  =  DriverManager.getConnection(url, uid, pw);
	    PreparedStatement pstmt = con.prepareStatement("SELECT * FROM reviews WHERE productId = ?;");
        pstmt.setString(1, id);
	    ResultSet rst = pstmt.executeQuery();
        //display reviews
        out.println("<h2>Reviews for " + rst.getString("name") + "</h2>");
        while(rst.next){
            out.println("<h3>" + rst2.getString("reviewer: ") + "</h3><br>");
            out.println("<p>" + rst2.getString("review") + "</p>");
        }
    }
    catch(NullPointerException e){
        out.println("<h2>No product found with that ID</h2>");
    }
	catch(Exception e){
        out.println(e.getMessage());
    }

%>
</div>
</body>
</html>

