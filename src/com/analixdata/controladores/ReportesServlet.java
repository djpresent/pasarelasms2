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

import javax.mail.Session;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;

import com.analixdata.modelos.DAO;
import com.analixdata.modelos.Servicio;
import com.analixdata.modelos.Transaccion;
import com.analixdata.modelos.Usuario;
import com.google.appengine.api.utils.SystemProperty;


public class ReportesServlet extends HttpServlet
{
	
	protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException
	{
		String url = null;
		String confirmacion=null;
		
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
			
		    	  String empresa=req.getParameter("reporteEmpresa");
		    	  String usu=req.getParameter("reporteUsuario");
		    	  String ser=req.getParameter("reporteServicio");
		    	  String inputContinuarReportes=req.getParameter("btnContinuarReportes");
		    	  String inputContinuarUsuarios=req.getParameter("btnContinuarUsuarios");
		    	  String inputConsultar=req.getParameter("btnConsultar");
		    	  String fechaDesde = req.getParameter("fechaDesde");
		    	  String fechaHasta = req.getParameter("fechaHasta");
		    	  
		    	//  System.out.println(empresa);
		    	  
		    	  
		    	  if(inputContinuarReportes!=null)
		    	  {  
		    		  
		    		  ResultSet rs1 = conn.createStatement().executeQuery("SELECT DISTINCT servicio.idservicio,servicio.descripcion FROM pasarelasms.servicio_usuario,pasarelasms.empresa,pasarelasms.servicio WHERE servicio_usuario.idservicio=servicio.idservicio and servicio_usuario.idempresa=empresa.idempresa and  empresa.nombre='"+empresa+"';");
			        	
				        List<Servicio> listaServicios=new ArrayList();
				        
				        while (rs1.next()) {
				            int id =rs1.getInt("idservicio");
				        	String descripcion = rs1.getString("descripcion");
				        	System.out.println(descripcion);
				        	Servicio servicio=new Servicio(id,descripcion);
				        	
				        	listaServicios.add(servicio);
				        	
		 
			        	}
				        
				        
				        ResultSet rs = conn.createStatement().executeQuery("SELECT usuario.* FROM pasarelasms.usuario,pasarelasms.servicio_usuario,pasarelasms.empresa WHERE usuario.idusuario=servicio_usuario.idusuario AND servicio_usuario.idempresa=empresa.idempresa AND empresa.nombre='"+empresa+"'  AND servicio_usuario.idservicio="+ser);
			        	
				        List<Usuario> listaUsuarios=new ArrayList();
				        
				        
				        while (rs.next()) 
				        {
				            int id =rs.getInt("idusuario");
				        	String nombre = rs.getString("nombres")+" "+rs.getString("apellidos");
				        	System.out.println(id+"-"+nombre);
				        	Usuario usuario=new Usuario(id,nombre);
				        	
				        	listaUsuarios.add(usuario);
				        	
		 
			        	}
				        
		
				        
				        
				        session.setAttribute("empresa", empresa);
				        session.setAttribute("usu", usu);
				        session.setAttribute("fDesde", fechaDesde);
				        session.setAttribute("fHasta", fechaHasta);
				        session.setAttribute("listaUsuarios", listaUsuarios);
				        session.setAttribute("listaServicios", listaServicios);
				        
				        resp.sendRedirect("reportes.jsp");
		    		  
		    	  
			       
			    
		    	  }
		    	  else if(inputContinuarUsuarios!=null)
			        {  
			    	  
				        System.out.print("Ingreso");
		    		   ResultSet rs = conn.createStatement().executeQuery("SELECT usuario.* FROM pasarelasms.usuario,pasarelasms.servicio_usuario,pasarelasms.empresa WHERE usuario.idusuario=servicio_usuario.idusuario AND servicio_usuario.idempresa=empresa.idempresa AND empresa.nombre='"+empresa+"'  AND servicio_usuario.idservicio="+ser);
			        	
				        List<Usuario> listaUsuarios=new ArrayList();
				        //List<Servicio> listaServicios=new ArrayList();
				        
				        while (rs.next()) 
				        {
				            int id =rs.getInt("idusuario");
				        	String nombre = rs.getString("nombres")+" "+rs.getString("apellidos");
				        	System.out.println(id+"-"+nombre);
				        	Usuario usuario=new Usuario(id,nombre);
				        	
				        	listaUsuarios.add(usuario);
				        	
		 
			        	}
				        
		
				        
				        session.setAttribute("usu", "nousuario");
				        session.setAttribute("empresa", empresa);
				        session.setAttribute("ser", ser);
				        session.setAttribute("fDesde", fechaDesde);
				        session.setAttribute("fHasta", fechaHasta);
				        session.setAttribute("listaUsuarios", listaUsuarios);
				        //session.setAttribute("listaServicios", listaServicios);
				        
				        resp.sendRedirect("reportes.jsp");
				        
				        
			        }
		    	  else if (inputConsultar!=null)
		    	  {
		    		  
		    		  
		    		  PrintWriter out = resp.getWriter();

		    		  Transaccion tran ;
		    		  List <Transaccion> transacciones = new ArrayList<Transaccion> ();
			    	  

			    	  if (empresa.equals("noempresa"))
			    	  {
			    		  ResultSet rs = conn.createStatement().executeQuery("SELECT idtransaccion,fecha,hora,retorno,plataforma,celular,mensaje,servicio.descripcion as servicio,concat(usuario.nombres,\" \",usuario.apellidos) as usuario, empresa.nombre as empresa FROM  pasarelasms.transaccion, pasarelasms.servicio,pasarelasms.usuario,pasarelasms.empresa WHERE servicio.idservicio=transaccion.idservicio AND usuario.idusuario= transaccion.idusuario and empresa.idempresa = transaccion.idempresa AND fecha between '"+fechaDesde+"' AND '"+fechaHasta+"' order by idtransaccion desc; ");
			    		  
				    	  
			    		  while(rs.next())
				    	  {
			    			//  System.out.println("Entró bucle ");
				        		//tran = new Transaccion(rs.getInt("idTransaccion"), rs.getString("fecha"), rs.getString("hora"), rs.getString("retorno"),rs.getString("plataforma"), rs.getString("celular"), rs.getString("mensaje"),rs.getString("servicio"), rs.getString("usuario"), rs.getString("empresa"));
				        		//transacciones.add(tran);
				        		 
				    	  }
			    	  }
			    	  else if (ser.equals("noservicio"))
			    	  {
			    		  ResultSet rs = conn.createStatement().executeQuery("SELECT idtransaccion,fecha,hora,retorno,plataforma,celular,mensaje,servicio.descripcion as servicio,concat(usuario.nombres,\" \",usuario.apellidos) as usuario, empresa.nombre as empresa FROM  pasarelasms.transaccion, pasarelasms.servicio,pasarelasms.usuario,pasarelasms.empresa WHERE servicio.idservicio=transaccion.idservicio AND usuario.idusuario= transaccion.idusuario and empresa.idempresa = transaccion.idempresa AND empresa.nombre= '"+empresa+"' AND fecha between '"+fechaDesde+"' AND '"+fechaHasta+"' order by idtransaccion desc; ");

			    		  while(rs.next())
				    	  {
			    			//  System.out.println("Entró bucle ");
				        		//tran = new Transaccion(rs.getInt("idTransaccion"), rs.getString("fecha"), rs.getString("hora"), rs.getString("retorno"),rs.getString("plataforma"), rs.getString("celular"), rs.getString("mensaje"),rs.getString("servicio"), rs.getString("usuario"), rs.getString("empresa"));
				        		//transacciones.add(tran);
				    	  }
			    	  }
			    	  else if (usu.equals("nousuario"))
			    	  {
			    		//Sin son servicios de mensajeria SMS
			    		  if (Integer.parseInt(ser)==1)
			    		  {
				    		  ResultSet rs = conn.createStatement().executeQuery("SELECT idtransaccion,fecha,hora,retorno,plataforma,celular,mensaje,servicio.descripcion as servicio,concat(usuario.nombres,\" \",usuario.apellidos) as usuario, empresa.nombre as empresa FROM  pasarelasms.transaccion, pasarelasms.servicio,pasarelasms.usuario,pasarelasms.empresa WHERE servicio.idservicio=transaccion.idservicio AND usuario.idusuario= transaccion.idusuario and empresa.idempresa = transaccion.idempresa AND empresa.nombre= '"+empresa+"' AND servicio.idservicio="+ser+" AND fecha between '"+fechaDesde+"' AND '"+fechaHasta+"' order by idtransaccion desc; ");
	
				    		  while(rs.next())
					    	  {
				    			
					        		//tran = new Transaccion(rs.getInt("idTransaccion"), rs.getString("fecha"), rs.getString("hora"), rs.getString("retorno"),rs.getString("plataforma"), rs.getString("celular"), rs.getString("mensaje"),rs.getString("servicio"), rs.getString("usuario"), rs.getString("empresa"));
					        		//transacciones.add(tran);
					    	  }
			    		  }
			    		  else if (Integer.parseInt(ser)==3) //Si son servicios de Whatsapp
			    		  {
			    			  ResultSet rs = conn.createStatement().executeQuery("SELECT idtwhatsapp,idinterno,fecha,hora,retorno,celular,mensaje,servicio.descripcion as servicio,concat(usuario.nombres,\" \",usuario.apellidos) as usuario, empresa.nombre as empresa FROM  pasarelasms.twhatsapp, pasarelasms.servicio,pasarelasms.usuario,pasarelasms.empresa WHERE servicio.idservicio=twhatsapp.idservicio AND usuario.idusuario= twhatsapp.idusuario and empresa.idempresa = twhatsapp.idempresa AND empresa.nombre= '"+empresa+"' AND servicio.idservicio="+ser+" AND fecha between '"+fechaDesde+"' AND '"+fechaHasta+"' order by idtwhatsapp desc; ");
			    				
				    		  while(rs.next())
					    	  {
				    			
					        		//tran = new Transaccion(rs.getInt("idtwhatsapp"), rs.getString("fecha"), rs.getString("hora"), rs.getString("retorno"),rs.getString("idinterno"), rs.getString("celular"), rs.getString("mensaje"),rs.getString("servicio"), rs.getString("usuario"), rs.getString("empresa"));
					        		//transacciones.add(tran);
					    	  }
			    		  }
			    	  }
			    	  else
			    	  {
			    		  if (Integer.parseInt(ser)==1)
			    		  {
				    		  ResultSet rs = conn.createStatement().executeQuery("SELECT idtransaccion,fecha,hora,retorno,plataforma,celular,mensaje,servicio.descripcion as servicio,concat(usuario.nombres,\" \",usuario.apellidos) as usuario, empresa.nombre as empresa FROM  pasarelasms.transaccion, pasarelasms.servicio,pasarelasms.usuario,pasarelasms.empresa WHERE servicio.idservicio=transaccion.idservicio AND usuario.idusuario= transaccion.idusuario and empresa.idempresa = transaccion.idempresa AND empresa.nombre= '"+empresa+"' AND servicio.idservicio="+ser+" AND usuario.idusuario="+usu+" AND fecha between '"+fechaDesde+"' AND '"+fechaHasta+"' order by idtransaccion desc; ");
	
				    		  while(rs.next())
					    	  {
				    			
					        		//tran = new Transaccion(rs.getInt("idTransaccion"), rs.getString("fecha"), rs.getString("hora"), rs.getString("retorno"),rs.getString("plataforma"), rs.getString("celular"), rs.getString("mensaje"),rs.getString("servicio"), rs.getString("usuario"), rs.getString("empresa"));
					        		//transacciones.add(tran);
					    	  }
			    		  }
			    		  else if (Integer.parseInt(ser)==3) //Si son servicios de Whatsapp
			    		  {
			    			  ResultSet rs = conn.createStatement().executeQuery("SELECT idtwhatsapp,idinterno,fecha,hora,retorno,celular,mensaje,servicio.descripcion as servicio,concat(usuario.nombres,\" \",usuario.apellidos) as usuario, empresa.nombre as empresa FROM  pasarelasms.twhatsapp, pasarelasms.servicio,pasarelasms.usuario,pasarelasms.empresa WHERE servicio.idservicio=twhatsapp.idservicio AND usuario.idusuario= twhatsapp.idusuario and empresa.idempresa = twhatsapp.idempresa AND empresa.nombre= '"+empresa+"' AND servicio.idservicio="+ser+" AND usuario.idusuario="+usu+" AND fecha between '"+fechaDesde+"' AND '"+fechaHasta+"' order by idtwhatsapp desc; ");
			    				
				    		  while(rs.next())
					    	  {
				    			
					        	//	tran = new Transaccion(rs.getInt("idtwhatsapp"), rs.getString("fecha"), rs.getString("hora"), rs.getString("retorno"),rs.getString("idinterno"), rs.getString("celular"), rs.getString("mensaje"),rs.getString("servicio"), rs.getString("usuario"), rs.getString("empresa"));
					        	//	transacciones.add(tran);
					    	  }
			    		  }
			    	  }
			    	  
			    	  	
			    	  	session.setAttribute("empresa", empresa);
			    	  	session.setAttribute("usu", usu);
			    	  	session.setAttribute("ser", ser);
				        session.setAttribute("fDesde", fechaDesde);
				        session.setAttribute("fHasta", fechaHasta);
				        //session.setAttribute("listaUsuarios", listaUsuarios);
				        //session.setAttribute("listaServicios", listaServicios);
				        session.setAttribute("transacciones", transacciones);
				        resp.sendRedirect("reportes.jsp");
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
