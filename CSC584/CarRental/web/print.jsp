<%-- 
    Document   : print
    Created on : Jul 9, 2020, 11:51:14 AM
    Author     : MKA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<sql:setDataSource var="rentalData" driver="org.apache.derby.jdbc.ClientDriver" url="jdbc:derby://localhost:1527/transport" user="car" password="car"/>
<html>
    <head>
		<title>Car Rent: Print</title>
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
	<body class="w3-content w3-border-left w3-border-right">
		<c:set var="print_num" value="${param.printNum}"/>
		<c:set var="cancel_num" value="${param.cancelNum}"/>
		<%
			String staff_id = (String) session.getAttribute("staff_id");
			if (null == staff_id)
			{	//If there is no session send to index.jsp
		%>
			<c:set var="Home" value="index.jsp" />
		<%
			}
			else
			{	//If there is session send to admin.jsp
		%>
			<c:set var="Home" value="admin.jsp" />
		<%
			}
		%>
		<c:choose>
		<c:when test="${(cancel_num!=null)}">	
			<sql:update var="test" dataSource="${rentalData}">
				UPDATE CAR
                SET CAR_STATUS = 'Available'
                WHERE CAR_PLATE = (SELECT CAR_PLATE FROM RENTAL WHERE RENTAL_NUM = ?)
				<sql:param value="${cancel_num}"/>
			</sql:update>
				
			 <sql:update var="test" dataSource="${rentalData}">
                DELETE FROM RENTAL 
				WHERE RENTAL_NUM = ?
                <sql:param value="${cancel_num}"/>
            </sql:update>
				
				<h1>Rent <c:out value="${print_num}" /> has been canceled</h1>
				<button class="w3-button w3-blue"><a href='<c:out value="${Home}" />'>Home</a></button>
        </c:when>
		<c:otherwise>
		<sql:query var="resultP" dataSource="${rentalData}">
			SELECT * FROM RENTAL R, CAR C, LESSEE L
			WHERE R.RENTAL_NUM = ?
			AND R.CAR_PLATE = C.CAR_PLATE
			AND R.LESSEE_IC = L.LESSEE_IC
			 <sql:param value="${print_num}"/>
        </sql:query>
		<c:forEach var="rowP" items="${resultP.rowsByIndex}">
		<div class="w3-main">
			<div class="w3-container">
				<center>
				<h2> Shah Alam - SF Car Rental </h2>
				<hr style='height:2px;border-width:0;color:gray;background-color:gray'>
				<table>
					<tr>
						<th>Name : <c:out value="${rowP[13]}" /></th>
					</tr>
					<tr>
						<th> IC : <c:out value="${rowP[12]}" /></th>
					</tr>
					<tr>
						<th> Telephone : <c:out value="${rowP[14]}" /> </th>
					</tr>
					<tr>
						<th> Address : <c:out value="${rowP[15]}" /> </th>
					</tr>
					<tr>
						<th> Employement : <c:out value="${rowP[16]}" /></th>
					</tr>
					<tr><td><hr style='height:2px;border-width:0;color:gray;background-color:gray'><td></tr>
					<tr>
						<th>Car Plate : <c:out value="${rowP[5]}" /></th>
					</tr>
					<tr>
						<th>Car Brand/Name : <c:out value="${rowP[6]}" /></th>
					</tr>
					<tr><td><hr style='height:2px;border-width:0;color:gray;background-color:gray'><td></tr>
					<tr>
					<table>
						<tr>
							<th>Pickup Date</th>
							<td><c:out value="${rowP[3]}" /></td>
						</tr>
						<tr>
							<th>Rent/Day</th>
							<td><c:out value="${rowP[9]}" /></td>
						</tr>
						<tr>
							<th>Duration</th>
							<td><c:out value="${rowP[4]}" /> days</td>
						</tr>
						<tr>
							<th>Sub Total</th>
							<td>RM<c:out value="${rowP[4] * rowP[9]}" /></td>
						</tr>
						<tr>
							<th></th>
							<td>+RM100 (Deposit)</td>
						</tr>
						<tr>
							<th>Total</th>
							<td>RM<c:out value="${(rowP[4] * rowP[9]) + 100}" /></td>
						</tr>
					</table>
					</tr>
				</table>
				</center>
				<font color='red'>
				<h3>Rental Number:  <c:out value="${rowP[0]}" /></h3>
				</font>
			</div>
			<hr style='height:2px;border-width:0;color:gray;background-color:gray'>
			<p>
				Note: Canceling after 24hours of rent submitted will be charged (RM2.00) for processing fee 
			<p>
			<button id="printbtn" class="w3-button w3-blue" onClick="window.print()">Print Form</button> 
			<input type="button" id="printbtn" class="w3-button w3-red" value="Cancel Rent" onclick="confirm_decision('${rowP[0]}');"> 
			<button id="printbtn" class="w3-right w3-button w3-blue"><a href='<c:out value="${Home}" />'>Home</a></button>
		</div>
		</c:forEach>
		</c:otherwise>
		</c:choose>
	<script>
		function confirm_decision(rent_id)
		{
			if(confirm("Confirm cancellation for "+rent_id+"\nCanceling after 24hours of form submission will be charged (RM2.00) for processing fee"))
			{
				window.location="print.jsp?rentNum="+rent_id+"&cancelNum="+rent_id; 
			}
			else
			{
				return false;
			}
			return true;
		}
	</script>
	</body>
	<style type="text/css">
	@media print 
	{
		#printbtn 
		{
			display :  none;
		}
	}
	</style>
</html>
