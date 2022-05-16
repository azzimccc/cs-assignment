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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import rent.util.DBC;

/**
 *
 * @author MKA
 */
@WebServlet(name = "lesseeController", urlPatterns = {"/lessee.Controller"})
public class lesseeController extends HttpServlet {

	/**
	 * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		List errorMsgs = new LinkedList();
		try (PrintWriter out = response.getWriter()) 
		{
			/* TODO output your page here. You may use following sample code. */
			Connection con = null;
            Statement statement = null;
            ResultSet resultSet = null;
			boolean dup = false;
            
            try
            {
                //
                con = DBC.createConnection();
               
				String lIC = request.getParameter("ic");
				
				//Check for duplicate IC
				String sql1b = "SELECT LESSEE_IC, COUNT(LESSEE_IC) FROM LESSEE GROUP BY LESSEE_IC HAVING COUNT(LESSEE_IC) >= 1";
				PreparedStatement st1b = con.prepareStatement(sql1b);
				ResultSet rs1b = st1b.executeQuery();
				while(rs1b.next())
                {
					if(lIC.equals(rs1b.getString("LESSEE_IC")))
						dup = true;
                }
				
				//Insert new LESSEE if not duplicate
				if(!dup)
				{
					String sql1 = "INSERT INTO LESSEE (LESSEE_IC, LESSEE_NAME, LESSEE_PHONE, LESSEE_ADDRESS, LESSEE_EMPLOYMENT)"
							+ " values (?,?,?,?,?)";
					
					PreparedStatement st1 = con.prepareStatement(sql1);
					st1.setString(1, lIC);
					st1.setString(2, request.getParameter("name"));
					st1.setString(3, request.getParameter("telephone"));
					st1.setString(4, request.getParameter("address"));
					st1.setString(5, request.getParameter("employment"));
					st1.executeUpdate();
					
					st1.close();
				}
				PreparedStatement st = con.prepareStatement("SELECT MAX(RENTAL_NUM)+1 FROM RENTAL");
                ResultSet rs = st.executeQuery();
                String rNum = "";
                while(rs.next())
                {
                    rNum = rs.getString(1);
					if(rNum == null)
						rNum = "1";
                }
				
				String sql2 = "INSERT INTO RENTAL (RENTAL_NUM, LESSEE_IC, CAR_PLATE, RENTAL_DATE, RENTAL_PERIOD)"
						+ " VALUES (?,?,?,?,?)";
				
                PreparedStatement st2 = con.prepareStatement(sql2);
                st2.setString(1, rNum);
                st2.setString(2, lIC);
                st2.setString(3, request.getParameter("plateForForm"));
                st2.setString(4, request.getParameter("date"));
				st2.setString(5, request.getParameter("period"));
                st2.executeUpdate();
				
				String sql3 = "UPDATE CAR SET CAR_STATUS = 'Rented' WHERE CAR_PLATE = ?";
				PreparedStatement st3 = con.prepareStatement(sql3);
				st3.setString(1, request.getParameter("plateForForm"));
				st3.executeUpdate();
				
				st.close();
                st2.close();
				st3.close();
                con.close();
                //
                // Dispatch to Success view
                RequestDispatcher view = request.getRequestDispatcher("/print.jsp?printNum="+rNum);
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
