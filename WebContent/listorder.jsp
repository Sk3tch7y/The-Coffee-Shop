<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Joey's Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	String url = "jdbc:sqlserver://cosc304-sqlserver:1433;databaseName=orders;trustServerCertificate=true";
    String uid = "SA";
    String pw = "304#sa#pw";
	
	Connection con  =  DriverManager.getConnection(url, uid, pw);
	PreparedStatement pstmt = con.prepareStatement("SELECT orderId, orderDate, customerId, totalAmount FROM ordersummary ORDER BY orderDate DESC;");
	ResultSet rst = pstmt.executeQuery();
	
	
	while(rst.next()){
		out.println("<table class = orderList>");
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		PreparedStatement customerName = con.prepareStatement("SELECT firstName, lastName FROM customer WHERE customerId = '" + rst.getInt("customerId") + "';");
		ResultSet nrst = customerName.executeQuery();
		
		out.println("<tr><th>Order ID</th><th>Order Date</th><th>Customer Name</th><th>Order Total</th></tr>");
		
		if (nrst.next()) {
            out.println("<tr><td>"+ rst.getInt("orderId") + "</td><td>"+ rst.getString("orderDate") +"</td>"
            +"<td>"+ nrst.getString("firstName") + " " + nrst.getString("lastName") +"</td>"
            +"<td>"+ currFormat.format(rst.getDouble("totalAmount")) +"</td></tr>");
        }else{
			out.println("<tr><td>"+ rst.getInt("orderId") + "</td><"+"<td>"+ rst.getString("orderDate") +"</td>"
			+"<td>"+ rst.getInt("customerId") +"</td>"+"<td>"+ "No Name Given" +"</td>" +
			"<td>"+ currFormat.format(rst.getDouble("totalAmount")) +"</td></tr>");
		}
		
		PreparedStatement orderProducts = con.prepareStatement("SELECT * FROM orderproduct WHERE orderid = " + rst.getInt("orderId") + ";");
		ResultSet prst = orderProducts.executeQuery();

		out.println("<table class = orderList>");
		out.println("<tr><th>Product ID</th><th>Product Name</th><th>Quantity</th><th>Price</th></tr>");
		while(prst.next()){
			PreparedStatement products = con.prepareStatement("SELECT productName FROM product WHERE productId = " + prst.getInt("productId") + ";");
			ResultSet pnrst = products.executeQuery();
			pnrst.next();
			out.println("<tr><td>"+ prst.getInt("productId") + "</td>"+"<td>"+ pnrst.getString("productName") +"</td>"
			+"<td>"+ prst.getInt("quantity") +"</td>" + "<td>"+ currFormat.format(prst.getDouble("price")) +"</td></tr>");
		}
		out.println("</table>");
	}
	out.println("</table>");
	con.close();
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}
catch(NullPointerException e){
	out.println("<h2 id = 'notFound'>No orders yet!</h2>");
}


// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection

// Write query to retrieve all order summary records

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
%>

</body>
</html>

