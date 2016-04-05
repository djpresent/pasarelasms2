<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.analixdata.modelos.Usuario" %>


<html>
<head>
  	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
  	<link rel="stylesheet" type="text/css" href="css/estilos.css">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Analixdata Servicios en Línea</title>
    <script src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
    <script>
    
    
    $.get('comunidades', function(data) {
        alert(data);
    });
    
    
    
    $(document).ready(function () {
		
    	 $('.itemLista').on('click', function () {
    	        $(this).parents('tr').toggleClass('selected');
    	      });
    	
     });
    
   
    
    </script>
  </head>

  <body>

  <%

	
  	HttpSession sessionlog = request.getSession();
  	Usuario u = (Usuario)sessionlog.getAttribute("usuario");
  	
  	if (u==null)
  	{
  		
  		sessionlog.setAttribute("error", "error");
  		response.sendRedirect("/login.jsp");
  	}
	
  	
	String userName = null;
	String sessionID = null;
	Cookie[] cookies = request.getCookies();
	if(cookies !=null)
	{
		for(Cookie cookie : cookies)
		{
		    if(cookie.getName().equals("usuario")) userName = cookie.getValue();
		    if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
		
		}
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
			<div class="col-sm-9 col-md-10 main contenido">
				<div class="row">
					<div class="col-sm-3 col-md-3" style="text-align: center; margin-top: 3%;">
					
						<img class="icoheader" src="imagenes/logoWhatsapp.jpg" /> 
					</div >
					<div class="col-sm-3 col-md-3" style="text-align: center;">
						<h4 style="margin-top: 15%;">Tus chats</h4>
						<button type="button" class="btn btn-primary btn-circle" style="background-color: rgb(232, 78, 27) ! important; border-color:#AF3B08 ! important; ">0</button>
					</div>
					<div class="col-sm-3 col-md-3" style="text-align: center;">
						<h4 style="margin-top: 15%;">Chats sin asignar</h4>
						<button type="button" class="btn btn-primary btn-circle" style="background-color: rgb(232, 78, 27) ! important; border-color:#AF3B08 ! important;">0</button>
					</div>
					<div class="col-sm-3 col-md-3" style="text-align: center;">
						<h4 style="margin-top: 15%;">Chats Finalizados</h4>
						<button type="button" class="btn btn-primary btn-circle" style="background-color: rgb(232, 78, 27) ! important; border-color:#AF3B08 ! important;">0</button>
					</div>
				</div>	
				
				<div class="row">
					<div class="col-sm-4 col-md-4">
						
						    <div class="chat-window col-xs-12 col-md-12" id="chat_window_1" >
						        
						        	<div class="panel panel-default">
						                <div class="panel-heading top-bar">
						                    <div class="col-md-12 col-xs-12">
						                        	<h3 class="panel-title">
							                        	TUS CHATS
						                        	</h3>
						                    </div>
						                </div>
						                <div class="panel-body lista ">
						                	<table class="table table-filter">
												<tbody>
													<tr >
														<td>
															<div class="media itemLista">
																<a href="#" class="pull-left">
																	<img src="http://bootsnipp.com/img/avatars/bcf1c0d13e5500875fdd5a7e8ad9752ee16e7462.jpg" class="imgPersona">
																</a>
																<div >
																	<h4 class="title">
																		Alina Guerrero
																	</h4>
																	<p class="summary">METROCAR - 14/3 17:54</p>
																</div>
															</div>
														</td>
													</tr>
													<tr >
														<td>
															<div class="media itemLista">
																<a href="#" class="pull-left">
																	<img src="http://bootsnipp.com/img/avatars/bcf1c0d13e5500875fdd5a7e8ad9752ee16e7462.jpg" class="imgPersona">
																</a>
																<div >
																	<h4 class="title">
																		Geovanny Campoverde
																	</h4>
																	<p class="summary">METROCAR - 14/3 17:54</p>
																</div>
															</div>
														</td>
													</tr>
													
												</tbody>
											</table>    
						                </div>
						    		</div>
						       
						    </div>
						
					</div>
					<div class="col-sm-8 col-md-8">

						
						    <div class="chat-window col-xs-12 col-md-12" id="chat_window_1" >
						       
						        	<div class="panel panel-default">
						                <div class="panel-heading top-bar">
						                    <div class="col-md-12 col-xs-12">
						                        <div class="col-md-6 col-xs-6">
						                        	<h3 class="panel-title">
							                        	<img src="http://bootsnipp.com/img/avatars/bcf1c0d13e5500875fdd5a7e8ad9752ee16e7462.jpg" class="imgPersona"/>Geovanny Campoverde
						                        	</h3>
						                        </div>
						                        <div class="col-md-6 col-xs-6">
						                        	<div class="col-md-6 col-xs-6" style="text-align: center; padding-top: 2.5%;">
						                        		<button class="redondeado">
						                        			<span class="glyphicon glyphicon-picture moverSpan"></span>
						                        		</button>
						                        		<button class="redondeado">
						                        			<span class="glyphicon glyphicon-map-marker moverSpan"></span>
						                        		</button>
						                        	</div>
						                        	<div class="col-md-6 col-xs-6" style="text-align: center; padding-top: 2.5%;">
						                        		<button class="redondeado">
						                        			<span class="glyphicon glyphicon glyphicon-transfer moverSpan"></span>
						                        		</button>
						                        		<button class="redondeado">
						                        			<span class="glyphicon glyphicon-check moverSpan"></span>
						                        		</button>
						                        		
						                        		
						                        	</div>
						                        	
						                        	
						                        	
						                        </div>
						                        
						                    </div>

						                </div>
						                <div class="panel-body msg_container_base">
						                    <div class="row msg_container base_sent">
						                        <div  style="padding: 0;">
						                            <div class="messages msg_sent">
						                                <p>that mongodb thing looks good, huh?
						                                tiny master db, and huge document store</p>
						                                <time datetime="2009-11-13T20:00">Timothy • 51 min</time>
						                            </div>
						                        </div>
						                        <div class=" avatar">
						                            <img src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg" class=" img-responsive ">
						                        </div>
						                    </div>
						                    <div class="row msg_container base_receive">
						                        <div class="avatar">
						                            <img src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg" class=" img-responsive ">
						                        </div>
						                        <div  style="padding: 0;">
						                            <div class="messages msg_receive">
						                                <p>that mongodb thing looks good, huh?
						                                tiny master db, and huge document store</p>
						                                <time datetime="2009-11-13T20:00">Timothy • 51 min</time>
						                            </div>
						                        </div>
						                    </div>
						                    
						                    
						                    
						                    
						                    
						                    
						                    <div class="row msg_container base_receive">
						                        <div class="avatar">
						                            <img src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg" class=" img-responsive ">
						                        </div>
						                        <div  style="padding: 0;">
						                            <div class="messages msg_receive">
						                                <p>that mongodb thing looks good, huh?
						                                tiny master db, and huge document store</p>
						                                <time datetime="2009-11-13T20:00">Timothy • 51 min</time>
						                            </div>
						                        </div>
						                    </div>
						                    <div class="row msg_container base_receive">
						                        <div class="avatar">
						                            <img src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg" class=" img-responsive ">
						                        </div>
						                        <div  style="padding: 0;">
						                            <div class="messages msg_receive">
						                                <p>that mongodb thing looks good, huh?
						                                tiny master db, and huge document store</p>
						                                <time datetime="2009-11-13T20:00">Timothy • 51 min</time>
						                            </div>
						                        </div>
						                    </div>
						                    <div class="row msg_container base_receive">
						                        <div class="avatar">
						                            <img src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg" class=" img-responsive ">
						                        </div>
						                        <div  style="padding: 0;">
						                            <div class="messages msg_receive">
						                                <p>that mongodb thing looks good, huh?
						                                tiny master db, and huge document store</p>
						                                <time datetime="2009-11-13T20:00">Timothy • 51 min</time>
						                            </div>
						                        </div>
						                    </div>
						                    <div class="row msg_container base_receive">
						                        <div class="avatar">
						                            <img src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg" class=" img-responsive ">
						                        </div>
						                        <div  style="padding: 0;">
						                            <div class="messages msg_receive">
						                                <p>that mongodb thing looks good, huh?
						                                tiny master db, and huge document store</p>
						                                <time datetime="2009-11-13T20:00">Timothy • 51 min</time>
						                            </div>
						                        </div>
						                    </div>
						                    <div class="row msg_container base_receive">
						                        <div class="avatar">
						                            <img src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg" class=" img-responsive ">
						                        </div>
						                        <div  style="padding: 0;">
						                            <div class="messages msg_receive">
						                                <p>that mongodb thing looks good, huh?
						                                tiny master db, and huge document store</p>
						                                <time datetime="2009-11-13T20:00">Timothy • 51 min</time>
						                            </div>
						                        </div>
						                    </div>
						                    <div class="row msg_container base_receive">
						                        <div class="avatar">
						                            <img src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg" class=" img-responsive ">
						                        </div>
						                        <div  style="padding: 0;">
						                            <div class="messages msg_receive">
						                                <p>that mongodb thing looks good, huh?
						                                tiny master db, and huge document store</p>
						                                <time datetime="2009-11-13T20:00">Timothy • 51 min</time>
						                            </div>
						                        </div>
						                    </div>
						                    <div class="row msg_container base_receive">
						                        <div class="avatar">
						                            <img src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg" class=" img-responsive ">
						                        </div>
						                        <div  style="padding: 0;">
						                            <div class="messages msg_receive">
						                                <p>that mongodb thing looks good, huh?
						                                tiny master db, and huge document store</p>
						                                <time datetime="2009-11-13T20:00">Timothy • 51 min</time>
						                            </div>
						                        </div>
						                    </div>
						                    </div>
						                    
						                    
						                    
						                    
						                    
						                    
						                    
						                    
						                   
						                <div class="panel-footer">
						                    <div class="input-group">
						                        <input id="btn-input" type="text" class="form-control input-sm chat_input" placeholder="Write your message here..." />
						                        <span class="input-group-btn">
						                        <button class="btn btn-primary btn-sm" id="btn-chat" style="background-color: rgb(232, 78, 27); border-color: rgb(196, 84, 39);"><img src="./imagenes/send.png" style="width: 18px;"/></button>
						                        </span>
						                    </div>
						                </div>
						    		</div>
						       
						    </div>
						    
						    <div class="btn-group dropup">
						        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						            <span class="glyphicon glyphicon-cog"></span>
						            <span class="sr-only">Toggle Dropdown</span>
						        </button>
						        <ul class="dropdown-menu" role="menu">
						            <li><a href="#" id="new_chat"><span class="glyphicon glyphicon-plus"></span> Novo</a></li>
						            <li><a href="#"><span class="glyphicon glyphicon-list"></span> Ver outras</a></li>
						            <li><a href="#"><span class="glyphicon glyphicon-remove"></span> Fechar Tudo</a></li>
						            <li class="divider"></li>
						            <li><a href="#"><span class="glyphicon glyphicon-eye-close"></span> Invisivel</a></li>
						        </ul>
						    </div>
						
						
						
					
					</div>
				</div>
			</div>
			
			
			
	
		</div>
		
	</div>
	<footer class="footer ">
      <div class="container" style="margin-left:25px;margin-right:-25px;">
      	 <div class="footizquierda">Analixdata, 2015 | Copyright © 2016. Todos los derechos reservados.</div>
       	  <div class="footderecha">Teléfono: 593 07 3701919   Email: lalvarez@analixdata.com<img class="icoheader" style="margin-left:10px;" src="imagenes/icogoogle.png"/> <img class="icoheader" src="imagenes/icotwitter.png"/> <a href="https://www.facebook.com/AnalixData-Cia-Ltda-1053799024633059/?fref=ts" target="_blank"><img class="icoheader" src="imagenes/icofacebook.png"/></a></div>
    
      </div>
    </footer>

  	<%} %>
  
  </body>
</html>
