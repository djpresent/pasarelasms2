package com.analixdata.controladores;

import java.io.IOException;

import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;

import com.analixdata.modelos.Transaccion;
import com.analixdata.modelos.Usuario;
import com.google.appengine.api.utils.SystemProperty;




public class EnvioWhatsappServlet extends HttpServlet {

	protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException
	{
		resp.setContentType("text/html;charset=UTF-8");
		
		/*
		 * Este servlet realiza el envio de un listado de mensajes obtenido a partir de un archivo de texto, csv o excel.
		 * */
		
		HttpSession session=req.getSession(true); //Se obtiene la session actual
		session = req.getSession();
		Usuario u = (Usuario)session.getAttribute("usuario"); 
		if (u!=null)
        {
		String disp =  (String) session.getAttribute("disponibles");
		int env = Integer.parseInt(disp);
		List <Transaccion> mensajes = new ArrayList<Transaccion>();
		String url = null;
		String mensaje = null;
		//conexion a la 
		
		try {
  	      if (SystemProperty.environment.value() ==
  	          SystemProperty.Environment.Value.Production) {

  	        Class.forName("com.mysql.jdbc.GoogleDriver");
  	        url = "jdbc:google:mysql://pasarelasms-1190:analixdata/pasarelasms?user=root&password=1234";
  	      } else {

  	        Class.forName("com.mysql.jdbc.Driver");
  	        url = "jdbc:mysql://localhost:3306/pasarelasms?user=geo";

  	      }
  	    } catch (Exception e) 
		{
  	    	session.setAttribute("codigo", 1);
			resp.sendRedirect("mensajeria.jsp");
  	    }

		
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);

		try {
		
			FileItemIterator iterator = upload.getItemIterator(req);
			
			FileItemStream uploadedFile = null;
			while (iterator.hasNext()) 
			{
	            FileItemStream uploaded = iterator.next();
	            
	            if (!uploaded.isFormField()) 
	            {

					   uploadedFile =  uploaded;   
					   
					   System.out.println(uploadedFile.getContentType());

					   if (uploadedFile.getContentType().equalsIgnoreCase("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
					   {					   
						   XSSFWorkbook workBook = new XSSFWorkbook(uploadedFile.openStream());
						   XSSFSheet sheet = workBook.getSheetAt(0); 
						   
						   System.out.println("El numero de filas es: "+sheet.getPhysicalNumberOfRows());
						   for (int i=0;i<sheet.getPhysicalNumberOfRows();i++)
						   {
							   XSSFRow row = sheet.getRow(i);
							   String mtemp = mensaje;
							   if (!row.getCell(0).toString().equalsIgnoreCase(""))
							   {
								   System.out.println("El valor del numero es: "+row.getCell(0).toString());
								   if (row.getCell(1)!=null)  
									   mtemp = mtemp.replace("[VARIABLE1]", row.getCell(1).toString());
								   
								   if (row.getCell(2)!=null)  
									   mtemp = mtemp.replace("[VARIABLE2]", row.getCell(2).toString());
								   
								   if (row.getCell(3)!=null)  
									   mtemp = mtemp.replace("[VARIABLE3]", row.getCell(3).toString());
								   
								   if (row.getCell(4)!=null)  
									   mtemp = mtemp.replace("[VARIABLE4]", row.getCell(4).toString());
	
								   Transaccion mens = new Transaccion (row.getCell(0).toString(),mtemp);
								   mensajes.add(mens);
							   }
							   else
							   {
								  break; 
							   }
						   	}
						   
					   }
					   else
					   {

						   BufferedReader br = null;
						   String line;
							try {

								br = new BufferedReader(new InputStreamReader(uploadedFile.openStream()));
								while ((line = br.readLine()) != null) 
								{

									String mtemp = mensaje;
									String numero=null;
								    StringTokenizer st = new StringTokenizer(line,";");
								    int i=0;
								    
								    if (st.countTokens()>0)
								    {
									    while(st.hasMoreTokens()) 
									    {
									    	if (i==0){
									    		 numero = st.nextToken();
									    		 
									    		
									    	}
									    	if (i==1)
									    	{
									    		String variable1 = st.nextToken();
									    		if (!variable1.equals(""))
									    			mtemp = mtemp.replace("[VARIABLE1]", variable1);
									    	}
									    	if (i==2)
									    	{
									    		String variable2 = st.nextToken();
									    		if (!variable2.equals(""))
									    			mtemp = mtemp.replace("[VARIABLE2]", variable2);
									    	}
									    	if (i==3)
									    	{
									    		String variable3 = st.nextToken();
									    		if (!variable3.equals(""))
									    			mtemp = mtemp.replace("[VARIABLE3]", variable3);
									    	}
									    	if (i==4)
									    	{
									    		String variable4 = st.nextToken();
									    		System.out.println("Esta es la variable 4"+variable4);
									    		if (!variable4.equals(""))
									    			mtemp = mtemp.replace("[VARIABLE4]", variable4);
	
									    	}
									    	i++;
									    }

									   Transaccion mens = new Transaccion (numero,mtemp);
									   mensajes.add(mens);
								    }
									
									
								}

							} catch (IOException e) {
								session.setAttribute("codigo", 2);
								resp.sendRedirect("mensajeria.jsp");
							} finally {
								if (br != null) {
									try {
										br.close();
									} catch (IOException e) {
										e.printStackTrace();
									}
								}
							}
						 
					   }
				   }
				   else
				   {
					   if (uploaded.getFieldName().equals("mensaje"))
					   {
						  
						   mensaje = IOUtils.toString(uploaded.openStream(), "utf-8"); 

					   }

				   }
	            
	            
	        }

			
			if (Integer.parseInt(disp)>=mensajes.size())
			{	
				
				Pattern pat = Pattern.compile("^5939.*");
				
				Connection conn = DriverManager.getConnection(url);
				int enviados=0;
				PrintWriter out = resp.getWriter();
				
				String cadena = "usuario=WAC28572&clave=851663&bloque=";
				String bloque="";
				//String destinatarios="\"Destinatarios\": [\"";
				//String mensajesp= "\"Mensajes\": [\"";
				
				String respuesta="";
				int contador=0;
				for (int i = 0; i<mensajes.size();i++)
				{
					contador++;
					String idsms="";
					if (contador<=1000 )
					{
						String cel=mensajes.get(i).getCelular();
					     Matcher mat = pat.matcher(cel);
					     if (mat.matches() && cel.length()==12) {
					    	 Calendar cal = Calendar.getInstance(); // creates calendar
					    	 cal.add(Calendar.HOUR_OF_DAY, -5); // adds one hour
			    		     String fecha= new SimpleDateFormat("yyyyMMdd").format(cal.getTime()).toString();
			    		     String hora=new SimpleDateFormat("HHmmss").format(cal.getTime()).toString();
			    		      idsms = fecha+hora+i;
					         bloque+=idsms+","+cel+","+mensajes.get(i).getMensaje()+"\r\n";
					        // System.out.println(cal.toString());
					        respuesta="PROCESADO";
					         enviados++;
					     } else {
					         //System.out.println("NO");
					         respuesta="NUMERO INCORRECTO";
					     }
	
						try
		        		{
		        			
		        			Calendar cal = Calendar.getInstance(); // creates calendar
		    	    		
		    		        cal.add(Calendar.HOUR_OF_DAY, -5); // adds one hour
	
		    		         		        
		    		        String fecha= new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime()).toString();
		    		        String hora=new SimpleDateFormat("HH:mm:ss").format(cal.getTime()).toString();
		        			

		    		        System.out.println("Ingreso antes de la base");
		    		        
		    		        
		        			String statement = "INSERT INTO twhatsapp (fecha,hora,retorno,idinterno,celular,mensaje,idservicio,idusuario,idempresa) VALUES( ? , ? , ? , ? , ? , ? , ? , ? , ? )";
		    		          PreparedStatement stmt = conn.prepareStatement(statement);
		    		          stmt.setString(1, fecha);
		    		          stmt.setString(2,  hora);
		    		          stmt.setString(3, respuesta);
		    		          stmt.setString(4, idsms);
		    		          stmt.setString(5, mensajes.get(i).getCelular());
		    		          stmt.setString(6, mensajes.get(i).getMensaje());
		    		          stmt.setInt(7, 3);
		    		          stmt.setInt(8, u.getId() );
		    		          stmt.setInt(9, u.getEmpresa().getIdEmpresa());
		    		          
		    		          stmt.executeUpdate();
		    		          System.out.println(statement);
		        		}catch (Error e){
		        			session.setAttribute("codigo", "ERRORGRABARBASE");
		    				resp.sendRedirect("mensajeria.jsp");
		        		}
						
					}
					//System.out.println(contador);
					if (contador==mensajes.size() || contador==1000)
					{
							int tipoMensaje = Integer.parseInt(req.getParameter("tipoMensaje"));

							String mensajeCod = URLEncoder.encode(bloque, "utf-8");
							System.out.println(cadena+mensajeCod);
							
							URL obj = new URL("http://private.whappend.com/wa_send_bulk.asp");
			        		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
			        		con.setReadTimeout(60 * 5000);
			                con.setConnectTimeout(60 * 5000);
			                
			                //con.setRequestProperty ("Authorization", "Basic REM1NjIzMTVCM0NCOUVGOjA2MzZFM0FGMTQ=");
			        		con.setRequestMethod("POST");
			        		con.setRequestProperty("content-type", "application/x-www-form-urlencoded");
			                con.setRequestProperty("accept", "application/text");

			                con.setUseCaches(false);
			                con.setDoInput(true);
			                con.setDoOutput(true);
			                
			                OutputStreamWriter writer = new OutputStreamWriter(con.getOutputStream());
			                    writer.write(cadena+mensajeCod);
			                    writer.close();
			        		//con.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:43.0) Gecko/20100101 Firefox/43.0");
			        		
			        		int responseCode = con.getResponseCode();
			        		
			        		
			        		
			        		if(responseCode==200)
			        		{
			        			BufferedReader in = new BufferedReader(
				        		        new InputStreamReader(con.getInputStream()));
				        		String inputLine;
				        		StringBuffer response = new StringBuffer();
				        		
				        		while ((inputLine = in.readLine()) != null)
				        		{
				        			response.append(inputLine);
				        		}
				        		System.out.println(response);
				        		in.close();
			        			
			        		}
			        		
			        		con.disconnect();
			        		
						
						
			        	String stmt1 = "UPDATE servicio_empresa SET disponible="+(env-enviados)+" WHERE idempresa="+u.getEmpresa().getIdEmpresa()+" AND idservicio=3";
							PreparedStatement stmt = conn.prepareStatement(stmt1);
							stmt.executeUpdate();
							String stmt2= "UPDATE servicio_empresa SET disponible="+(env-enviados)+" WHERE idempresa=1 AND idservicio=3";
							stmt= conn.prepareStatement(stmt2);
							stmt.executeUpdate();
							conn.close();
							contador=0;
							
					}
				}
				session.setAttribute("codigo", 4);
				resp.sendRedirect("whatsapp.jsp");

			}
			else
			{
				
					session.setAttribute("codigo", 5);
					resp.sendRedirect("whatsapp.jsp");
			}
			
			
			
		
		} catch (FileUploadException e) {
			
			session.setAttribute("codigo", 6);
			resp.sendRedirect("whatsapp.jsp");
			
			///e.printStackTrace();
		} catch (Exception e) {

			session.setAttribute("codigo", 7);
			resp.sendRedirect("whatsapp.jsp");
		
		}
        }
		else
	    {
	    	
	    	session.invalidate();
	    	RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
            PrintWriter out= resp.getWriter();
            out.println("<div class=\"alert alert-warning\" style=\"text-align: center;\"><strong>Lo sentimos! </strong>Su sesión a caducado. Por favor, vuelva a ingresar</div>	");
            try 
            {
				rd.include(req, resp);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    	
	    }
	
		
	//	resp.sendRedirect("mensajeria.jsp");

	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		processRequest(req, resp);
	

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		processRequest(req, resp);
		
	}

}
