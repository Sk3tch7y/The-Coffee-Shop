<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<html>
<head>
        <title>The Coffee Shop Main Page</title>
		<link rel="stylesheet" type="text/css" href="css/standardStyle.css">
		
</head>
<body>
<%@ include file="header.jsp" %>
<h1 text-align="left">Welcome to The Coffee Shop</h1>
<%
	String url = "jdbc:sqlserver://cosc304-sqlserver:1433;databaseName=orders;trustServerCertificate=true";
    String uid = "SA";
    String pw = "304#sa#pw";
try{
    Connection con  =  DriverManager.getConnection(url, uid, pw);
	String userID = (String)session.getAttribute("authenticatedUser");
	if(userID != null){
		out.println("<h2 align=\"left\">For You</h2>");
		PreparedStatement currentUser = con.prepareStatement("SELECT customerId FROM customer WHERE userId = ?");
		currentUser.setString(1, userID);
		ResultSet userss = currentUser.executeQuery();
		userss.next();
		userID = userss.getString("customerId");
		PreparedStatement past = con.prepareStatement("SELECT TOP 1 orderId FROM ordersummary WHERE customerId = ? ORDER BY orderDate DESC");
		past.setString(1, userID);
		ResultSet lastOrder = past.executeQuery();
		if(!lastOrder.next()) throw new SQLException("No orders");
		PreparedStatement lastItems = con.prepareStatement("SELECT productId FROM orderproduct WHERE orderId = ?");
		lastItems.setString(1, lastOrder.getString("orderId"));
		lastOrder.close();
		ResultSet items = lastItems.executeQuery();
		StringBuilder cat = new StringBuilder();
		cat.append("SELECT categoryId FROM product WHERE productId IN (");
		while(items.next()){
			cat.append(items.getString("productId")+ ", ");
		}
		cat.append("-1);");
		PreparedStatement yourCategory = con.prepareStatement(cat.toString());
		ResultSet category = yourCategory.executeQuery();
		StringBuilder prood = new StringBuilder();
		prood.append("SELECT productName, productId, productPrice, productDesc, productImage, productImageURL FROM product WHERE categoryId IN (");
		while(category.next()){
			prood.append(category.getString("categoryId")+ ", ");
		}
		prood.append("-1)ORDER BY productName DESC;");
		PreparedStatement productsLikeYours = con.prepareStatement(prood.toString());
		ResultSet products = productsLikeYours.executeQuery();
		items.close();
		category.close();
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		StringBuilder prod = new StringBuilder();
		prod.append("<table class = 'productDisplay'>");
		while(products.next()){
			String productImageURL = products.getString("productImageURL");
			String prodName = products.getString("productName");
			prod.append("<tr class = 'productRow'> <td class = 'productDisplay'>");
			prod.append("<br>");
			if(products.getBinaryStream("productImage") != null){
				prod.append("<img src = 'displayImage.jsp?id=" + products.getString("productId") + "'class = 'img' alt = 'An image of " + prodName + "'></img>");
			}else{
				prod.append("<img src = '" + productImageURL + "' class = 'img' alt = 'An image of " + prodName + "'></img>");
			}
			prod.append("<br>");
			prod.append("<a href = product.jsp?prodId=" + products.getString("productId") + ">" 
			+ products.getString("productName") + "</a>");
			prod.append("<h3>");
			prod.append(currFormat.format(products.getDouble("productPrice")));
			prod.append("</h3><h3>");
			prod.append(products.getString("productDesc"));
			//if there is an image, display it
			prod.append("</h3>");
			//change page to addcart.jsp
			prod.append("<a class = 'addToCart' href='addcart.jsp?id=");
			//push name, price, and ID to cart page
			prod.append(products.getString("productId"));
			
			prod.append("&price=");
			prod.append(products.getDouble("productPrice"));
			prod.append("&name=");
			prod.append(products.getString("productName"));
			prod.append("'>");
			prod.append("<h3>Add to Cart</h3></a></td></tr>");
		}
		prod.append("</table>");
		out.println(prod.toString());

	}else{
		out.println("<h2 align=\"left\">Our Most Popular</h2>");
		throw new SQLException("Not logged in");
	}
}catch(SQLException e){
	
	try{
		
		Connection con  =  DriverManager.getConnection(url, uid, pw);
		PreparedStatement popular = con.prepareStatement("SELECT productId, COUNT(productId) AS num FROM orderproduct GROUP BY productId ORDER BY num DESC ");
		ResultSet popularProducts = popular.executeQuery();
		String popInfo = "SELECT * FROM product WHERE productId IN (";
		
		StringBuilder cat = new StringBuilder();
		cat.append("SELECT TOP 8 * FROM product WHERE productId IN (");
		while(popularProducts.next()){
			
			cat.append(popularProducts.getString("productId") + ", ");
		}
		cat.append("-1);");
		PreparedStatement popularProductInfo = con.prepareStatement(cat.toString());
		
		ResultSet popularInfo = popularProductInfo.executeQuery();

		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		StringBuilder prod = new StringBuilder();
		prod.append("<table class = 'productDisplay'>");
		while(popularInfo.next()){
			String productImageURL = popularInfo.getString("productImageURL");
			String prodName = popularInfo.getString("productName");
			prod.append("<tr class = 'productRow'> <td class = 'productDisplay'>");
			prod.append("<br>");
			if(popularInfo.getBinaryStream("productImage") != null){
				prod.append("<img src = 'displayImage.jsp?id=" + popularInfo.getString("productId") + "'class = 'img' alt = 'An image of " + prodName + "'></img>");
			}else{
				prod.append("<img src = '" + productImageURL + "' class = 'img' alt = 'An image of " + prodName + "'></img>");
			}
			prod.append("<br>");
			prod.append("<a href = product.jsp?prodId=" + popularInfo.getString("productId") + ">" 
			+ popularInfo.getString("productName") + "</a>");
			prod.append("<h3>");
			prod.append(currFormat.format(popularInfo.getDouble("productPrice")));
			prod.append("</h3><h3>");
			prod.append(popularInfo.getString("productDesc"));
			//if there is an image, display it
			prod.append("</h3>");
			//change page to addcart.jsp
			prod.append("<a class = 'addToCart' href='addcart.jsp?id=");
			//push name, price, and ID to cart page
			prod.append(popularInfo.getString("productId"));
			
			prod.append("&price=");
			prod.append(popularInfo.getDouble("productPrice"));
			prod.append("&name=");
			prod.append(popularInfo.getString("productName"));
			prod.append("'>");
			prod.append("<h3>Add to Cart</h3></a></td></tr>");
		}
		prod.append("</table>");
		out.println(prod.toString());

	}
	catch(Exception ex){
		
	}

}
catch(Exception e){
	
}

%>

</body>
</head>


