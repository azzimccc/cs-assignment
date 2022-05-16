/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rent.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import rent.bean.carBean;
import rent.util.DBC;

/**
 *
 * @author MKA
 */
public class rentController extends HttpServlet 
{
	/**
	 * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		response.setContentType("text/html;charset=UTF-8");
		List errorMsgs = new LinkedList();
		try (PrintWriter out = response.getWriter()) 
		{
			/* TODO output your page here. You may use following sample code. */
			
			//Get parameter
			String car_plate = request.getParameter("car_plate");
			String car_name = request.getParameter("car_name");
			String car_brand = request.getParameter("car_brand");
			String car_capacity = request.getParameter("car_capacity");
            String car_rent = request.getParameter("car_rent");
			String car_mileage = request.getParameter("car_mileage");
			String car_status = request.getParameter("car_status");
            
            // Form verification
			if( car_plate == null || car_plate.trim().length() == 0)
			{
				errorMsgs.add("Please enter the Car plate number.");
			}
            if( car_name == null || car_name.trim().length() == 0)
			{
                errorMsgs.add("Please enter the Car name.");
            }
			if( car_brand == null || car_brand.trim().length() == 0)
			{
                errorMsgs.add("Please enter the Car brand.");
            } 
            if( car_capacity == null || car_capacity.trim().length() == 0 )
			{
                    errorMsgs.add("Please enter the Car capacity.");
            } 
			if( car_rent == null || car_rent.trim().length() == 0)
			{
                errorMsgs.add("Please enter the Car rent.");
            } 
            if( car_mileage == null || car_mileage.trim().length() == 0)
			{
                errorMsgs.add("Please enter the Car mileage.");
            } 
            
            if(!errorMsgs.isEmpty() )
			{
                request.setAttribute("errorMsgs", errorMsgs);
                RequestDispatcher view = request.getRequestDispatcher("/error.jsp");
                view.forward(request, response);
                return;
            }
            
            Connection con = null;
            Statement statement = null;
            ResultSet resultSet = null;
            
            try
            {
                //
                con = DBC.createConnection();
                /*
                PreparedStatement st1 = con.prepareStatement("select max(id)+1 from staff");
                ResultSet rs = st1.executeQuery();
                String id = "";
                while(rs.next())
                {
                    id = rs.getString(1);
					if(id == null)
						id = "1";
                }
				*/
                String sql = "INSERT INTO CAR (CAR_PLATE,CAR_NAME,CAR_BRAND,CAR_CAPACITY,CAR_RENT,CAR_MILEAGE,CAR_STATUS)"
						+ " values (?,?,?,?,?,?,?)";
				
                PreparedStatement st = con.prepareStatement(sql);
                st.setString(1, car_plate);
                st.setString(2, car_name);
                st.setString(3, car_brand);
                st.setString(4, car_capacity);
				st.setString(5, car_rent);
				st.setString(6, car_mileage);
				st.setString(7, car_status);
                st.executeUpdate();

                st.close();
                con.close();
                //
                // Dispatch to Success view
                RequestDispatcher view = request.getRequestDispatcher("/admin.jsp");
                view.forward(request, response);
				
            }
            catch(SQLException e)
            {
                e.printStackTrace();
                errorMsgs.add("An unexpected error: " + e.getMessage());
                request.setAttribute("errorMsgs", errorMsgs);
                RequestDispatcher view = request.getRequestDispatcher("/error.jsp");
                view.forward(request, response);
            }
            // Handle any unexpected expections
			
			/*OLD EXECUTE
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Servlet rentController</title>");			
			out.println("</head>");
			out.println("<body>");
			out.println("<h1>Servlet rentController at " + request.getContextPath() + "</h1>");
			out.println("</body>");
			out.println("</html>");
			*/
        } 
		catch(RuntimeException e)
		{
            errorMsgs.add("An unexpected error: " + e.getMessage());
            request.setAttribute("errorMsgs", errorMsgs);
            RequestDispatcher view = request.getRequestDispatcher("/error.jsp");
            view.forward(request, response);
		}
	}

	// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
	/**
	 * Handles the HTTP <code>GET</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Handles the HTTP <code>POST</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Returns a short description of the servlet.
	 *
	 * @return a String containing servlet description
	 */
	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>

}
