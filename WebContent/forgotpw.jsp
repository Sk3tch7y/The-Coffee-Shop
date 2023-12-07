<%@ page import="java.sql.*" %>

<%
    // Get the user's email from the request
    String email = request.getParameter("email");

    // Connect to the database
    String url = "jdbc:sqlserver://cosc304-sqlserver:1433;databaseName=orders;trustServerCertificate=true";
    String uid = "SA";
    String pw = "304#sa#pw";
    try {
        
        Connection con  =  DriverManager.getConnection(url, uid, pw);
        // Check if the email exists in the database
        PreparedStatement pstmt = con.prepareStatement("SELECT * FROM customer WHERE email = ?");
        pstmt.setString(1, email);
        ResultSet rst = pstmt.executeQuery();

        if (rst.next()) {
            // Email exists in the database
            out.println("<h1>Email sent!</h1>");
        } else {
            // Email does not exist in the database
            out.println("<h2>Email not found</h2>");
            out.println("<a href='register.jsp'>Register</a>");
        }
    } catch (SQLException e) {
        out.println(e); 
    }
%>
