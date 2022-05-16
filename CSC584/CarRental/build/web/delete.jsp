<%-- 
    Document   : delete.jsp
    Created on : Jul 9, 2020, 10:01:43 PM
    Author     : MKA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<sql:setDataSource var="rentalData" driver="org.apache.derby.jdbc.ClientDriver" url="jdbc:derby://localhost:1527/transport" user="car" password="car"/>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Deleting...</title>
    </head>
    <body>
		<%
			//Page Protection
			try
			{
				String staff_id = (String) session.getAttribute("staff_id");
				
				if (null == staff_id)
				{
					request.setAttribute("Error", "Please login.");
					RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
					rd.forward(request, response);
				}	
			}
			catch(Exception e)
			{
				
			}
		%>
        <c:set var="delete_plate" value="${param.plateForDelete}"/>
		
		<c:if test="${(delete_plate!=null)}">
            <sql:update var="test" dataSource="${rentalData}">
                DELETE FROM CAR 
				WHERE CAR_PLATE = ?
                <sql:param value="${delete_plate}"/>
            </sql:update>
        </c:if>
		<c:redirect url="/admin.jsp"/>
    </body>
</html>
