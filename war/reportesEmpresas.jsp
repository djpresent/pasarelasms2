<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import= "java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="com.analixdata.modelos.Usuario" %>
<%@ page import="com.analixdata.modelos.Servicio" %>
<%@ page import="com.analixdata.modelos.Transaccion" %>


<html>
<head>
	  	
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

		

	  	<link rel="stylesheet" type="text/css" href="css/estilos.css">
	    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
	    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

	  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	  <script src="js/jquery.table2excel.js"></script>
	  
	  <script>
	  
	  $(function() {
		    $('#rServicio').on('change', function(event) {
		    	var ser = document.getElementById("rServicio").value;
		    	if (ser!="noservicio")
		    	{
		    	document.getElementById("btnContinuarReportes").click();
		    	}
		    });
		});
	  		
	  $(function() {
		    $('#rUsuario').on('change', function(event) {
		    	var usu = document.getElementById("rUsuario").value;
		    	if (usu!="nousuario")
		    	{
		    	document.getElementById("btnContinuarUsuarios").click();
		    	}
		    });
		});
	  
		  $(function() {
		    $( "#fechaDesde" ).datepicker({ dateFormat: 'yy-mm-dd' }).val();
		    
		    $( "#fechaHasta" ).datepicker({ dateFormat: 'yy-mm-dd' }).val();
		  });
		  
		  function CreateExcelSheet (tabla)
			{
			  var f = new Date();
			
					$(".".concat(tabla)).table2excel({
						exclude: ".noExl",
						name: "Excel Document Name",
						filename: tabla+"-"+f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear(),
						exclude_img: true,
						exclude_links: true,
						exclude_inputs: true
					});
				
			}
		  
		  
		  function verificarServicio()
		  {
			  var servicio = document.getElementById('rServicio').value;
			  
			  if (servicio=="noservicio")
			{
				  alert('Debe seleccionar un servicio');
				  return false;
			}
			  else
			{
				  var usu = document.getElementById('rUsuario').value;	
				  
				  if (usu=="nousuario")
					{
					  alert('Debe seleccionar un usuario');
					  	return false;
					}
				  else
					  {
				  return true;
					  }
			}
		  }
		  
		  
		  function abrir(m)
		  {
			  //alert(m);
			 // document.getElementById(tab).style.display='block';
		    $("#".concat(m)).modal();
		  }

		  
		  
	  </script>
	  
 
	  
    <title>Analixdata Servicios en Línea</title>
  </head>

  <body>

  <%

	
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
	//session.setAttribute("idEmpresa", u.getEmpresa().getIdEmpresa());
	ResultSet rs = conn.createStatement().executeQuery(
			"SELECT servicio.* FROM pasarelasms.servicio_empresa,pasarelasms.empresa,pasarelasms.servicio where empresa.idempresa=servicio_empresa.idempresa and servicio_empresa.idservicio=servicio.idservicio and empresa.idempresa="+u.getEmpresa().getIdEmpresa())  ;
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
				<h1 class="page-header">Reportes <img style="padding-left:10px;" class="icoheader" src="imagenes/icoreloj.png"/><img class="icoheader" src="imagenes/icopastel.png"/><img class="icoheader" src="imagenes/icoaudifonos.png"/><img class="icoheader" src="imagenes/icodescarga.png"/></h1>
				
				<form onsubmit="return verificarServicio();" action="/reporteEmpresasTransacciones">
					
					<div class="row">
        				<div class="col-xs-3">
        					<div class="form-group">
							    <label for="fechaDesde">Desde</label>
								<%
									if (!(session.getAttribute("fDesde") == null))
									{
										String fd= session.getAttribute("fDesde").toString();
								%>
												
								<input type="text" class="form-control" placeholder="Fecha inicial de busqueda" id="fechaDesde" name ="fechaDesde"  value=<%=fd %> required="required" >
								<% 
									}
									else
									{
								%>
								<input type="text" class="form-control" placeholder="Fecha inicial de busqueda" id="fechaDesde" name ="fechaDesde" required="required" >
								<% 
			
									}
								%>
							</div>
        				</div>
        				
        				<div class="col-xs-3">
        					<div class="form-group">
	        				<label for="fechaHasta">Hasta</label>
							<%
								if (!(session.getAttribute("fHasta") == null))
								{
									String fa= session.getAttribute("fHasta").toString();
							%>
											
							<input type="text" class="form-control" placeholder="Fecha final de busqueda" id="fechaHasta" name ="fechaHasta"  value=<%=fa %> required="required"  >
							<% 
								}
								else
								{
							%>
							<input type="text" class="form-control" placeholder="Fecha final de busqueda" id="fechaHasta" name ="fechaHasta" required="required">
							<% 			
								}
							%>		
							</div>
        				</div>
        				
        				
        				<div class="col-xs-3 vert-offset-top-1-8">
        					<div class="form-group">
        						<label for="btnConsultar"></label> 
        						<input class="btn btn-default" type="submit" value="Consultar" name="btnConsultar"/>
        					</div>
        				</div>
        				
        			</div>
        			
					<div class="row">
					
						<!--
        				
        				 SECCION SERVICIOS
        				  
        				  -->
        				  
        				 
        				<div class="col-xs-3">
        					<div class="form-group">
        						<label for="rServicio">Servicio</label>
        						<select class="form-control" name="reporteServicio" id="rServicio" >
									<option value="noservicio" selected >Seleccione un servicio....</option>	
									
									<% 
										while (rs.next()) {
										String servicio = rs.getString("descripcion");
										
										if(!(session.getAttribute("servicio") == null)){
												
												if(rs.getInt("idservicio")==Integer.parseInt(session.getAttribute("servicio").toString())){%>
													<option value="<%= rs.getInt("idservicio") %>" selected ><%= servicio %></option>
												<%}else{%>
												<option value="<%= rs.getInt("idservicio") %>"><%= servicio %></option>
										<%	
												}
											}else{%>
											<option value="<%= rs.getInt("idservicio") %>"><%= servicio %></option>
										<%}}
										%>
								</select>
								<input type="submit" class="oculto" value="Continuar" name="btnContinuarReportes" id="btnContinuarReportes"/>
        					</div>
        				</div>
        				 
        				 
        				 <!--
        				
        				 FIN SECCION SERVICIOS
        				  
        				  -->
					
					
					
						<!-- 
						
						INICIO USUARIOS
						 -->
							<!--
        				
        				 SECCION USUARIOS
        				  
        				  -->
        				
        				<div class="col-xs-3">
        					<div class="form-group">
        						<label for="rUsuario">Usuarios</label>
        							<%

									if(!(session.getAttribute("listaUsuarios") == null))
									{
										
										List<Usuario> lista= (List<Usuario>)session.getAttribute("listaUsuarios");
							
									%>
									
									<select class="form-control" name="reporteUsuario" id="rUsuario" >
									<option value="nousuario" >Seleccione un usuario....</option>	
									<% 
									
									if (!(session.getAttribute("usu")==null))
									{
										
										//session.setAttribute("usu", null);
										for( Usuario usuario:lista) 
										{
											//System.out.println("Dentro del for "+session.getAttribute("usu"));
											if(!(session.getAttribute("usu").equals("nousuario")) )
											{
												//System.out.println(usuario.getNombres()+" "+ session.getAttribute("usu"));
												if (usuario.getId()==Integer.parseInt(session.getAttribute("usu").toString()))
												{
													%>
														<option value=<%= usuario.getId() %> selected><%= usuario.getNombres() %></option>
													<% 
												}
												else
												{
													%>
													<option value=<%= usuario.getId() %>><%= usuario.getNombres() %></option>
													<% 
												}
											}
											else
											{
												%>
												<option value=<%= usuario.getId() %>><%= usuario.getNombres() %></option>
												<%
											}
											
										}
									}
									else
									{
										for( Usuario usuario:lista) 
										{
																					
																						%>
																						<option value=<%= usuario.getId() %>><%= usuario.getNombres() %></option>
																						<%
										}
									}
										
									%>
									
									</select>
									<input type="submit" class="oculto" value="ContinuarUs" name="btnContinuarUsuarioss" id="btnContinuarUsuarioss"/>
									<% 	
									}
									%>	
        					</div>
        				</div>
        				
        				
        				<!--
        				
        					FIN SECCION USUARIOS
        				  
        				  -->
        				<!-- 
        				
        				FIN USUARIOS
        				
        				 -->
        				
					</div>        		
				</form>
				
				
			<!-- 
			
				INICIO DE LA TABLA DE REPORTES 
				
			-->
		
			<div class="table-responsive">

				<%
					if(!(session.getAttribute("envios") == null))
					{
						ArrayList <List>  envios =(ArrayList <List>) session.getAttribute("envios");
						
					System.out.println("Loss envios son :"+envios.size());
						if (envios.size()>0)
						{
							if (Integer.parseInt(session.getAttribute("servicio").toString())==1)
							{
								%>
										
										<h4>Los resultados son:</h4>
							
										<table class="table table-bordered table-condensed "  style="table-layout: fixed; font-size: 85%; word-wrap: break-word;">
										<tr>
											<td style="width: 6%; text-align:center;">ID</td>
											<td style="width: 8%;">Fecha</td>
											<td style="width: 30%;" >Mensaje Modelo</td>
											<td style="width: 12%; text-align:center;">Cantidad de SMS</td>
											<td style="width: 12%;">Acción</td>
											<td style="width:0%;"></td>
				
										</tr>
									<% 
									for (int j=0;j<envios.size();j++)
									{
										//System.out.println("Entrooooooo");
										List <Transaccion> transacciones = (List <Transaccion>)envios.get(j);
										
										//String nClase= String.valueOf(transacciones.get(0).getIdEnvio())+ transacciones.get(0).getFecha().toString();
										String nClase=String.valueOf(transacciones.get(0).getIdEnvio());
										String modal="myModal"+nClase;
										//System.out.println(nClase);
										%>
										<tr >
											<td style="text-align:center;"><%= transacciones.get(0).getIdEnvio()%></td>
											<td><%= transacciones.get(0).getFecha() %></td>
											<td><%= transacciones.get(0).getMensaje() %></td>
											<td style="text-align:center;"> <%= transacciones.size() %></td>
											<td style="text-align:center;">
												<button type="button" onclick="abrir('<%= modal %>')">Ver detalle</button>
												<input type="button" onclick="CreateExcelSheet(<%= nClase %>)" value="Exportar a Excel"/></td>
											<td   >
											<div class="container">
							                      
							                      <!-- Trigger the modal with a button -->
							                      
							                      <!-- Modal -->
							                      <div class="modal fade" id="<%=modal %>" role="dialog">
							                        <div class="modal-dialog-lg" style="width: 95%; top: 15%; margin: 4% auto auto;">
							                        
							                          <!-- Modal content-->
							                          <div class="modal-content">
							                            <div class="modal-header">
							                              <button type="button" class="close" data-dismiss="modal">&times;</button>
							                              <h4 class="modal-title">Detalles</h4>
							                            </div>
							                            <div class="modal-body">

												<table id="<%= nClase %>" class="table table-bordered table-condensed  <%= nClase %>" >
													<tr>
														<td style="width: 6%;">ID</td>
														<td style="width: 8%;">Fecha</td>
														<td style="width: 7%;">Hora</td>
														<td style="width: 10%;">Código de retorno</td>
														<td style="width: 9%;">Plataforma</td>
														<td style="width: 10%;">Celular</td>
														<td>Mensaje</td>
														<td style="width: 10%;">Empresa</td>
														<td style="width: 9%;">Usuario</td>
														<td style="width: 8%;">Servicio</td>
					
												</tr>
													<%
													for (int i =0;i< transacciones.size();i++)
													{
														%>
														<tr>
															<td><%= transacciones.get(i).getId() %></td>
															<td><%= transacciones.get(i).getFecha() %></td>
															<td><%= transacciones.get(i).getHora() %></td>
															<td> <%= transacciones.get(i).getCodRetorno() %></td>
															<td><%= transacciones.get(i).getPlataforma() %></td>
															<td><%= transacciones.get(i).getCelular().toString() %></td>
															<td><%= transacciones.get(i).getMensaje() %></td>
															<td><%= transacciones.get(i).getNombreEmpresa() %></td>
															<td><%= transacciones.get(i).getNombreUsuario() %></td>
															<td><%= transacciones.get(i).getNombreServicio() %></td>
														</tr>
														<% 
													}

													
													
													%>
												</table>
												</div>
							                           		<div class="modal-footer">
							                              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							                            </div>
							                          </div>
							                          
							                        </div>
							                      </div>
							                      
							                    </div>
											</td>
											
										</tr>
										<% 
										
										
										
									}
										%>
										 
										 
										</table>
										<%
							}
							else if (Integer.parseInt(session.getAttribute("servicio").toString())==3)
							{
							
								%>
								
								<h4>Los resultados son:</h4>
								
								<table class="table table-bordered table-condensed  table2excel" id="table2excel" style="table-layout: fixed; font-size: 85%; word-wrap: break-word;">
								<tr>
									
									<td style="width: 6%; text-align:center;">ID</td>
									<td style="width: 8%;">Fecha</td>
									<td style="width: 30%;" >Mensaje Modelo</td>
									<td style="width: 12%; text-align:center;">Cantidad de SMS</td>
									<td style="width: 12%;">Acción</td>
									<td style="width:0%;"></td>
		
								</tr>
									<% 
									for (int j=0;j<envios.size();j++)
									{
										//System.out.println("Entrooooooo");
										List <Transaccion> transacciones = (List <Transaccion>)envios.get(j);
										
										//String nClase= String.valueOf(transacciones.get(0).getIdEnvio())+ transacciones.get(0).getFecha().toString();
										String nClase=String.valueOf(transacciones.get(0).getIdEnvio());
										String modal="myModal"+nClase;
										//System.out.println(nClase);
										%>
										<tr >
											<td style="text-align:center;"><%= transacciones.get(0).getIdEnvio()%></td>
											<td><%= transacciones.get(0).getFecha() %></td>
											<td><%= transacciones.get(0).getMensaje() %></td>
											<td style="text-align:center;"> <%= transacciones.size() %></td>
											<td style="text-align:center;">
												<button type="button" onclick="abrir('<%= modal %>')">Ver detalle</button>
												<input type="button" onclick="CreateExcelSheet(<%= nClase %>)" value="Exportar a Excel"/></td>
											<td   >
											<div class="container">
							                      
							                      <!-- Trigger the modal with a button -->
							                      
							                      <!-- Modal -->
							                      <div class="modal fade" id="<%=modal %>" role="dialog">
							                        <div class="modal-dialog-lg" style="width: 95%; top: 15%; margin: 4% auto auto;">
							                        
							                          <!-- Modal content-->
							                          <div class="modal-content">
							                            <div class="modal-header">
							                              <button type="button" class="close" data-dismiss="modal">&times;</button>
							                              <h4 class="modal-title">Detalles</h4>
							                            </div>
							                            <div class="modal-body">

												<table id="<%= nClase %>" class="table table-bordered table-condensed  <%= nClase %>" >
													<tr>
														<td style="width: 6%;">ID</td>
														<td style="width: 8%;">Fecha</td>
														<td style="width: 7%;">Hora</td>
														<td style="width: 10%;">Código de retorno</td>
														<td style="width: 9%;">ID Interno</td>
														<td style="width: 10%;">Celular</td>
														<td>Mensaje</td>
														<td style="width: 10%;">Empresa</td>
														<td style="width: 9%;">Usuario</td>
														<td style="width: 8%;">Servicio</td>
							
													</tr>
													<%
													for (int i =0;i< transacciones.size();i++)
													{
														%>
															<tr>
																<td><%= transacciones.get(i).getId() %></td>
																<td><%= transacciones.get(i).getFecha() %></td>
																<td><%= transacciones.get(i).getHora() %></td>
																<td> <%= transacciones.get(i).getCodRetorno() %></td>
																<td><%= transacciones.get(i).getPlataforma() %></td>
																<td><%= transacciones.get(i).getCelular() %></td>
																<td><%= transacciones.get(i).getMensaje() %></td>
																<td><%= transacciones.get(i).getNombreEmpresa() %></td>
																<td><%= transacciones.get(i).getNombreUsuario() %></td>
																<td><%= transacciones.get(i).getNombreServicio() %></td>
															</tr>
														<% 
													}

													
													
													%>
												</table>
												</div>
							                           		<div class="modal-footer">
							                              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							                            </div>
							                          </div>
							                          
							                        </div>
							                      </div>
							                      
							                    </div>
											</td>
											
										</tr>
										<% 
										
										
										
									}
										%>
							
								 
								 
								</table>
								<%
								
							}
						
						}
						else
						{
							%>
							<h4>No existen resultados para esta consulta. Por favor, verifique las fechas</h4>
							<% 
						}
					}
					else
					{
						%>
						<h4>No existen resultados para esta consulta. Por favor, verifique las fechas</h4>
						<% 
					}
				%>
				
			</div>
			
			<!-- 
			
				FIN DE LA TABLA DE REPORTES 
				
			-->	
				
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
