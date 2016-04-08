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

import sun.reflect.generics.tree.BottomSignature;

import com.analixdata.modelos.DAO;
import com.analixdata.modelos.Servicio;
import com.analixdata.modelos.Transaccion;
import com.analixdata.modelos.Usuario;
import com.google.appengine.api.utils.SystemProperty;


public class ReportesUsuariosServlet extends HttpServlet
{
	
	protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException
	{
		String url = null;
		resp.setContentType("text/html;charset=UTF-8");
	
		HttpSession session = req.getSession();
        session = req.getSession();
        Usuario u = (Usuario)session.getAttribute("usuario"); 
        if (u!=null)
        {
			try
			{
				if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production) 
				{
			        // Load the class that provides the new "jdbc:google:mysql://" prefix.
					Class.forName("com.mysql.jdbc.GoogleDriver");
			        url = "jdbc:google:mysql://pasarelasms-1190:analixdata/pasarelasms?user=root&password=1234";
			   	} 
				else 
				{
			        // Local MySQL instance to use during development.
			        Class.forName("com.mysql.jdbc.Driver");
			        url = "jdbc:mysql://localhost:3306/pasarelasms?user=geo";
			   	}
			} catch (Exception e) 
			{
				e.printStackTrace();
				return;
			}
		 
			//Si fu� posible conectarse a la base de datos entonces continue
			try 
			{
				Connection conn = DriverManager.getConnection(url);
				try 
				{
					//
			    	String inputContinuarReportes=req.getParameter("btnContinuarReportes");
			    	//String inputConsultar = req.getParameter("btnConsultar");
					 String ser=req.getParameter("reporteServicio");
					
					String fechaDesde = req.getParameter("fechaDesde");
			    	String fechaHasta = req.getParameter("fechaHasta");
	
			    	//System.out.println(ser);
			    	if(inputContinuarReportes!=null)
			    	{
			    		session.setAttribute("servicio", ser);
					    session.setAttribute("fDesde", fechaDesde);
					    session.setAttribute("fHasta", fechaHasta);
					    resp.sendRedirect("reportesUsuarios.jsp");
			    	}
			    	else
			    	{
			    		
			    		int anterior=0;
			    		int c =0;
				    	if (Integer.parseInt(ser)==1)
				    	{
				    		//System.out.println("Entr� a SMS ");
				    		ArrayList<List> envios = new ArrayList<List>();
				    		Transaccion tran ;
				    		
					    	  
				    		
				    		 u = (Usuario)session.getAttribute("usuario");
				    		
		  
				    			ResultSet rs = conn.createStatement().executeQuery("SELECT idtransaccion,fecha,hora,retorno,plataforma,celular,mensaje,servicio.descripcion as servicio,concat(usuario.nombres,\" \",usuario.apellidos) as usuario, empresa.nombre as empresa,idEnvio FROM  pasarelasms.transaccion, pasarelasms.servicio,pasarelasms.usuario,pasarelasms.empresa WHERE servicio.idservicio=transaccion.idservicio AND usuario.idusuario= transaccion.idusuario and empresa.idempresa = transaccion.idempresa and empresa.idempresa="+u.getEmpresa().getIdEmpresa()+"  AND usuario.idusuario="+u.getId()+" AND fecha between '"+fechaDesde+"' AND '"+fechaHasta+"' order by idtransaccion desc; ");
				    			List <Transaccion> transacciones =null;
				    			while(rs.next())
						    	{
				    				if (anterior==0)
				    				{
				    					 transacciones = new ArrayList<Transaccion> ();
				    					tran = new Transaccion(rs.getInt("idTransaccion"), rs.getString("fecha"), rs.getString("hora"), rs.getString("retorno"),rs.getString("plataforma"), rs.getString("celular"), rs.getString("mensaje"),rs.getString("servicio"), rs.getString("usuario"), rs.getString("empresa"),rs.getInt("idEnvio"));
				    					transacciones.add(tran);
				    					anterior=rs.getInt("idEnvio");
				    					c++;
				    					
				    				}
				    				else if (rs.getInt("idEnvio")==anterior)
				    				{
				    					tran = new Transaccion(rs.getInt("idTransaccion"), rs.getString("fecha"), rs.getString("hora"), rs.getString("retorno"),rs.getString("plataforma"), rs.getString("celular"), rs.getString("mensaje"),rs.getString("servicio"), rs.getString("usuario"), rs.getString("empresa"),rs.getInt("idEnvio"));
				    					transacciones.add(tran);
				    					anterior=rs.getInt("idEnvio");
				    					c++;
				    				}
				    				else
				    				{
				    					//System.out.println("Existen "+c+" mensajes para el grupo "+anterior);
				    					envios.add(transacciones);
				    					transacciones = new ArrayList<Transaccion> ();
				    					tran = new Transaccion(rs.getInt("idTransaccion"), rs.getString("fecha"), rs.getString("hora"), rs.getString("retorno"),rs.getString("plataforma"), rs.getString("celular"), rs.getString("mensaje"),rs.getString("servicio"), rs.getString("usuario"), rs.getString("empresa"),rs.getInt("idEnvio"));
				    					transacciones.add(tran);
				    					anterior=rs.getInt("idEnvio");
				    					c=1;
				    					
				    				}
						        	
						    	 }
				    			
				    		if (c>0)
				    		{
				    			envios.add(transacciones);
				    		}
				    		session.setAttribute("servicio", ser);
						    session.setAttribute("fDesde", fechaDesde);
						    session.setAttribute("fHasta", fechaHasta);
						    session.setAttribute("envios", envios);
						    //System.out.println(envios.size());
						    resp.sendRedirect("reportesUsuarios.jsp");
						    
						    
				    	}
				    	else if (Integer.parseInt(ser)==3)
				    	{
				    		ArrayList<List> envios = new ArrayList<List>();
				    		Transaccion tran ;
				    		List <Transaccion> transacciones = new ArrayList<Transaccion> ();
					    	  
				    		
				    		 u = (Usuario)session.getAttribute("usuario");
				    		 
				    		 //String empresa = u.getEmpresa().getNombre();
				    		
				    		
		  
				    		 ResultSet rs = conn.createStatement().executeQuery("SELECT idtwhatsapp,idinterno,fecha,hora,retorno,celular,mensaje,servicio.descripcion as servicio,concat(usuario.nombres,\" \",usuario.apellidos) as usuario, empresa.nombre as empresa,idEnvio FROM  pasarelasms.twhatsapp, pasarelasms.servicio,pasarelasms.usuario,pasarelasms.empresa WHERE servicio.idservicio=twhatsapp.idservicio AND usuario.idusuario= twhatsapp.idusuario and empresa.idempresa = twhatsapp.idempresa AND empresa.nombre= '"+u.getEmpresa().getNombre()+"' AND servicio.idservicio="+ser+" AND usuario.idusuario="+u.getId()+" AND fecha between '"+fechaDesde+"' AND '"+fechaHasta+"' order by idtwhatsapp desc; ");
			    				
				    		  while(rs.next())
					    	  {
				    			  if (anterior==0)
				    			  {
				    				  transacciones = new ArrayList<Transaccion> ();
				    				  tran = new Transaccion(rs.getInt("idtwhatsapp"), rs.getString("fecha"), rs.getString("hora"), rs.getString("retorno"),rs.getString("idinterno"), rs.getString("celular"), rs.getString("mensaje"),rs.getString("servicio"), rs.getString("usuario"), rs.getString("empresa"),rs.getInt("idEnvio"));
				    				  transacciones.add(tran);
				    				  anterior=rs.getInt("idEnvio");
				    					c++;
				    			  }
				    			  else if (rs.getInt("idEnvio")==anterior)
				    			  {
				    				  tran = new Transaccion(rs.getInt("idtwhatsapp"), rs.getString("fecha"), rs.getString("hora"), rs.getString("retorno"),rs.getString("idinterno"), rs.getString("celular"), rs.getString("mensaje"),rs.getString("servicio"), rs.getString("usuario"), rs.getString("empresa"),rs.getInt("idEnvio"));
				    				  transacciones.add(tran);
				    				  anterior=rs.getInt("idEnvio");
				    					c++;
				    			  }
				    			  else
				    			  {
				    				  envios.add(transacciones);
				    					transacciones = new ArrayList<Transaccion> ();
				    				  tran = new Transaccion(rs.getInt("idtwhatsapp"), rs.getString("fecha"), rs.getString("hora"), rs.getString("retorno"),rs.getString("idinterno"), rs.getString("celular"), rs.getString("mensaje"),rs.getString("servicio"), rs.getString("usuario"), rs.getString("empresa"),rs.getInt("idEnvio"));
				    				  transacciones.add(tran);
				    				  anterior=rs.getInt("idEnvio");
				    					c++;
				    			  }
				    			  
				    			
					        	//	tran = new Transaccion(rs.getInt("idtwhatsapp"), rs.getString("fecha"), rs.getString("hora"), rs.getString("retorno"),rs.getString("idinterno"), rs.getString("celular"), rs.getString("mensaje"),rs.getString("servicio"), rs.getString("usuario"), rs.getString("empresa"));
					        		//transacciones.add(tran);
					    	  }	
				    		  if (c>0)
				    		  {
				    		  envios.add(transacciones);
				    		  }
				    		  session.setAttribute("servicio", ser);
						    session.setAttribute("fDesde", fechaDesde);
						    session.setAttribute("fHasta", fechaHasta);
						    session.setAttribute("envios", envios);
						    resp.sendRedirect("reportesUsuarios.jsp");
				    	
				    	}
			    	}
				}
				finally 
				{
					conn.close();
				}
			} 
				catch (SQLException e) 
			{
				e.printStackTrace();
			}
			
        }
        else
	    {
	    	
	    	session.invalidate();
	    	RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
            PrintWriter out= resp.getWriter();
            out.println("<div class=\"alert alert-warning\" style=\"text-align: center;\"><strong>Lo sentimos! </strong>Su sesi�n a caducado. Por favor, vuelva a ingresar</div>	");
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
