<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.analixdata.modelos.Usuario" %>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Olvidé mi contraseña</title>
    
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
     <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/estilos.css">
    <script src="js/codificacion.js"></script>
    
  </head>

  <body>

  
  <div class="container-fluid">
	<div class="row">
		<div class="col-xs-6 col-md-4 col-xs-offset-3 col-md-offset-4">
		
		<img class="logologin" src="imagenes/logotipo.png" />
		
		<h2 class="form-signin-heading">Escriba su email</h2>
	    <form action="/olvidar" method="post" class="form-signin" >
	    	<label for="txtEmail" class="sr-only">E-mail</label>
			<input type="email" class="form-control" id="txtEmail" name="txtEmail" placeholder="E-mail" required="required" autofocus/>
			<input type="submit" class="btn btn-lg btn-primary btn-block btnlogin" value="Enviar"/>
		</form>
		 
		</div>
  
	</div>
	</div>

  </body>
</html>
