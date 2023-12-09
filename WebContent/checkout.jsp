<html>
<head>
<title>The Coffee Shop</title>
</head>
<body>

<h2>Checkout with payment and shipping Information</h2>

<form method="get" action="anOrder.jsp">
<table>
<tr><td>Card Name:</td><td><input type="text" name="cardName" size="20"></td></tr>
<tr><td>Card Number:</td><td><input type="text" name="cardNumber" size="20"></td></tr>
<tr><td>Card Expiration Date(year-month):</td><td><input type="text" name="cardExpirationDate" size="20"></td></tr>

<tr><td>Shipping Address:</td><td><input type="text" name="shippingAddress" size="20"></td></tr>
<tr><td>Shipping City:</td><td><input type="text" name="shippingCity" size="20"></td></tr>
<tr><td>Shipping State:</td><td><input type="text" name="shippingState" size="20"></td></tr>
<tr><td>Shipping Zip/Postal Code:</td><td><input type="text" name="shippingZip" size="20"></td></tr>

<tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
</table>
</form>

</body>
</html>

