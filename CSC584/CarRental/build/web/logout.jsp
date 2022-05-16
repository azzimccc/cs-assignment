<%-- 
    Document   : logout
    Created on : Jun 30, 2020, 8:41:19 PM
    Author     : MKA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
			session.invalidate();
			response.sendRedirect("index.jsp");
		%>
    </body>
</html>
