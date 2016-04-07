package com.analixdata.modelos;

import java.io.Serializable;

public class Transaccion implements Serializable {

	private int id,idEnvio;
	private String fecha,hora,codRetorno,plataforma,celular,mensaje, nombreEmpresa, nombreUsuario, nombreServicio;
	
	public Transaccion(){}
	

	
	public Transaccion(int id, String fecha, String hora, String codRetorno,String plataforma,
			 String celular, String mensaje, String nombreServicio ,String nombreUsuario,String nombreEmpresa,int idEnvio) {
		super();
		this.id = id;
		this.fecha = fecha;
		this.hora = hora;
		this.codRetorno = codRetorno;
		this.plataforma=plataforma;
		this.celular = celular;
		this.mensaje = mensaje;
		this.nombreEmpresa = nombreEmpresa;
		this.nombreUsuario = nombreUsuario;
		this.nombreServicio = nombreServicio;
		this.idEnvio=idEnvio;
	}


	public Transaccion (String celular, String mensaje)
	{
		this.celular=celular;
		this.mensaje=mensaje;
	}
	
	public Transaccion (String plataforma,String celular, String mensaje)
	{
		this.plataforma=plataforma;
		this.celular=celular;
		this.mensaje=mensaje;
	}

	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public String getFecha() {
		return fecha;
	}



	public void setFecha(String fecha) {
		this.fecha = fecha;
	}



	public String getHora() {
		return hora;
	}



	public void setHora(String hora) {
		this.hora = hora;
	}



	public String getCodRetorno() {
		return codRetorno;
	}



	public void setCodRetorno(String codRetorno) {
		this.codRetorno = codRetorno;
	}



	public String getPlataforma() {
		return plataforma;
	}



	public void setPlataforma(String plataforma) {
		this.plataforma = plataforma;
	}



	public String getCelular() {
		return celular;
	}



	public void setCelular(String celular) {
		this.celular = celular;
	}



	public String getMensaje() {
		return mensaje;
	}



	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}



	public String getNombreEmpresa() {
		return nombreEmpresa;
	}

	


	public int getIdEnvio() {
		return idEnvio;
	}



	public void setIdEnvio(int idEnvio) {
		this.idEnvio = idEnvio;
	}



	public void setNombreEmpresa(String nombreEmpresa) {
		this.nombreEmpresa = nombreEmpresa;
	}



	public String getNombreUsuario() {
		return nombreUsuario;
	}



	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}



	public String getNombreServicio() {
		return nombreServicio;
	}



	public void setNombreServicio(String nombreServicio) {
		this.nombreServicio = nombreServicio;
	}



	
	
	
}
