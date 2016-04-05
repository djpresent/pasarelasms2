package com.analixdata.controladores;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.json.JSONArray;




public class ComunidadesServlet extends HttpServlet{
	
	
	
	protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException
	{
		resp.setContentType("text/html;charset=UTF-8");
		HttpSession session =req.getSession();
		String token="";
		
		if(session.getAttribute("token")==null){
			String cadenaJSON="{\"logindata\":{\"user\":\"jdlandy@analixdata.com\", \"password\":\"jdbernardo1980\"}}";
			
			
			try {
				URL obj = new URL("https://data.meteordesk.com/login");
				HttpURLConnection con = (HttpURLConnection) obj.openConnection();
				con.setRequestMethod("POST");
				con.setRequestProperty("content-type", "application/json");
		        con.setRequestProperty("accept", "application/json");

		        con.setDoOutput(true);
		        con.setDoInput(true);
	        
		        OutputStreamWriter writer = new OutputStreamWriter(con.getOutputStream());
		        writer.write(cadenaJSON);
		        writer.close();
			
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
					
					String s= response.toString();
					
					JSONObject jsonObject = new JSONObject(s);
			        JSONObject resultado = jsonObject.getJSONObject("result");
			        token=resultado.getString("token");
			        session.setAttribute("token", token);
			        
			        
			        

				}
				else
				{
					
					RequestDispatcher rd = getServletContext().getRequestDispatcher("/comunidades.jsp");
			        PrintWriter out= resp.getWriter();
			        out.println("<div class=\"alert alert-success\" style=\"text-align: center;\"><strong>Fallo ! </strong>Fallo en el sistema, por favor comuníquese con Analixdata.</div> ");
			          try 
			    	  {
					rd.include(req, resp);
			    	  } catch (ServletException t) 
			    	  {
					t.printStackTrace();
			    	  }
				}
			}catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		
			
		}else{
			resp.setContentType("text/plain");
			resp.setCharacterEncoding("UTF-8");
			//resp.getWriter().write("Ya existe");
			token=session.getAttribute("token").toString();
			
		}
		
		
		if(token!=""){
        	
        	
        	String canales=obtenerCanal(token);
			
			String agente=obtenerAgente(token);
			if(agente!=null){
				
			String chats=obtenerChats(agente,token);
				
				resp.setContentType("text/plain");
				resp.setCharacterEncoding("UTF-8");
				resp.getWriter().write(chats);
			}
        	
        	
			
        }else{
        	RequestDispatcher rd = getServletContext().getRequestDispatcher("/comunidades.jsp");
	        PrintWriter out= resp.getWriter();
	        out.println("<div class=\"alert alert-success\" style=\"text-align: center;\"><strong>Fallo ! </strong>Fallo en el sistema, por favor comuníquese con Analixdata.</div> ");
	          try 
	    	  {
			rd.include(req, resp);
	    	  } catch (ServletException t) 
	    	  {
			t.printStackTrace();
	    	  }
        }
		
		
		
	}
	
	
	private String obtenerCanal(String t) {
		
		try {
			URL obj = new URL("https://data.meteordesk.com/channels");
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("content-type", "application/json");
	        con.setRequestProperty("accept", "application/json");
	        con.setRequestProperty("token", t);

	        con.setDoInput(true);
	        con.setDoOutput(true);

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
				
				/*String s= response.toString();
				
				JSONObject jsonObject = new JSONObject(s);
		        JSONObject resultado = jsonObject.getJSONObject("result");
		        String token=resultado.getString("token");
		        */
				return response.toString();
	
				
			}
			else
			{	

				return null;
			}
		}catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
	
private String obtenerAgente(String t) {
		
		try {
			URL obj = new URL("https://data.meteordesk.com/agents");
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("content-type", "application/json");
	        con.setRequestProperty("accept", "application/json");
	        con.setRequestProperty("token", t);

	        con.setDoInput(true);
	        con.setDoOutput(true);

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
				
				String s= response.toString();
				
				JSONObject jsonObject = new JSONObject(s);
		        JSONObject resultado = jsonObject.getJSONObject("result");
		        JSONArray data=resultado.getJSONArray("data");
		        JSONObject agente=data.getJSONObject(0);
		        String agentid=agente.getString("agentid");
		        
				return agentid;
	
				
			}
			else
			{	

				return null;
			}
		}catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
	
private String obtenerChats(String id,String t) {
	
	try {
		URL obj = new URL("https://data.meteordesk.com/agent/"+id+"/chats?type=open");
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("content-type", "application/json");
        con.setRequestProperty("accept", "application/json");
        con.setRequestProperty("token", t);

        con.setDoInput(true);
        con.setDoOutput(true);

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
			
			String s= response.toString();
			
			JSONObject jsonObject = new JSONObject(s);
	        JSONObject resultado = jsonObject.getJSONObject("result");
	        JSONArray data=resultado.getJSONArray("data");
	        
	        
	        JSONObject mischats = new JSONObject();
	        JSONArray chats=new JSONArray();
	        
	        for(int i=0;i<data.length();i++){
	        	JSONObject agente=data.getJSONObject(i);
		        String chatid=agente.getString("chatId");
		        String chatuser=agente.getString("chatUser");
		        String lastMessage=String.valueOf(agente.getLong("lastMessage"));
		        
		        
		        JSONObject datos=new JSONObject(obtenerPersona(chatuser,t));
		        JSONObject resul = datos.getJSONObject("result");
		        
		        //Aqui recuperar data
		       // String nombre=resul.getString("whatsappName");
		       // String foto=resul.getString("profilePicture");
		        
		        
		        JSONObject chat=new JSONObject(); 
		        chat.put("chatId", chatid);
		        chat.put("chatUser", chatuser);
		        //chat.put("whatsappName", nombre);
		        chat.put("lastMessage", lastMessage);
		       // chat.put("profilePicture", foto);
		        
		        chats.put(chat);
		        return resul.toString();
	        }
	        
	        mischats.put("chats", chats);
	        
			//return mischats.toString();
	       
	   

			
		}
		else
		{	

			return null;
		}
	}catch (MalformedURLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return null;
	
}
	
	private String obtenerPersona(String chatuser,String t) {
	
		try {
			URL obj = new URL("https://data.meteordesk.com/phone/"+chatuser);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("content-type", "application/json");
	        con.setRequestProperty("accept", "application/json");
	        con.setRequestProperty("token", t);

	        con.setDoInput(true);
	        con.setDoOutput(true);

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
				

		        
				return response.toString();
	
				
			}
			else
			{	

				return null;
			}
		}catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	
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
