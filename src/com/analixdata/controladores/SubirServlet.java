package com.analixdata.controladores;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.IOException;


import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.analixdata.modelos.Usuario;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.util.store.DataStoreFactory;
import com.google.api.client.util.store.MemoryDataStoreFactory;
import com.google.common.collect.Lists;






import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;




@SuppressWarnings("serial")
public class SubirServlet extends HttpServlet {
	
	

	private static final int BUFFER_SIZE = 1024 * 1024;
	/*
	 private final GcsService gcsService = GcsServiceFactory.createGcsService(new RetryParams.Builder()
	    .initialRetryDelayMillis(10)
	    .retryMaxAttempts(10)
	    .totalRetryPeriodMillis(15000)
	    .build());
	   
	 
	*/
	private void copy(InputStream input, OutputStream output) throws IOException {
	    try {
	      byte[] buffer = new byte[BUFFER_SIZE];
	      int bytesRead = input.read(buffer);
	      while (bytesRead != -1) {
	        output.write(buffer, 0, bytesRead);
	        bytesRead = input.read(buffer);
	      }
	    } finally {
	      input.close();
	      output.close();
	    }
	  }
	

	protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException
	{
		resp.setContentType("text/html;charset=UTF-8");
		
		HttpSession session=req.getSession(true); //Se obtiene la session actual
		session = req.getSession();
		Usuario u = (Usuario)session.getAttribute("usuario"); 
		/*if (u!=null)
        {

		//conexion a la 
		/*
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
			resp.sendRedirect("subir.jsp");
  	    }
		
		session.setAttribute("codigo", 1);
		resp.sendRedirect("subir.jsp");
		*/
		
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		
		String sctype = null, sfieldname, sname = null;
		
        FileItemIterator iterator;
        FileItemStream item;
        
		try 
		{
			 OutputStream salida = null;
			upload = new ServletFileUpload();
            iterator = upload.getItemIterator(req);
            while (iterator.hasNext()) {
                item = iterator.next();
                //stream = item.openStream();

                if (!item.isFormField()){

                	System.out.println("Es imagen");
                   //sfieldname = item.getFieldName();
                    //sname = item.getName();

                    //sctype = item.getContentType();
                    //copy(stream, salida);
                	 
                	 DataInputStream dis = new DataInputStream(item.openStream());
                	 int longitud=item.openStream().available();
                	 
                     byte[] barray = new byte[(int) longitud];
                    
                    
                     try 
                     { 
                       dis.readFully(barray);           // now the array contains the image
                     }
                     catch (Exception e) 
                     { 
                       barray = null; 
                     }
                     finally 
                     { 
                       dis.close( ); 
                     }
                     
                     
                     
                    String scope = "https://www.googleapis.com/auth/devstorage.read_write";

          		  // This callback URL will allow you to copy the token from the success screen.
          		  // This must match the one associated with your client ID.
          		  String CALLBACK_URL = "http://localhost:8888/autorizar";

          		  // If you do not have a client ID or secret, please create one in the
          		  // API console: https://console.developers.google.com/project
          		  String CLIENT_ID = "335544489774-pvf6v6ibovjavi03b2vhderpli7um0b5.apps.googleusercontent.com";
          		  String CLIENT_SECRET = "cAAq6ld4GgTuogtwjWZBBKP4";
          		  
          		  DataStoreFactory storeFactory = new MemoryDataStoreFactory();
          		  
          		  GoogleAuthorizationCodeFlow authorizationFlow = new GoogleAuthorizationCodeFlow.Builder(
          			        new NetHttpTransport(),
          			        new JacksonFactory(),
          			        CLIENT_ID,
          			        CLIENT_SECRET,
          			        Lists.newArrayList(scope))
          			        .setDataStoreFactory(storeFactory)
          			        // Set the access type to offline so that the token can be refreshed.
          			        // By default, the library will automatically refresh tokens when it
          			        // can, but this can be turned off by setting
          			        // api.dfp.refreshOAuth2Token=false in your ads.properties file.
          			        .setAccessType("offline").build();

          			    String authorizeUrl =
          			        authorizationFlow.newAuthorizationUrl().setRedirectUri(CALLBACK_URL).build();
          			    System.out.printf("Paste this url in your browser:%n%s%n", authorizeUrl);

          			    
          			    URL aut = new URL(authorizeUrl);
          			    HttpURLConnection c = (HttpURLConnection) aut.openConnection();
          			    c.setRequestMethod("GET");
          			    int responseC = c.getResponseCode();
          			    //System.out.println("\nSending 'GET' request to URL : " + urlEnvio);
          			    System.out.println("Response Code : " + responseC);
          			    
          			  BufferedReader inp = new BufferedReader(new InputStreamReader(c.getInputStream()));
          			    if (responseC==200)
          			    {
          			    	System.out.println(inp.readLine());
          			    }
          			   
          			    	
          			 
          			    
          			    // Wait for the authorization code.
          			    System.out.println("Type the code you received here: ");
          			    String authorizationCode = new BufferedReader(new InputStreamReader(System.in)).readLine();

          			    // Authorize the OAuth2 token.
          			    GoogleAuthorizationCodeTokenRequest tokenRequest =
          			        authorizationFlow.newTokenRequest(authorizationCode);
          			    tokenRequest.setRedirectUri(CALLBACK_URL);
          			    GoogleTokenResponse tokenResponse = tokenRequest.execute();
          			    System.out.println(tokenResponse.getAccessToken());
          			    // Store the credential for the user.
          			 //   authorizationFlow.createAndStoreCredential(tokenResponse, userId);
          		  
          			  
          			    
          			    
          			  URL obj = new URL("https://www.googleapis.com/upload/storage/v1/b/analixdata/o?name=a.jpg&predefinedAcl=publicRead");
		        		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		        		con.setReadTimeout(60 * 5000);
		                con.setConnectTimeout(60 * 5000);
		                con.setRequestProperty ("Authorization", "Bearer "+tokenResponse.getAccessToken());
		        		con.setRequestMethod("POST");
		        		con.setRequestProperty("content-type", "image/jpeg");
		                con.setRequestProperty("accept", "application/json");
		                
		                con.setRequestProperty("content-length", String.valueOf(longitud));

		                con.setUseCaches(false);
		                con.setDoInput(true);
		                con.setDoOutput(true);
		                
		              //  OutputStreamWriter writer = new OutputStreamWriter(con.getOutputStream());
		                
		                DataOutputStream writer = new DataOutputStream(con.getOutputStream());
		                    writer.write(barray);
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
          			    
          			    
          			    
          			    
          			    
          			    
          			    
          			    
          			    
          			    
          		 
          		   resp.sendRedirect("subir.jsp");

                   
              
                }
            }
		
		} catch (Exception e) {
				
			System.out.println(e);
			session.setAttribute("codigo", 6);
			resp.sendRedirect("subir.jsp");
		
		}catch(Error e){
			
			//SIEMPRE ENTRA POR AQUI
			System.out.println(e);
			session.setAttribute("codigo", 7);
			resp.sendRedirect("subir.jsp");
		}
		
	
		
		
		/*String cadena="{\"web\": {\"client_id\": \"335544489774-pvf6v6ibovjavi03b2vhderpli7um0b5.apps.googleusercontent.com\","+
		"\"project_id\": \"pasarelasms-1190\",\"auth_uri\": \"https://accounts.google.com/o/oauth2/auth",
		"token_uri": "https://accounts.google.com/o/oauth2/token",
		"auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
		"client_secret": "cAAq6ld4GgTuogtwjWZBBKP4",
		"redirect_uris": ["https://servicios.analixdata.com"]
	}
}";
		
		URL obj = new URL("https://accounts.google.com/o/oauth2/auth");
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setReadTimeout(60 * 5000);
        con.setConnectTimeout(60 * 5000);
        
        //con.setRequestProperty ("Authorization", "Basic REM1NjIzMTVCM0NCOUVGOjA2MzZFM0FGMTQ=");
		con.setRequestMethod("POST");
		con.setRequestProperty("content-type", "application/json");
        con.setRequestProperty("accept", "application/json");

        con.setUseCaches(false);
        con.setDoInput(true);
        con.setDoOutput(true);
        
        OutputStreamWriter writer = new OutputStreamWriter(con.getOutputStream());
            writer.write(cadena);
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
		*/
		
		/*String xmlString = "";
		  xmlString += "<AccessControlList><Entries>";
		  xmlString += "  <Entry>";
		  xmlString += "    <Scope type=\"UserByEmail\">foo@example.com</Scope>";
		  xmlString += "    <Permission>READ</Permission>";
		  xmlString += "  </Entry>";
		  xmlString += "</Entries></AccessControlList>";

		  ArrayList scopes = new ArrayList();
		  scopes.add("https://www.googleapis.com/auth/devstorage.full_control");

		  AppIdentityService.GetAccessTokenResult accessToken =
		      AppIdentityServiceFactory.getAppIdentityService().getAccessToken(scopes);
		  
		 System.out.println("Token" +accessToken.getAccessToken()); 
	
			
		 session.setAttribute("token", accessToken.getAccessToken());*/
		
		

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
