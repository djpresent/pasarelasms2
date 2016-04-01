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
    
    <script type="text/javascript">
    
	function validarPass()
	{
			var caract_invalido = " ";
			var caract_longitud = 6;
			var cla1 = document.getElementById("txtPass").value;
			var cla2 = document.getElementById("txtPass1").value;
			
			if (cla1 == '' || cla2 == '') 
			{
				alert('No ha ingresado la contraseña.');
				return false;
			}
			if (cla1 < caract_longitud) 
			{
				alert('Su contraseña debe constar de ' + caract_longitud + ' caracteres.');
				return false;
			}
			if (cla1.indexOf(caract_invalido) > -1) 
			{
				alert("Las contraseñas no pueden contener espacios.");
				return false;
			}
			else 
			{
				if (cla1 != cla2) 
				{
					alert ("Las contraseñas introducidas no coinciden.");
					return false;
				}
				else 
				{
					document.getElementById('txtPass').value = hex_md5(document.getElementById('txtPass').value);
					document.getElementById('txtPass1').value = hex_md5(document.getElementById('txtPass1').value);	
					return true;
			    }
			 }
		
		}
	    
    </script>
    
    
    
  </head>

  <body>


  </body>
</html>
