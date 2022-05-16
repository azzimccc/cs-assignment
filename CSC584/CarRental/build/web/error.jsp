<%-- 
    Document   : error
    Created on : Jun 7, 2020, 3:11:43 AM
    Author     : User
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <head>
		<title>Error Have Occured</title>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<style>
			body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", Arial, Helvetica, sans-serif}
			.mySlides {display: none}
		</style>
	</head>
    </head>
    <body>
        <h1>Error</h1>
        <%-- Report any errors (if any)--%>
        <c:if test="${not empty errorMsgs}">
            <p>
                <font color='red'> The following error(s) have occured:
                    <ul>
                        <c:forEach var="message" items="${errorMsgs}">
                            <li>${message}</li>
                        </c:forEach>
                    </ul>
                </font>
            </p>
        </c:if>
			<%
				String staff_id = (String) session.getAttribute("staff_id");
				if (null == staff_id)
				{	//If there is no session send to index.jsp
			%>
				<button class="w3-button w3-blue"><a href="index.jsp">Home</a></button>
			<%
				}
				else
				{	//If there is session send to admin.jsp
			%>
				<button class="w3-button w3-blue"><a href="admin.jsp">Home</a></button>
			<%
				}
			%>
    </body>
</html>
