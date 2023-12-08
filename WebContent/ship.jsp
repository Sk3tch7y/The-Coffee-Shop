<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>The Coffee Shop Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
	String ordernum = request.getParameter("orderId");
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
	
	try{
		
		Connection con  =  DriverManager.getConnection(url, uid, pw);
		PreparedStatement checkOrder = con.prepareStatement("SELECT * FROM ordersummary WHERE orderId = ?");
		
		// TODO: Start a transaction (turn-off auto-commit)
		con.setAutoCommit(false);
		con.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);

    	// TODO: Check if valid order id in database
		
		checkOrder.setString(1, ordernum);
		ResultSet order = checkOrder.executeQuery();
		order.next();
		// TODO: Retrieve all items in order with given id
		PreparedStatement custInventory = con.prepareStatement("SELECT * FROM orderproduct WHERE orderId = ?");
		custInventory.setString(1, ordernum);
		ResultSet custOrder = custInventory.executeQuery();

		// TODO: Create a new shipment record.
		PreparedStatement newShipment = con.prepareStatement("INSERT INTO shipment (shipmentDate, shipmentDesc, warehouseId) VALUES (?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
		//set current date
		newShipment.setDate(1, new java.sql.Date(System.currentTimeMillis()));
		newShipment.setString(2,"A description of the order");
		newShipment.setInt(3, 1); //sets primary warehouse
		newShipment.executeUpdate();
		
		ResultSet keys = newShipment.getGeneratedKeys();
		keys.next();

		PreparedStatement inventory = con.prepareStatement("SELECT * FROM productinventory WHERE productId = ?");
		PreparedStatement updateInv = con.prepareStatement("UPDATE productinventory SET quantity = ? WHERE productId = ?");
		// TODO: For each item verify sufficient quantity available in warehouse 1.
		while(custOrder.next()){
			
			inventory.setString(1, custOrder.getString("productId"));
			ResultSet prodInv = inventory.executeQuery();
			if(prodInv.next()){
				if(prodInv.getInt("quantity") < custOrder.getInt("quantity")){
					con.rollback();
					throw new Exception((String)("Not enough inventory for Item #" + custOrder.getString("productId") +"\n Amount left: "+ prodInv.getInt("quantity") + " You ordered: " + custOrder.getInt("quantity")));
				}
				else{
					out.println("<h2 class = 'shippedProduct'>Ordered Product " + custOrder.getString("productId") + " Quatity: " + custOrder.getInt("quantity") +" Amount left: "+ prodInv.getInt("quantity") + "</h2>" );
					updateInv.setInt(1, (int)(prodInv.getInt("quantity")-custOrder.getInt("quantity")));
					updateInv.setInt(2,custOrder.getInt("productId"));
					updateInv.executeUpdate();
				}
			}
			// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
			
		}

		con.commit();
		con.setAutoCommit(true);
		out.println("<h1>Order #" + ordernum + "</h1>");
		out.println("<h2>Thanks for Shopping with Joey's!</h2>");
	}
	catch(Exception e){
		e.printStackTrace();
		out.print("Error with order: " + e.getMessage());
	}
	
	// TODO: Start a transaction (turn-off auto-commit)
	
	
	
	// TODO: Create a new shipment record.
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	
	
	// TODO: Auto-commit should be turned back on
	
%>                       				

<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>
