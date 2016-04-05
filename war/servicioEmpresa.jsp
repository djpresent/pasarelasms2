<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="com.analixdata.modelos.Usuario" %>

<html>
<HEAD>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
  	<link rel="stylesheet" type="text/css" href="css/estilos.css">

	<script src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
	<SCRIPT type=text/javascript>
	
			function obtenerDatos(el) {
			
				document.getElementById("divCarga").style.display = 'none';
				document.getElementById("divFormS").style.display = 'block';
				
				
				
			document.getElementById("divEmpresaS").style.display = 'block';
			document.getElementById("divServicioS").style.display = 'block';
				
			document.getElementById("idServicio").value= el.parentNode.parentNode.cells[0].textContent;
			document.getElementById("servicio").value= el.parentNode.parentNode.cells[1].textContent;
			document.getElementById("serviciotexto").value= el.parentNode.parentNode.cells[1].textContent;
			document.getElementById("empresa").value = el.parentNode.parentNode.cells[2].textContent;
			document.getElementById("empresatexto").value = el.parentNode.parentNode.cells[2].textContent;
			document.getElementById("limite").value = el.parentNode.parentNode.cells[3].textContent;
			document.getElementById("costo").value = el.parentNode.parentNode.cells[4].textContent;
			
			document.getElementById("divempresa").style.display = 'none';
			document.getElementById("divservicio").style.display = 'none';	
			document.getElementById("divlimite").style.display = 'none';
				
			
			if(el.parentNode.parentNode.cells[5].textContent == "Activo")
			 	document.getElementById("estado").value = 1 ;
			else
				document.getElementById("estado").value = 0 ;
			
			
			}
			
			function obtenerDCarga(el) {
				document.getElementById("divCarga").style.display = 'block';
				document.getElementById("divFormS").style.display = 'none';
				
				document.getElementById("idServicioCarga").value= el.parentNode.parentNode.cells[0].textContent;
				document.getElementById("servicioCarga").value= el.parentNode.parentNode.cells[1].textContent;
				document.getElementById("empresaC").value = el.parentNode.parentNode.cells[2].textContent;

				
				
				
				}
			
			function liberar(){
				
				
				document.getElementById("divempresa").style.display = 'block';
				document.getElementById("divservicio").style.display = 'block';
				document.getElementById("divEmpresaS").style.display = 'none';
				document.getElementById("divServicioS").style.display = 'none';
			}
			
			function liberarC(){
				document.getElementById("divFormS").style.display = 'block';
				document.getElementById("divempresa").style.display = 'block';
				document.getElementById("divservicio").style.display = 'block';
				
				document.getElementById("divEmpresaS").style.display = 'none';
				document.getElementById("divServicioS").style.display = 'none';
				document.getElementById("divCarga").style.display = 'none';
			}
			
			function validar(){
				
				if(document.getElementById("empresa").value =="noempresa" && document.getElementById("servicio").value =="noservicio" ){
					
					alert("No hay información suficiente para continuar. Revise sus selecciones.");
				}
				
			}
			
			function validarC(){
				
				if(document.getElementById("empresaC").value.lenght>0 && document.getElementById("servicioCarga").value.lenght>0){
					alert("No hay información suficiente para continuar. Revise sus selecciones.");
					return false;
				}else{
					if(document.getElementById("cupoCarga").value>0){
						return true;
					}else{
						alert("No hay información suficiente para continuar.");
						return false;
						
					}
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
    "SELECT servicio_empresa.idservicio,descripcion,nombre,limite,disponible,costotransaccion,servicio_empresa.estado FROM pasarelasms.servicio_empresa,pasarelasms.servicio,pasarelasms.empresa WHERE servicio_empresa.idservicio=servicio.idservicio and servicio_empresa.idempresa=empresa.idempresa and empresa.estado=1;");
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
									<%if( u.tieneServicio(1)){
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
				<h1 class="page-header">Asignación de Servicios a Empresas <img style="padding-left:10px;" class="icoheader" src="imagenes/icoreloj.png"/><img class="icoheader" src="imagenes/icopastel.png"/><img class="icoheader" src="imagenes/icoaudifonos.png"/><img class="icoheader" src="imagenes/icodescarga.png"/></h1>
				<table class="table table-bordered" id="datosUsuarios">
				<tbody>
				<tr>
				<th>ID Servicio</th>
				<th>Descripción</th>
				<th>Empresa</th>
				<th>Disponible</th>
				<th>Precio / Transacción</th>
				<th>Estado</th>
				</tr>
				
				<%
				while (rs.next()) {
				    int id =rs.getInt("idservicio");
					String servicio = rs.getString("descripcion");
				    String empresa = rs.getString("nombre");
				    int limite = rs.getInt("limite");
				    int disponible = rs.getInt("disponible");
				    float costo = rs.getFloat("costotransaccion");
				    int estado = rs.getInt("estado"); 
				    String est="";
				    if(estado==1)est="Activo";else est="Inactivo";
				   
				 %>
				<tr>
					<td><%= id %></td>
					<td><%= servicio %></td>
					<td><%= empresa %></td>
					<td><%= disponible %></td>
					<td><%= costo %></td>
					<td><%= est %></td>
					<td><button class="btnEditar" type="button" onclick="obtenerDatos(this);" >Editar</button></td>
					<td><button class="btnCargar" type="button" onclick="obtenerDCarga(this);" >Cargar</button></td>
				</tr>
				<%
				}
				
				rs = conn.createStatement().executeQuery("SELECT * FROM servicio");%>
				
				
				
				</tbody>
				</table>
				
				<h4>Servicios a Empresas</h4>
				<div id="divFormS">
				<form action="/asignarServicio" method="post" onsubmit="validar()" class="form-horizontal">
					 <div><input type="hidden" name="idServicio" id="idServicio" required="required"></input></div>
				   	 <div class="form-group" id="divEmpresaS" style="display:none;">
						<label for="empresatexto" class="col-sm-2 control-label"> Empresa: </label> 
						<div class="col-sm-10">
					 		<input type="text" id="empresatexto" name="empresatexto"  required="required" readonly ></input>
					 	</div>
					 </div>
					 
					 <div class="form-group" id="divServicioS" style="display:none;" >
						<label for="serviciotexto" class="col-sm-2 control-label"> Servicio: </label> 
						<div class="col-sm-10">
					  		<input type="text" id="serviciotexto" name="serviciotexto" required="required" readonly></input>
					  	</div>
					</div>
										
					<%ResultSet rs1 = conn.createStatement().executeQuery("SELECT * FROM empresa where estado=1");%>
					
					
					<div class="form-group" id="divempresa">
						<label for="empresa" class="col-sm-2 control-label"> Empresa:</label> 
						<div class="col-sm-10">
								
							<select name=empresa id="empresa" class="form-control">
							<option value="noempresa">Seleccionar...</option>
							<% 
							while (rs1.next()) {
							String empresa = rs1.getString("nombre");%>
								<option value="<%= empresa %>"><%= empresa %></option>
							<%}%>
							</select>
							</div>
					</div>
					
					<div class="form-group" id="divservicio">
						<label for="servicio" class="col-sm-2 control-label"> Servicio:</label> 
						<div class="col-sm-10">
					    	<select name=servicio id="servicio" class="form-control">
					    	<option value="noservicio">Seleccionar...</option>
					    		<% 
						while (rs.next()) {
						String descServicio = rs.getString("descripcion");%>
							<option value="<%= descServicio %>"><%= descServicio %></option>
						<%}%>
					    		</select> 
					    </div>
					</div>
					
				    <div class="form-group" id="divlimite">
						<label for="limite" class="col-sm-2 control-label"> Cupo disponible: </label> 
						<div class="col-sm-10">
						<input type="number" name="limite" id="limite" class="form-control" required="required"></input>
						</div>
					</div>
					<div class="form-group">
						<label for="costo" class="col-sm-2 control-label"> Precio por Transacción: </label> 
						<div class="col-sm-10">
						<input type="text" name="costo" id="costo" class="form-control" required="required"></input>
						</div>
					</div>
				    <div class="form-group">
						<label for="estado" class="col-sm-2 control-label"> 	Estado:</label> 
						<div class="col-sm-10">
					
				    	<select name=estado id="estado" class="form-control">
				    		<option seleted value=1>Activo</option>
				    		<option value=0>Inactivo</option>
				    		</select> 
				    	</div>
					</div>
					
				    
					<%
					conn.close();
					%>
					
				    <div class="col-sm-offset-2">
				    	<input type="submit" class="btn btn-primary"  value="Guardar"/>
				    	<input type="reset" class="btn btn-default btnCancelar" value="Cancelar" onclick="liberar()"/>
				    </div>
				  </form>
				  
				  </div>
				  
				  <div id="divCarga" style="display:none;">
				  <form action="/cargarServicio" method="post" onsubmit="validarC()" class="form-horizontal">
					 <div><input type="hidden" name="idServicioCarga" id="idServicioCarga" required="required"></input></div>
					 
					 <div class="form-group">
						<label for="empresaC" class="col-sm-2 control-label"> Empresa: </label> 
						<div class="col-sm-10">
					 		<input type="text" id="empresaC" name="empresaC"  required="required" readonly ></input>
					 	</div>
					 </div>
					 
					 <div class="form-group">
						<label for="servicioCarga" class="col-sm-2 control-label"> Servicio: </label> 
						<div class="col-sm-10">
					  		<input type="text" id="servicioCarga" name="servicioCarga" required="required" readonly></input>
					  	</div>
					</div>
						
				    <div class="form-group">
						<label for="agregar" class="col-sm-2 control-label"> Cupo a agregar: </label> 
						<div class="col-sm-10">
						<input type="number" name="cupoCarga" id="cupoCarga" class="form-control" required="required" ></input>
						</div>
					</div>
					
					
				    <div class="col-sm-offset-2">
				    	<input type="submit" class="btn btn-primary"  value="Guardar"/>
				    	<input type="reset" class="btn btn-default btnCancelar" value="Cancelar" onclick="liberarC()"/>
				    </div>
				  </form>
				  </div>
				  
				  <%
				  if(session.getAttribute("updateServEmp") != null){ 
							
							  
							  if(session.getAttribute("updateServEmp").toString().equals("1")){
								  %>
									<div class="alert alert-success">
									  Acción completada exitosamente.
									</div>
							
								<%
								
								session.setAttribute("idServicio", null);
							  }
							  
							  if(session.getAttribute("updateServEmp").toString().equals("2")){
								  %>
									<div class="alert alert-danger">
									    No fue posible completar la acción. Por favor intentar nuevamente o comunicarse con Analixdata.
									</div>
									
								<%
							  }
							  
							  if(session.getAttribute("updateServEmp").toString().equals("3")){
								  %>
									<div class="alert alert-danger">
									   Analixdata no posee cupo suficiente para completar la acción.
									</div>
									
								<%
							  }
							  
							  session.setAttribute("updateServEmp", null);
							  
							  
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