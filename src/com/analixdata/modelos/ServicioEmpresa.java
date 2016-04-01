package com.analixdata.modelos;

public class ServicioEmpresa {

	private int idServicio, idEmpresa,limite,estado;
	private float costoTransaccion;
	
	
	
	public ServicioEmpresa() {
	}



	public ServicioEmpresa(int idServicio, int idEmpresa, int limite,
			int estado, float costoTransaccion) {
		super();
		this.idServicio = idServicio;
		this.idEmpresa = idEmpresa;
		this.limite = limite;
		this.estado = estado;
		this.costoTransaccion = costoTransaccion;
	}



	private int getIdServicio() {
		return idServicio;
	}



	private void setIdServicio(int idServicio) {
		this.idServicio = idServicio;
	}



	private int getIdEmpresa() {
		return idEmpresa;
	}



	private void setIdEmpresa(int idEmpresa) {
		this.idEmpresa = idEmpresa;
	}



	private int getLimite() {
		return limite;
	}



	private void setLimite(int limite) {
		this.limite = limite;
	}



	private int getEstado() {
		return estado;
	}



	private void setEstado(int estado) {
		this.estado = estado;
	}



	private float getCostoTransaccion() {
		return costoTransaccion;
	}



	private void setCostoTransaccion(float costoTransaccion) {
		this.costoTransaccion = costoTransaccion;
	}
	
	
	
	
}
