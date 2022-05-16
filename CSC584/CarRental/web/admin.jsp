<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<sql:setDataSource var="rentalData" driver="org.apache.derby.jdbc.ClientDriver" url="jdbc:derby://localhost:1527/transport" user="car" password="car"/>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
	<head>
		<title>Car Rent: Admin</title>
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
		
		<c:set var="car_plate" value="${param.CAR_PLATE}"/>
        <c:set var="car_name" value="${param.CAR_NAME}" />
        <c:set var="car_brand" value="${param.CAR_BRAND}" />
        <c:set var="car_capacity" value="${param.CAR_CAPACITY}" />
		<c:set var="car_rent" value="${param.CAR_RENT}" />
		<c:set var="car_mileage" value="${param.CAR_MILEAGE}" />
		<c:set var="car_status" value="${param.CAR_STATUS}" />
        
        <c:if test="${(car_plate!=null)}">
            <sql:update var="test" dataSource="${rentalData}">
                UPDATE CAR
                SET CAR_NAME = ?, CAR_BRAND = ?, CAR_CAPACITY = ?, CAR_RENT = ?, CAR_MILEAGE = ?, CAR_STATUS = ?
                WHERE CAR_PLATE = ?
                <sql:param value="${car_name}"/>
                <sql:param value="${car_brand}"/>
				<sql:param value="${car_capacity}"/>
				<sql:param value="${car_rent}"/>
				<sql:param value="${car_mileage}"/>
				<sql:param value="${car_status}"/>
				<sql:param value="${car_plate}"/>
            </sql:update>
        </c:if>
				
		<sql:query var="result" dataSource="${rentalData}">
			SELECT * FROM CAR
        </sql:query>
		<div class="w3-main">
			<div class="w3-container">
				<h3> Adminstrator Page </h3>
				<hr style='height:2px;border-width:0;color:gray;background-color:gray'>
				
				<button class="w3-button w3-grey w3-right"><a href="logout.jsp">Logout</a></button>
				<button class="w3-button w3-blue w3-right"><a href="register.jsp">Register</a></button>
				<button class="w3-button w3-blue w3-right"><a href="index.jsp">Main Page</a></button>
			</div>
			<!-- Car List-->
			<div class="w3-container w3-border-left w3-left-align">
				<h2>Car List</h2>
				Total Car : <c:out value="${result.rowCount}" />
				<hr style='height:2px;border-width:0;color:gray;background-color:gray'>
				<table style='table-layout: fixed'>
					<tr>
					<c:set var="columnNames" value="${result.columnNames}" />
					<c:forEach var="columnName" items="${columnNames}">
                        <th><c:out value="${columnName}"/></th>
					</c:forEach>
					</tr>
					<!-- column data -->
					<c:forEach var="row" items="${result.rowsByIndex}">
					<tr>    
					<c:choose>
						<c:when test="${row[0] == param.plateForEdit}">
						<form action="admin.jsp" method="POST">
						<c:forEach var="column" items="${row}" end="2" varStatus="status">
									<td><input type="text" name="${columnNames[status.index]}" value="${column}"></td>
						</c:forEach>
						<c:forEach var="column" items="${row}" begin="3" end="5" varStatus="status">
							<c:choose>
								<c:when test="${status.index == 3}">
									<td><input type="number" name="${columnNames[status.index]}" value="${column}"></td>
								</c:when>
								<c:otherwise>
									<td><input type="number" name="${columnNames[status.index]}" step="0.01"  value="${column}"></td>
								</c:otherwise>
							</c:choose>
						</c:forEach>
									<td><select name="CAR_STATUS" class="w3-input">
											<option value="Available"> Available </option>
											<option value="Repair"> Repair </option>
											<option value="Rented"> Rented </option>
									</select></td>
								<!-- Add new Form to edit HERE -->
								<td><input type="submit" class="w3-button w3-red" value="Save" /></td>
						</form>
							<form action="delete.jsp" method="POST">
								<td><input type="hidden" name="plateForDelete" value="${param.plateForEdit}"/>
								<input type="submit" class="w3-button w3-blue" value="Delete Car" /></td>
							</form>
						</c:when>
						<c:otherwise>
						<c:forEach var="column" items="${row}">
							<td><c:out value="${column}"/></td>
						</c:forEach>
							<td>
								<form action="admin.jsp" method="POST">
									<input type="hidden" name="plateForEdit" value="${row[0]}" />
									<input type="submit" class="w3-button w3-green" value="Edit" />
								</form>
							</td>
						</c:otherwise>
					</c:choose>
					</tr>
				</c:forEach>
					<tr>
						<form action="rent.Controller" method="POST">
						<td><input type="text" name="car_plate" value=""/></td>
						<td><input type="text" name="car_name" value=""/></td>
						<td><input type="text" name="car_brand" value=""/></td>
						<td><input type="number" name="car_capacity" value="" /></td>
						<td><input type="number" step="0.01" name="car_rent" value="" /></td>
						<td><input type="number" step="0.01" name="car_mileage" value=""/></td>
						<td>
							<select name="car_status" class="w3-input">
								<option value="Available"> Available </option>
								<option value="Repair"> Repair </option>
								<option value="Rented"> Rented </option>
							</select></td>
							<td><label>
								<input type="file" name="image"/>
								Add Picture
							</label></td>
						<td><input type="submit" class="w3-button w3-blue" value="Add Car" /></td>
						</form>
					</tr>
				</table>
				
				<h2>Rent List</h2>
			<sql:query var="resultR" dataSource="${rentalData}">
				SELECT * FROM RENTAL
			</sql:query>
				Total Car Rent: <c:out value="${resultR.rowCount}" />
				<hr style='height:2px;border-width:0;color:gray;background-color:gray'>
				<table>
					<tr>
						<th>Rent Num</th>
						<th>Personal Info</th>
						<th>Car Info</th>
						<th>Pickup Date</th>
					</tr>
					<!-- Load info from database to table below-->
					<c:forEach var="rowR" items="${resultR.rowsByIndex}">
					<tr>
						<!-- <th width="20%" rowspan="3"><button class="w3-button w3-blue">Rental Num: 0001</button></th> -->
						<td><button class="w3-button w3-blue w3-block">
								<a href="print.jsp?printNum=${rowR[0]}">
									<c:out value="${rowR[0]}" /></a>
							</button></td>
						<c:forEach var="columnR" items="${rowR}" begin="1" end="3">
							<td><c:out value="${columnR}"/></td>
						</c:forEach> 
						<td><button class="w3-button w3-red w3-block">
							<a href="print.jsp?cancelNum=${rowR[0]}">
								Cancel
						</button></td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</body>
	<style type="text/css">
	table {
		table-layout: fixed ;
		width: 100% ;
		overflow: hidden;
	}
	td {
		width: 10% ;
	}
	
	input {
		width: 100%;
	}
	</style>
</html>
