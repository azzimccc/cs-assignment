<%-- 
    Document   : register
    Created on : Jul 12, 2020, 9:58:32 PM
    Author     : MKA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<style>
			body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", Arial, Helvetica, sans-serif}
			.mySlides {display: none}
		</style>
        <title>Car Rental: Register</title>
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
        <h1>Register New Staff</h1>
		<div class="w3-container">
			<hr style='height:2px;border-width:0;color:gray;background-color:gray'>
			<form action="staff.Controller" method="POST">
				<table class="w3-content">
						<col style="width: 50%">
						<tr>
							<th>Staff ID</th>
							<td><input class="w3-input w3-border" type='text' name='staff_id' required></td>
						</tr>
						<tr>
							<th>Password</th>
							<td><input class="w3-input w3-border" type='password' name='staff_password' required></td>
						</tr>
						<tr>
							<td>
								<input type="submit" class="w3-button w3-block w3-blue" value="Registar Staff">
							</td>
							<td>
								<button class="w3-button w3-block w3-grey" onclick="history.back()">Cancel</button>
							</td>
						</tr>
					</table>
			</form>
		</div>
    </body>
</html>
