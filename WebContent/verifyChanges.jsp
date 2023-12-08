
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
    String confirm = request.getParameter("conPassword");

    // Database connection
    String url = "jdbc:sqlserver://cosc304-sqlserver:1433;databaseName=orders;trustServerCertificate=true";
    String uid = "SA";
    String pw = "304#sa#pw";
    String id = request.getParameter("custId");
    String oldPw = request.getParameter("oldPassword");
	try{
        
        Connection con  =  DriverManager.getConnection(url, uid, pw);
        if(!password.equals(confirm) && !password.equals("")){
            response.sendRedirect("register.jsp?error=confirm="+ password);
        }
        PreparedStatement checkPass = con.prepareStatement("SELECT customerId FROM customer WHERE password = ?");
        checkPass.setString(1, oldPw);
        ResultSet passResult = checkPass.executeQuery();
        if(!passResult.next() ){
            if(!id.equals(passResult.getString("customerId"))){
                response.sendRedirect("register.jsp?error=oldPw");
            }
        }
        else if(passResult.next()){
                // Check if user info exists in the customer database
            PreparedStatement checkStmt = con.prepareStatement("UPDATE customer SET firstName = ?, lastName = ?,  email = ?, phonenum = ?, address = ?, city = ?, state = ?, postalCode = ?, country = ?,"+
            "userId = ?, password = ?  WHERE customerId = ? AND password = ?");
            checkStmt.setString(1, firstName);
            checkStmt.setString(2, lastName);
            checkStmt.setString(3, email);
            checkStmt.setString(4, phonenum);
            checkStmt.setString(5, address);
            checkStmt.setString(6, city);
            checkStmt.setString(7, state);
            checkStmt.setString(8, postalCode);
            checkStmt.setString(9, country);
            checkStmt.setString(10, userid);
            checkStmt.setString(11, password);
            checkStmt.setString(12, id);
            checkStmt.setString(13, oldPw);
            checkStmt.executeUpdate();
            response.sendRedirect("login.jsp");

        }
    
    }
    catch (SQLException e) {
        out.print(e);
    }
    catch (Exception e) {
        out.print(e);
    }
%>
