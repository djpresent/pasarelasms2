<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="com.analixdata.modelos.Usuario" %>

<html>
<HEAD>

 	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
  	<link rel="stylesheet" type="text/css" href="css/estilos.css">
  	
	<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
	<SCRIPT type=text/javascript>
		function validar(formObj){
		
			if (formObj.nombre.value == ""){
			alert("Datos imcompletos");
			return false;
			}else if (formObj.direccion.value == ""){
				alert("Datos imcompletos");
				return false;
				}else if (formObj.telefono.value == ""){
					alert("Datos imcompletos");
					return false;
					}else if (formObj.telefono.value == ""){
						alert("Datos imcompletos");
						return false;}else return true;
			}
		
		function obtenerDatos(el) {
			document.getElementById("idEmpresa").value = el.parentNode.parentNode.cells[0].textContent;
			document.getElementById("nombreEmpresa").value= el.parentNode.parentNode.cells[1].textContent;
			document.getElementById("direccionEmpresa").value = el.parentNode.parentNode.cells[2].textContent;
			document.getElementById("telefonoEmpresa").value = el.parentNode.parentNode.cells[3].textContent;
			document.getElementById("contactoEmpresa").value = el.parentNode.parentNode.cells[4].textContent;
			
			if(el.parentNode.parentNode.cells[5].textContent == "Activo")
			 	document.getElementById("estadoEmpresa").value = 1 ;
			else
				document.getElementById("estadoEmpresa").value = 0 ;
			   
			   
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
								
									<li><a href="reportes.jsp"><h5><img class="icomenu" src="imagenes/icoreportes.png"/>Reporte SMS</h5></a></li>
									<li><a href="reporteCargas.jsp"><h5><img class="icomenu" src="imagenes/icoreportes.png"/>Reporte Cargas </h5></a></li>
									
								<%}
							
							
							if(tipo == 2){ 
								%>
									<li><a href="empresa.jsp"><h5><img class="icomenu" src="imagenes/icoempresa.png"/>Empresa</h5></a></li>
									<li ><a href="serviciosContratados.jsp"><h5><img class="icomenu" src="imagenes/icoservicios.png"/>Servicios</h5></a></li>
									<li><a href="usuarios.jsp"><h5><img class="icomenu" src="imagenes/icousuarios.png"/>Usuarios</h5></a></li>
									<li><a href="servicioUEmpresa.jsp">Servicios a Usuarios</a></li>
									<%if( u.tieneServicio(1)){
										%>
									<li><a href="mensajeria.jsp"><h5><img class="icomenu" src="imagenes/icomensajeria.png"/>Mensajería</h5></a></li>
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
				<h1 class="page-header">Empresas<img style="padding-left:10px;" class="icoheader" src="imagenes/icoreloj.png"/><img class="icoheader" src="imagenes/icopastel.png"/><img class="icoheader" src="imagenes/icoaudifonos.png"/><img class="icoheader" src="imagenes/icodescarga.png"/></h1>
				<table class="table table-bordered" id="datosEmpresas" style="font-size: 100%; width: 100%;">
						<tbody>
						<tr>
						<th>ID</th>
						<th>Nombre</th>
						<th>Direccion</th>
						<th>Teléfono</th>
						<th>Contácto</th>
						<th>Estado</th>
						</tr>
						
						<%
						while (rs.next()) {
						    int id =rs.getInt("idempresa");
							String nombre = rs.getString("nombre");
						    String direccion = rs.getString("direccion");
						    String telefono = rs.getString("telefono");
						    String contacto = rs.getString("contacto");
						    int estado = rs.getInt("estado");
						    String est="";
						    if(estado==1){est="Activo";}else{est="Inactivo";};
						 %>
						<tr>
							<td><%= id %></td>
							<td><%= nombre %></td>
							<td><%= direccion %></td>
							<td><%= telefono %></td>
							<td><%= contacto %></td>
							<td><%= est %></td>
							<td><button class="btnEditar" type="button" onclick="obtenerDatos(this);" >Editar</button></td>
						</tr>
						<%
						}
						conn.close();
						%>
						
						</tbody>
						</table>
						
						<h4>Datos de la empresa</h4>
						<form  onsubmit="return validar(this);" action="/empresas" method="post" class="form-horizontal">
							<div><input type="hidden" name="identificador" id="idEmpresa" ></input></div>
						    <div class="form-group">
								 <label for="nombreEmpresa" class="col-sm-2 control-label">Nombre:</label> 
								 <div class="col-sm-10">
								 	<input type="text" name="nombre" class="form-control" id="nombreEmpresa" required="required"></input>
								 </div>
							</div>
						    <div class="form-group">
								 <label for="direccionEmpresa" class="col-sm-2 control-label">Dirección:</label> 
								 <div class="col-sm-10">
								 	<input type="text" name="direccion" class="form-control" id="direccionEmpresa" required="required"></input>
								 </div>
							</div>
						    <div class="form-group">
								 <label for="telefonoEmpresa" class="col-sm-2 control-label">Teléfono:</label> 
								 <div class="col-sm-10">
								 	<input type="tel" name="telefono" class="form-control" id="telefonoEmpresa" required="required"></input>
								 </div>
							</div>
						    <div class="form-group">
								 <label for="contactoEmpresa" class="col-sm-2 control-label">Contacto: </label> 
								 <div class="col-sm-10">
								 	<input type="text" name="contacto" class="form-control" id="contactoEmpresa" required="required"></input>
								 </div>
							</div>
						    <div class="form-group">
								 <label for="estadoEmpresa" class="col-sm-2 control-label">Estado: </label> 
								 <div class="col-sm-10">
							    	<select name=estado id="estadoEmpresa" class="form-control">
							    		<option seleted value=1>Activo</option>
							    		<option value=0>Inactivo</option>
							    		</select> 
						    	</div>
							</div>
						    <div class="col-sm-offset-2" >
						    	<input type="submit" class="btn btn-primary" value="Guardar"/>
						    	<input type="reset" class="btn btn-default btnCancelar" value="Cancelar"/>
						    </div>
						  </form>
						  
						   <%
				  if(session.getAttribute("updateEmpresa") != null){ 
							
							  
							  if(session.getAttribute("updateEmpresa").toString().equals("1")){
								  %>
									<div class="alert alert-success">
									  Empresa almacenada exitosamente.
									</div>
								<%
							  }
							  
							  if(session.getAttribute("updateEmpresa").toString().equals("2")){
								  %>
									<div class="alert alert-success">
										Datos actualizados exitosamente.
									</div>
								<%
							  }
							  
							  if(session.getAttribute("updateEmpresa").toString().equals("3")){
								  %>
									<div class="alert alert-danger">
									    No fue posible completar la acción. Por favor intentar nuevamente o comunicarse con Analixdata.
									</div>
								<%
							  }
							  
							  session.setAttribute("updateEmpresa", null);
							  
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