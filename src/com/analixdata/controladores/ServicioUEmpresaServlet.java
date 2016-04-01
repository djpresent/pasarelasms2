package com.analixdata.controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;

import com.analixdata.modelos.DAO;
import com.analixdata.modelos.Servicio;
import com.analixdata.modelos.Usuario;
import com.google.appengine.api.utils.SystemProperty;

public class ServicioUEmpresaServlet extends HttpServlet {

	protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException
	{
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
		 
		 try {
		      Connection conn = DriverManager.getConnection(url);
		      try {
			
		    	 
		    	  String usu=req.getParameter("userEmpresa");
		    	
		    	  String inputServicios=req.getParameter("btnServicios");
		    	  String inputGuardar=req.getParameter("btnGuardar");
		    	  String inputCancelar=req.getParameter("btnCancelar");
		    	  
		    	 // HttpSession session = req.getSession();
			    	 u = (Usuario)session.getAttribute("usuario");
		    	  
		    	  ResultSet rs;
		    	  
			       if(inputServicios!=null){  
			    	   
				    	  
			        	rs = conn.createStatement().executeQuery("Select A.idservicio,descripcion,idusuario from (SELECT servicio_empresa.idservicio,descripcion FROM pasarelasms.servicio_empresa,pasarelasms.empresa,pasarelasms.servicio WHERE empresa.idempresa='"+u.getEmpresa().getIdEmpresa()+"' and servicio_empresa.idservicio=servicio.idservicio and servicio_empresa.idempresa=empresa.idempresa) A left join (SELECT idservicio,idusuario   FROM pasarelasms.servicio_usuario WHERE idusuario="+usu+") B on A.idservicio=B.idservicio;");
				        
				        
				        List<Servicio> listaServicios=new ArrayList();
				        
				        while (rs.next()) {
				            int id =rs.getInt("idservicio");
				        	String descripcion = rs.getString("descripcion");
				        	
				        	int asignado=0;
				        	
				        
				        	
				        	if(rs.getInt("idusuario") > 0){
				        		asignado=1;
				        		
				        	}
				        	
				        	Servicio servicio=new Servicio(id,descripcion,asignado);
				        	
				        	listaServicios.add(servicio);
				        	
			        	}
				      
				    
				        session.setAttribute("idusuario", usu);
				   
				        session.setAttribute("serviciosU", listaServicios);
				        session.setAttribute("confServU", null); 
				        resp.sendRedirect("servicioUEmpresa.jsp");
				        
				        	
		 
			        	} else if(inputGuardar!=null){
			    	  
			    	  PrintWriter out = resp.getWriter();
			    	  
			    	
			    	  List<Servicio> listaS=(List<Servicio>)session.getAttribute("serviciosU");
			    	  
			    	  for(Servicio serv:listaS)
			    		  
			    	  {
			    		  String idser=req.getParameter(serv.getDescripcion());
			    		  
			    		  
			    		  
			    		 if(idser!=null && serv.getAsignado()==0){
			    			  String statement = "INSERT INTO servicio_usuario (idservicio,idempresa,idusuario) VALUES( ? , "+u.getEmpresa().getIdEmpresa()+" , ? )";
					          PreparedStatement stmt = conn.prepareStatement(statement);
					          stmt.setInt(1, serv.getIdServicio());
					   
					          stmt.setString(2, usu);
					          
					          int success = 2;
					          success = stmt.executeUpdate();
					         
					          if (success == 1) {
					        	  session.setAttribute("confServU", 1);
					        	  
							        
					          
					          } else if (success == 0) {
					        	  session.setAttribute("confServU", 2);
					        	  
					          }
					          
					          
			    		  }
			    		  
			    		  if(idser==null && serv.getAsignado()==1){
			    			  String statement = "DELETE FROM servicio_usuario WHERE idservicio="+serv.getIdServicio()+" and idusuario="+usu+";";
					          PreparedStatement stmt = conn.prepareStatement(statement);
					         				          
					          int success = 2;
					          success = stmt.executeUpdate();
					         
					          if (success == 1) {
					        	  session.setAttribute("confServU", 1);
					        	  
							        
					          
					          } else if (success == 0) {
					        	  session.setAttribute("confServU", 2);
					        	  
					          }
			    			  
			    		  }
			    		  
			    		   
			    		  
			    	  }
			    	
			          session.setAttribute("serviciosU", null);
			   
			          session.setAttribute("idusuario",null);
			        
			    	  
			         
			          
			          
			          resp.sendRedirect("servicioUEmpresa.jsp");
			      }else if(inputCancelar!=null){
			    	
			    	  session.setAttribute("serviciosU", null);
		
			          session.setAttribute("idusuario",null);
			          resp.sendRedirect("servicioUEmpresa.jsp");
			      }
			      
			      
			        
		
		      } finally {
			        conn.close();
			      }
			    } catch (SQLException e) {
			      e.printStackTrace();
			    }
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
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		processRequest(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(req, resp);
	}


}
