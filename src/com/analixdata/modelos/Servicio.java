package com.analixdata.modelos;

import java.io.Serializable;

public class Servicio implements Serializable{

	private int idServicio;
	private String descripcion;
	private int asignado;
	
	public Servicio()
	{}

	public Servicio(int idServicio, String descripcion) {
		super();
		this.idServicio = idServicio;
		this.descripcion = descripcion;
	}
	
	public Servicio(int idServicio, String descripcion,int asignado) {
		super();
		this.idServicio = idServicio;
		this.descripcion = descripcion;
		this.asignado = asignado;
	}

	public int getIdServicio() {
		return idServicio;
	}

	public void setIdServicio(int idServicio) {
		this.idServicio = idServicio;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public int getAsignado() {
		return asignado;
	}

	public void setAsignado(int asignado) {
		this.asignado = asignado;
	}

	
	
}
