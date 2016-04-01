package com.analixdata.controladores;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Cookie;


import javax.xml.bind.DatatypeConverter;

import com.analixdata.modelos.DAO;
import com.analixdata.modelos.Usuario;

public class ValidarServlet extends HttpServlet {

	protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException
	{
		resp.setContentType("text/html;charset=UTF-8");
		DAO dao = new DAO();
		
		String email,pass;
		
		email=req.getParameter("txtEmail");
		pass = req.getParameter("txtPassword");
		
		Usuario u = new Usuario(email,pass);
		Usuario u2 = dao.existe(u);
		
		if (u2==null)
		{
			//HttpSession session = req.getSession();
			//session.setAttribute("usuario", u2);
			//req.getRequestDispatcher("error.jsp").forward(req, resp);
			 RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
	            PrintWriter out= resp.getWriter();
	            out.println("<div class=\"alert alert-danger\"  style=\"text-align: center;\"><strong>Error! </strong>Usuario y/o contraseña incorrectos</div>	");
	            rd.include(req, resp);
			
		}
		else
		{
			if (u2.getEstado()!=0)
			{
				HttpSession session = req.getSession();
				session.setAttribute("usuario", u2);
				
				session.setMaxInactiveInterval(30*60);
	            Cookie userName = new Cookie ("usuario",u2.getNombres()+" "+u2.getApellidos());
	            userName.setMaxAge(30*60);
	            resp.addCookie(userName);			
				resp.sendRedirect("index.jsp");
			}
			else
			{
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
	            PrintWriter out= resp.getWriter();
	            out.println("<div class=\"alert alert-danger\"  style=\"text-align: center;\"><strong>Error! </strong>Su usuario se encuentra inactivo. Por favor, comuniquese con su Administrador</div>	");
	            rd.include(req, resp);
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
