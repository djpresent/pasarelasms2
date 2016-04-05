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
	<script src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
	<SCRIPT type=text/javascript>
	
	
	$(function() {
	    $('#empresa').on('change', function(event) {
	    	document.getElementById("btnContinuar").click();
	    });
	});
	
	$(function() {
	    $('#empresa').on('focus', function(event) {
	    	document.getElementById("msgConfirmacion").style.display="none";
	    });
	});
	
	$(function() {
	    $('#usuario').on('change', function(event) {
	    	document.getElementById("verServicios").click();
	    });
	});
	
	function validar(){
		
	
		if(document.getElementById("empresa").value == "noempresa" && document.getElementById("usuario").value == "nousuario" ){
			
			alert("No hay información suficiente para continuar. Revise sus selecciones.");
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
    "SELECT * FROM empresa WHERE estado=1");
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
			  	<img class="imgpestana" src="imagenes/imgpestana.png"/>
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
				<form  action="/asignarServicioUsuario" onsubmit="validar()" class="form-horizontal">

				<div class="form-group">
						<label for="empresa" class="col-sm-2 control-label"> Seleccione una empresa:</label> 
						<div class="col-sm-10">
						<select name=empresa id="empresa" class="form-control"> 
						<option value="noempresa">Seleccionar...</option>
						<% 
						while (rs.next()) {
						String empresa = rs.getString("nombre");
						
						System.out.println(session.getAttribute("empresa"));
						
						if(!(session.getAttribute("empresa") == null)){
								
								if(empresa.equals(session.getAttribute("empresa"))){%>
									<option value="<%= empresa %>" selected ><%= empresa %></option>
								<%}else{%>
								<option value="<%= empresa %>"><%= empresa %></option>
						<%	
								}
							}else{%>
							<option value="<%= empresa %>"><%= empresa %></option>
						<%}}
						%>
						</select>
					</div>
						<input type="submit" class="oculto" value="Continuar" name="btnContinuar" id="btnContinuar"/>
					</div>
				
					<%
						
					
						if(!(session.getAttribute("listaUsuarios") == null)){
							
						List<Usuario> lista= (List<Usuario>)session.getAttribute("listaUsuarios");
						
					%>
						<div class="form-group">
						<label for="usuario" class="col-sm-2 control-label">Seleccione un usuario:</label> 
						<div class="col-sm-10">
						
								<select name=usuario id="usuario" class="form-control">
								<option value="nousuario">Seleccionar...</option>
									<% 
									for( Usuario usuario:lista) {
								
						
						if(!(session.getAttribute("idusuario") == null)){
								
								String id=session.getAttribute("idusuario").toString();
							
								if(usuario.getId()==Integer.parseInt(id)){%>
									<option value=<%= usuario.getId() %> selected ><%= usuario.getNombres() %></option>
									<%}else{%>
								<option value=<%= usuario.getId() %>><%= usuario.getNombres() %></option>
								<%	
								}
							}else{%>
							<option value=<%= usuario.getId() %>><%= usuario.getNombres() %></option>
							<%}
									}	
										
									%>
					    		</select> 
					    	</div>
				    		<input type="submit" class="oculto" value="Continuar" name="verServicios" id="verServicios"/>
							</div>
					<% 	
						}
					%>	
					
					
					<%
						if(!(session.getAttribute("listaServicios") == null) && !(session.getAttribute("idusuario") == null)){
							
						List<Servicio> listaS= (List<Servicio>)session.getAttribute("listaServicios");
						
					%>
					   
						<div class="form-group">
						<label for="usuario" class="col-sm-2 control-label">Seleccione un servicio:</label> 
						<div class="col-sm-10">
						
														<% 
								for( Servicio ser:listaS) {
									
									if(ser.getAsignado()==1){
								%>
								
									
									<input type="checkbox" name="<%=ser.getDescripcion() %>" checked> <%=ser.getDescripcion() %><br>
						
									
								<%
								
									}else{
										
										%>
										<input type="checkbox" name="<%=ser.getDescripcion() %>" > <%=ser.getDescripcion() %><br>
										
										<%
									}
									}
								%>
								
								
								
				  			</div>
				  			
				  			
							</div>
				  			
				  			<div class="col-sm-offset-2">
								<input type="submit" value="Guardar" class="btn btn-primary" name="btnGuardar"/>
								<input type="submit" value="Cancelar" class="btn btn-default btnCancelar" name="btnCancelar"/> 
							</div>
				  			
					<% 	
						}else{%>
							<div class="col-sm-offset-2">
								<input type="submit" value="Cancelar" class="btn btn-default btnCancelar" name="btnCancelar"/> 
							</div>
						<%
						}
					%>	
					
				    
				    
				
				
				
				
				
				  </form>
				  
				  	<%
				
						
						
						if(!(session.getAttribute("confirmacion") == null)){
							if(session.getAttribute("confirmacion").equals("1")){
							%>
								<div class="alert alert-success">Operación realizada exitosamente.</div>
							<%
							}
							
							if(session.getAttribute("confirmacion").equals("0")){
								%>
									<div class="alert alert-danger msgConfirmacion">No se pudo completar la acción. Por favor intentar nuevamente o comunicarse con Analixdata.</div>
								<%
								}
							
							session.setAttribute("confirmacion",null);
							
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