<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="com.analixdata.modelos.Usuario" %>
<%@ page import="com.analixdata.modelos.Servicio" %>

<html>
<HEAD>

	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
  	<link rel="stylesheet" type="text/css" href="css/estilos.css">
	<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
	<SCRIPT type=text/javascript>
	

	
	$(function() {
	    $('#userEmpresa').on('change', function(event) {
	    	document.getElementById("btnServicios").click();
	    });
	});
	
	function validar(){
		
	
		if(document.getElementById("userEmpresa").value == "nousuario" ){
			
			alert("No ha seleccionado un usuario.");
		}
		
	}
	
		
		
	</SCRIPT> 
   </HEAD>

  <body>

<%

//allow access only if session exists

session = request.getSession();
	Usuario u = (Usuario)session.getAttribute("usuario");
	
	if (u==null)
	{
		
		session.setAttribute("error", "error");
		response.sendRedirect("/login.jsp");
	}
String userName = null;
String sessionID = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
if(cookie.getName().equals("usuario")) 
	userName = cookie.getValue();
}
}


String url = null;
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
	    "SELECT * FROM usuario WHERE estado=1 and idempresa="+u.getEmpresa().getIdEmpresa()+";");
%>


  	<nav class="navbar" >
  	<div class="container-fluid">
		<div class="navbar-header">
			<a href="index.jsp"><img class="logo" src="imagenes/logo-analix-data.png"/></a>
		</div>  
		
		<div class="navbar-nav navbar-right">
			<a href="/cerrarSesion" class="cerrarsesion"><img class="imglogout" src="imagenes/imglogout.png"/></button></a>
		</div>
		<div class="navbar-nav navbar-right ">
			<h4 class="msgbienvenida">Bienvenido usuario <%= userName %><img class="icousuario" src="imagenes/icousuario.png"/></h4>
			 
		</div>
		
	</div>	
  	</nav>
  	<div class="container-fluid">
	  	<div class="row">
			  	<div class="col-sm-3 col-md-2 sidebar"> 
				    <ul class="nav nav-sidebar">
			
						<%  
						if(u != null){
							
							int tipo=u.getTipo().getId();
							
							if(tipo == 1){ 
							%>
								<li><a href="empresas.jsp"><h5><img class="icomenu" src="imagenes/icoempresa.png"/>Empresas</h5></a></li>
								<li ><a href="servicios.jsp"><h5><img class="icomenu" src="imagenes/icoservicios.png"/>Servicios</h5></a></li>
								<li><a href="usuarios.jsp"><h5><img class="icomenu" src="imagenes/icousuarios.png"/>Usuarios</h5></a></li>
								<li ><a href="servicioEmpresa.jsp"><h5>Servicios a empresas</h5></a></li>
								<li><a href="servicioUsuarios.jsp"><h5>Servicios a Usuarios</h5></a></li>
								
									<li><a href="mensajeria.jsp"><h5><img class="icomenu" src="imagenes/icomensajeria.png"/>Mensajería</h5></a></li>
								<li><a href="whatsapp.jsp"><h5><img class="icomenu" src="imagenes/icomensajeria.png"/>Whatsapp</h5></a></li>
								
								<li><a href="reportes.jsp"><h5><img class="icomenu" src="imagenes/icoreportes.png"/>Reporte SMS</h5></a></li>
									<li><a href="reporteCargas.jsp"><h5><img class="icomenu" src="imagenes/icoreportes.png"/>Reporte Cargas </h5></a></li>
										
								<%}
							
							
							if(tipo == 2){ 
								%>
									<li><a href="empresa.jsp"><h5><img class="icomenu" src="imagenes/icoempresa.png"/>Empresa</h5></a></li>
									<li ><a href="serviciosContratados.jsp"><h5><img class="icomenu" src="imagenes/icoservicios.png"/>Servicios</h5></a></li>
									<li><a href="usuarios.jsp"><h5><img class="icomenu" src="imagenes/icousuarios.png"/>Usuarios</h5></a></li>
									<li><a href="servicioUEmpresa.jsp">Servicios a Usuarios</a></li>
									<%
									if( u.tieneServicio(1)){
										%>
									<li><a href="mensajeria.jsp"><h5><img class="icomenu" src="imagenes/icomensajeria.png"/>Mensajería</h5></a></li>
									
									<%}
									if( u.tieneServicio(3)){
										%>
									<li><a href="whatsapp.jsp"><h5><img class="icomenu" src="imagenes/icomensajeria.png"/>Whatsapp</h5></a></li>
								
									<%}
									if( u.tieneServicio(1) || u.tieneServicio(3)){
										%>
									<li><a href="reportesEmpresas.jsp"><h5><img class="icomenu" src="imagenes/icoreportes.png"/>Reportes</h5></a></li>
									
									<%}
								}
							
							if(tipo == 3){ 
								%>
									<li><a href="empresa.jsp"><h5><img class="icomenu" src="imagenes/icoempresa.png"/>Empresa</h5></a></li>
									<li ><a href="serviciosContratados.jsp"><h5><img class="icomenu" src="imagenes/icoservicios.png"/>Servicios</h5></a></li>
									<li><a href="usuario.jsp"><h5><img class="icomenu" src="imagenes/icousuarios.png"/>Usuario</h5></a></li>
							
								<%
								
								if( u.tieneServicio(1)){
									%>
								<li><a href="mensajeria.jsp"><h5><img class="icomenu" src="imagenes/icomensajeria.png"/>Mensajería</h5></a></li>
								
								<%}
								if( u.tieneServicio(3)){
									%>
								<li><a href="whatsapp.jsp"><h5><img class="icomenu" src="imagenes/icomensajeria.png"/>Whatsapp</h5></a></li>
							
								<%}
								if( u.tieneServicio(1) || u.tieneServicio(3)){
									%>
								<li><a href="reportesUsuarios.jsp"><h5><img class="icomenu" src="imagenes/icoreportes.png"/>Reportes</h5></a></li>
								
								<%}
							}
							
							
						
						
						%>
					</ul>
					
					<hr>
					<ul class="menuCuenta nav">
						<li><a href="usuario.jsp"><h5><img class="icomenu" src="imagenes/icousuarios.png"/>Mis Datos</h5></a></li>
						<li><a href="/cerrarSesion"><img class="icomenu" src="imagenes/icocerrar.png"/>Cerrar Sesión</a></li>
					</ul>
				</div>
		
			<div class="col-sm-9 col-md-9 main">
				<h1 class="page-header">Asignación de Servicios a Usuarios<img style="padding-left:10px;" class="icoheader" src="imagenes/icoreloj.png"/><img class="icoheader" src="imagenes/icopastel.png"/><img class="icoheader" src="imagenes/icoaudifonos.png"/><img class="icoheader" src="imagenes/icodescarga.png"/></h1>
				<form  action="/asignarServicioUEmpresa" onsubmit="validar()" class="form-horizontal">

				<div class="form-group">
					<label class="col-sm-3 control-label">Seleccione un usuario:</label>
					<div class="col-sm-4"> 
					<select name=userEmpresa id="userEmpresa" class="form-control"> 
					<option value="nousuario">Seleccionar...</option>
					<% 
					while (rs.next()) {
					String usuario = rs.getString("idusuario");
					
					String nomusuario=rs.getString("nombres")+" "+rs.getString("apellidos");
					
					
					
					if(!(session.getAttribute("idusuario") == null)){
							
							if(usuario.equals(session.getAttribute("idusuario"))){%>
								<option value=<%= usuario %> selected ><%= nomusuario %></option>
							<%}else{%>
							<option value=<%= usuario %>><%= nomusuario %></option>
					<%	
							}
						}else{%>
						<option value=<%= usuario %>><%= nomusuario %></option>
					<%}}
					%>
					</select>
					</div>
					
					<input type="submit" class="oculto" value="Continuar" name="btnServicios" id="btnServicios"/>
				</div>
				
					<%
						
					
			
				
						if(!(session.getAttribute("serviciosU") == null) && !(session.getAttribute("idusuario") == null)){
							
						List<Servicio> listaS= (List<Servicio>)session.getAttribute("serviciosU");
						
					%>
					   
							<div class="form-group">
								<label class="col-sm-3 control-label">Seleccione un usuario:</label>
								<div class="col-sm-4"> 
														<% 
								for( Servicio ser:listaS) {
									
									if(ser.getAsignado()==1){
								%>
								
									
									<input type="checkbox" name="<%=ser.getDescripcion() %>" checked/> <%=ser.getDescripcion() %><br>
						
									
								<%
								
									}else{
										
										%>
										<input type="checkbox" name="<%=ser.getDescripcion() %>"/> <%=ser.getDescripcion() %><br>
										
										<%
									}
									}
														
								%>
				  				</div>
				  				</div>
							
					<% 	
						}
					%>	
					
					
				    
				    
				
				<div class="col-sm-offset-3">
					<input type="submit" class="btn btn-primary" value="Guardar" name="btnGuardar"/>
					<input type="submit" value="Cancelar" class="btn btn-default btnCancelar" name="btnCancelar"/> 
				</div>
				
				
				
				  </form>
				  <%
				
						
						
						if(session.getAttribute("confServU") != null){
														
							if(session.getAttribute("confServU").toString().equals("1")){
							%>
							
								<div class="alert alert-success">
									  Operación realizada exitosamente.
								</div>
								
							<%
							}
							
							if(session.getAttribute("confServU").toString().equals("2")){
								%>
								
									<div class="alert alert-danger">
										  No se pudo completar la acción. Por favor intentar nuevamente o comunicarse con Analixdata.
									</div>
									
								<%
								}
							
							session.setAttribute("confServU",null);
							
							}
					conn.close();
					%>
				  	
			</div>	
			
			
		</div>
	</div>
	<footer class="footer">
      <div class="container" style="margin-left:25px;margin-right:-25px;">
      	 <div class="footizquierda">Analixdata, 2015 | Copyright © 2016. Todos los derechos reservados.</div>
       	  <div class="footderecha">Teléfono: 593 07 3701919   Email: lalvarez@analixdata.com<img class="icoheader" style="margin-left:10px;" src="imagenes/icogoogle.png"/> <img class="icoheader" src="imagenes/icotwitter.png"/> <a href="https://www.facebook.com/AnalixData-Cia-Ltda-1053799024633059/?fref=ts" target="_blank"><img class="icoheader" src="imagenes/icofacebook.png"/></a></div>
    
      </div>
    </footer>
<%} %>



  </body>
</html>