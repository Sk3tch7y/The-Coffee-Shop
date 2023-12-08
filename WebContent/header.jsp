<html>
<head>
    <link rel="stylesheet" type="text/css" href="standardStyle.css" />
</head>
<body>
    
    <div class = "nav">
        <h2><a href="index.jsp">The Coffee Shop</a></h2>
        <% 
            String user = (String)session.getAttribute("authenticatedUser");
            if (user != null) {
                out.println("<h2>Welcome " + user + "</h2>");
                
                if(user.equals("admin")){
                    out.println("<h2><a href=\"admin.jsp?userId="+user+" \">Administrators</a></h2>");
                }
                out.println("<h2><a href=\"logout.jsp\">Log out</a></h2>");
            }else{
                out.println("<h2><a href='login.jsp'>Login</a></h2>");
            }
                out.println("<h2><a href=\"listprod.jsp\">Begin Shopping</a></h2>");
                out.println("<h2><a href=\"listorder.jsp\">List All Orders</a></h2>"); 
                out.println("<h2><a href=\"customer.jsp\">Customer Info</a></h2>");
            
        %>
        
        
    </div>
    
</body>
</html>