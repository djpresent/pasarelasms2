<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="com.analixdata.modelos.Usuario" %>
<%@ page import="com.analixdata.modelos.Servicio" %>

<html>
<HEAD>

	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
  	<link rel="stylesheet" type="text/css" href="css/estilos.css">

	<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="js/codificacion.js"></script>
	<SCRIPT type=text/javascript>
	

	
	function validarPass(){
		
		if(document.getElementById('divContrasena').style.display != 'none'){
		
		var caract_invalido = " ";
		var caract_longitud = 6;
		var cla1 = document.datosUsuario.password.value;
		var cla2 = document.datosUsuario.cpassword.value;
		if (cla1 == '' || cla2 == '') {
			alert('No ha ingresado la contraseña.');
			return false;
		}
		if (document.datosUsuario.password.value.length < caract_longitud) {
		alert('Su contraseña debe constar de ' + caract_longitud + ' caracteres.');
		return false;
		}
		if (document.datosUsuario.password.value.indexOf(caract_invalido) > -1) {
		alert("Las contraseñas no pueden contener espacios.");
		return false;
		}
		else {
		if (cla1 != cla2) {
		alert ("Las contraseñas introducidas no coinciden.");
		return false;
		}
		else {
			
			
				if(document.getElementById("empresaUsuario").value == "noempresa" || document.getElementById("tipoUsuario").value == "nousuario" ){
								
								alert("No hay información suficiente para continuar. Revise sus selecciones.");
							}else{
								document.getElementById('divContrasena').style.display = 'block';
								document.getElementById('divContrasenaC').style.display = 'block';
								document.getElementById('divEmpresa').style.display = 'block';
								document.getElementById('passwordUsuario').value = hex_md5(document.getElementById('password').value);
								
								return true;
							}
		      }
		   }
		}else{
			return true;
		}
		}
	

		function obtenerDatos(el) {
			document.getElementById("idUsuario").value = el.parentNode.parentNode.cells[0].textContent;
			document.getElementById("cedulaUsuario").value= el.parentNode.parentNode.cells[1].textContent;
			document.getElementById("nombresUsuario").value = el.parentNode.parentNode.cells[2].textContent;
			document.getElementById("apellidosUsuario").value = el.parentNode.parentNode.cells[3].textContent;
			document.getElementById("cargoUsuario").value = el.parentNode.parentNode.cells[4].textContent;
			document.getElementById("telefonoUsuario").value = el.parentNode.parentNode.cells[5].textContent;
			document.getElementById("emailUsuario").value = el.parentNode.parentNode.cells[6].textContent;
			
			if(el.parentNode.parentNode.cells[7].textContent == "Activo")
			 	document.getElementById("estadoUsuario").value = 1 ;
			else
				document.getElementById("estadoUsuario").value = 0 ;
			
			document.getElementById("tipoUsuario").value = el.parentNode.parentNode.cells[8].textContent;
			
			document.getElementById('divEmpresa').style.display = 'none';
			document.getElementById('divContrasena').style.display = 'none';
			document.getElementById('divContrasenaC').style.display = 'none';
			document.getElementById('divServicios').style.display = 'none';
			
			
		
			
			
		
		}
		
		function habilitarC(){
			
			document.getElementById('divContrasena').style.display = 'block';
			document.getElementById('divContrasenaC').style.display = 'block';
			document.getElementById('divEmpresa').style.display = 'block';
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
ResultSet rs = null;

if(u.getTipo().getId() == 1){
	rs=conn.createStatement().executeQuery(
    "SELECT idusuario,cedula,nombres,apellidos,cargo,email,usuario.telefono,password,descripcion,nombre,usuario.estado FROM pasarelasms.usuario,pasarelasms.tipo,pasarelasms.empresa WHERE usuario.idtipo=tipo.idtipo and usuario.idempresa=empresa.idempresa and usuario.idtipo >= "+u.getTipo().getId()+" and empresa.estado=1;");
}



if(u.getTipo().getId() == 2){
	int idempresa = u.getEmpresa().getIdEmpresa();
	rs=conn.createStatement().executeQuery(
    "SELECT idusuario,cedula,nombres,apellidos,cargo,email,usuario.telefono,password,descripcion,nombre,usuario.estado FROM pasarelasms.usuario,pasarelasms.tipo,pasarelasms.empresa WHERE usuario.idtipo=tipo.idtipo and usuario.idempresa=empresa.idempresa and usuario.idempresa="+idempresa+" and usuario.idtipo >= "+u.getTipo().getId()+";");
}


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
							
							int tipou=u.getTipo().getId();
							
							if(tipou == 1){ 
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
							
							
							if(tipou == 2){ 
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
							
							if(tipou == 3){ 
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
				<h1 class="page-header">Usuarios<img style="padding-left:10px;" class="icoheader" src="imagenes/icoreloj.png"/><img class="icoheader" src="imagenes/icopastel.png"/><img class="icoheader" src="imagenes/icoaudifonos.png"/><img class="icoheader" src="imagenes/icodescarga.png"/></h1>
				<table class="table table-bordered" id="datosUsuarios" style="font-size: 100%; width: 100%;">
				<tbody>
				<tr>
				<th>ID</th>
				<th>Cédula</th>
				<th>Nombres</th>
				<th>Apellidos</th>
				<th>Cargo</th>
				<th>Telefono</th>
				<th>Email</th>
				<th>Estado</th>
				<th>Tipo</th>
				<th>Empresa</th>
				</tr>
				
				<%
				while (rs.next()) {
				    int id =rs.getInt("idusuario");
					String cedula = rs.getString("cedula");
				    String nombres = rs.getString("nombres");
				    String apellidos = rs.getString("apellidos");
				    String cargo = rs.getString("cargo");
				    String telefono = rs.getString("telefono");
				    String email = rs.getString("email");
				    String password = rs.getString("password");
				    int estado = rs.getInt("estado"); 
				    String est="";
				    if(estado==1)est="Activo";else est="Inactivo";
				    
				    String tipo = rs.getString("descripcion");
				    String empresa = rs.getString("nombre");
				   
				 %>
				<tr>
					<td><%= id %></td>
					<td><%= cedula %></td>
					<td><%= nombres %></td>
					<td><%= apellidos %></td>
					<td><%= cargo %></td>
					<td><%= telefono %></td>
					<td><%= email %></td>
					<td><%= est %></td>
					<td><%= tipo %></td>
					<td><%= empresa %></td>
					<td><button class="btnEditar" type="button" onclick="obtenerDatos(this);" >Editar</button></td>
				</tr>
				<%
				}
				
				rs = conn.createStatement().executeQuery("SELECT * FROM tipo");%>
				
				
				
				</tbody>
				</table>
				
				<h4>Datos del Usuario</h4>
				<form onSubmit="return validarPass();" action="/usuario" class="form-horizontal" method="post" name="datosUsuario">
					<div><input type="hidden" name="identificador" id="idUsuario" ></input></div>
				    <div class="form-group">
						 <label for="cedulaUsuario" class="col-sm-2 control-label">Cédula:</label> 
						 <div class="col-sm-10">
						 <input type="text" name="cedula" class="form-control" id="cedulaUsuario" required="required"></input>
						 </div>
					</div>
				    <div class="form-group">
						 <label for="nombresUsuario" class="col-sm-2 control-label">Nombres:</label> 
						 <div class="col-sm-10">
						 <input type="text" name="nombres" class="form-control" id="nombresUsuario" required="required"></input>
						 </div>
					</div>
				    <div class="form-group">
						 <label for="apellidosUsuario" class="col-sm-2 control-label">Apellidos:</label> 
						 <div class="col-sm-10">
						 <input type="text" name="apellidos" class="form-control" id="apellidosUsuario" required="required"></input>
						 </div>
				    </div>
				    <div class="form-group">
						 <label for="cargoUsuario" class="col-sm-2 control-label">Cargo:</label> 
						 <div class="col-sm-10">
						 <input type="text" name="cargo" class="form-control" id="cargoUsuario" required="required"></input>
						 </div>
				    </div>
				    <div class="form-group">
						 <label for="telefonoUsuario" class="col-sm-2 control-label">Teléfono:</label> 
						 <div class="col-sm-10">
						 <input type="text" name="telefono" class="form-control" id="telefonoUsuario" required="required"></input>
						 </div>
					</div>
				   	<div class="form-group">
						 <label for="emailUsuario" class="col-sm-2 control-label">Email:</label> 
						 <div class="col-sm-10">
						 <input type="text" name="email" class="form-control" id="emailUsuario" required="required"></input>
						 </div>
					</div>
				   	<div id="divContrasena" class="form-group">
				   		 <label for="password" class="col-sm-2 control-label">Contraseña:</label> 
						 <div class="col-sm-10">
				   		 <input type="password" class="form-control" name="password" id="password"></input>
				   		 </div>
				   	</div>
				   	<div><input type="hidden" id="passwordUsuario" name="passwordUsuario" ></input></div>
				   	<div id="divContrasenaC" class="form-group">
				   		<label for="cpassword" class="col-sm-2 control-label">Confirmar Contraseña:</label> 
						 <div class="col-sm-10">
				   	 	 <input type="password" class="form-control" name="cpassword" id="cpassword"></input>
				   	 	 </div>
				   	 </div>
				    <div class="form-group">
						 <label class="col-sm-2 control-label">Estado:</label> 
						 <div class="col-sm-10">
					    	<select name=estado id="estadoUsuario" class="form-control">
					    		<option seleted value=1>Activo</option>
					    		<option value=0>Inactivo</option>
					    		</select> 
					    </div>
					</div>
					<div class="form-group">
						 <label class="col-sm-2 control-label"> Tipo de usuario:</label> 
						 <div class="col-sm-10">
						    	<select name=tipo id="tipoUsuario" class="form-control">
						    	<option value="nousuario">Seleccionar...</option>
						    		<% 
							while (rs.next()) {
								
							int idtipo = rs.getInt("idtipo");	
							if(idtipo >= u.getTipo().getId()){
							String tipoU = rs.getString("descripcion");%>
								<option value="<%= tipoU %>"><%= tipoU %></option>
							<%}}%>
						    		</select> 
					</div>
					</div>
					
					
					<%
					
					rs = conn.createStatement().executeQuery("SELECT * FROM empresa where estado=1");
					
					List<Servicio> servicios= new ArrayList();
					
					if(u.getTipo().getId() == 1){
					%>
					<div class="form-group" id="divEmpresa">
						<label class="col-sm-2 control-label"> Empresa:</label> 
							 <div class="col-sm-10">
						
						
								<select name=empresaUsuario id="empresaUsuario" class="form-control">
								<option value="noempresa">Seleccionar...</option>
								<% 
								
								
								
								
								while (rs.next()) {
								String empresa = rs.getString("nombre");%>
									<option value="<%= empresa %>"><%= empresa %></option>
								<%}	
								%>
									</select>
							</div>
					</div>
					<%					
					}else{%>
						<input name="empresa" type="hidden" value="<%= u.getEmpresa().getNombre() %>"/>
						
						
						<div id="divServicios" class="form-group">
						<label class="col-sm-2 control-label"> Servicios:</label> 
						 <div class="col-sm-10">
						
						<%
						   servicios=u.getServicios();
						
							for(int i=0;i<servicios.size();i++){
								%>
								<input type="checkbox" name="<%=servicios.get(i).getDescripcion() %>" value="<%=servicios.get(i).getIdServicio() %>" checked> <%=servicios.get(i).getDescripcion() %><br>
								
							<%
							}
							
						%>
						</div>
						</div>
					<%}
					conn.close();
					%>
					
				    <div class="col-sm-offset-2" >
				    <input type="submit" class="btn btn-primary" value="Guardar" name="btnGuardar"/>
				    <input type="reset" value="Cancelar" class="btn btn-default btnCancelar" onclick="habilitarC()"/></div>
				  </form>
				  <%
				  if(session.getAttribute("updateUsuario") != null){ 
							
							  
							  if(session.getAttribute("updateUsuario").toString().equals("1")){
								  %>
									<div class="alert alert-success">
									  Usuario almacenado exitosamente.
									</div>
								<%
							  }
							  
							  if(session.getAttribute("updateUsuario").toString().equals("2")){
								  %>
									<div class="alert alert-success">
										Datos actualizados exitosamente.
									</div>
								<%
							  }
							  
							  if(session.getAttribute("updateUsuario").toString().equals("3")){
								  %>
									<div class="alert alert-danger">
									    No fue posible completar la acción. Por favor intentar nuevamente o comunicarse con Analixdata.
									</div>
								<%
							  }
							  
							  session.setAttribute("updateUsuario", null);
							  
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