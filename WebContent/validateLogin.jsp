<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	String inSale = request.getParameter("checkout");

	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }
	

	if(authenticatedUser != null){
		if(inSale== "1"){
			response.sendRedirect("order.jsp");
		}else{
			response.sendRedirect("index.jsp");	
		}
	}
	else
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;

		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;

		try 
		{
			String url = "jdbc:sqlserver://cosc304-sqlserver:1433;databaseName=orders;trustServerCertificate=true";
    		String uid = "SA";
    		String pw = "304#sa#pw";
			Connection con  =  DriverManager.getConnection(url, uid, pw);
			
			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
			PreparedStatement pstmt = con.prepareStatement("SELECT userid, password, customerId FROM customer WHERE userid = ? AND password = ?");
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			retStr = rs.getString("userid");
						
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally
		{
			closeConnection();
		}	
		
		if(retStr != null)
		{	session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser", retStr);
		}
		else
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");

		return retStr;
	}
%>

