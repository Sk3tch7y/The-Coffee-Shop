
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
    // Get user info from register.jsp
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phonenum = request.getParameter("phonenum");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String postalCode = request.getParameter("postalCode");
    String country = request.getParameter("country");
    String userid = request.getParameter("userid");
    String password = request.getParameter("password");

    // Database connection
    String url = "jdbc:sqlserver://cosc304-sqlserver:1433;databaseName=orders;trustServerCertificate=true";
    String uid = "SA";
    String pw = "304#sa#pw";
    String id = request.getParameter("prodId");
	try{
        Connection con  =  DriverManager.getConnection(url, uid, pw);
    // Check if user info exists in the customer database
        PreparedStatement checkStmt = con.prepareStatement("SELECT * FROM customer WHERE user = ? OR email = ?");
        checkStmt.setString(1, userid);
        checkStmt.setString(2, email);
        ResultSet resultSet = checkStmt.executeQuery();

        if (resultSet.next()) {
            response.sendRedirect("register.jsp?error=exists");
        } else {
            //insert user into customer
            PreparedStatement stmt = con.prepareStatement("INSERT INTO customer (userid, password, email, phonenum, address, city, state, postalCode, country, firstName, lastName) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            stmt.setString(1, userid);
            stmt.setString(2, password);
            stmt.setString(3, email);
            stmt.setString(4, phonenum);
            stmt.setString(5, address);
            stmt.setString(6, city);
            stmt.setString(7, state);
            stmt.setString(8, postalCode);
            stmt.setString(9, country);
            stmt.setString(10, firstName);
            stmt.setString(11, lastName);
            stmt.executeUpdate();
            stmt.close();
            con.close();
            response.sendRedirect("login.jsp");
        }

    }
    catch (SQLException e) {
        out.print(e);
    }
%>
