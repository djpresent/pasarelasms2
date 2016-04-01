package com.analixdata.controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.analixdata.modelos.Usuario;
import com.google.appengine.api.utils.SystemProperty;

public class ActualizarContrasena extends HttpServlet {

	
	@Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
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
	        String oldpass = req.getParameter("oldcod");
	        String newpass = req.getParameter("newcod");
	

	        
	        
	    	 u = (Usuario)session.getAttribute("usuario");
	        
	        if (u != null ) {
	        	
	        	System.out.println("contrasena antigua "+oldpass);
	        	
	        	if(oldpass.equals(u.getPassword())){
	        		
	        		System.out.println("contrasena antigua "+oldpass);
	        		        	
	        	String statement = "UPDATE usuario SET password=? WHERE idusuario=?";
		          PreparedStatement stmt = conn.prepareStatement(statement);

		          stmt.setString(1, newpass);
		          stmt.setInt(2, u.getId());
		          
		          int success = 2;
		          
		          System.out.println(statement);
		          
		          success = stmt.executeUpdate();
		          if (success == 1) {
		        	  
		        	  u.setPassword(newpass);
		        	  session.setAttribute("confCambioC", 1);
		            
		          } else if (success == 0) {
		        	  session.setAttribute("confCambioC", 2);
		          }
	        	}else{
	        		session.setAttribute("confCambioC", 3);
	       
	        	} 
	        }
	      } finally {
	        conn.close();
	      }
	    } catch (SQLException e) {
	      e.printStackTrace();
	      session.setAttribute("confCambioC", 3);
	    }
	    resp.sendRedirect("/usuario.jsp");
	  }
        
        else
    	{
        	session.invalidate();
    		resp.sendRedirect("/login.jsp");
    	}
        
	}
	

}
