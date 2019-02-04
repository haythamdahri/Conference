package com.conference.entities;

public class Affectation {

	private int id;
	private Comite comite;
	private Papier papier;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Comite getComite() {
		return comite;
	}
	public void setComite(Comite comite) {
		this.comite = comite;
	}
	public Papier getPapier() {
		return papier;
	}
	public void setPapier(Papier papier) {
		this.papier = papier;
	}
	
	public Affectation() {}
	
	public Affectation(int id, Comite comite, Papier papier) {
		this.id = id;
		this.comite = comite;
		this.papier = papier;
	}
	
	
}
