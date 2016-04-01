package com.analixdata.controladores;

import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.analixdata.modelos.Usuario;
import com.google.appengine.api.utils.SystemProperty;

public class CargaSEmpresaServlet extends HttpServlet {
	
	@Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	    String url = null;
	    
	    resp.setContentType("text/html;charset=UTF-8");
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
	    	String idServicio = req.getParameter("idServicioCarga");
	        String servicio = req.getParameter("servicioCarga");
	        String empresa = req.getParameter("empresaC");
	        String cupo = req.getParameter("cupoCarga");

	        
	        String idEmpresa=null;
	        
	        System.out.println(servicio);
	        System.out.println("SELECT idempresa FROM empresa where nombre ='"+empresa+"';");
	        
	        ResultSet rs = conn.createStatement().executeQuery("SELECT idempresa FROM empresa where nombre ='"+empresa+"';");
        	
        	if(rs.first()){
        		
        		 idEmpresa=Integer.toString(rs.getInt("idempresa"));
        		 
        	}
        	 
        	
        	System.out.println(idEmpresa);
	        
	        if (idServicio == "" || idServicio == null || idEmpresa == "" || idEmpresa == null  ) {
	        	session.setAttribute("updateServEmp", 2);
	        	
	        	
	        } else {
	        	
	        	System.out.println("ENtrooooo");
	        	
	        	ResultSet rs3 = conn.createStatement().executeQuery("SELECT limite,disponible FROM servicio_empresa where idservicio ="+idServicio+" and idempresa="+idEmpresa+";");
	        	
	        	System.out.println("idServicio "+idServicio);
	        	
	        	
	        	int limiteact=0;
	        	
	        	int disponible=0;
	        	
	        	if(rs3.first()){
	        		
	        		 limiteact=rs3.getInt("limite");
	        		 disponible=rs3.getInt("disponible");
	        		 
	        	}
	        	
	        	
	        	ResultSet rs4 = conn.createStatement().executeQuery("SELECT disponible FROM servicio_empresa where idservicio ="+idServicio+" and idempresa=1;");

	        	
	        	int dispAnalix=0;
	        	
	        	if(rs4.first()){
	        		
	        		dispAnalix=rs4.getInt("disponible");
	        		 
	        	}
	        	
	        	
	        
	       
	        		disponible=Integer.parseInt(cupo)+disponible;
	        		limiteact=disponible;
	        		
	        		int esAnalix=0;
		        	
		        	if(Integer.parseInt(idEmpresa)==1){
		        		esAnalix=1;
		        		System.out.println("Es analix");
		        	}
		        	
	        	
	        	if(dispAnalix>=Integer.parseInt(cupo) || esAnalix==1){
	        			
	        		
	        		
	        		
	        		Calendar cal = Calendar.getInstance(); // creates calendar
    	    		
    		        cal.add(Calendar.HOUR_OF_DAY, -5); // adds one hour

    		         		        
    		     
	        		
	        	String statement = "UPDATE servicio_empresa SET limite=? , disponible=? where idservicio=? and idempresa=?;";
		          PreparedStatement stmt = conn.prepareStatement(statement);
		      
		          stmt.setInt(1, limiteact);
		          stmt.setInt(2, disponible);
		          stmt.setInt(3, Integer.parseInt(idServicio));
		          stmt.setInt(4, Integer.parseInt(idEmpresa));
		          int success = 2;
		          
		         
		          System.out.println("Consulta "+stmt.toString());
		          
		          
		          
		          success = stmt.executeUpdate();
		          
		          if(esAnalix==0){
		          int nuevoCupo=dispAnalix-Integer.parseInt(cupo);
		          
		          statement = "UPDATE servicio_empresa SET limite=? , disponible=? where idservicio=? and idempresa=1;";
		          stmt = conn.prepareStatement(statement);
		      
		          stmt.setInt(1, nuevoCupo);
		          stmt.setInt(2, nuevoCupo);
		          stmt.setInt(3, Integer.parseInt(idServicio));

		          success = stmt.executeUpdate();
		          }
		          
		          if (success == 1) {
		        	  	  String fecha= new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime()).toString();
		        	  	  String hora=new SimpleDateFormat("HH:mm:ss").format(cal.getTime()).toString();
		        	  
		        	  	  System.out.println("Antes de consulta");
		        	  	  
			        	  String statement1 = "INSERT INTO carga_servicio (idempresa,idservicio,idusuario,cantidad,fecha,hora) VALUES( ? , ? , ? , ? , ?, ?)";
			        	  System.out.println("Luego de consulta");
			        	  PreparedStatement stmt1 = conn.prepareStatement(statement1);
			        	  System.out.println("luego de stmt1");
				          stmt1.setInt(1, Integer.parseInt(idEmpresa));
				          stmt1.setInt(2, Integer.parseInt(idServicio));
				          stmt1.setInt(3, u.getId());
				          stmt1.setInt(4, Integer.parseInt(cupo));
				          stmt1.setString(5, fecha);
				          stmt1.setString(6, hora);
				    
				          	System.out.println(stmt1.toString());
				          success = stmt1.executeUpdate();
				          if (success == 1) {
				            session.setAttribute("updateServEmp", 1);
				          } else if (success == 0) {
				        	  session.setAttribute("updateServEmp", 2);
				          }
		        	  
		        	  
		        	  
		        	  
		          } else if (success == 0) {
		        	  session.setAttribute("updateServEmp", 2);
		          }
		          
		         
		          } else{
		        	  
		        	  System.out.println("No hay cupo");
		        	  session.setAttribute("updateServEmp", 3);
		          }
	          
	        }
	      } finally {
	        conn.close();
	      }
	    } catch (SQLException e) {
	    	session.setAttribute("updateServEmp", 2);
	    }
	    resp.sendRedirect("/servicioEmpresa.jsp");
        }
        else
	    {
	    	
	    	session.invalidate();
	    	RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
            PrintWriter out= resp.getWriter();
            out.println("<div class=\"alert alert-warning\" style=\"text-align: center;\"><strong>Lo sentimos! </strong>Su sesión ha caducado. Por favor, vuelva a ingresar</div>	");
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
