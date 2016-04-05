<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.analixdata.modelos.Usuario" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="java.sql.*" %>

<html>
  <head>
  
  	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
  	<link rel="stylesheet" type="text/css" href="css/estilos.css">
  	
  	 <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
	  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
   

	<script type=text/javascript>
	
	var csv;
	
  	var num_caracteres_permitidos=200;
  	var contenido_textarea="";
	
		function cuenta()
		{
			var car = "Caracteres: ";
			
			 num_caracteres = document.getElementById("idTexto").value.length;

			   if (num_caracteres > num_caracteres_permitidos){ 
				   document.getElementById("idTexto").value = contenido_textarea;
			   }else{ 
			      contenido_textarea = document.getElementById("idTexto").value;	
			      document.getElementById("caracteres").value=car.concat(num_caracteres_permitidos-document.getElementById("idTexto").value.length);
					
			   } 
	
			
		}
		
		function handleFiles(files) 
		{
		      // Check for the various File API support.
			if (window.FileReader) {
				getAsText(files[0]);
			} else 
			{
		    	alert('Su navegador no le permite subir archivos.');
			}
		}
		
		function getAsText(fileToRead) 
		{
			var reader = new FileReader();
			// Read file into memory as UTF-8      
		  	reader.readAsText(fileToRead);
		 	// Handle errors load
		 	reader.onload = loadHandler;
			reader.onerror = errorHandler;
		}
		
		function loadHandler(event) 
		{
			 csv = event.target.result;
			//processData(csv);
		}
		
		function errorHandler(evt) 
		{
			if(evt.target.error.name == "NotReadableError") 
			{
		 		alert("No fue posible leer el archivo!");
		  	}
		}

	    function processData() 
	    {
	    	
	    
	    	var cadenaMensajes="{\"messages\":[";
	    	var remitente="InfoSMS";
	    	var mensaje= document.getElementById("idTexto").value;
	        var allTextLines = csv.split(/\r\n|\n/);
	        if(document.getElementById("cantDisponibles").value>=allTextLines.length){
	        	
	        	document.getElementById("cantSMS").value=allTextLines.length;
	        
	        
	      //  var lines = [];
	        for (var i=0; i<allTextLines.length; i++)
	        {
	            var data = allTextLines[i].split(';');
	                //var tarr = [];
	                var destino = data[0];
	                var variable1 = data[1];
	                var variable2 = data[2];
	                var variable3 = data[3];
	                var variable4 = data[4];
	                
	                if (typeof variable1 === 'undefined')
	                {
	                	variable1=""
	                }
	                if (typeof variable2 === 'undefined')
	                {
	                	variable2=""
	                }
	                if (typeof variable3 === 'undefined')
	                {
	                	variable3=""
	                }
	                if (typeof variable4 === 'undefined')
	                {
	                	variable4=""
	                }
	                

	                var res = mensaje.replace(/\[VARIABLE1\]/g, variable1);
	                res = res.replace(/\[VARIABLE2\]/g, variable2);
	                res = res.replace(/\[VARIABLE3\]/g, variable3);
	                res = res.replace(/\[VARIABLE4\]/g, variable4);
	                
	             	if (i>0)
	             	{	
	             		cadenaMensajes+=",";
	             		
	             	}
	                	cadenaMensajes+="{\"from\":\""+remitente+"\",\"to\":\""+destino+"\",\"text\":\""+res+"\"}"; 

	          
	                	
	        }
	        cadenaMensajes+="]}";
	        document.getElementById("mensaje").value=cadenaMensajes;
	    	alert(cadenaMensajes);
	    	
	    	}else{
	    		
	    		alert("No hay suficientes mensajes disponibles en su cuenta.");
	    	}
	    }

	    function agregarV(variable)
	    {
	    	document.getElementById("idTexto").value += variable;
	    	document.getElementById("idTexto").focus();
	    }
	    
	    function elegirTipoMensaje(){
	    	var tipoM=document.getElementById("tipoMensaje").value;
	    	if(tipoM == 1){
	    		document.getElementById("iframeSubir").style.display='none';
	    	
	    	}
	    	
	    	if(tipoM == 2 ){
	    		num_caracteres_permitidos=145;
	    		document.getElementById("caracteres").value=num_caracteres_permitidos;
	    		document.getElementById("iframeSubir").style.display='block';
	    		
	    	}
	    	
	    }

		function comprobar(){
			var tipoM=document.getElementById("tipoMensaje").value;
			if(tipoM == 2){
				if(document.getElementById("url").value.length>0){
					return true;
				}
				else{
					alert("No ha ingresado una URL.");
					return false;
				}
			}
			return true;
			
		} 
	</script> 
  
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Envío de Mensajes</title>
  </head>

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
    "SELECT disponible FROM servicio_empresa where idservicio=3 and idempresa="+u.getEmpresa().getIdEmpresa()+";");
 
String disponible="N/D";

if(rs.next()){
 disponible=Integer.toString(rs.getInt("disponible"));
 
 
}
else
{
	disponible="0";
}

session.setAttribute("disponibles",disponible );
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
					<ul class="menuCuenta nav ">
						<li><a href="usuario.jsp"><h5><img class="icomenu" src="imagenes/icousuarios.png"/>Mis Datos</h5></a></li>
						<li><a href="/cerrarSesion"><img class="icomenu" src="imagenes/icocerrar.png"/>Cerrar Sesión</a></li>
					</ul>
				</div>
		
			<div class="col-sm-9 col-md-9 main">
				<h1 class="page-header">Servicio de Mensajería Whatsapp<img style="padding-left:10px;" class="icoheader" src="imagenes/icoreloj.png"/><img class="icoheader" src="imagenes/icopastel.png"/><img class="icoheader" src="imagenes/icoaudifonos.png"/><img class="icoheader" src="imagenes/icodescarga.png"/></h1>
				<h4>Disponibles: <%= disponible %></h4>

			  	<form  action="whatsapp" enctype="multipart/form-data" method="post" onsubmit="return comprobar();" >
			  	
			  		<div class="row">
			  			<div class="col-xs-4 col-xs-offset-1">
			  				
			  				<div class="form-group">
        						<label for="idTexto">¿Qué tipo de mensaje desea enviar?</label>
        			
	        						<select  class="form-control" id="tipoMensaje" name="tipoMensaje" onchange="elegirTipoMensaje();">
	        							<option value="1" selected>Texto</option>
	        							<option value="2">Multimedia</option>
	        							
	        						</select>
        					
        					</div>
        					
        				</div>
        			</div>
        					
        			<div class="row" id="iframeSubir" style="display:none;">
        			
        				
        				<div class="col-xs-offset-1">
        				
        					<iframe src="upload.html" width="800px" height="240px" frameBorder="0" seamless='seamless' scrolling="no"></iframe>
			  				
			  			</div>
			  			
			  			<div class="col-xs-1">
        					<div class="form-group">
        						<label for="idTexto">URL generado:</label>
        					</div>
        				</div>
        				
        				<div class="col-xs-4">
        					<div class="form-group">
        						<input class="form-control" type="text" name="url" id="url">
        						

        					</div>
        				</div>
        				
			  		</div>
			  		
			  		<div class="row">
			  		
        				<div class="col-xs-1">
        					<div class="form-group">
        						<label for="idTexto">Mensaje:</label>
        					</div>
        				</div>
        				
        				
        				<div class="col-xs-4">
        					<div class="form-group">
        						<textarea class="form-control" cols="40" rows="6" name="mensaje" id="idTexto" required="required" onKeyDown="cuenta()" onKeyUp="cuenta()"></textarea>
        						<input class="form-control"  type="text" name=caracteres id="caracteres" size=4 value="200" disabled="disabled" >

        					</div>
        				</div>
        				
        				
        				<div class="col-xs-2">
        					<div class="form-group">
        						<input class="form-control" type="button" onclick="agregarV('[VARIABLE1]')" value="Variable 1"></input></br>
					  			<input class="form-control" type="button" onclick="agregarV('[VARIABLE2]')" value="Variable 2"></input></br>
					  			<input class="form-control" type="button" onclick="agregarV('[VARIABLE3]')" value="Variable 3"></input></br>
					  			<input class="form-control" type="button" onclick="agregarV('[VARIABLE4]')" value="Variable 4"></input></br>
        					</div>
        				</div>
        				
        				
        					
        			
        				
        			</div>
        			
        			<div class="row">
        				<div class="col-xs-1">
        					<div class="form-group">
        						<label for="archivo">Archivo:</label>
        					</div>
        				</div>
        				<div class="col-xs-6">
        					<div class="form-group">
        						<input  type="file" name="archivo" onchange="handleFiles(this.files)" accept=".csv,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,text/plain" required="required"  />
        					</div>
        				</div>
        			</div>

        			<div class="row">
        				<div class="col-xs-1">
        					<div class="form-group">
        						
        					</div>
        				</div>
        				<div class="col-xs-4">
        					<div class="form-group">
        						<input type="hidden" id="mensaje" name="txtmensaje" >
        						<input type="hidden" id="cantDisponibles" value="<%= disponible %>"/>
			  					<input type="hidden" id="cantSMS" />
			  					<input class="form-control"  onclick="return confirm('¿Está seguro que desea enviar los mensajes?')"  type="submit" value="Enviar" /></td>
        					</div>
        				</div>
        			</div>

			  	</form>
			  	
			  	<%
					if(!(session.getAttribute("codigo") == null))
					{
						int codigo = Integer.parseInt(session.getAttribute("codigo").toString());
						
						String cod;
						switch (codigo)
						{
							case 1:
												cod= "ERROR AL CONECTARSE CON LA BASE DE DATOS!";
												%>
													<div class="alert alert-danger">
													  <strong>Error!</strong> <%= cod %>
													</div>	
												<%
												break;
							case 2:
												cod= "EL ARCHIVO PROPORCIONADO CONTIENE ERRORES. POR FAVOR REVISELO E INTENTE NUEVAMENTE.";
												%>
													<div class="alert alert-danger">
													  <strong>Error!</strong> <%= cod %>
													</div>	
												<%
												break;
							case 3:
												cod= "ALGUNOS MENSAJES NO FUERON ENVIADOS. POR FAVOR, COMUNIQUESE CON ANALIXDATA";
												%>
													<div class="alert alert-danger">
													  <strong>Error!</strong> <%= cod %>
													</div>	
												<%
												break;
							case 4:
												cod= "MENSAJES ENVIADOS SATISFACTORIAMENTE!";
												%>
													<div class="alert alert-success">
													  <strong>Exito!</strong> <%= cod %>
													</div>	
												<%
												break;
							case 5:
												cod= "LOS MENSAJES NO HAN SIDO ENVIADOS. El NUMERO DE MENSAJES ES SUPERIOR A LOS MENSAJES DISPONIBLES. POR FAVOR CONTACTARSE CON ANALIXDATA";
												%>
													<div class="alert alert-danger">
													  <strong>Error!</strong> <%= cod %>
													</div>	
												<%
												break;
							case 6:
												cod= "ERROR AL SUBIR EL ARCHIVO!";
												%>
													<div class="alert alert-danger">
													  <strong>Error!</strong> <%= cod %>
													</div>	
												<%
												break;
							case 7:
												cod= "OPERACION ERRÓNEA. POR FAVOR, COMUNICARSE CON ANALIXDATA URGENTEMENTE";
												%>
													<div class="alert alert-danger">
													  <strong>Error!</strong> <%= cod %>
													</div>	
												<%
												break;
												
							case 8:
												cod= "EL MENSAJE CONTENÍA MÁS CARACTERES DE LO PERMITIDO, FAVOR REVISE SU TEXTO E INTÉNTELO NUEVAMENTE.";
												%>
													<div class="alert alert-danger">
													  <strong>Error!</strong> <%= cod %>
													</div>	
												<%
												break;
						}

					}
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