<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!--//stylesheet-->


<html>
<head>
<title>The Coffee Shop - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
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
	    PreparedStatement pstmt = con.prepareStatement("SELECT * FROM product WHERE productId = ?;");
        pstmt.setString(1, id);
	    ResultSet rst = pstmt.executeQuery();
        rst.next();
        String prodName = rst.getString("productName");
        String prodDesc = rst.getString("productDesc");
        String prodPrice = rst.getString("productPrice");
        String productImageURL = rst.getString("productImageURL");
        String categoryId = rst.getString("categoryId");
        out.println("<h1 class = 'title'>" + prodName + "</h1>");
        out.println("<h2 class = 'price'>" + prodPrice + "</h2>");
        out.println("<h2 class = 'desc'>" + prodDesc + "</h2>");
        out.println("<img src = '" + productImageURL + "' class = 'img' alt = 'An image of " + prodName + "'></img>");
        if(rst.getBinaryStream("productImage") != null){
            out.print("<img src = 'displayImage.jsp?id=" + id + "' class = 'img' alt = 'An image of " + prodName + "'></img>");
        }
        out.println("<br><a class = 'addToCart' href='addcart.jsp?id=");
		//push name, price, and ID to cart page
		out.print(rst.getString("productId"));
		out.print("&price=");
		out.print(rst.getDouble("productPrice"));
		out.print("&name=");
		out.print(rst.getString("productName"));
		out.print("'>");
		out.print("<h2>Add to Cart</h2></a>");
        out.println("<a class = 'cont' href = 'listprod.jsp'><h2>Continue Shopping</h2></a>");
        con.close();


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

