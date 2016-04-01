package com.analixdata.modelos;

import java.io.Serializable;

public class Empresa implements Serializable {

private int idEmpresa,estado;
private String nombre, direccion, telefono, contacto;


public Empresa()
{}


public Empresa(int idEmpresa, int estado, String nombre, String direccion,String telefono, String contacto) 
{
	super();
	this.idEmpresa = idEmpresa;
	this.estado = estado;
	this.nombre = nombre;
	this.direccion = direccion;
	this.telefono = telefono;
	this.contacto = contacto;
}


public int getIdEmpresa() {
	return idEmpresa;
}


public void setIdEmpresa(int idEmpresa) {
	this.idEmpresa = idEmpresa;
}


public int getEstado() {
	return estado;
}


public void setEstado(int estado) {
	this.estado = estado;
}


public String getNombre() {
	return nombre;
}


public void setNombre(String nombre) {
	this.nombre = nombre;
}


public String getDireccion() {
	return direccion;
}


public void setDireccion(String direccion) {
	this.direccion = direccion;
}


public String getTelefono() {
	return telefono;
}


public void setTelefono(String telefono) {
	this.telefono = telefono;
}


public String getContacto() {
	return contacto;
}


public void setContacto(String contacto) {
	this.contacto = contacto;
}



	
}
