package com.analixdata.modelos;

import java.io.Serializable;

public class Carga implements Serializable {
	
	int id;
	String empresa;
	String usuario;
	String servicio;
	int cantidad;
	String fecha;
	String hora;
	
	
	
	public Carga() {

	}

	public Carga(int id, String empresa, String servicio, String usuario,
			int cantidad, String fecha, String hora) {
		super();
		this.id = id;
		this.empresa = empresa;
		this.servicio = servicio;
		this.usuario = usuario;
		this.cantidad = cantidad;
		this.fecha = fecha;
		this.hora = hora;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmpresa() {
		return empresa;
	}

	public void setEmpresa(String empresa) {
		this.empresa = empresa;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public String getServicio() {
		return servicio;
	}

	public void setServicio(String servicio) {
		this.servicio = servicio;
	}

	public int getCantidad() {
		return cantidad;
	}

	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
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
	
	
	

}
