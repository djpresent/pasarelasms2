<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.analixdata.modelos.Usuario" %>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Inicio de Sesión</title>
    
     <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/estilos.css">
    <script src="js/codificacion.js"></script>
    
  </head>

  <body>
  <%
  
//allow access only if session exists

session = request.getSession();
	Usuario u = (Usuario)session.getAttribute("usuario");
	
	if (u!=null)
	{	
		response.sendRedirect("/index.jsp");
	}

  
  %>
  
  <div class="container-fluid">
	<div class="row">
		<div class="col-xs-6 col-md-4 col-xs-offset-3 col-md-offset-4">
		
		<img class="logologin" src="imagenes/logotipo.png" />
		
		<h2 class="form-signin-heading">Bienvenido, por favor inicie sesión</h2>
	    <form action="/validar" method="post" class="form-signin" onsubmit="document.getElementById('txtPassword').value = hex_md5(document.getElementById('txtPasswordT').value)">
	    	<label for="txtEmail" class="sr-only">E-mail</label>
			<input type="email" class="form-control" id="txtEmail" name="txtEmail" placeholder="E-mail" required="required" autofocus/>
			<label for="txtPassword" class="sr-only">Contraseña</label>
			<input type="password" class="form-control" id="txtPasswordT" placeholder="Contraseña" required="required"/>
			<input type="hidden" name="txtPassword" id="txtPassword"/>
			
			
			<input type="submit" class="btn btn-lg btn-primary btn-block btnlogin" value="Iniciar Sesión"/>
		</form>
		<a href="mailRestablecer.jsp" style="color:#337ab7!important;" >¿Olvidaste tu contraseña?</a> 
		</div>
		<% 
		
		if(null == session.getAttribute("name"))
		{  
	
		} 
		else 
		{
			String error=(String)session.getAttribute("error");
			
			if(session.getAttribute("error").equals("error"))
			{
			%>
				<div><h4>Usuario y/o contraseña incorrectos</h4></div>
			<%
			}
			
		}%>
		

		
        
	</div>
	</div>
	
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
	
  </body>
</html>
