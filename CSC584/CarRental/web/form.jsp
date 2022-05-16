<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<sql:setDataSource var="rentalData" driver="org.apache.derby.jdbc.ClientDriver" url="jdbc:derby://localhost:1527/transport" user="car" password="car"/>
<html>
	<head>
		<title>Car Rent: Form</title>
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
		<sql:query var="car_name" dataSource="${rentalData}">
			SELECT CAR_NAME FROM CAR WHERE CAR_PLATE = ?
			<sql:param value="${param.plateForForm}" />
		</sql:query>
		<!-- Lazy name getter from DB -->
		<c:set var="cName" value="${car_name.getRows()[0].values().toString().substring(1,car_name.getRows()[0].values().toString().length()-1)}"/></p>
	
		<h1>Rent Car Form </h1>
		<div class="w3-container">
			<form action="lessee.Controller" method='POST'>
				<div style="width:50%; float: left">
					<table style="text-align: left">
						<input type="hidden" name="plateForForm" value="${param.plateForForm}" />
						<tr>
							<th> Name </th> 
							<td><input class="w3-input w3-border" type='text' name='name' required></td>
						</tr>
						<tr>
							<th> IC </th>
							<td><input class="w3-input w3-border" type='text' placeholder='E.g: 990199053331' name='ic' required></td>
						</tr>
						<tr>
							<th> Telephone </th>
							<td><input class="w3-input w3-border" type='text' placeholder='E.g: 0195855373' name='telephone' required></td>
						</tr>
						<tr>
							<th> Address </th>
							<td><input class="w3-input w3-border" type='text' name='address' required></td>
						</tr>
						<tr>
							<th> Employement </th>
							<td>
								<select name="employment" class="w3-input w3-border" required>
									<option value="Working">Working</option>
									<option value="Student" selected>Student</option>
									<option value="Unemployed">Unemployed</option>
									<option value="Other">Other</option>
								</select>
							</td>
						</tr>
						<tr>
							<th> Rent Date </th>
							<td><input class="w3-input w3-border" type='text' placeholder='E.g: 31/12/18' name='date' required></td>
						</tr>
						<tr>
							<th> Number of Day </th>
							<td>
							<select name="period" class="w3-input w3-border" required>
								<option value="1">1 Day</option>
								<option value="2">2 Days</option>
								<option value="3">3 Days</option>
								<option value="4">4 Days</option>
								<option value="5">5 Days</option>
								<option value="6">6 Days</option>
								<option value="7">7 Days</option>
							</select></td>
						</tr>
					</table>
				</div>
				<div style="width:50%; display: inline-block">
					<img src="${pageContext.servletContext.contextPath}/img/${cName}.jpg" style="width:100%;margin-bottom:-6px">
					<h1><c:out value="${cName}"/></h1>
				</div>
				<h3>Deposit</h3>
				<p>
					Customers will need to make a RM100.00 deposit for the car reservation.
					This RM100.00 deposit will be returned four (4) days from the date of return of the car for the purpose of reviewing the local authorities, police, JPJ (if any).
					This deposit payment slip should be sent via whatsapp to our on-duty staff for the purpose of our records
				</p>
				<input type="submit" class="w3-button w3-half w3-green" value="Send Form" />
				<button class="w3-button w3-half w3-red" onclick="history.back()">Cancel</a></button>
			</form>
			<div>
				<br/><br/><hr style='height:2px;border-width:0;color:gray;background-color:gray'>
				<p>
					CONTACT US<br/>
					Shah Alam Car Rental - Sf Car Rental Agency<br/>
					Address: Jalan Kristal Tiga 7 / 76c, Section 7, 40000 Shah Alam, Selangor<br/>
					Phone: 017-244 9251<br/>
				</p>
			</div>
		</div>
	</body>
</html>
