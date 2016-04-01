package com.analixdata.modelos;

public class ServicioUsuario {

	private int idServicio,idEmpresa,idUsuario;
	
	public ServicioUsuario()
	{}

	private ServicioUsuario(int idServicio, int idEmpresa, int idUsuario) {
		super();
		this.idServicio = idServicio;
		this.idEmpresa = idEmpresa;
		this.idUsuario = idUsuario;
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

	private int getIdUsuario() {
		return idUsuario;
	}

	private void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}
	
	
	
	
}
