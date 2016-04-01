package com.analixdata.modelos;

import com.google.appengine.api.utils.SystemProperty;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAO {
	
	public Usuario existe(Usuario u)
	{
		
		
	    try {
	    	String url = "";
	    	if (SystemProperty.environment.value() ==
	    	    SystemProperty.Environment.Value.Production) {
	    	  // Load the class that provides the new "jdbc:google:mysql://" prefix.
	    	  Class.forName("com.mysql.jdbc.GoogleDriver");
	    	  url = "jdbc:google:mysql://pasarelasms-1190:analixdata/pasarelasms?user=root&password=1234";
	    	} else {
	    	  // Local MySQL instance to use during development.
	    	  Class.forName("com.mysql.jdbc.Driver");
	    	  url = "jdbc:mysql://localhost:3306/pasarelasms?user=geo";
	    	}
	        
	        Connection conn = DriverManager.getConnection(url);
		    ResultSet rs = conn.createStatement().executeQuery(
		        "SELECT * FROM usuario WHERE email='"+u.getEmail()+"' and password='"+u.getPassword()+"';");
		    
		    if (!rs.isBeforeFirst()) 
		    {    
		    	 return null; 
		    }
		    else
		    {
		    	while(rs.next())
		    	{
		    	ResultSet rs1 = conn.createStatement().executeQuery("SELECT * FROM empresa WHERE idempresa='"+rs.getInt("idempresa")+"';");
		    	ResultSet rs2 = conn.createStatement().executeQuery("SELECT * FROM tipo WHERE idtipo='"+rs.getInt("idtipo")+"';");
		    	ResultSet rs3 = conn.createStatement().executeQuery("SELECT servicio_usuario.idservicio,descripcion FROM pasarelasms.servicio_usuario,pasarelasms.servicio WHERE servicio_usuario.idservicio=servicio.idservicio and servicio_usuario.idusuario='"+rs.getInt("idusuario")+"';");
		    	
		    	
		    	
		    	Tipo tipo=new Tipo();
		    	Empresa empresa = new Empresa();
		    	Servicio servicio = new Servicio();
		    	
		    	List<Servicio> listaServicio=new ArrayList();
		    	
		    	while (rs2.next())
		    	{
		    		tipo.setId(rs2.getInt("idtipo"));
		    		tipo.setDescripcion(rs2.getString("descripcion"));
		    	}
		    	
		    	while (rs1.next())
		    	{
		    		empresa.setIdEmpresa(rs1.getInt("idempresa"));
		    		empresa.setNombre(rs1.getString("nombre"));
		    		empresa.setDireccion(rs1.getString("direccion"));
		    		empresa.setTelefono(rs1.getString("telefono"));
		    		empresa.setContacto(rs1.getString("contacto"));
		    		empresa.setEstado(rs1.getInt("estado"));
		    	}
		    	
		    	while (rs3.next())
		    	{

		    		listaServicio.add(new Servicio(rs3.getInt("idservicio"),rs3.getString("descripcion")));
		    	}
		    	
		    	Usuario usuario = new Usuario (rs.getInt("idusuario"),rs.getString("cedula"),rs.getString("nombres"),rs.getString("apellidos"),rs.getString("cargo"),rs.getString("email"),rs.getString("telefono"),rs.getString("password"),rs.getInt("estado"),empresa,tipo);
		    	
		    	if(listaServicio.size()>0){
		    		usuario.setServicios(listaServicio);
		    	}
		    	
		    	return usuario;
		    
		    	}
		    }
	      
	    } catch (Exception e) 
	    {
	      e.printStackTrace();
	    }
		return null;

	}
}
