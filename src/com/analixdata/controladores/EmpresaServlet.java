package com.analixdata.controladores;

import java.io.*;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.analixdata.modelos.Usuario;
import com.google.appengine.api.utils.SystemProperty;

public class EmpresaServlet extends HttpServlet {
	
	@Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/html;charset=UTF-8");
		String url = null;
	    HttpSession session = req.getSession();
        session = req.getSession();
        Usuario u = (Usuario)session.getAttribute("usuario"); 
        if (u!=null)
        {
	    
	    try {
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
	    try {
	      Connection conn = DriverManager.getConnection(url);
	      try {
	        String direccion = req.getParameter("direccion");
	        String telefono = req.getParameter("telefono");
	        String contacto = req.getParameter("contacto");

	        
	       
	    	 u = (Usuario)session.getAttribute("usuario");
	        
	        if (u != null ) {
	        		        	
	        	String statement = "UPDATE empresa SET direccion=?, telefono=? ,contacto=?  WHERE idempresa=?";
		          PreparedStatement stmt = conn.prepareStatement(statement);

		          stmt.setString(1, direccion);
		          stmt.setString(2, telefono);
		          stmt.setString(3, contacto);

		          stmt.setInt(4, u.getEmpresa().getIdEmpresa());
		          int success = 2;
		          success = stmt.executeUpdate();
		          if (success == 1) {
		        	  
		        	  u.getEmpresa().setDireccion(direccion);
		        	  u.getEmpresa().setTelefono(telefono);
		        	  u.getEmpresa().setContacto(contacto);
		        	  
		        	  session.setAttribute("updateEmpresa", 1);
		          } else if (success == 0) {
		        	  session.setAttribute("updateEmpresa", 2);
		          }
	          
	        }
	      } finally {
	        conn.close();
	      }
	    } catch (SQLException e) {
	      e.printStackTrace();
	      session.setAttribute("updateEmpresa", 2);
	    }
	    resp.sendRedirect("/empresa.jsp");
        }
	    else
	    {
	    	
	    	session.invalidate();
	    	RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
            PrintWriter out= resp.getWriter();
            out.println("<div class=\"alert alert-warning\" style=\"text-align: center;\"><strong>Lo sentimos! </strong>Su sesión a caducado. Por favor, vuelva a ingresar</div>	");
            try 
            {
				rd.include(req, resp);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    	
	    }
	  }

}
