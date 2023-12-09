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
<title>Joey's Grocery Order Processing</title>
</head>
<body>

<% 
// Get customer id
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
// Determine if there are products in the shopping cart
// If either are not true, display an error message

// Make connection
try{

	String url = "jdbc:sqlserver://cosc304-sqlserver:1433;databaseName=orders;trustServerCertificate=true";
    String uid = "SA";
    String pw = "304#sa#pw";

	Connection con  =  DriverManager.getConnection(url, uid, pw);
	String address = request.getParameter("shippingAddress");
    String city = request.getParameter("shippingCity");
    String state = request.getParameter("shippingState");
    String postalCode = request.getParameter("shippingZip");
	String cardNumber = request.getParameter("cardNumber");
	String cardExpiryDate = request.getParameter("cardExpirationDate");
	String cardHolderName = request.getParameter("cardName");
	String cardType = "auto";
    //create prepared statement to insert order payment record
    PreparedStatement payment = con.prepareStatement("INSERT INTO paymentMethod (paymentNumber, paymentExpiryDate, customerId, paymentType) VALUES (?, ?, ?, ?)");
	cardExpiryDate = cardExpiryDate + "-01";
	payment.setString(1, cardNumber);
	payment.setDate(2, java.sql.Date.valueOf(cardExpiryDate));
	payment.setString(3, null);
	payment.setString(4, cardType);
	payment.executeUpdate();
	// Create prepared statement to insert order record
	PreparedStatement pstmt = con.prepareStatement("INSERT INTO ordersummary (orderDate, totalAmount, shipToAddress, shipToCity, shipToState, shipToPostalCode, customerId)"+
	" VALUES (?, ?, ?, ?, ?, ?, ?);", Statement.RETURN_GENERATED_KEYS);

	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	double orderTotal = 0;
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		double pr = Double.parseDouble((String) product.get(2));
		int qty = ((Integer)product.get(3)).intValue();
		orderTotal = orderTotal + (pr * qty);
	}

	
	pstmt.setDate(1, new java.sql.Date(System.currentTimeMillis()));
	pstmt.setDouble(2, orderTotal);
	pstmt.setString(3, address);
	pstmt.setString(4, city);
	pstmt.setString(5, state);
	pstmt.setString(6, postalCode);
	pstmt.setString(7, null);
	pstmt.executeUpdate();
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	String orderNum = keys.getString(1); 
	PreparedStatement orderproduct = con.prepareStatement("INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)");
	iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ((Integer)product.get(3)).intValue();
		orderproduct.setString(1, orderNum);
		orderproduct.setString(2, productId);
		orderproduct.setInt(3, qty);
		orderproduct.setDouble(4, pr);
		orderproduct.executeUpdate();
	}
	//close shopping cart and connection
	session.removeAttribute("productList");
	con.close();
	response.sendRedirect("ship.jsp?orderId=" + orderNum);
}
catch(NullPointerException e){
	out.println("No products in cart");
	response.sendRedirect("index.jsp");
}
catch(SQLException e){
	out.println(e);
			return;
}
catch(Exception e){
	out.println(e);
			return;
}


// Save order information to database


	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/

// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully
%>
</BODY>
</HTML>

