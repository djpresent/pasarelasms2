package com.analixdata.controladores;

import java.io.*;
import java.net.URL;
import java.net.HttpURLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import org.apache.commons.codec.binary.Base64;

import com.analixdata.modelos.DAO;
import com.analixdata.modelos.Servicio;
import com.analixdata.modelos.Usuario;
import com.analixdata.modelos.Utilidades;
import com.google.appengine.api.utils.SystemProperty;






import java.security.MessageDigest;
import java.util.Arrays;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

public class restablecer extends HttpServlet {
	
	@Override
	  public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		resp.setContentType("text/html;charset=UTF-8");

	        String u=null;
	        String pass=null;
	        //String pass=null;
	        String mensaje=null;
      

       		PrintWriter out = resp.getWriter();
       		
       		pass=req.getParameter("rvry");
       		
       		try 
       		{
				String md = Utilidades.Desencriptar(pass);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/RestablecerPassword.jsp");    
		        out.println("<div class=\"container-fluid\"><div class=\"row\"><div class=\"col-xs-6 col-md-4 col-xs-offset-3 col-md-offset-4\"><img class=\"logologin\" src=\"imagenes/logotipo.png\"/><h2 class=\"form-signin-heading\">Escriba su email para restablecer su contraseña</h2> <form onSubmit=\"return validarPass();\" action=\"/recuperarPassword\" method=\"post\" class=\"form-signin\" > <div class=\"form-group\"> <label for=\"txtPass\" class=\"sr-only\">Nueva contraseña</label><input type=\"password\" class=\"form-control\" id=\"txtPass\" name=\"txtPass\" placeholder=\"Nueva contraseña\" required=\"required\" autofocus/></div><div class=\"form-group\"><label for=\"txtPass1\" class=\"sr-only\">Confirmar nueva contraseña</label><input type=\"password\" class=\"form-control\" id=\"txtPass1\" name=\"txtPass1\" placeholder=\"Confirmar nueva contraseña\" required=\"required\"/></div><div class=\"form-group\"><input type=\"hidden\" class=\"form-control\" id=\"mailo\" name=\"mailo\" value=\""+md+"\"/></div><div class=\"form-group\"><input type=\"submit\" class=\"btn btn-lg btn-primary btn-block btnlogin\" value=\"Enviar\"/></div></form> </div></div></div>");
				rd.include(req, resp);
       		}
			catch (ServletException e) 
       		{
				// TODO Auto-generated catch block
				e.printStackTrace();
					
			} catch (Exception e1) 
       		{
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	        out.close();
	        

	}
	}

