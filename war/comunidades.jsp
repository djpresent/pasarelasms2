<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.analixdata.modelos.Usuario" %>


<html>
<head>

  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.js"></script>
  	
  	<link rel="stylesheet" type="text/css" href="css/estilos.css">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <title>Analixdata Servicios en Línea</title>
    <script type="text/javascript" src="https://maps.google.com/maps/api/js?sensor=false">
	</script>
   
 	<script type="text/javascript">
		function getCoords(marker){
		    document.getElementById("loglat").value=marker.getPosition().lat();
		      document.getElementById("loglong").value=marker.getPosition().lng();
		}
		function initialize() {
		    var myLatlng = new google.maps.LatLng(-2.897476, -79.004444);
		    var myOptions = {
		        zoom: 16,
		        center: myLatlng,
		        mapTypeId: google.maps.MapTypeId.ROADMAP,
		    }
		    var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
		    
		   marker = new google.maps.Marker({
		          position: myLatlng,
		          draggable: true,
		          title:"Ubicación a enviar"
		    });
		    google.maps.event.addListener(marker, "dragend", function() {
		                    getCoords(marker);
		    });
		    
		      marker.setMap(map);
		    getCoords(marker);
		    
		    google.maps.event.trigger(map,'resize');
		  
		  }
		
		
    var listaOpenChats="";
    var listaQueueChats="";
    var listaClosedChats="";
    
    
    function obtenerOpen(){
    	$("#listaChats tr").remove();
    	
    	if(listaOpenChats == ""){
    	
	        $.getJSON('comunidades',{
	        	accion: "obtenerChats",
	            opcion: "open"
	         }, function(json) {
	        	document.getElementById("openchats").innerHTML=json.chats.length;
	        	listaOpenChats=json.chats;
	            $.each(listaOpenChats, function (i, chat) {
	            	
	            	var listaChats = document.getElementById("listaChats");
	            	var row = listaChats.insertRow(i);
	            	var cell1 = row.insertCell(0);
	
	            	var contenido="<div class=\"media itemLista\" id=\""+chat.chatId+"\" onclick=\"abrirChat(this);\" >"+
	    			"<a href=\"#\" class=\"pull-left\">"+
	    			"<img src=\""+chat.profilePicture+"\" class=\"imgPersona\">"+
	    			"</a>"+
	    			"<div>"+
	    			"<h4 class=\"title\">"+chat.whatsappName+"</h4>"+
	    			"<p class=\"summary\">"+chat.chatUser+" - "+chat.lastMessage+"</p>"+
	    			"</div>"+
	    			"</div>";
	
	            	cell1.innerHTML = contenido;
	            });
	        });
    	}else{
    		$.each(listaOpenChats, function (i, chat) {
            	
            	var listaChats = document.getElementById("listaChats");
            	var row = listaChats.insertRow(i);
            	var cell1 = row.insertCell(0);

            	var contenido="<div class=\"media itemLista\" id=\""+chat.chatId+"\" onclick=\"abrirChat(this);\" >"+
    			"<a href=\"#\" class=\"pull-left\">"+
    			"<img src=\""+chat.profilePicture+"\" class=\"imgPersona\">"+
    			"</a>"+
    			"<div>"+
    			"<h4 class=\"title\">"+chat.whatsappName+"</h4>"+
    			"<p class=\"summary\">"+chat.chatUser+" - "+chat.lastMessage+"</p>"+
    			"</div>"+
    			"</div>";

            	cell1.innerHTML = contenido;
            });
    	}
    }
    
    function obtenerClosed(){
    	$("#listaChats tr").remove();
    	
    	if(listaClosedChats == ""){
    	
	        $.getJSON('comunidades',{
	        	accion: "obtenerChats",
	            opcion: "solved"
	         }, function(json) {
	        	document.getElementById("closedchats").innerHTML=json.chats.length;
	        	listaClosedChats=json.chats;
	            $.each(listaClosedChats, function (i, chat) {
	            	
	            	var listaChats = document.getElementById("listaChats");
	            	var row = listaChats.insertRow(i);
	            	var cell1 = row.insertCell(0);
	
	            	var contenido="<div class=\"media itemLista\" id=\""+chat.chatId+"\" onclick=\"abrirChat(this);\" >"+
	    			"<a href=\"#\" class=\"pull-left\">"+
	    			"<img src=\""+chat.profilePicture+"\" class=\"imgPersona\">"+
	    			"</a>"+
	    			"<div>"+
	    			"<h4 class=\"title\">"+chat.whatsappName+"</h4>"+
	    			"<p class=\"summary\">"+chat.chatUser+" - "+chat.lastMessage+"</p>"+
	    			"</div>"+
	    			"</div>";
	
	            	cell1.innerHTML = contenido;
	            });
	        });
    	}else{
				$.each(listaClosedChats, function (i, chat) {
            	
            	var listaChats = document.getElementById("listaChats");
            	var row = listaChats.insertRow(i);
            	var cell1 = row.insertCell(0);

            	var contenido="<div class=\"media itemLista\" id=\""+chat.chatId+"\" onclick=\"abrirChat(this);\" >"+
    			"<a href=\"#\" class=\"pull-left\">"+
    			"<img src=\""+chat.profilePicture+"\" class=\"imgPersona\">"+
    			"</a>"+
    			"<div>"+
    			"<h4 class=\"title\">"+chat.whatsappName+"</h4>"+
    			"<p class=\"summary\">"+chat.chatUser+" - "+chat.lastMessage+"</p>"+
    			"</div>"+
    			"</div>";

            	cell1.innerHTML = contenido;
            });
    	}
    }
    
    
    function obtenerQueue(){
    	$("#listaChats tr").remove();
    	
    	if(listaQueueChats == ""){
		        $.getJSON('comunidades',{
		        	accion: "obtenerChats",
		            opcion: "queue"
		         }, function(json) {
		        	document.getElementById("queuechats").innerHTML=json.chats.length;
		        	listaQueueChats=json.chats;
		            $.each(listaQueueChats, function (i, chat) {
		            	
		            	var listaChats = document.getElementById("listaChats");
		            	var row = listaChats.insertRow(i);
		            	var cell1 = row.insertCell(0);
		
		            	var contenido="<div class=\"media itemLista\" id=\""+chat.chatId+"\" onclick=\"abrirChat(this);\" >"+
		    			"<a href=\"#\" class=\"pull-left\">"+
		    			"<img src=\""+chat.profilePicture+"\" class=\"imgPersona\">"+
		    			"</a>"+
		    			"<div>"+
		    			"<h4 class=\"title\">"+chat.whatsappName+"</h4>"+
		    			"<p class=\"summary\">"+chat.chatUser+" - "+chat.lastMessage+"</p>"+
		    			"</div>"+
		    			"</div>";
		
		            	cell1.innerHTML = contenido;
		            });
		        });
        
			}else{
				$.each(listaQueueChats, function (i, chat) {
		    	
		    	var listaChats = document.getElementById("listaChats");
		    	var row = listaChats.insertRow(i);
		    	var cell1 = row.insertCell(0);
		
		    	var contenido="<div class=\"media itemLista\" id=\""+chat.chatId+"\" onclick=\"abrirChat(this);\" >"+
				"<a href=\"#\" class=\"pull-left\">"+
				"<img src=\""+chat.profilePicture+"\" class=\"imgPersona\">"+
				"</a>"+
				"<div>"+
				"<h4 class=\"title\">"+chat.whatsappName+"</h4>"+
				"<p class=\"summary\">"+chat.chatUser+" - "+chat.lastMessage+"</p>"+
				"</div>"+
				"</div>";
		
		    	cell1.innerHTML = contenido;
		    });
		}
    }
    
    var seleccionado="";
    
    function abrirChat(item) {
    	
    		document.getElementById("txtMensaje").value="";
    	
    		var id=item.id;
    		
    		
	        $("#"+id).parents('tr').toggleClass('selected');
	        
	        $("#"+seleccionado).parents('tr').toggleClass('selected');
	        
	        document.getElementById("contenedorMensajes").innerHTML="";
	        document.getElementById('divCargando').style.display='block';
	        
			
	        var matches = [];
	        var searchEles = item.children;
	        document.getElementById("imgPersona").src=searchEles[0].children[0].src;
	        document.getElementById("nombrePersona").innerHTML=searchEles[1].children[0].innerHTML;
  
	        $.getJSON('comunidades',{
	        	accion: "obtenerMensajes",
	            opcion: id
	         }, function(json) {
	        	if(json.result.status==200){
	        		 
	 		        	
	 		        	listaMensajes=json.result.data;
	 		        
	 		        	
	 		        	var contenido="";
	 		            $.each(listaMensajes, function (i, mensaje) {
	 		            		
	 		            	//alert(JSON.stringify(mensaje,null,4));
	 		            	
	 		            	var time = new Date(mensaje.sendtime*1000);
	 		            	var fecha=time.getDate()+"/"+(time.getMonth()+1)+" "+(time.getHours()-5)+":"+time.getMinutes();
	 				        
	 		            	var extracto="";
	 		            	
	 		            	if(mensaje.type == 1){
	 		            		extracto="<p>"+mensaje.message+"</p>";
	 		            	}
	 		            	
	 		            	if(mensaje.type == 2){
	 		            		extracto="<img style=\"max-height: 300px;\" src="+mensaje.path+" />";
	 		            	}
	 		            	
	 		            	if(mensaje.type == 5){
	 		            		extracto="<iframe style=\"height: 300px;width: 300px;\" src=\"https://www.google.com/maps/embed/v1/place?key=AIzaSyDn9VDyDRUwVuaDHz8OsQgTtsjOVxZBhLw&q="+mensaje.latitude+","+mensaje.longitude+"\" ></iframe>";
				    				
	 		            	}
	 		            	
	 		            	
	 		            	if(mensaje.direction=="outbound"){
	 		            	
	 		         		contenido+="<div class=\"row msg_container base_sent\">"+
            				"<div  style=\"padding: 0;\">"+
       						"<div class=\"messages msg_sent\">"+
       						extracto+
       							"<div><p>"+mensaje.title+"</p></div>"+
            					"<time>"+fecha+"</time>"+
        					"</div>"+
    					"</div>"+
    					"<div class=\" avatar\">"+
        					"<img src=\"http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg\" class=\" img-responsive \">"+
    					"</div>"+
					"</div>";
					
	 		            	}else{
	 		            		contenido+="<div class=\"row msg_container base_receive\">"+
	            				
	            				"<div class=\" avatar\">"+
	        					"<img src=\"http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg\" class=\" img-responsive \">"+
	    						"</div>"+
	    						"<div  style=\"padding: 0;\">"+
	       						"<div class=\"messages msg_receive\">"+
	            					extracto+
	            					"<div><p>"+mensaje.title+"</p></div>"+
	            					"<time>"+fecha+"</time>"+
	        					"</div>"+
	    					"</div>"+
	    					
						"</div>";
						
	 		            		
	 		            	}
	 		            	
	 		           
	 		            		
	 						
	 		            	
	 		            });
	 		           document.getElementById('divCargando').style.display='none';
	 		           var mensajes = document.getElementById("contenedorMensajes");
	 		           mensajes.innerHTML = contenido;
	 		          $('#scrollMensajes').scrollTop($('#scrollMensajes').prop("scrollHeight"));
	 		          
	        	}
	        });
	        
	        seleccionado=item.id;
	       
	        document.getElementById("botonesChat").style.display='block';
	        
	        
	}
    
    
    function enviarMensaje(){
    	
    	
    	var texto=document.getElementById("txtMensaje").value;
        
    	//alert(texto);
    	//alert(seleccionado);

        $.getJSON('comunidades',{
        	accion: "enviarMensaje",
            opcion: texto,
            chatid: seleccionado
         }, function(json) {
        	 //alert(JSON.stringify(json,null,4));
        	 
        	 
        	if(json.result.status==200){
        		if(json.result.message=="Message sent."){
        			var time = new Date();
		            var fecha=time.getDate()+"/"+(time.getMonth()+1)+" "+(time.getHours()-5)+":"+time.getMinutes();
				        
        			var contenido="<div class=\"row msg_container base_sent\">"+
					    				"<div  style=\"padding: 0;\">"+
											"<div class=\"messages msg_sent\">"+
					    					"<p>"+texto+"</p>"+
					    					"<time>"+fecha+"</time>"+
										"</div>"+
									"</div>"+
									"<div class=\" avatar\">"+
										"<img src=\"http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg\" class=\" img-responsive \">"+
									"</div>"+
								"</div>";
			
		           var mensajes = document.getElementById("contenedorMensajes");
		           var anterior = mensajes.innerHTML;
		          mensajes.innerHTML =  anterior+contenido;
		          document.getElementById("txtMensaje").value="";
		          $('#scrollMensajes').scrollTop($('#scrollMensajes').prop("scrollHeight"));
        		}else{
        			alert("No fue posible enviar el mensaje.");
        		}
 		      
        	}
        	
        	if(json.result.status==409){
        		
        		alert("No se puede responder en este chat. El último mensaje del usuario fue recibido hace más de 7 días.");
        		document.getElementById("txtMensaje").value="";
        	}
        });
    	
    }
    
  
    
    function handleFiles(files) 
	{
	      // Check for the various File API support.
		if (window.FileReader) {
			getAsText(files[0]);
			readURL(document.getElementById("archivo"));
	        document.getElementById("imagen").style.display='block';
		} else 
		{
	    	alert('Su navegador no le permite subir archivos.');
		}
	}
    
    
    var textoArchivo="";
    
	function getAsText(fileToRead) 
	{
		var reader = new FileReader();
		// Read file into memory as UTF-8   
		reader.onload = function(e) {
		    textoArchivo= e.target.result;
		  
		};
		
	  	reader.readAsDataURL(fileToRead);
	 	// Handle errors load
		
		reader.onerror = errorHandler;
	}
	
	function errorHandler(evt) 
	{
		if(evt.target.error.name == "NotReadableError") 
		{
	 		alert("No fue posible leer el archivo!");
	  	}
	}
    
    
    function readURL(input) {

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#imagen').attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }

    
    function enviarFoto(){
    	
    	document.getElementById("cargandoEnvioImagen").style.display='block';
    	
    	var size = document.getElementById("archivo").files[0].size;
    	var texto=textoArchivo.substring(22);
    	
    	//alert(textoArchivo);
    	
    	//console.log(textoArchivo);
    	
    	if(size<=16777216){
    		
    		$.post('comunidades', {
            	accion: "enviarFoto",
                opcion: texto,
                chatid: seleccionado
             }, function(json) {
            	// alert(JSON.stringify(json,null,4));
             	if(json.result.status==200){
             		if(json.result.message=="Message sent."){
             			var time = new Date();
     		            var fecha=time.getDate()+"/"+(time.getMonth()+1)+" "+(time.getHours()-5)+":"+time.getMinutes();
     				        
             			var contenido="<div class=\"row msg_container base_sent\">"+
     					    				"<div  style=\"padding: 0;\">"+
     											"<div class=\"messages msg_sent\">"+
     					    					"<img style=\"max-height: 300px;\" src="+textoArchivo+" />"+
     					    					"<time>"+fecha+"</time>"+
     										"</div>"+
     									"</div>"+
     									"<div class=\" avatar\">"+
     										"<img src=\"http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg\" class=\" img-responsive \">"+
     									"</div>"+
     								"</div>";
     			
     		           var mensajes = document.getElementById("contenedorMensajes");
     		           var anterior = mensajes.innerHTML;
     		          mensajes.innerHTML =  anterior+contenido;
     		          document.getElementById("txtMensaje").value="";
     		          $('#scrollMensajes').scrollTop($('#scrollMensajes').prop("scrollHeight"));
     		         document.getElementById("cmdCerrarModal").click();
     		        	document.getElementById("cargandoEnvioImagen").style.display='none';
             		}else{
             			alert("No fue posible enviar el mensaje.");
             		}
      		      
             	}else{
             		
             		alert("Ocurrió un inconveniente. Por favor intentar nuevamente o comunicarse con Analixdata.");
             		document.getElementById("txtMensaje").value="";
             	}
         	
         }, "json");     
        	
    	}else{
    		alert("El tamaño del archivo debe ser inferior a 16MB.");
    	}
    	
    	

    	
    }
    
function enviarUbicacion(){
    	
    	document.getElementById("cargandoEnvioUbicacion").style.display='block';
    	
    	var nombre = document.getElementById("txtDescUbicacion").value;
		var latitud = document.getElementById("loglat").value;
    	var longitud = document.getElementById("loglong").value;
    	if(nombre != ""){
    		
    		$.post('comunidades', {
            	accion: "enviarUbicacion",
                opcion: nombre,
                latitud: latitud,
                longitud: longitud,
                chatid: seleccionado
             }, function(json) {
            	 //alert(JSON.stringify(json,null,4));
             	if(json.result.status==200){
             		if(json.result.message=="Message sent."){
             			var time = new Date();
     		            var fecha=time.getDate()+"/"+(time.getMonth()+1)+" "+(time.getHours()-5)+":"+time.getMinutes();
     				        
             			var contenido="<div class=\"row msg_container base_sent\">"+
     					    				"<div  style=\"padding: 0;\">"+
     											"<div class=\"messages msg_sent\">"+
     											"<iframe style=\"height: 300px;width: 300px;\" src=\"https://www.google.com/maps/embed/v1/place?key=AIzaSyDn9VDyDRUwVuaDHz8OsQgTtsjOVxZBhLw&q="+latitud+","+longitud+"\" ></iframe>";
     											"<div><p>"+nombre+"</p></div>"+
     											"<time>"+fecha+"</time>"+
     										"</div>"+
     									"</div>"+
     									"<div class=\" avatar\">"+
     										"<img src=\"http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg\" class=\" img-responsive \">"+
     									"</div>"+
     								"</div>";
     			
     		           var mensajes = document.getElementById("contenedorMensajes");
     		           var anterior = mensajes.innerHTML;
     		          mensajes.innerHTML =  anterior+contenido;
     		          document.getElementById("txtMensaje").value="";
     		          $('#scrollMensajes').scrollTop($('#scrollMensajes').prop("scrollHeight"));
     		         document.getElementById("cmdCerrarModalU").click();
     		        	document.getElementById("cargandoEnvioUbicacion").style.display='none';
             		}else{
             			alert("No fue posible enviar el mensaje.");
             		}
      		      
             	}else{
             		
             		alert("Ocurrió un inconveniente. Por favor intentar nuevamente o comunicarse con Analixdata.");
             		document.getElementById("txtMensaje").value="";
             	}
         	
         }, "json");     
        	
    	}else{
    		alert("Es indispensable definir un nombre o descripción de la ubicación a enviar.");
    	}
    	

    }
    
    
    
    obtenerOpen();
    
    $("#modalUbicacion").on('shown.bs.modal', function (e) {
		  initialize();
		});
	

  </script>
  </head>

  <body >

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
						<button id="openchats" onclick="obtenerOpen();" type="button" class="btn btn-primary btn-circle" style="background-color: rgb(232, 78, 27) ! important; border-color:#AF3B08 ! important; ">0</button>
					</div>
					<div class="col-sm-3 col-md-3" style="text-align: center;">
						<h4 style="margin-top: 15%;">Chats sin asignar</h4>
						<button id="queuechats" onclick="obtenerQueue();" type="button" class="btn btn-primary btn-circle" style="background-color: rgb(232, 78, 27) ! important; border-color:#AF3B08 ! important;">0</button>
					</div>
					<div class="col-sm-3 col-md-3" style="text-align: center;">
						<h4 style="margin-top: 15%;">Chats Finalizados</h4>
						<button id="closedchats" onclick="obtenerClosed();" type="button" class="btn btn-primary btn-circle" style="background-color: rgb(232, 78, 27) ! important; border-color:#AF3B08 ! important;">0</button>
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
						                <div class="panel-body lista" >
						                	<table class="table table-filter" id="listaChats">
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
							                        	<img src="http://servicios.analixdata.com/imagenes/icousuario.png" class="imgPersona" id="imgPersona"/><span id="nombrePersona"></span>
							                        </h3>
						                        </div>
						                        <div class="col-md-6 col-xs-6" id="botonesChat" style="display:none">
						                        	<div class="col-md-6 col-xs-6" style="text-align: center; padding-top: 2.5%;">
						                        		<button class="redondeado" data-toggle="modal" data-target="#myModal">
						                        			<span class="glyphicon glyphicon-picture moverSpan"></span>
						                        		</button>
						                        		<button class="redondeado" data-toggle="modal" data-target="#modalUbicacion" id="cmdUbicacion">
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
						                <div id="scrollMensajes" class="panel-body msg_container_base" >
						                    <div id="divCargando" style="text-align: center; padding: 50px;display:none">
						                        <img src="imagenes/loading.gif" >
						                    </div>
						                  	<div id="contenedorMensajes">
                   							</div>
						                    </div>
						                    
						                   
						                <div class="panel-footer">
						                    <div class="input-group">
						                        <input id="txtMensaje" type="text" class="form-control input-sm chat_input" placeholder="Escriba un mensaje ..." />
						                        <span class="input-group-btn">
						                        <button class="btn btn-primary btn-sm" id="cmdEnviar" onclick="enviarMensaje()" style="background-color: rgb(232, 78, 27); border-color: rgb(196, 84, 39);"><img src="imagenes/send.png" style="width: 18px;"/></button>
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

 
  
<!-- Modal Enviar Imagen -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Enviar imagen</h4>
      </div>
   
      <div class="modal-body">
       
        <div class="form-group" style="text-align: center;" >
        	<input  type="file" name="archivo" id="archivo" onchange="handleFiles(this.files)" accept=".jpg,.png,.gif"  />
        	<div>
        	<img id="imagen" src="#" alt="Su imagen" style="height:200px; margin-top:25px;display:none" />
        	<img id="cargandoEnvioImagen" src="imagenes/loading.gif" style="display:none;margin-left: auto;margin-right: auto;" />
        	</div>
        </div>
      </div>
      <div class="modal-footer" >
      	<button type="button" class="btn btn-primary" onclick="enviarFoto()" >Enviar</button>
        <button type="button" id="cmdCerrarModal" class="btn btn-default" data-dismiss="modal">Cerrar</button>
      </div>
   
    </div>

  </div>
</div>
 
 
 <!-- Modal Enviar Ubicacion -->
<div id="modalUbicacion" class="modal" role="dialog" >
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Enviar ubicación</h4>
      </div>
   
      <div class="modal-body" style="text-align: center;" >
      
			<input id="txtDescUbicacion" type="text" class="form-control" onfocus="initialize()" placeholder="Descripción o nombre de la ubicación..." />
            <div id="map_canvas" style="width:100%; height:300px"></div><br>
			<input type="hidden" id="loglat"/>
			<input  type="hidden" id="loglong"/>
        	<img id="cargandoEnvioUbicacion" src="imagenes/loading.gif" style="display:none;margin-left: auto;margin-right: auto;" />
        	
        </div>
      </div>
      <div class="modal-footer" >
      	<button type="button" class="btn btn-primary" onclick="enviarUbicacion()" >Enviar</button>
        <button type="button" id="cmdCerrarModalU" class="btn btn-default" data-dismiss="modal">Cerrar</button>
      </div>
   
    </div>

  </div>
  
  <%} %>
  </body>
</html>