package com.analixdata.controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.analixdata.modelos.Usuario;
import com.google.appengine.api.utils.SystemProperty;

public class RestablecerPasswordServlet extends HttpServlet {

	
	@Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/html;charset=UTF-8");
		String url = null;
	    
	    //HttpSession session = req.getSession();
        //session = req.getSession();
        //Usuario u = (Usuario)session.getAttribute("usuario"); 
        
	    
	    try
	    {
	      if (SystemProperty.environment.value() ==
	          SystemProperty.Environment.Value.Production) {
	        // Load the class that provides the new "jdbc:google:mysql://" prefix.
	        Class.forName("com.mysql.jdbc.GoogleDriver");
	        url = "jdbc:google:mysql://pasarelasms-1190:analixdata/pasarelasms?user=root&password=1234";
	      } else {
	        // Local MySQL instance to use during development.
	        Class.forName("com.mysql.jdbc.Driver");
	        url = "jdbc:mysql://localhost:3306/pasarelasms?user=geo";

	        // Alternatively, connect to a Google Cloud SQL instance using:
	        // jdbc:mysql://ip-address-of-google-cloud-sql-instance:3306/guestbook?user=root
	      }
	    } catch (Exception e) {
	    	
	      e.printStackTrace();
	      return;
	    }
	    
	    

	    PrintWriter out = resp.getWriter();
	    try 
	    {
	      Connection conn = DriverManager.getConnection(url);
	      try 
	      {
	        //String oldpass = req.getParameter("txtPass");
	        String newpass = req.getParameter("txtPass1");
	        String email = req.getParameter("mailo");

	        

	        		        	
	        	String statement = "UPDATE usuario SET password='"+newpass+"' WHERE email='"+email+"'";
		        PreparedStatement stmt = conn.prepareStatement(statement);

		        int success = 2;
		          
		        System.out.println(statement);
		          
		        success = stmt.executeUpdate();
		        if (success == 1) 
		        {
		        	RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
		            
			            out.println("<div class=\"alert alert-success\"  style=\"text-align: center;\"><strong>Contraseña actualizada exitosamente. Por favor ingrese de nuevo</div>	");
	       		
						try {
							rd.include(req, resp);
						} catch (ServletException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}  
		        	//  u.setPassword(newpass);
		        	 // session.setAttribute("confCambioC", 1);
		            
		          } else if (success == 0) {
		        	  //session.setAttribute("confCambioC", 2);
		        	  RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
			            
			            out.println("<div class=\"alert alert-danger\"  style=\"text-align: center;\"><strong>Fallo al actualizar su contraseña. Comuniquese con ANALIXDATA "+stmt+"  "+email+" </div>	");
	       		
						try {
							rd.include(req, resp);
						} catch (ServletException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} 
		          }
	        	
	        
	      } finally {
	        conn.close();
	      }
	    } catch (SQLException e) {
	      e.printStackTrace();
	      
	    }

        
	}
	

}
