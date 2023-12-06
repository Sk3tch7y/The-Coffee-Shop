<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%
    @SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
    String prodId = request.getParameter("id");
    Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
    while(iterator.hasNext()){
        Map.Entry<String, ArrayList<Object>> entry = iterator.next();
        ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
        if(product.get(0).equals(prodId) && Integer.parseInt(product.get(3).toString()) <= 1){
            productList.remove(entry.getKey());
        }
        else{
            product.set(3, Integer.parseInt(product.get(3).toString())-1);
        }
    }
}
response.sendRedirect("showcart.jsp");
%>
