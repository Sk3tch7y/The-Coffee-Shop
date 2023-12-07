<html>
<head>
<title>Ray's Grocery</title>
</head>
<body>

<h1>Enter your customer id and password to complete the transaction:</h1>

<form method="get" action="order.jsp">
<table>
<tr><td>Customer ID:</td><td><input type="text" name="customerId" size="20"></td></tr>
<tr><td>Password:</td><td><input type="password" name="password" size="20"></td></tr>
<tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
</table>
</form>

<h2>Or checkout with payment and shipping infor</h2>

<form method="get" action="order.jsp">
<table>
<tr><td>Card Name:</td><td><input type="text" name="cardName" size="20"></td></tr>
<tr><td>Card Number:</td><td><input type="text" name="cardNumber" size="20"></td></tr>
<tr><td>Card Expiration Date:</td><td><input type="text" name="cardExpirationDate" size="20"></td></tr>

<tr><td>Shipping Address:</td><td><input type="text" name="shippingAddress" size="20"></td></tr>
<tr><td>Shipping City:</td><td><input type="text" name="shippingCity" size="20"></td></tr>
<tr><td>Shipping State:</td><td><input type="text" name="shippingState" size="20"></td></tr>
<tr><td>Shipping Zip/Postal Code:</td><td><input type="text" name="shippingZip" size="20"></td></tr>

<tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
</table>
</form>

</body>
</html>

