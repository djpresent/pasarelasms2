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

import com.analixdata.modelos.Carga;
import com.analixdata.modelos.DAO;
import com.analixdata.modelos.Servicio;
import com.analixdata.modelos.Usuario;
import com.google.appengine.api.utils.SystemProperty;


public class ReporteCargas extends HttpServlet
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
		    	  //String ser=req.getParameter("servicio");
		    	  String inputContinuarReportes=req.getParameter("btnContinuarReportes");
		    	  String inputConsultar=req.getParameter("btnConsultar");
		    	  String fechaDesde = req.getParameter("fechaDesde");
		    	  String fechaHasta = req.getParameter("fechaHasta");
		    	  
		    	  System.out.println(empresa);
		    	  
		    	  
		    	  if(inputContinuarReportes!=null){  
		    	  
			        ResultSet rs = conn.createStatement().executeQuery("SELECT usuario.* FROM pasarelasms.usuario,pasarelasms.empresa WHERE usuario.idempresa=empresa.idempresa and usuario.estado=1 and empresa.nombre='"+empresa+"';");
		        	
			        List<Usuario> listaUsuarios=new ArrayList();
			        
			        while (rs.next()) {
			            int id =rs.getInt("idusuario");
			        	String nombre = rs.getString("nombres")+" "+rs.getString("apellidos");
			        	
			        	Usuario usuario=new Usuario(id,nombre);
			        	
			        	listaUsuarios.add(usuario);
			        	
	 
		        	}
			        
			        rs = conn.createStatement().executeQuery("SELECT servicio_empresa.idservicio,descripcion FROM pasarelasms.servicio_empresa,pasarelasms.empresa,pasarelasms.servicio WHERE nombre='"+empresa+"' and servicio_empresa.idservicio=servicio.idservicio and servicio_empresa.idempresa=empresa.idempresa;");
		        	
			        List<Servicio> listaServicios=new ArrayList();
			        
			        while (rs.next()) {
			            int id =rs.getInt("idservicio");
			        	String descripcion = rs.getString("descripcion");
			        	
			        	Servicio servicio=new Servicio(id,descripcion);
			        	
			        	listaServicios.add(servicio);
			        	
		        	}
			        
			        
			        session.setAttribute("empresa", empresa);
			        //session.setAttribute("usu", usu);
			        session.setAttribute("fDesde", fechaDesde);
			        session.setAttribute("fHasta", fechaHasta);
			        session.setAttribute("listaUsuarios", listaUsuarios);
			        session.setAttribute("listaServicios", listaServicios);
			        
			        resp.sendRedirect("reporteCargas.jsp");
			        
			    
		    	  }
		    	  else if (inputConsultar!=null)
		    	  {
		    		  
		    		  
		    		  PrintWriter out = resp.getWriter();

		    		  Carga tran ;
		    		  List <Carga> cargas = new ArrayList<Carga> ();
			    	  

			    	  if (empresa.equals("noempresa"))
			    	  {
			    		  ResultSet rs = conn.createStatement().executeQuery("SELECT idcarga, empresa.nombre as empresa,servicio.descripcion as servicio,concat(usuario.nombres,\" \",usuario.apellidos) as usuario,cantidad,fecha,hora FROM  pasarelasms.carga_servicio, pasarelasms.servicio,pasarelasms.usuario,pasarelasms.empresa WHERE servicio.idservicio=carga_servicio.idservicio AND usuario.idusuario= carga_servicio.idusuario and empresa.idempresa = carga_servicio.idempresa AND fecha between '"+fechaDesde+"' AND '"+fechaHasta+"' order by idcarga desc; ");
			    		  
				    	  
			    		  while(rs.next())
				    	  {
			    			//  System.out.println("Entró bucle ");
				        		tran = new Carga(rs.getInt("idcarga"), rs.getString("empresa"), rs.getString("servicio"), rs.getString("usuario"), rs.getInt("cantidad") , rs.getString("fecha"), rs.getString("hora"));
				        		cargas.add(tran);
				        		 
				    	  }
			    	  }
			    	  else if (usu.equals("nousuario"))
			    	  {
			    		  ResultSet rs = conn.createStatement().executeQuery("SELECT idcarga,empresa.nombre as empresa,servicio.descripcion as servicio,concat(usuario.nombres,\" \",usuario.apellidos) as usuario,cantidad, fecha,hora FROM  pasarelasms.carga_servicio, pasarelasms.servicio,pasarelasms.usuario,pasarelasms.empresa WHERE servicio.idservicio=carga_servicio.idservicio AND usuario.idusuario= carga_servicio.idusuario and empresa.idempresa = carga_servicio.idempresa AND empresa.nombre= '"+empresa+"' AND fecha between '"+fechaDesde+"' AND '"+fechaHasta+"' order by idcarga desc; ");

			    		  while(rs.next())
				    	  {
			    			//  System.out.println("Entró bucle ");
			    			  	tran = new Carga(rs.getInt("idcarga"), rs.getString("empresa"), rs.getString("servicio"), rs.getString("usuario"), rs.getInt("cantidad") , rs.getString("fecha"), rs.getString("hora"));
				        		cargas.add(tran);
				    	  }
			    	  }
			    	  else
			    	  {
			    		  ResultSet rs = conn.createStatement().executeQuery("SELECT idcarga,empresa.nombre as empresa,servicio.descripcion as servicio,concat(usuario.nombres,\" \",usuario.apellidos) as usuario,cantidad,fecha,hora FROM  pasarelasms.carga_servicio, pasarelasms.servicio,pasarelasms.usuario,pasarelasms.empresa WHERE servicio.idservicio=carga_servicio.idservicio AND usuario.idusuario= carga_servicio.idusuario and empresa.idempresa = carga_servicio.idempresa AND empresa.nombre= '"+empresa+"' AND usuario.idusuario="+usu+" AND fecha between '"+fechaDesde+"' AND '"+fechaHasta+"' order by idcarga desc; ");

			    		  while(rs.next())
				    	  {
			    			//  System.out.println("Entró bucle ");
			    			    tran = new Carga(rs.getInt("idcarga"), rs.getString("empresa"), rs.getString("servicio"), rs.getString("usuario"), rs.getInt("cantidad") , rs.getString("fecha"), rs.getString("hora"));
				        		cargas.add(tran);
				    	  }
			    	  }
			    	  
			    	  	
			    	  	session.setAttribute("empresa", empresa);
			    	  	//session.setAttribute("usu", usu);
				        session.setAttribute("fDesde", fechaDesde);
				        session.setAttribute("fHasta", fechaHasta);
				       // session.setAttribute("listaUsuarios", listaUsuarios);
				        //session.setAttribute("listaServicios", listaServicios);
				        session.setAttribute("cargas", cargas);
				        resp.sendRedirect("reporteCargas.jsp");
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
