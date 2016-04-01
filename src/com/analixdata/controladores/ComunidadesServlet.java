package com.analixdata.controladores;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.analixdata.modelos.DAO;
import com.analixdata.modelos.Usuario;

public class ComunidadesServlet extends HttpServlet{

	protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException
	{
		resp.setContentType("text/html;charset=UTF-8");
		HttpSession session =req.getSession();
		
		String cadenaJSON="{\"logindata\":{\"user\":\"jdlandy@analixdata.com\", \"password\":\"jdbernardo1980\"}}";
		
		URL obj = new URL("https://data.meteordesk.com/login");
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		//con.setReadTimeout(60 * 5000);
        //con.setConnectTimeout(60 * 5000);
       // con.setRequestProperty ("Authorization", "Basic REM1NjIzMTVCM0NCOUVGOjA2MzZFM0FGMTQ=");
		con.setRequestMethod("POST");
		con.setRequestProperty("content-type", "application/json");
        con.setRequestProperty("accept", "application/json");

        //con.setUseCaches(false);
        //con.setDoInput(true);
        con.setDoOutput(true);
        
        OutputStreamWriter writer = new OutputStreamWriter(con.getOutputStream());
            writer.write(cadenaJSON);
            writer.close();
		//con.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:43.0) Gecko/20100101 Firefox/43.0");
		
		int responseCode = con.getResponseCode();
		
		
		
		if(responseCode==200)
		{
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();
			
			while ((inputLine = in.readLine()) != null)
			{
				response.append(inputLine);
			}
			
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/comunidades.jsp");
	            PrintWriter out= resp.getWriter();
	            out.println("<div class=\"alert alert-success\" style=\"text-align: center;\"><strong>Ok ! </strong>Bienvenido "+response+"</div> ");
  	          try 
  	    	  {
				rd.include(req, resp);
  	    	  } catch (ServletException t) 
  	    	  {
				t.printStackTrace();
  	    	  }
		}
		else
		{
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();
			
			while ((inputLine = in.readLine()) != null)
			{
				response.append(inputLine);
			}
			
			
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/comunidades.jsp");
            PrintWriter out= resp.getWriter();
            out.println("<div class=\"alert alert-success\" style=\"text-align: center;\"><strong>Ok ! </strong>Falló"+response+"</div> ");
	          try 
	    	  {
			rd.include(req, resp);
	    	  } catch (ServletException t) 
	    	  {
			t.printStackTrace();
	    	  }
		}
		
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		processRequest(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(req, resp);
	}
	
}
