<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="com.analixdata.modelos.Usuario" %>

<html>
<HEAD>

 	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
  	<link rel="stylesheet" type="text/css" href="css/estilos.css">
  	
    <script src="js/codificacion.js"></script>
	<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
	<SCRIPT type=text/javascript>
		function validar(){
		
	
				var caract_invalido = " ";
				var caract_longitud = 6;
				var cla1 = document.getElementById("newpass").value;
				var cla2 = document.getElementById("confpass").value;
				if (cla1 == '' || cla2 == '') {
					alert('No ha ingresado la contraseña.');
					return false;
				}
				if (cla1 < caract_longitud) {
				alert('Su contraseña debe constar de ' + caract_longitud + ' caracteres.');
				return false;
				}
				if (cla1.indexOf(caract_invalido) > -1) {
				alert("Las contraseñas no pueden contener espacios.");
				return false;
				}
				else {
				if (cla1 != cla2) {
				alert ("Las contraseñas introducidas no coinciden.");
				return false;
				}
				else {
					document.getElementById('oldcod').value = hex_md5(document.getElementById('oldpass').value);
					document.getElementById('newcod').value = hex_md5(document.getElementById('newpass').value);
				
					
					return true;
				      }
				   }
			
			}
		
			
		function habilitar(){
			
			document.getElementById("formActDatos").style.display="block";

		}
		
		function deshabilitar(){
			
			document.getElementById("formActDatos").style.display="none";

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
    "SELECT * FROM empresa");
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
		
			<div class="col-sm-9 col-md-9 main contenido">
				<h1 class="page-header">Mis Datos<img style="padding-left:10px;" class="icoheader" src="imagenes/icoreloj.png"/><img class="icoheader" src="imagenes/icopastel.png"/><img class="icoheader" src="imagenes/icoaudifonos.png"/><img class="icoheader" src="imagenes/icodescarga.png"/></h1>
				
				<table class="datosU" style="font-size: 100%; width: 100%;">
				<tbody>
				
				
				<tr><th><h4>Cédula: </h4></th> <th> <h5><%= u.getCedula()%> </h5></th></tr>
				<tr><th><h4>Nombres: </h4></th> <th> <h5><%= u.getNombres()%> <%= u.getApellidos()%>  </h5></th></tr>
				<tr><th><h4>Apellidos: </h4></th> <th> <h5><%= u.getApellidos() %></h5></th></tr>
				<tr><th><h4>Cargo: </h4></th> <th> <h5><%= u.getCargo() %></h5></th></tr>
				<tr><th><h4>Email: </h4></th> <th> <h5><%= u.getEmail() %></h5></th></tr>
				<tr><th><h4>Teléfono: </h4></th> <th> <h5><%= u.getTelefono() %></h5></th></tr>
				<tr><th><h4>Tipo de usuario: </h4></th> <th> <h5><%= u.getTipo().getDescripcion() %></h5></th></tr>
			
			<% 
			int estado=u.getEstado();
			String est="";
		    if(estado==1){est="Activo";}else{est="Inactivo";}
			%>
				<tr><th><h4>Estado: </h4></th> <th><h5> <%= est %></h5></th></tr>
				</tbody>
				</table>
						
		
				<button value="CambiarContrasena" class="btn btn-default btnCambiarC" onclick="habilitar()">Cambiar contraseña</button>

						<form  onsubmit="return validar();" action="/actContrasena" class="form-horizontal" method="post" style="display:none" id="formActDatos">
							
						    <div class="form-group">
						    	<label for="oldpass" class="col-sm-2 control-label">Contraseña actual:</label> 
						    	<div class="col-sm-10">
						    		<input type="password" name="oldpass" id="oldpass" class="form-control" required="required"></input>
						    	</div>
						    </div>
						    <div class="form-group">
						    	<label for="newpass" class="col-sm-2 control-label">Nueva contraseña:</label> 
						    	<div class="col-sm-10">
						     		<input type="password" name="newpass" class="form-control" id="newpass" required="required"></input>
						     	</div>
						     </div>
						     
						    <div class="form-group">
							    <label for="confpass" class="col-sm-2 control-label">Confirmar:</label> 
							    	<div class="col-sm-10">
						    			 <input type="password" name="confpass" class="form-control" id="confpass" required="required"></input>
						    		</div>
						    </div>
						    
						    <input type="hidden" id="oldcod" name="oldcod"/>
						    <input type="hidden" id="newcod" name="newcod"/>
						
						    
						    <div class="col-sm-offset-2"><input type="submit" class="btn btn-primary" value="Aceptar"/><input type="reset"  class="btn btn-default btnCancelar" value="Cancelar" onclick="deshabilitar()"/></div>
						  </form>
						  
						 
						  
						  <%
						
						  if(session.getAttribute("confCambioC") != null){ 
							
							  
							  if(session.getAttribute("confCambioC").toString().equals("1")){
								  %>
									<div class="alert alert-success">
									  Contraseña actualizada exitosamente.
									</div>
								<%
							  }
							  
							  if(session.getAttribute("confCambioC").toString().equals("2")){
								  %>
									<div class="alert alert-danger">
									  No fue posible completar la acción. Por favor intentar nuevamente o comunicarse con Analixdata.
									</div>
								<%
							  }
							  
							  if(session.getAttribute("confCambioC").toString().equals("3")){
								  %>
									<div class="alert alert-warning">
									  La contraseña actual proporcionada es incorrecta.
									</div>
								<%
							  }
							  
							  session.setAttribute("confCambioC", null);
							  
						  } %>
						  
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