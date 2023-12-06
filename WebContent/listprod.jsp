<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/standardStyle.css">
<link rel="stylesheet" type="text/css" href="css/productView.css">
<title>Joey's Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
Connection con;
try{
	String url = "jdbc:sqlserver://cosc304-sqlserver:1433;databaseName=orders;trustServerCertificate=true";
    String uid = "SA";
    String pw = "304#sa#pw";
	con  =  DriverManager.getConnection(url, uid, pw);
	// Print out the ResultSet
	
	//builds table element
	PreparedStatement pstmt = con.prepareStatement("SELECT productName, productId, productPrice, productDesc, productImage, productImageURL FROM product WHERE productName LIKE ? ORDER BY productName ASC");
	if(name == null){
		name = "";
	}
	pstmt.setString(1, "%"+name+"%");
	ResultSet rst = pstmt.executeQuery();
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	StringBuilder prod = new StringBuilder();
	prod.append("<table class = 'productDisplay'>");
	while(rst.next()){
		String productImageURL = rst.getString("productImageURL");
		String prodName = rst.getString("productName");
		prod.append("<tr class = 'productRow'> <td class = 'productDisplay'>");
		prod.append("<br>");
		if(rst.getBinaryStream("productImage") != null){
            prod.append("<img src = 'displayImage.jsp?id=" + rst.getString("productId") + "'class = 'img' alt = 'An image of " + prodName + "'></img>");
        }else{
			prod.append("<img src = '" + productImageURL + "' class = 'img' alt = 'An image of " + prodName + "'></img>");
		}
		prod.append("<br>");
		prod.append("<a href = product.jsp?prodId=" + rst.getString("productId") + ">" 
		+ rst.getString("productName") + "</a>");
		prod.append("<h3>");
		prod.append(currFormat.format(rst.getDouble("productPrice")));
		prod.append("</h3><h3>");
		prod.append(rst.getString("productDesc"));
		//if there is an image, display it
		prod.append("</h3>");
		//change page to addcart.jsp
		prod.append("<a class = 'addToCart' href='addcart.jsp?id=");
		//push name, price, and ID to cart page
		prod.append(rst.getString("productId"));
		
		prod.append("&price=");
		prod.append(rst.getDouble("productPrice"));
		prod.append("&name=");
		prod.append(rst.getString("productName"));
		prod.append("'>");
		prod.append("<h3>Add to Cart</h3></a></td></tr>");
	}
	prod.append("</table>");
	out.println(prod.toString());
		// For each product create a link of the form
		
		// Close connection
		con.close();
		// Useful code for formatting currency values:
		// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		// prod.println(currFormat.format(5.0);	// Prints $5.00
}
catch(NullPointerException e){
	out.println("<h2 class = 'notFound'>No products found</h2>");
}
catch (Exception e){
	out.println("Exception: " + e);
}

%>

</body>
</html>