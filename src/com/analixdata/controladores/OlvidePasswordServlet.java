package com.analixdata.controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.analixdata.modelos.Utilidades;
import com.google.appengine.api.utils.SystemProperty;





import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;



import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;



import java.security.MessageDigest;
import java.util.Arrays;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;



public class OlvidePasswordServlet extends HttpServlet {

	protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException
	{
		resp.setContentType("text/html;charset=UTF-8");
		String url = null;
		String email = req.getParameter("txtEmail");
		try 
		{
	  	      if (SystemProperty.environment.value() ==
	  	          SystemProperty.Environment.Value.Production) {

	  	        Class.forName("com.mysql.jdbc.GoogleDriver");
	  	        url = "jdbc:google:mysql://pasarelasms-1190:analixdata/pasarelasms?user=root&password=1234";
	  	      } else {

	  	        Class.forName("com.mysql.jdbc.Driver");
	  	        url = "jdbc:mysql://localhost:3306/pasarelasms?user=geo";

	  	      }
	  	      
	  	      Connection conn = DriverManager.getConnection(url);
	  	      String sentencia = "SELECT * FROM usuario where email='"+email+"';";
	  	      
	  	      ResultSet rs=conn.createStatement().executeQuery(sentencia);
	  	      
	  	      if (rs.first())
	  	      {
	  	    	  
	  	    	int id = rs.getInt("idusuario");
	  	    	Properties props = new Properties();
	  	        Session session = Session.getDefaultInstance(props, null);
	  	        
	  	        //Encriptar mail
	  	        
	  	        String me = Utilidades.Encriptar(email);
	  	        
	  	        ///Enviar mail
	  	        try 
	  	        {
	  	        	String htmltemplate ="<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <style type=\"text/css\"> body, .mainTable{height:100% !important; width:100% !important; margin:0; padding:0;}img, a img{border:0; outline:none; text-decoration:none;}.imageFix{display:block;}table, td{border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;}p{margin:0; padding:0; margin-bottom:0;}.ReadMsgBody{width:100%;}.ExternalClass{width:100%;}.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div{line-height:100%;}img{-ms-interpolation-mode: bicubic;}body, table, td, p, a, li, blockquote{-ms-text-size-adjust:100%; -webkit-text-size-adjust:100%;}</style><!--[if gte mso 9]><xml> <o:OfficeDocumentSettings> <o:AllowPNG/> <o:PixelsPerInch>96</o:PixelsPerInch> </o:OfficeDocumentSettings></xml><![endif]--></head><body scroll=\"auto\" style=\"padding:0; margin:0; FONT-SIZE: 12px; FONT-FAMILY: Arial, Helvetica, sans-serif; cursor:auto; background:#F3F3F3\"><TABLE class=mainTable cellSpacing=0 cellPadding=0 width=\"100%\" bgColor=#f3f3f3><TR><TD style=\"LINE-HEIGHT: 0; HEIGHT: 20px; FONT-SIZE: 0px\">&#160;</TD></TR><TR><TD vAlign=top><TABLE style=\"MARGIN: 0px auto; WIDTH: 600px\" border=0 cellSpacing=0 cellPadding=0 width=600 align=center><TR><TD style=\"BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; PADDING-BOTTOM: 1px; BACKGROUND-COLOR: transparent; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: medium none; BORDER-RIGHT: medium none; PADDING-TOP: 1px\"><TABLE style=\"WIDTH: 100%\" cellSpacing=0 cellPadding=0 align=left><TR style=\"HEIGHT: 1px\"><TD style=\"BORDER-BOTTOM: medium none; TEXT-ALIGN: center; BORDER-LEFT: medium none; PADDING-BOTTOM: 1px; BACKGROUND-COLOR: transparent; PADDING-LEFT: 15px; WIDTH: 100%; PADDING-RIGHT: 15px; VERTICAL-ALIGN: top; BORDER-TOP: medium none; BORDER-RIGHT: medium none; PADDING-TOP: 1px\"></TD></TR></TABLE></TD></TR><TR><TD style=\"BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; PADDING-BOTTOM: 0px; BACKGROUND-COLOR: transparent; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: medium none; BORDER-RIGHT: medium none; PADDING-TOP: 0px\"><TABLE style=\"WIDTH: 100%\" cellSpacing=0 cellPadding=0 align=left><TR style=\"HEIGHT: 10px\"><TD style=\"BORDER-BOTTOM: medium none; TEXT-ALIGN: center; BORDER-LEFT: medium none; PADDING-BOTTOM: 35px; BACKGROUND-COLOR: transparent; PADDING-LEFT: 15px; WIDTH: 100%; PADDING-RIGHT: 15px; VERTICAL-ALIGN: bottom; BORDER-TOP: medium none; BORDER-RIGHT: medium none; PADDING-TOP: 35px\"><TABLE border=0 cellSpacing=0 cellPadding=0 align=left><TR><TD style=\"PADDING-BOTTOM: 2px; PADDING-LEFT: 2px; PADDING-RIGHT: 2px; PADDING-TOP: 2px\" align=center><TABLE border=0 cellSpacing=0 cellPadding=0><TR><TD style=\"BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; BACKGROUND-COLOR: transparent; BORDER-TOP: medium none; BORDER-RIGHT: medium none\"><IMG style=\"BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; BACKGROUND-COLOR: transparent; DISPLAY: block; BORDER-TOP: medium none; BORDER-RIGHT: medium none\" border=0 src=\"http://analixdata.com/imagenes/Image_1.png\" width=280 height=63 hspace=\"0\" vspace=\"0\"></TD></TR></TABLE></TD></TR></TABLE></TD><TD style=\"BORDER-BOTTOM: medium none; TEXT-ALIGN: center; BORDER-LEFT: medium none; PADDING-BOTTOM: 35px; BACKGROUND-COLOR: transparent; PADDING-LEFT: 15px; WIDTH: 1%; PADDING-RIGHT: 15px; VERTICAL-ALIGN: bottom; BORDER-TOP: medium none; BORDER-RIGHT: medium none; PADDING-TOP: 35px\"><TABLE border=0 cellSpacing=0 cellPadding=0 align=center><TR><TD><TABLE border=0 cellSpacing=0 cellPadding=0 align=center><TR><TD style=\"PADDING-BOTTOM: 2px; PADDING-LEFT: 2px; PADDING-RIGHT: 5px; PADDING-TOP: 2px\" align=center><TABLE border=0 cellSpacing=0 cellPadding=0><TR><TD style=\"BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; BACKGROUND-COLOR: transparent; BORDER-TOP: medium none; BORDER-RIGHT: medium none\"><IMG style=\"BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; BACKGROUND-COLOR: transparent; DISPLAY: block; BORDER-TOP: medium none; BORDER-RIGHT: medium none\" border=0 src=\"http://analixdata.com/imagenes/Image_2.png\" width=24 height=24 hspace=\"0\" vspace=\"0\"></TD></TR></TABLE></TD></TR></TABLE></TD><TD><TABLE border=0 cellSpacing=0 cellPadding=0 align=center><TR><TD style=\"PADDING-BOTTOM: 2px; PADDING-LEFT: 2px; PADDING-RIGHT: 5px; PADDING-TOP: 2px\" align=center><TABLE border=0 cellSpacing=0 cellPadding=0><TR><TD style=\"BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; BACKGROUND-COLOR: transparent; BORDER-TOP: medium none; BORDER-RIGHT: medium none\"><IMG style=\"BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; BACKGROUND-COLOR: transparent; DISPLAY: block; BORDER-TOP: medium none; BORDER-RIGHT: medium none\" border=0 src=\"http://analixdata.com/imagenes/Image_3.png\" width=24 height=24 hspace=\"0\" vspace=\"0\"></TD></TR></TABLE></TD></TR></TABLE></TD><TD></TD><TD></TD><TD></TD><TD></TD><TD></TD></TR></TABLE></TD></TR></TABLE></TD></TR><TR><TD style=\"BORDER-BOTTOM: #dbdbdb 1px solid; BORDER-LEFT: #dbdbdb 1px solid; PADDING-BOTTOM: 0px; BACKGROUND-COLOR: #feffff; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: #dbdbdb 1px solid; BORDER-RIGHT: #dbdbdb 1px solid; PADDING-TOP: 0px\"><TABLE style=\"WIDTH: 100%\" cellSpacing=0 cellPadding=0 align=left><TR style=\"HEIGHT: 20px\"><TD style=\"BORDER-BOTTOM: medium none; TEXT-ALIGN: center; BORDER-LEFT: medium none; PADDING-BOTTOM: 35px; BACKGROUND-COLOR: #feffff; PADDING-LEFT: 15px; WIDTH: 100%; PADDING-RIGHT: 15px; VERTICAL-ALIGN: top; BORDER-TOP: medium none; BORDER-RIGHT: medium none; PADDING-TOP: 35px\"><P style=\"LINE-HEIGHT: 155%; BACKGROUND-COLOR: transparent; MARGIN-TOP: 0px; FONT-FAMILY: Arial, Helvetica, sans-serif; MARGIN-BOTTOM: 1em; COLOR: #a8a7a7; FONT-SIZE: 18px; mso-line-height-rule: exactly\" align=left><STRONG>Estimado Usuario</STRONG></P><P style=\"LINE-HEIGHT: 155%; BACKGROUND-COLOR: transparent; MARGIN-TOP: 0px; FONT-FAMILY: Arial, Helvetica, sans-serif; MARGIN-BOTTOM: 1em; COLOR: #a7a7a7; FONT-SIZE: 12px; mso-line-height-rule: exactly\" align=left>Ha solicitado un cambio de contrase&#241;a desde nuestro sitio. Si usted no ha solicitado&#160;este cambio&#160;por favor comun&#237;quese con ANALIXDATA inmediatamente.</P><P style=\"LINE-HEIGHT: 155%; BACKGROUND-COLOR: transparent; MARGIN-TOP: 0px; FONT-FAMILY: Arial, Helvetica, sans-serif; MARGIN-BOTTOM: 1em; COLOR: #a7a7a7; FONT-SIZE: 12px; mso-line-height-rule: exactly\" align=left>Utilice el siguiente enlace para restablecer su contrase&#241;a:</P><DIV style=\"TEXT-ALIGN: center\"><A href=\"http://servicios.analixdata.com/restablecer?rvry="+me+"\"><IMG title=\"\" border=none alt=\"Clic aquí\" src=\"http://analixdata.com/imagenes/Image_4.png\"> </A></DIV></TD></TR></TABLE></TD></TR><TR><TD style=\"BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; PADDING-BOTTOM: 0px; BACKGROUND-COLOR: transparent; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: medium none; BORDER-RIGHT: medium none; PADDING-TOP: 0px\"><TABLE style=\"WIDTH: 100%\" cellSpacing=0 cellPadding=0 align=left><TR style=\"HEIGHT: 20px\"><TD style=\"BORDER-BOTTOM: medium none; TEXT-ALIGN: center; BORDER-LEFT: medium none; PADDING-BOTTOM: 0px; BACKGROUND-COLOR: transparent; PADDING-LEFT: 0px; WIDTH: 100%; PADDING-RIGHT: 0px; VERTICAL-ALIGN: top; BORDER-TOP: medium none; BORDER-RIGHT: medium none; PADDING-TOP: 0px\"><DIV></DIV></TD></TR></TABLE></TD></TR><TR><TD style=\"BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; PADDING-BOTTOM: 0px; BACKGROUND-COLOR: transparent; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: medium none; BORDER-RIGHT: medium none; PADDING-TOP: 0px\"><TABLE style=\"WIDTH: 100%\" cellSpacing=0 cellPadding=0 align=left><TR style=\"HEIGHT: 10px\"><TD style=\"BORDER-BOTTOM: medium none; TEXT-ALIGN: center; BORDER-LEFT: medium none; PADDING-BOTTOM: 35px; BACKGROUND-COLOR: transparent; PADDING-LEFT: 15px; WIDTH: 100%; PADDING-RIGHT: 15px; VERTICAL-ALIGN: top; BORDER-TOP: medium none; BORDER-RIGHT: medium none; PADDING-TOP: 35px\"><P style=\"LINE-HEIGHT: 125%; BACKGROUND-COLOR: transparent; MARGIN-TOP: 0px; FONT-FAMILY: Arial, Helvetica, sans-serif; MARGIN-BOTTOM: 1em; COLOR: #7c7c7c; FONT-SIZE: 10px; mso-line-height-rule: exactly\" align=left><STRONG>ANALIXDATA, 2015 <BR></STRONG>Copyright &#169; 2015. Todos los derechos reservados. <BR><STRONG>Direcci&#243;n</STRONG>: Ulises Chac&#243;n y Ricardo Mu&#241;oz, Edificio Monte Zion - Planta Baja <BR><STRONG>Tel&#233;fono</STRONG>: 593 07 3701919 , <BR><STRONG>Email</STRONG>: lalvarez@analixdata.com</P></TD><TD style=\"BORDER-BOTTOM: medium none; TEXT-ALIGN: center; BORDER-LEFT: medium none; PADDING-BOTTOM: 35px; BACKGROUND-COLOR: transparent; PADDING-LEFT: 15px; WIDTH: 50%; PADDING-RIGHT: 15px; VERTICAL-ALIGN: top; BORDER-TOP: medium none; BORDER-RIGHT: medium none; PADDING-TOP: 35px\"><TABLE border=0 cellSpacing=0 cellPadding=0 align=center><TR><TD><TABLE border=0 cellSpacing=0 cellPadding=0 align=center><TR><TD style=\"PADDING-BOTTOM: 2px; PADDING-LEFT: 2px; PADDING-RIGHT: 5px; PADDING-TOP: 2px\" align=center><TABLE border=0 cellSpacing=0 cellPadding=0><TR><TD style=\"BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; BACKGROUND-COLOR: transparent; BORDER-TOP: medium none; BORDER-RIGHT: medium none\"><IMG style=\"BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; BACKGROUND-COLOR: transparent; DISPLAY: block; BORDER-TOP: medium none; BORDER-RIGHT: medium none\" border=0 src=\"http://analixdata.com/imagenes/Image_5.png\" width=24 height=24 hspace=\"0\" vspace=\"0\"></TD></TR></TABLE></TD></TR></TABLE></TD><TD><TABLE border=0 cellSpacing=0 cellPadding=0 align=center><TR><TD style=\"PADDING-BOTTOM: 2px; PADDING-LEFT: 2px; PADDING-RIGHT: 5px; PADDING-TOP: 2px\" align=center><TABLE border=0 cellSpacing=0 cellPadding=0><TR><TD style=\"BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; BACKGROUND-COLOR: transparent; BORDER-TOP: medium none; BORDER-RIGHT: medium none\"><IMG style=\"BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; BACKGROUND-COLOR: transparent; DISPLAY: block; BORDER-TOP: medium none; BORDER-RIGHT: medium none\" border=0 src=\"http://analixdata.com/imagenes/Image_6.png\" width=24 height=24 hspace=\"0\" vspace=\"0\"></TD></TR></TABLE></TD></TR></TABLE></TD><TD></TD><TD></TD><TD></TD><TD></TD><TD></TD></TR></TABLE></TD></TR></TABLE></TD></TR><TR><TD style=\"BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; PADDING-BOTTOM: 1px; BACKGROUND-COLOR: transparent; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: medium none; BORDER-RIGHT: medium none; PADDING-TOP: 1px\"><TABLE style=\"WIDTH: 100%\" cellSpacing=0 cellPadding=0 align=left><TR style=\"HEIGHT: 10px\"><TD style=\"BORDER-BOTTOM: medium none; TEXT-ALIGN: center; BORDER-LEFT: medium none; PADDING-BOTTOM: 1px; BACKGROUND-COLOR: transparent; PADDING-LEFT: 15px; WIDTH: 100%; PADDING-RIGHT: 15px; VERTICAL-ALIGN: top; BORDER-TOP: medium none; BORDER-RIGHT: medium none; PADDING-TOP: 1px\"></TD></TR></TABLE></TD></TR></TABLE></TD></TR><TR><TD style=\"LINE-HEIGHT: 0; HEIGHT: 8px; FONT-SIZE: 0px\">&#160;</TD></TR></TABLE></body></html>";

	  	        	Message msg = new MimeMessage(session);
	  	            msg.setFrom(new InternetAddress("cloud@analixdata.com", "Analixdata Cia. Ltda."));
	  	            msg.addRecipient(Message.RecipientType.TO,new InternetAddress(email, email));
	  	            msg.setSubject("Restablecimiento de clave de acceso");
	  	            Multipart mp = new MimeMultipart();
	  	            MimeBodyPart htmlPart = new MimeBodyPart();
	  	            htmlPart.setContent(htmltemplate, "text/html");
	  	            mp.addBodyPart(htmlPart);
			        msg.setContent(mp);	  	            
	  	            Transport.send(msg);
	  	            
	  	            RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
	  	            PrintWriter out= resp.getWriter();
	  	            out.println("<div class=\"alert alert-success\" style=\"text-align: center;\"><strong>Ok ! </strong>Revise su bandeja de entrada para obtener información de restablecimiento de su contraseña.</div> ");
		  	          try 
		  	    	  {
						rd.include(req, resp);
		  	    	  } catch (ServletException t) 
		  	    	  {
						t.printStackTrace();
		  	    	  }

	  	        } catch (AddressException e) 
	  	        {
	  	            
	  	        	RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
	  	        	PrintWriter out= resp.getWriter();
	  	        	out.println("<div class=\"alert alert-danger\" style=\"text-align: center;\"><strong>Error ! </strong>Direccion no encontrada.</div>	");

		  	    	try 
		  	    	  {
						rd.include(req, resp);
		  	    	  } catch (ServletException t) 
		  	    	  {
						t.printStackTrace();
		  	    	  }

		  	    	  
	  	        } catch (MessagingException e) {
		  	        	RequestDispatcher rd = getServletContext().getRequestDispatcher("/mailRestablecer.jsp");
		  	        	PrintWriter out= resp.getWriter();
		  	        	out.println("<div class=\"alert alert-danger\" style=\"text-align: center;\"><strong>Error ! </strong>Desconocido."+e+"</div>	");
	
			  	    	try 
			  	    	  {
							rd.include(req, resp);
			  	    	  } catch (ServletException t) 
			  	    	  {
							t.printStackTrace();
			  	    	  }
	  	        }
	  	      }
	  	      else
	  	      {
	  	    	  RequestDispatcher rd = getServletContext().getRequestDispatcher("/mailRestablecer.jsp");
	  	    	  PrintWriter out= resp.getWriter();
	  	    	  out.println("<div class=\"alert alert-danger\" style=\"text-align: center;\"><strong>Error! </strong>Verifique su email.</div>	");
	  	    	  try 
	  	    	  {
					rd.include(req, resp);
	  	    	  } catch (ServletException t) 
	  	    	  {
					t.printStackTrace();
	  	    	  }
	  	      }
	  	     
	  	      
	  	      
		} 
		catch (Exception e) 
		{
	  	    	RequestDispatcher rd = getServletContext().getRequestDispatcher("/mailRestablecer.jsp");
	            PrintWriter out= resp.getWriter();
	            out.println("<div class=\"alert alert-danger\" style=\"text-align: center;\"><strong>Error! </strong>Hubo un problema con el sistema. Por favor, contacte con su administrador.</div>	");
	            try 
	            {
					rd.include(req, resp);
				} catch (ServletException t) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(req, resp);
	}

	
}
