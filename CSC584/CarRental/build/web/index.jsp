<%-- 
    Document   : index
    Created on : Jun 26, 2020, 6:38:58 AM
    Author     : MKA
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<sql:setDataSource var="rentalData" driver="org.apache.derby.jdbc.ClientDriver" url="jdbc:derby://localhost:1527/transport" user="car" password="car"/>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
	<head>
		<title>Car Rent</title>
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
		<jsp:useBean id="car" scope="page" class="rent.bean.carBean" />
		<c:set var="s_number" value="${param.car_rent}"/>
		<c:set var="s_brand" value="${param.car_brand}"/>
		<c:set var="s_cap" value="${param.car_capacity}"/>
		
		<sql:query var="result" dataSource="${rentalData}">
			SELECT * FROM CAR
			WHERE CAR_STATUS = 'Available'
		</sql:query>
		<!--Side Bar-->
		<nav class="w3-sidebar w3-light-grey w3-collapse w3-top" style="z-index:3;width:260px" id="mySidebar">
			<div class="w3-container w3-display-container w3-padding-16">
				<h3>Search Available Car</h3>
				<h4>from RM65/day</h4>
				<hr>
				<!-- action_page tukor -->
				<form action="index.jsp" method="POST">
					<p><label><i class="fa fa-money"></i> Budget (RM)</label></p>
					<input class="w3-input w3-border" type="number" step="0.01" name="car_rent">  
					<p><label><i class="fa fa-car"></i> Brand</label></p>
					<input class="w3-input w3-border" type="text" name="car_brand">  
					<p><label><i class="fa fa-male"></i> Number of People</label></p>
					<input class="w3-input w3-border" type="number" name="car_capacity">
					<p>
						<button class="w3-button w3-block w3-green w3-left-align" type="submit">
							<i class="fa fa-search w3-margin-right"></i> Check Availability
						</button>
					</p>
					<a href="#contact" class="w3-bar-item w3-button w3-padding-16">
						<i class="fa fa-phone"></i> Contact
					</a>
				</form>
			</div>
		</nav>
		<!--Header-->
		<header class="w3-bar w3-top w3-hide-large w3-black w3-xlarge">
			<span class="w3-bar-item">Transport System Top Bar</span>
			<a href="javascript:void(0)" class="w3-right w3-bar-item w3-button" onclick="w3_open()"><i class="fa fa-bars"></i></a>
		</header>
		
		<!--IMPORTANT FOR OVERLAYING-->
		<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>
		<!--Content Here-->
		<div class="w3-main w3-white" style="margin-left:260px">
			<!--Search Bar-->
			<div class="w3-container">
				<hr style='height:2px;border-width:0;color:gray;background-color:gray'>
				<h2>Search by Input Rental Number</h2>
				<form action="print.jsp" method="GET">
				<input class="w3-input w3-half" type="text" name="printNum">
				<input class="w3-button w3-blue" type="submit" value="Search">
				</form>
				<a href="login.jsp"<button class="w3-button w3-green w3-right">Admin</button></a>
				<hr style='height:2px;border-width:0;color:gray;background-color:gray'>
			</div>
			<div class="w3-container" id="carList">
				<h1>Shah Alam - Sf Car Rental Agency</h1>
				<h2 class="w3-text-green">List of car(s)</h2>
				<!-- use mySlide class for 1 item-->
				<c:forEach var="row" items="${result.rowsByIndex}">
					<jsp:setProperty name="car" property="car_plate" value="${row[0]}" />
					<jsp:setProperty name="car" property="car_name" value="${row[1]}" />
					<jsp:setProperty name="car" property="car_brand" value="${row[2]}" />
					<jsp:setProperty name="car" property="car_capacity" value="${row[3]}" />
					<jsp:setProperty name="car" property="car_rent" value="${row[4]}" />
					<!-- Mileage number 5 -->
					<jsp:setProperty name="car" property="car_status" value="${row[6]}" />
	 
					<c:choose>
						<c:when test="${s_number != null || s_brand != null || s_cap !=null}">
							<c:if test="${car.checkSearch(s_number, s_brand, s_cap)}">
								<div class="w3-display-container mySlide">
								<img src="${pageContext.servletContext.contextPath}/img/${row[1]}.jpg" style="width:100%;margin-bottom:-6px">
								<div class="w3-display-bottomleft w3-container w3-black">
									<p><c:out value="${row[1]}"/></p>
								</div>
								</div>
								<p>
								Brand<span style="padding-left: 21px">: <c:out value="${row[2]}"/> <br/>
								Capacity<span style="padding-left: 2px">: <c:out value="${row[3]}"/> people<br/> 
								Cost<span style="padding-left: 31px">: <c:out value="${row[4]}"/> / day <br/>
								Status<span style="padding-left: 19px">: <c:out value="${row[6]}"/> <br/>
								</p>
								<p><form action="form.jsp" method="POST">
								<input type="hidden" name="plateForForm" value="${row[0]}" />
								<input type="submit" class="w3-button w3-green w3-third" value="Rent Car" />
								</form></p><br/>
								<hr style='height:2px;border-width:0;color:gray;background-color:gray'>
							</c:if>
						</c:when>
						<c:otherwise>
							<div class="w3-display-container mySlide">
							<img src="${pageContext.servletContext.contextPath}/img/${row[1]}.jpg" style="width:100%;margin-bottom:-6px">
							<div class="w3-display-bottomleft w3-container w3-black">
								<p><c:out value="${row[1]}"/></p>
							</div>
							</div>
							<p>
							Brand<span style="padding-left: 21px">: <c:out value="${row[2]}"/> <br/>
							Capacity<span style="padding-left: 2px">: <c:out value="${row[3]}"/> people<br/> 
							Cost<span style="padding-left: 31px">: <c:out value="${row[4]}"/> / day <br/>
							Status<span style="padding-left: 19px">: <c:out value="${row[6]}"/> <br/>
							</p>
							<p><form action="form.jsp" method="POST">
							<input type="hidden" name="plateForForm" value="${row[0]}" />
							<input type="submit" class="w3-button w3-green w3-third" value="Rent Car" />
							</form></p><br/>
							<hr style='height:2px;border-width:0;color:gray;background-color:gray'>
						</c:otherwise>
					</c:choose>
				
				</c:forEach>
			</div>
			<div>
				<br/><br/><hr style='height:2px;border-width:0;color:gray;background-color:gray'>
				<p>
					<a name="contact">CONTACT US</a><br/>
					Shah Alam Car Rental - Sf Car Rental Agency<br/>
					Address: Jalan Kristal Tiga 7 / 76c, Section 7, 40000 Shah Alam, Selangor<br/>
					Phone: 017-244 9251<br/>
				</p>
			</div>
		</div>
	</body>
	
	<!-- OPTIONAL SCRIPT-->
	<script>
		// Script to open and close sidebar when on tablets and phones
		function w3_open() 
		{
			document.getElementById("mySidebar").style.display = "block";
			document.getElementById("myOverlay").style.display = "block";
		}
		function w3_close() 
		{
			document.getElementById("mySidebar").style.display = "none";
			document.getElementById("myOverlay").style.display = "none";
		}
	</script>
</html>

